# Contributing to Truthprenuer Ecosystem

Thank you for contributing to Truthprenuer. This repository (`TRUTHPRENUER-AMD`) is the central orchestrator and governance hub.

---

## 1. Multi-Repository Architecture Principles

Truthprenuer follows an independent multi-repository structure linked via Git submodules:

- **`TRUTHPRENUER-AMD`** (Parent): Governance, shared contracts, architecture specs, CI orchestration.
- **`TRUTHPRENUER-ADMIN`** (Submodule): Local Admin Console UI (React 19 / Vite 8) and Local Privileged API (FastAPI).
- **`TRUTHPRENUER-PLATFORM`** (Submodule): Core Backend (FastAPI), Database Migrations, Algorithms, and Docker.
- **`Truthprenuer`** (Submodule): Flutter Universal Mobile and Web Client Application.

### Strict Boundary Rules
1. **Never commit application code into the parent orchestrator.** Application features belong in their respective child repositories.
2. **Never commit Admin code into Platform or User repositories.**
3. **Never bypass loopback binding for Admin.** The Admin console must only run on `127.0.0.1:60135` and `127.0.0.1:60136`.
4. **Never commit secrets, tokens, or private keys.**

---

## 2. Development Workflow

1. **Identify Repository Owner:** Identify which submodule owns the subsystem being modified.
2. **Branching:** Create a feature branch in the specific submodule (`feat/<feature-name>` or `fix/<bug-name>`).
3. **Test:** Run repository-specific test suites before pushing.
4. **Pull Request:** Submit a PR in that repository with semantic commits.
5. **Pin in Parent:** After merging into the child repository, update the submodule pointer in `TRUTHPRENUER-AMD`:
   ```bash
   git add REPOSITORIES/<SUBMODULE_NAME>
   git commit -m "chore(submodule): advance <SUBMODULE_NAME> to <commit-sha>"
   ```
6. **Workspace Validation:** Run the workspace validator:
   ```bash
   ./DEVTOOLS/SCRIPTS/validate_workspace.sh
   ```

---

## 3. Commit Message Conventions
All repositories follow the Conventional Commits specification:
- `feat:` A new feature
- `fix:` A bug fix
- `docs:` Documentation changes
- `chore:` Maintenance, submodule pin updates, dependency updates
- `refactor:` Code restructuring without feature alteration
- `test:` Adding or modifying test suites
- `security:` Security hardening and remediation
