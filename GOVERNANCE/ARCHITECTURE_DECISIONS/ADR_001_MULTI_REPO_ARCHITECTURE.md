# ADR-001: Adoption of Multi-Repository Architecture with Git Submodules

## Status: Accepted

## Context
The Truthprenuer system encompasses diverse technical domains:
1. Consumer mobile and web applications (Flutter/Dart).
2. Administrative consoles with elevated operational privileges (React/TypeScript).
3. Public API gateways, proprietary mathematical algorithms, and relational database schemas (FastAPI/PostgreSQL).

A single monolithic repository creates security risks (leakage of admin/privileged tools into public mobile apps), bloated CI pipelines, and versioning bottlenecks. Ordinary subfolders without independent Git history would forfeit independent release tags and issue tracking.

## Decision
Adopt a multi-repository architecture coordinated by a parent orchestrator (`TRUTHPRENUER-AMD`) via Git submodules:
- `TRUTHPRENUER-ADMIN`: Dedicated to administrative tools and local privileged API.
- `TRUTHPRENUER-PLATFORM`: Dedicated to shared platform backend, database migrations, and algorithms.
- `Truthprenuer`: Dedicated to consumer Flutter applications.

## Consequences
- Independent release lifecycles and dedicated CI runners.
- Cryptographic submodule gitlink (mode `160000`) pinning in the parent repository.
- Parent updates are explicit, intentional, and verifiable.

