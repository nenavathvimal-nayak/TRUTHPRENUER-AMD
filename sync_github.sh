#!/usr/bin/env bash
# ==============================================================================
# TRUTHPRENUER WORKSPACE — GITHUB REPOSITORY SYNC RUNNER
# Pulls latest updates from remote GitHub repositories and updates submodules.
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ADMIN_DIR="${SCRIPT_DIR}/TRUTHPRENUER-ADMIN"
PLATFORM_DIR="${SCRIPT_DIR}/TRUTHPRENUER-PLATFORM"

echo "========================================================"
echo "  SYNCING TRUTHPRENUER WORKSPACE WITH GITHUB"
echo "========================================================"

# 1. Update TRUTHPRENUER-ADMIN & Submodules
if [ -d "${ADMIN_DIR}/.git" ]; then
    echo ""
    echo "[1/3] Updating TRUTHPRENUER-ADMIN..."
    cd "${ADMIN_DIR}"
    git fetch origin main
    git pull --ff-only origin main || echo "Note: Fast-forward pull skipped or local modifications present."

    echo ""
    echo "[2/3] Updating Submodule (taeed_flutter_source / Truthprenuer.git)..."
    git submodule sync --recursive
    git submodule update --init --recursive
    
    SUBMODULE_DIR="${ADMIN_DIR}/USERS/FLUTTER/taeed_flutter_source"
    if [ -d "${SUBMODULE_DIR}/.git" ] || [ -f "${SUBMODULE_DIR}/.git" ]; then
        cd "${SUBMODULE_DIR}"
        git fetch origin main
        echo "Submodule branch: $(git rev-parse --abbrev-ref HEAD) @ $(git rev-parse --short HEAD)"
    fi
else
    echo "[!] TRUTHPRENUER-ADMIN git directory not found at ${ADMIN_DIR}"
fi

# 2. Check TRUTHPRENUER-PLATFORM
echo ""
echo "[3/3] Checking TRUTHPRENUER-PLATFORM..."
if [ -d "${PLATFORM_DIR}/.git" ]; then
    cd "${PLATFORM_DIR}"
    if git remote | grep -q "^origin$"; then
        echo "Fetching updates for TRUTHPRENUER-PLATFORM..."
        git fetch origin main
        git pull --ff-only origin main || echo "Note: Check merge status in TRUTHPRENUER-PLATFORM."
    else
        echo "TRUTHPRENUER-PLATFORM has no remote 'origin' configured yet."
        echo "To link it to GitHub, create the repository and run:"
        echo "  cd \"${PLATFORM_DIR}\""
        echo "  git remote add origin https://github.com/nenavathvimal-nayak/TRUTHPRENUER-PLATFORM.git"
    fi
fi

echo ""
echo "========================================================"
echo "  SYNC COMPLETE"
echo "========================================================"

