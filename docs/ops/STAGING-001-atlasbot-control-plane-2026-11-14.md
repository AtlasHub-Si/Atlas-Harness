# AtlasBot Control Plane — STAGING-001 | Verified resources and upstream-dependency exit plan

**Created:** 2026-11-14. **Status:** infrastructure reserved, **no Atlas auth API deployed**.  
**Owner:** AtlasHub.SI Architecture. **Code ownership:** GPTWORK maintains `Atlas-Bot-Desktop` while hygiene is active. **Website:** Z.AI is the sole owner of `atlas-si-website`.

## 1. Verified infrastructure (not a claim of readiness)

### Resend (confirmed by connector)
- Sending domain: **atlas-si.com**.
- DNS DKIM/SPF/return-path/CNAME: **verified**.
- Region: **sa-east-1 (São Paulo)**.
- Sending enabled; receiving disabled; tracking disabled.
- A test message from `AtlasBot <no-reply@atlas-si.com>` to the designated test mailbox was accepted and returned status **delivered**.
- **No Resend API key has been created**; do not place long-lived tokens in GitHub or public chat logs.

### Cloudflare (confirmed by connector)
- Account: AtlasHub digital, zone `atlas-si.com` **active**.
- D1 database: `atlasbot-auth-staging`, ID `321fd070-533d-4708-b108-af97f809e8d8`.
- R2 buckets: `atlasbot-avatars-staging`, `atlasbot-skills-staging`, `atlasbot-sites-staging`.
- Two unrelated `atlashub-brand-*` R2 buckets already exist. Preserve them and their access policies.
- **No auth Worker deployed, D1 migrations applied, R2 data uploaded, DNS API record created or production credentials installed.**
- Created D1/R2 resources may incur usage-related charges. Confirm residency, account budget, R2 access model and data protection before real identities/PII. D1/R2 locations are **not implied** by the Resend São Paulo region.

## 2. Existing source and risks

`AtlasHub-Si/Atlas-Bot-Desktop` current code audited at `78c9955050c3f0050227c24cbf03af1e7523942e` (CI success run 43513242238; no functional or installer tests). The monorepo has:
- `apps/auth-api` = Cloudflare Worker/TanStack Start, D1 account and ticket data, R2 avatars/skills/sites, migrations and email login.
- `remote/api` = Bun/Elysia Signal WebSocket and ticket validation.
- `remote/compose.yaml` = Signal + coturn, host networking on TURN and public ports; **do not run this on Helena VPS**.
- Upstream production Wrangler contains `openbot.run` zone IDs/routes, SMTP relay `hello@openbot.run`, `REMOTE_SIGNAL_URL` upstream, `HOSTED_SERVERS_ENABLED=true`, `HOSTED_SERVERS_ALLOWED_USER_IDS=*`, upstream GitHub app and APNs IDs. **Absolutely do not deploy this unchanged**.
- Existing VPS `openbot.service` was reported alive as v0.69.0 and still may rely on upstream accounts and remote services. Its activity does not mean Atlas has independent authentication.
- OpenBot's upstream license is **PolyForm Noncommercial 1.0.0**; rebranding and cloud ownership do not grant commercial distribution rights. Copyright/derivative rights review is a blocking legal workstream.

## 3. Target architecture and repository boundaries

- **Atlas-Control-Plane (logical service)**: identity, OTP, sessions, organizations/tenant RBAC, registered devices and agent hosts, signing keys/JWKS, short-lived remote tickets, authorization epochs/revocation, entitlements, audit and customer support. V0.1 source can remain `apps/auth-api` under GPTWORK coordination; a separate versioned repository/service should be created only after build/dependency contracts and license obligations are reviewed.
- **Atlas Connection Plane**: own Signal HTTPS/WSS and coturn/STUN/TURN, with dedicated host/network, public IP and restricted TURN relay ranges. Replaces upstream signal and session endpoints; connects to Atlas control plane for independently issued tickets and revocation.
- **Atlas Execution Plane**: AtlasBot local client, isolated agent hosts (internal VPS, Atlas Cloud/AWS, customer BYOC) and Atlas-Agent/Hermes ACP. Never let remote hosts receive customer organization-wide secrets.
- **Atlas Harness plane**: GBrain private MCP + approved Knowledge Markdown/Obsidian + reviewed Workforce role catalog; tenant/scope enforcement and audit independent of remote signaling.

Backend portability interfaces: `IdentityStore`, `EmailSender` (Resend P0 / SES optional), `ObjectStore`, `TicketSigner`, `RemoteDirectory`, `Provisioner`, `BillingAdapter`. Stable API contracts must not embed D1 IDs, Cloudflare-only JWT claims or AWS-specific host assumptions.

## 4. Execution checklist, precise order

### P0A: staging auth backend (next engineering unit)
- [x] Sending domain verified and transactional deliverability tested.
- [x] Atlas D1 and three R2 staging resources created in separate namespace.
- [ ] GPTWORK provides frozen API interface/build SHA or a worktree to avoid clobbering concurrent Desktop changes.
- [ ] New **staging-only** Worker name `atlasbot-auth-staging`; create an independent `wrangler.atlas-staging.jsonc` that does **not inherit** production OpenBot routes, secrets, Cloudflare zone IDs, SMTP, Stripe, OpenBot relay or server provisioning. Keep `workers_dev` under control; use a restricted staging test endpoint before DNS.
- [ ] Bind D1 `DB`, R2 `AVATARS`, `SKILLS`, `SITES`. Verify object access is denied by default and each tenant has mandatory namespace/policy check.
- [ ] Review **all** SQL migrations for inherited users, billing, hosted servers, external webhooks and production assumptions. Apply to the new empty D1 only; verify version and drift. No production account imports.
- [ ] `HOSTED_SERVERS_ENABLED=false` and no wildcard hosted servers in staging.
- [ ] Create separate JWK/ES256 ticket signing keys, sessions, OTP HMAC and webhook secrets using a secret manager; secret names can be documented, **not values**. Separate staging keys from prod and from upstream.
- [ ] Implement Resend delivery adapter in the backend with idempotency, sender `AtlasBot <no-reply@atlas-si.com>`, OTP expiration/replay/rate-limit tests, bounce handling. Do not create key until staging secret storage path exists. Restrict key to `sending_access` and `atlas-si.com`; rotate any key printed in chat history.
- [ ] E2E smoke: registration/email OTP/session/refresh/revocation, wrong code, expired code, retries, suspended user, tenant leakage. Confirm no traffic to upstream `api.openbot.run`.

### P0B: remote independence
- [ ] Build Atlas-owned Signal + TURN staging behind isolated network with own host identity and TLS; no direct reuse of upstream auth webhook secrets, server claims or signaling tickets.
- [ ] Client chooses Atlas API and Signal endpoints via **explicit environment/configuration**, not broad find-and-replace of wire protocols or local data paths.
- [ ] Migrate one disposable remote host/test account, not the legacy OpenBot users. Validate replay protection, reconnection, server claim/enrolment and unauthorized host rejection.
- [ ] Fallback through TURN when P2P fails; verify NAT traversal, range limits, bandwidth/cost, TURN credentials and no upstream domain calls.

### P0C: integration and feature proof
- [ ] AtlasBot Desktop ⇄ own Atlas account service ⇄ own Signal/TURN ⇄ private agent host.
- [ ] Hermes ACP agent task using isolated credentials and actual `openbot` service user.
- [ ] GBrain MCP private, source exclusively `AtlasHub-Si/Atlas-Memory-Fabric`; approved synthetic Markdown source + provenance/revocation; one approved Workforce role; WorkSwarms remains off.
- [ ] Validate local-offline features separately; no forced Atlas auth when local work should be offline.

### P1: commercial/enterprise readiness
- [ ] All `openbot.run` routes, default URLs, account relays, callbacks, marketplace, installers, mobile IDs, update feeds, source assets, app identity and analytics inventoried; no inherited production calls during controlled integration tests. Preserve technical compatibility IDs until migrations are proven.
- [ ] BYOC enrollment, tenant isolation, key rotation, backups/restores, audit, billing and rollback.
- [ ] AWS landing zone/IAM/spending controls and separate agent host / Signal-TURN infrastructure. Keep Cloudflare D1 for V0.1; migrating to AWS PostgreSQL/S3 requires a deliberate data/schema/API conversion.
- [ ] Licensor permission or independently implemented and audited runtime for any commercial OpenBot-derived distribution. Existing PolyForm Noncommercial attribution/terms remain.

## 5. Critical coordination

- **GPTWORK:** Desktop source, build/CI, packaging, configuration split, endpoint replacement once agreed, tests. Do **not** push to their branch while work runs.
- **Atlas architecture:** Harness contracts, staging ownership, Resend/Cloudflare infrastructure, verification and test evidence.
- **Helena:** existing VPS resources, `openbot.service` and four legacy agents; no redeployment or cleanup from this work.
- **Z.AI:** website/landing only. No website change from this work.
- **Brand:** `AtlasHub-Si/atlas-brand-system` is **private**; frozen reference in `BRAND_LOCK.json`, development-only assets V0.7 approval. **Naming resolved on 2026-11-14:** the canonical enterprise name is **Atlas Harness**, with technical slug **`Atlas-Harness`**. `Atlas-Hardness` is an error on the frozen visual reference, not another product. See [the formal brand naming decision](https://github.com/AtlasHub-Si/atlas-brand-system/blob/main/docs/NAMING_DECISION_2026-11-14.md); do not rewrite frozen visual assets. Do not publish source brand assets into a public Desktop repo before provenance and release approval.

## 6. Immediate acceptance gate

Before claiming 'independent of original creator', capture a network trace/test report showing **no calls to the original domains/services** across:
1. New user → OTP → login → session restore/logout.
2. Register/connect/revoke server; WebRTC direct and relayed connection.
3. Multiagent execution and file sharing.
4. Marketplace and optional extensions disabled or Atlas-owned.
5. Software update/reinstall; app identity/local data migration.
6. Enterprise BYOC deployment and backup/restore.

**Runtime independence and licensing clearance are separate requirements. Neither can be inferred from a passing build.**

No public Worker or API deployed by this status report.
