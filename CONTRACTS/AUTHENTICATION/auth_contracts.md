# Authentication & Authorization Integration Contracts

## 1. Token Standards
- **Standard:** JSON Web Token (JWT), RFC 7519.
- **Signing Algorithm:** HS256 / RS256.
- **Issuer / Provider:** Supabase Authentication.

## 2. Claims Hierarchy & Privilege Enforcement
- **Public Client Persona:**
  - Token claims include `sub` (user UUID) and `email`.
  - Roles inside `user_metadata` (e.g. `user_metadata.role`) are treated as **untrusted client data**.
- **Privileged Administrative Persona:**
  - Administrative roles (`Admin`, `Super_Admin`) **MUST** be provisioned exclusively inside `app_metadata` (e.g. `app_metadata.role = "Admin"`).
  - Any request attempting to claim administrative access via `user_metadata` is rejected with `HTTP 403 Forbidden` (`privilege escalation detected`).

## 3. Fail-Closed Principles
- If `SUPABASE_JWT_SECRET` is unset or blank in production, the API service must fail fast at startup.
- Unsigned, forged, malformed, or expired tokens return `HTTP 401 Unauthorized`.
- Non-admin personas (`Founder`, `Investor`, `Creator`, `Professional`) attempting to access administrative endpoints return `HTTP 403 Forbidden`.

