# Repository Ownership & Responsibilities

| Subsystem | Owning Repository | Runtime Language | Port / Ingress |
| :--- | :--- | :--- | :--- |
| **Parent Ecosystem Governance** | `TRUTHPRENUER-AMD` | Git / Bash / CI | N/A |
| **Admin Console UI** | `TRUTHPRENUER-ADMIN` | TypeScript / React 19 | Loopback `127.0.0.1:60135` |
| **Admin Local Privileged API** | `TRUTHPRENUER-ADMIN` | Python 3.11 / FastAPI | Loopback `127.0.0.1:60136` |
| **Platform Public API Gateway** | `TRUTHPRENUER-PLATFORM` | Python 3.11 / FastAPI | Port `8000` / Cloud Ingress |
| **Relational Database Schemas** | `TRUTHPRENUER-PLATFORM` | SQL / PostgreSQL 15 | Managed Supabase / Port 5432 |
| **Proprietary Algorithms Engine** | `TRUTHPRENUER-PLATFORM` | Python 3.11 / NumPy | Embedded Service |
| **Consumer Client Applications** | `Truthprenuer` | Dart / Flutter 3.29.0 | Web / iOS / Android / Desktop |
