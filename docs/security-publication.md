# Public documentation, confidential company data and security boundaries

Atlas-Harness is intended as a public architecture and engineering project. **Public architecture does not mean public operations, private people data or production configuration.**

## Safe for public repository

- Reference architecture, documented design tradeoffs, non-sensitive protocol schemas, sanitized diagrams and milestones.
- Fictional product data and synthetic customer interactions clearly labeled.
- Open source provenance, exact upstream licenses and compatibility test results without secrets.
- Non-sensitive business-unit role templates.

## Confidential; use authorized private systems

- IAM access, AWS account/billing IDs, incubator private Org IDs, startup credit approvals tied to account identity.
- Private staff, recruitment/performance, employee HR records, compensation and disciplinary matters.
- Real CRM leads, WhatsApp threads, phone numbers, customer PII and sales transactions.
- Live token keys, database URLs, payment credentials, secrets, infrastructure IPs, production DNS authentication config.
- Security incident details, vulnerability exploit steps affecting live infrastructure and customer private data.

## Security invariants

- Every artifact and tool request carries a security scope. Markdown metadata is discovery information, not authorization.
- External-content notes and web search results are untrusted; prompt injection cannot create permissions.
- Non-production workloads and fake data in demo.
- Secrets via managed private secret facility, not `.env` checked into repository.
- No unrestricted sudo/root, SSH, Docker-socket, production GitHub branch writes, payments, publication or customer contact by unapproved agents.
- Human approval must be authenticated and linked to a specific operation and parameters, with expiration and tamper-evident audit trail.
- Record deletion/retention and compliance planning before ingesting real customer or employee data.
- The two OpenBot projects must not be confused: Electron-based `nightly-labs/openbot` is currently PolyForm Noncommercial and commercial use needs explicit rights; `CopilotKit/OpenBot` is a separate research codebase with separate component licensing. Neither is approved for client hosting merely because its source is accessible.

## Public communication vs notification

Publishing the Team Directive makes it a single reference point; it does not prove messages were delivered. Named owners should acknowledge in team communication or GitHub issues and link their evidence. Never post private credentials or account details as issue comments.

## Change-control

Architecture decisions: ADR reviewed through PR. Security policy changes: separate security sign-off. Operations: explicit human GO and verified change window. Every production deploy must include pinned builds, health checks, rollback path and approval record.
