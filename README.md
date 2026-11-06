# TRUTHPRENUER-AMD

**Classification:** Master Multi-Repository Ecosystem Orchestrator & Governance Hub  
**Repository Identity:** `https://github.com/nenavathvimal-nayak/TRUTHPRENUER-AMD.git`  
**Default Branch:** `main`  
**Architecture:** Multi-Repository Git Submodule Orchestration  

---

## 1. Executive Overview

`TRUTHPRENUER-AMD` is the authoritative parent orchestrator for the entire Truthprenuer engineering ecosystem. It coordinates technical governance, cross-repository testing, shared API contracts, security compliance, CI/CD orchestration, and version releases across independent sub-repositories.

### Core Ecosystem Components

| Repository Name | Submodule Path | Remote URL | Architectural Role | Stack & Hosting |
| :--- | :--- | :--- | :--- | :--- |
| **`TRUTHPRENUER-AMD`** | Root (Parent) | `https://github.com/nenavathvimal-nayak/TRUTHPRENUER-AMD.git` | Master Ecosystem Controller | Git Submodules / Bash / GitHub Actions |
| **`TRUTHPRENUER-ADMIN`** | `REPOSITORIES/TRUTHPRENUER-ADMIN` | `https://github.com/nenavathvimal-nayak/TRUTHPRENUER-ADMIN.git` | Child 1: Admin Console & Privileged API | React 19 / Vite 8 / FastAPI (Local Loopback `127.0.0.1:60135` & `60136`) |
| **`TRUTHPRENUER-PLATFORM`** | `REPOSITORIES/TRUTHPRENUER-PLATFORM` | `https://github.com/nenavathvimal-nayak/Truthprenuer.git` | Child 2: Non-Admin Product & Platform Services | Flutter 3.29 / FastAPI / PostgreSQL 15 / Supabase / Docker |

---

## 2. Architectural Boundaries & Principles

1. **Zero Monolith:** The parent repository does **not** house application source code for Admin or Platform services. Each domain maintains its own independent Git repository, commit history, branch policies, and release cycles.
2. **Sibling Submodules:** Both child repositories (`TRUTHPRENUER-ADMIN` and `TRUTHPRENUER-PLATFORM`) reside side-by-side as siblings under `REPOSITORIES/`.
3. **Admin Local Loopback Isolation:** The Administrative UI and its privileged API run exclusively on local loopback:
   - Frontend: `http://127.0.0.1:60135`
   - Local API: `http://127.0.0.1:60136`
   - **Zero Public Deployment:** The Admin console is never deployed to public CDNs (Cloudflare Pages, Vercel, Netlify).
4. **Platform Authority:** Platform backend services, database migrations (`001`, `002`, `003`), RLS policies, proprietary algorithms (ALS, BPR, LMF recommendation engines), and Flutter universal client applications are owned by `Truthprenuer.git` (`REPOSITORIES/TRUTHPRENUER-PLATFORM`).

---

## 3. Repository Topology

```text
TRUTHPRENUER-AMD/                                      <-- Parent Orchestrator
├── README.md, CONTRIBUTING.md, SECURITY.md, LICENSE
├── .gitmodules                                        <-- Tracks sibling submodules
├── .gitignore
│
├── REPOSITORIES/                                      <-- Submodules Container
│   ├── TRUTHPRENUER-ADMIN/                            <-- Submodule 1 (Admin Console & Local API)
│   └── TRUTHPRENUER-PLATFORM/                         <-- Submodule 2 (Truthprenuer.git: Apps, Backend, DB, Algorithms)
│
├── GOVERNANCE/                                        <-- Architecture, ADRs, Standards
├── ARCHITECTURE/                                      <-- System, Component, Data Flow & Security
├── CONTRACTS/                                         <-- OpenAPI Schemas, DB Models, Auth Specs
├── PRODUCT/                                           <-- Roadmap, Feature Matrix, Requirements
├── QUALITY/                                           <-- Integration Gates, E2E Tests
├── SECURITY/                                          <-- Threat Models, Policies, Audits
├── DEVTOOLS/                                          <-- Multi-repo runners and validators
└── .github/workflows/                                 <-- Ecosystem Master CI
```

---

## 4. Quick Start & Developer Onboarding

### Cloning with All Submodules
```bash
# Clone the parent repository recursively
git clone --recurse-submodules https://github.com/nenavathvimal-nayak/TRUTHPRENUER-AMD.git
cd TRUTHPRENUER-AMD

# Initialize and update submodules to pinned commits
git submodule update --init --recursive
```

### Synchronizing Updates from GitHub
Use the included synchronization runner:
```bash
chmod +x sync_github.sh
./sync_github.sh
```

---

## 5. Security & Verification

Run the ecosystem validator to inspect repository boundaries, network isolation, and test suite health:
```bash
./DEVTOOLS/SCRIPTS/validate_workspace.sh
```
