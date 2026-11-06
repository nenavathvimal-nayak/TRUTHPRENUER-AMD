# Security Policy: Truthprenuer Ecosystem

## 1. Reporting Security Vulnerabilities
If you discover a security vulnerability within the Truthprenuer ecosystem, please report it immediately via private channel or email to `security@truthprenuer.com`. Do not disclose vulnerabilities publicly or open public GitHub issues for security flaws.

---

## 2. Security Architecture Invariants

### A. Zero-Trust Admin Isolation
- The Admin Console frontend is strictly bound to `http://127.0.0.1:60135`.
- The Admin Local Privileged API is strictly bound to `http://127.0.0.1:60136`.
- External / public network requests (`0.0.0.0`) are forbidden and rejected at the socket layer.
- Admin UI and Local API are **NEVER** deployed to public hosting (Cloudflare Pages, Vercel, Netlify).

### B. Credential Isolation
- Browser-side client applications (Flutter, React Admin) must **NEVER** contain service-role keys, database master credentials, or private API keys.
- Client applications only utilize public Supabase anon keys coupled with strict server-side Row Level Security (RLS).
- All privileged database operations are handled exclusively by server-side APIs running in protected environments.

### C. Cryptographic Authentication & RBAC
- All administrative requests require a cryptographically signed JWT with verified signature, active expiration, and role declared within server-managed `app_metadata`.
- Client-writable `user_metadata` claims of administrative roles are rejected with HTTP 403 Forbidden.
- Unverified, expired, or malformed tokens fail-closed with HTTP 401 Unauthorized.

