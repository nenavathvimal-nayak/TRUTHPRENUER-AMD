# ADR-002: Strict Loopback Isolation for Administrative Console

## Status: Accepted

## Context
Administrative interfaces possess elevated permissions (user suspension, dispute resolution, audit inspection, system configuration). Exposing administrative interfaces to public internet DNS and web application hosting creates a large attack surface susceptible to credential stuffing, DDoS, and SSRF attacks.

## Decision
The Administrative frontend and its local backend API must run strictly on local loopback:
1. **Frontend Host:** `127.0.0.1` strictly (never `0.0.0.0`).
2. **Frontend Port:** `60135` strictly (`strictPort: true`).
3. **Local API Host:** `127.0.0.1` strictly.
4. **Local API Port:** `60136` strictly.
5. **Zero Public Cloud Deployment:** The Admin console must never be published to Cloudflare Pages, Vercel, Netlify, or any public web server.

## Consequences
- Administrative operations can only be initiated by authorized operators with physical or secure VPN/SSH access to the designated operator machine.
- Local API enforces origin validation, host header validation, and cryptographic JWT verification to prevent DNS rebinding and cross-site requests.
