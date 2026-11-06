# Database Schema & Migration Governance Contracts

## 1. Migration Sequence
All relational database tables and triggers are managed sequentially inside `TRUTHPRENUER-PLATFORM/DATABASE/MIGRATIONS/`:

1. **`001_initial_schema.sql`**:
   - `profiles`, `startups`, `pitches`, `votes`, `comments`, `ai_validations`.
   - Initial RLS policies ensuring users can only edit their own profile and startup data.
2. **`002_security_and_trust_upgrade.sql`**:
   - Security hardening, RLS role isolation functions (`is_admin()`, `is_moderator()`).
   - Anti-tampering triggers on vote weights and reputation scores.
3. **`003_audit_worm_and_role_guards.sql`**:
   - Write-Once-Read-Many (WORM) audit logging table `audit_logs`.
   - Immutable audit triggers preventing update or deletion of historical operational events.

## 2. Row Level Security (RLS) Mandate
- Every table created in PostgreSQL **MUST** have RLS enabled: `ALTER TABLE <table_name> ENABLE ROW LEVEL SECURITY;`.
- Default behavior: Deny all operations unless explicitly permitted by an authorized policy.
- Administrative queries must pass through server-side APIs authenticated with service-role credentials.
