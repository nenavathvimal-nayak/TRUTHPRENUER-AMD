# ADR-003: Platform Core Ownership of Database Migrations and Algorithms

## Status: Accepted

## Context
Previously, database schema migrations (`001`, `002`, `003`) and proprietary algorithms (`ALGORITHMS/`) existed in duplicate across the mobile application repository and the newly created platform repository. This created drift risk, multiple conflicting sources of truth, and uncommitted file discrepancies.

## Decision
Designate `TRUTHPRENUER-PLATFORM` as the sole authoritative owner for:
1. PostgreSQL database schema, migrations, triggers, functions, and RLS policies.
2. Proprietary mathematical algorithms (validation consensus, credibility scoring, hybrid search, implicit ALS/BPR/LMF recommendation engines).
3. Docker Compose environments and cloud deployment infrastructure.

Legacy copies in `Truthprenuer.git` will be cleaned, dedicating that repository strictly to Flutter universal client applications.

## Consequences
- Guaranteed single source of truth for all database changes and domain mathematics.
- Cleaner mobile client repository focused strictly on user experience, UI components, and state management.

