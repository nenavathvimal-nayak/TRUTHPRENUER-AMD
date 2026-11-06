# Multi-Repository Development & Git Workflow Guide

## 1. Golden Rules of Submodule Coordination
1. **Never edit submodule files without committing inside the submodule first:**
   Submodules are independent Git repositories. Editing files inside a submodule dirties that submodule.
2. **Commit inside the submodule, then commit the pointer in the parent:**
   Whenever a commit is created or pulled in a child repository, the parent records an updated commit SHA.
3. **Always use `--recurse-submodules` when pulling or cloning:**
   ```bash
   git pull --recurse-submodules
   git submodule update --init --recursive
   ```

---

## 2. Step-by-Step Scenario Workflows

### Scenario A: Modifying Parent Governance or Contracts
```bash
cd /Volumes/NAYAK/TRUTHRENUER\ ADM
git status
git add GOVERNANCE/ CONTRACTS/
git commit -m "docs(governance): update shared API contracts"
git push origin main
```

### Scenario B: Modifying Admin Console UI or Local API
```bash
cd /Volumes/NAYAK/TRUTHRENUER\ ADM/REPOSITORIES/TRUTHPRENUER-ADMIN
git checkout main
# Make edits to src/ or BACKEND/
npm run build
git add src/ BACKEND/
git commit -m "feat(admin): add audit export feature"
git push origin main

# Advance parent pointer
cd /Volumes/NAYAK/TRUTHRENUER\ ADM
git add REPOSITORIES/TRUTHPRENUER-ADMIN
git commit -m "chore(submodule): advance TRUTHPRENUER-ADMIN pointer"
git push origin main
```

### Scenario C: Modifying Platform Services or Database
```bash
cd /Volumes/NAYAK/TRUTHRENUER\ ADM/REPOSITORIES/TRUTHPRENUER-PLATFORM
git checkout main
# Make changes to DATABASE/ or ALGORITHMS/
pytest backend/tests/ ALGORITHMS/TESTS/
git add DATABASE/ ALGORITHMS/
git commit -m "feat(db): add Migration 004 for user reputation indexing"
git push origin main

# Advance parent pointer
cd /Volumes/NAYAK/TRUTHRENUER\ ADM
git add REPOSITORIES/TRUTHPRENUER-PLATFORM
git commit -m "chore(submodule): advance TRUTHPRENUER-PLATFORM pointer"
git push origin main
```
