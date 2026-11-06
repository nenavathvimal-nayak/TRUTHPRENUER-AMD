# TRUTHPRENUER-AMD

**Classification:** Master Multi-Repository Ecosystem Orchestrator & Governance Hub  
**Repository Identity:** `https://github.com/nenavathvimal-nayak/TRUTHPRENUER-AMD.git`  
**Default Branch:** `main`  
**Architecture:** Multi-Repository Git Submodule Orchestration  

---

## 1. Executive Overview

`TRUTHPRENUER-AMD` is the authoritative parent orchestrator for the entire Truthprenuer engineering ecosystem. It coordinates technical governance, cross-repository testing, shared API contracts, security compliance, CI/CD orchestration, and version releases across independent sub-repositories.

### Core Ecosystem Components

| Repository Name | Role | Classification | Technology Stack | Hosting / Target |
| :--- | :--- | :--- | :--- | :--- |
| **`TRUTHPRENUER-AMD`** (Parent) | Ecosystem Controller & Governance | Orchestrator | Git Submodules / Bash / GitHub Actions | GitHub Master Hub |
| **`TRUTHPRENUER-ADMIN`** (Child 1) | Local Admin Console UI & Local Privileged API | Sub-Repository | React 19 / Vite 8 / Python 3.11 (FastAPI) | Local Only (`127.0.0.1:60135` & `60136`) |
| **`TRUTHPRENUER-PLATFORM`** (Child 2) | Shared Backend, Database & Algorithms | Sub-Repository | Python 3.11 / PostgreSQL 15 / Supabase / Docker | Cloudflare / Fly.io / Supabase Cloud |
| **`Truthprenuer`** (Child 3) | Flutter Universal Client Applications | Sub-Repository | Flutter 3.29.0 / Dart 3.7+ | Web / iOS / Android / Desktop |

---

## 2. Architectural Boundaries & Principles

1. **Zero Monolith:** The parent repository does **not** house application source code for Admin, Platform, or User applications. Each domain maintains its own independent Git repository, commit history, branch policies, and release cycles.
2. **Strict Admin Local Loopback:** The Administrative UI and its privileged API run exclusively on local loopback:
   - Frontend: `http://127.0.0.1:60135`
   - Local API: `http://127.0.0.1:60136`
   - **Zero Public Deployment:** The Admin console is never deployed to public CDNs (Cloudflare Pages, Vercel, Netlify).
3. **Single Source of Truth:** Platform backend services, database migrations (`001`, `002`, `003`), RLS policies, and proprietary algorithms (ALS, BPR, LMF recommendation engines) are owned exclusively by `TRUTHPRENUER-PLATFORM`.
4. **Client Purity:** `Truthprenuer` focuses entirely on user-facing client code and assets, free of backend administrative logic or duplicated services.

---

## 3. Repository Topology

```text
TRUTHPRENUER-AMD/                                      <-- Parent Orchestrator
├── README.md, CONTRIBUTING.md, SECURITY.md, LICENSE
├── .gitmodules                                        <-- Submodule declarations
├── .gitignore
│
├── REPOSITORIES/                                      <-- Submodules Directory
│   ├── TRUTHPRENUER-ADMIN/                            <-- Submodule 1 (Admin Console)
│   ├── TRUTHPRENUER-PLATFORM/                         <-- Submodule 2 (Core Platform)
│   └── TRUTHPRENUER-USERS/                            <-- Submodule 3 (Flutter Client)
│
├── GOVERNANCE/                                        <-- Architecture, ADRs, Standards
├── PRODUCT/                                           <-- Roadmap, Feature Matrix, Specs
├── CONTRACTS/                                         <-- OpenAPI Schemas, DB Models
├── QUALITY/                                           <-- Integration Gates, E2E Tests
├── SECURITY/                                          <-- Threat Models, Policies, Audits
└── DEVTOOLS/                                          <-- Multi-repo runners and validators
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
