#!/usr/bin/env bash
# ==============================================================================
# TRUTHPRENUER WORKSPACE — GITHUB REPOSITORY SYNC RUNNER
# Pulls latest updates from remote GitHub repositories and updates submodules.
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ADMIN_DIR="${SCRIPT_DIR}/REPOSITORIES/TRUTHPRENUER-ADMIN"
PLATFORM_DIR="${SCRIPT_DIR}/REPOSITORIES/TRUTHPRENUER-PLATFORM"

echo "========================================================"
echo "  SYNCING TRUTHPRENUER WORKSPACE WITH GITHUB"
echo "========================================================"

# 1. Update Submodule 1: TRUTHPRENUER-ADMIN
if [ -d "${ADMIN_DIR}/.git" ] || [ -f "${ADMIN_DIR}/.git" ]; then
    echo ""
    echo "[1/2] Updating REPOSITORIES/TRUTHPRENUER-ADMIN..."
    cd "${ADMIN_DIR}"
    git fetch origin main || echo "Fetch skipped (check network/credentials)"
    echo "Admin branch: $(git rev-parse --abbrev-ref HEAD) @ $(git rev-parse --short HEAD)"
else
    echo "[!] Admin submodule not found at ${ADMIN_DIR}"
fi

# 2. Update Submodule 2: TRUTHPRENUER-PLATFORM (Truthprenuer.git)
if [ -d "${PLATFORM_DIR}/.git" ] || [ -f "${PLATFORM_DIR}/.git" ]; then
    echo ""
    echo "[2/2] Updating REPOSITORIES/TRUTHPRENUER-PLATFORM (Truthprenuer.git)..."
    cd "${PLATFORM_DIR}"
    git fetch origin main || echo "Fetch skipped (check network/credentials)"
    echo "Platform branch: $(git rev-parse --abbrev-ref HEAD) @ $(git rev-parse --short HEAD)"
else
    echo "[!] Platform submodule not found at ${PLATFORM_DIR}"
fi

# 3. Synchronize Submodules from Parent
echo ""
echo "Synchronizing Git submodule gitlinks..."
cd "${SCRIPT_DIR}"
git submodule sync --recursive
git submodule update --init --recursive

echo ""
echo "========================================================"
echo "  SYNC COMPLETE"
echo "========================================================"
