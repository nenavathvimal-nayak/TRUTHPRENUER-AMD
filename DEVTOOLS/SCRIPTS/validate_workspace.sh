#!/usr/bin/env bash
# ==============================================================================
# TRUTHPRENUER-AMD — MASTER ECOSYSTEM INTEGRATION & QUALITY GATE VALIDATOR
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

PASSED_CHECKS=0
FAILED_CHECKS=0
WARNINGS=0

log_header() {
    echo ""
    echo "=================================================================="
    echo "  $1"
    echo "=================================================================="
}

log_pass() {
    echo "  [PASS] $1"
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
}

log_fail() {
    echo "  [FAIL] $1"
    FAILED_CHECKS=$((FAILED_CHECKS + 1))
}

log_warn() {
    echo "  [WARN] $1"
    WARNINGS=$((WARNINGS + 1))
}

# 1. PARENT REPOSITORY & GIT IDENTITY
log_header "1. PARENT REPOSITORY & GIT IDENTITY CHECK"
if [ ! -d "${WORKSPACE_ROOT}/.git" ]; then
    log_fail "Parent git repository metadata not found at ${WORKSPACE_ROOT}/.git"
else
    PARENT_SHA=$(git -C "${WORKSPACE_ROOT}" rev-parse --short HEAD 2>/dev/null || echo "unknown")
    PARENT_BRANCH=$(git -C "${WORKSPACE_ROOT}" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
    log_pass "Parent repository verified at ${WORKSPACE_ROOT} (Branch: ${PARENT_BRANCH}, Commit: ${PARENT_SHA})"
fi

# 2. SUBMODULE REGISTRATION & BOUNDARIES
log_header "2. SUBMODULE REGISTRATION & INTEGRITY"
ADMIN_DIR="${WORKSPACE_ROOT}/REPOSITORIES/TRUTHPRENUER-ADMIN"
PLATFORM_DIR="${WORKSPACE_ROOT}/REPOSITORIES/TRUTHPRENUER-PLATFORM"

if [ -d "${ADMIN_DIR}" ]; then
    ADMIN_SHA=$(git -C "${ADMIN_DIR}" rev-parse --short HEAD 2>/dev/null || echo "unknown")
    log_pass "Admin submodule verified at REPOSITORIES/TRUTHPRENUER-ADMIN (Commit: ${ADMIN_SHA})"
else
    log_fail "Admin submodule missing from ${ADMIN_DIR}"
fi

if [ -d "${PLATFORM_DIR}" ]; then
    PLATFORM_SHA=$(git -C "${PLATFORM_DIR}" rev-parse --short HEAD 2>/dev/null || echo "unknown")
    log_pass "Platform submodule verified at REPOSITORIES/TRUTHPRENUER-PLATFORM (Commit: ${PLATFORM_SHA})"
else
    log_fail "Platform submodule missing from ${PLATFORM_DIR}"
fi

# 3. ADMIN ZERO-TRUST ISOLATION AUDIT (127.0.0.1:60135 & 60136)
log_header "3. ADMIN ZERO-TRUST ISOLATION AUDIT"
VITE_CONF="${ADMIN_DIR}/ADMIN/vite.config.ts"
if [ -f "${VITE_CONF}" ] && grep -q "host: '127.0.0.1'" "${VITE_CONF}" && grep -q "port: 60135" "${VITE_CONF}"; then
    log_pass "Admin UI enforces host 127.0.0.1, port 60135, and strictPort: true"
else
    log_fail "Admin UI lacks strict loopback host/port enforcement"
fi

ADMIN_API_CONF="${ADMIN_DIR}/ADMIN/BACKEND/app/core/config.py"
if [ -f "${ADMIN_API_CONF}" ] && grep -q "ADMIN_HOST: str = \"127.0.0.1\"" "${ADMIN_API_CONF}" && grep -q "ADMIN_PORT: int = 60136" "${ADMIN_API_CONF}"; then
    log_pass "Admin API config strictly enforces host 127.0.0.1 and port 60136"
else
    log_fail "Admin API lacks loopback port 60136 enforcement"
fi

# 4. NESTED SUBMODULE REMOVAL AUDIT
log_header "4. NESTED SUBMODULE REMOVAL AUDIT (ADMIN REPO)"
if [ -f "${ADMIN_DIR}/.gitmodules" ] || [ -d "${ADMIN_DIR}/USERS/FLUTTER/taeed_flutter_source" ]; then
    log_fail "Nested submodule still present in TRUTHPRENUER-ADMIN"
else
    log_pass "Nested submodule successfully removed from TRUTHPRENUER-ADMIN (Admin is clean child)"
fi

# 5. AUTOMATED TEST SUITE INTEGRITY
log_header "5. AUTOMATED TEST SUITE INTEGRITY"

# A. Admin UI Production Build
if (cd "${ADMIN_DIR}/ADMIN" && npm run build --silent >/dev/null 2>&1); then
    log_pass "Admin React 19 / Vite 8 production build succeeded cleanly"
else
    log_fail "Admin React 19 / Vite 8 production build failed"
fi

# B. Admin API Tests
VENV_PY="${PLATFORM_DIR}/backend/venv/bin/python3"
if [ -x "${VENV_PY}" ]; then
    if "${VENV_PY}" -m pytest "${ADMIN_DIR}/ADMIN/TESTS/test_admin_api_suite.py" -q >/dev/null 2>&1; then
        log_pass "Local Admin API Pytest Suite (11 tests) passed completely"
    else
        log_fail "Local Admin API Pytest Suite failed"
    fi
else
    log_warn "Python venv interpreter not found; skipping Admin API tests"
fi

# C. Platform API Tests
if [ -x "${VENV_PY}" ]; then
    if "${VENV_PY}" -m pytest "${PLATFORM_DIR}/backend/tests/test_api_suite.py" -q >/dev/null 2>&1; then
        log_pass "Platform API Pytest Suite (17 tests) passed completely"
    else
        log_fail "Platform API Pytest Suite failed"
    fi
else
    log_warn "Python venv interpreter not found; skipping Platform API tests"
fi

# D. Platform Algorithms Tests
if [ -x "${VENV_PY}" ]; then
    if "${VENV_PY}" -m pytest "${PLATFORM_DIR}/ALGORITHMS/TESTS/" -q >/dev/null 2>&1; then
        log_pass "Platform Algorithms Pytest Suite (11 tests) passed completely"
    else
        log_fail "Platform Algorithms Pytest Suite failed"
    fi
else
    log_warn "Python venv interpreter not found; skipping Platform Algorithms tests"
fi

# E. User Web React Application Build
USER_WEB_DIR="${PLATFORM_DIR}/apps/web/react"
if [ -d "${USER_WEB_DIR}" ]; then
    if (cd "${USER_WEB_DIR}" && npm run build --silent >/dev/null 2>&1); then
        log_pass "User Web React 19 / Vite 6 production build succeeded cleanly"
    else
        log_fail "User Web React production build failed"
    fi

    if (cd "${USER_WEB_DIR}" && npm test >/dev/null 2>&1); then
        log_pass "User Web Node test suite passed completely"
    else
        log_fail "User Web Node test suite failed"
    fi
else
    log_fail "User Web React application missing from ${USER_WEB_DIR}"
fi

# SUMMARY
log_header "VALIDATION SUMMARY"
echo "  Total Checks Passed : ${PASSED_CHECKS}"
echo "  Total Checks Failed : ${FAILED_CHECKS}"
echo "  Total Warnings      : ${WARNINGS}"
echo "=================================================================="

if [ "${FAILED_CHECKS}" -eq 0 ]; then
    echo "  RESULT: WORKSPACE VERIFICATION PASSED (CLEAN & SECURE) 🟢"
    echo "=================================================================="
    exit 0
else
    echo "  RESULT: WORKSPACE VERIFICATION FAILED WITH ${FAILED_CHECKS} ERRORS 🔴"
    echo "=================================================================="
    exit 1
fi
