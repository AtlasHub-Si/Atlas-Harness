# ADR-0005 — Atlas Control Plane: portable cloud architecture, AtlasBot remote access and transactional email

**Date:** 2026-11-13  
**Status:** Proposed architecture for V0.1; service provisioning and commercial release **not** approved by this ADR.  
**Scope:** Atlas-Harness strategic architecture, Atlas-Bot-Desktop control-plane dependencies, Atlas-Agent execution and future Cloud / Free / Enterprise editions.  
**Owners:** Architecture / AtlasHub.SI. Website code and landing remain under Z.AI / GLM 5.3. GPTWORK owns ongoing Atlas-Bot-Desktop source hygiene.

## Findings grounded in current Desktop source (main at `78c9955050c3f0050227c24cbf03af1e7523942e`)

- CI workflow `atlasbot-check.yml` completed successfully on commit `78c99550` (GitHub run 43513242238): install, i18n, three typechecks and build. This does **not** establish installer/upgrade, end-to-end or remote compatibility.
- `apps/auth-api` is TanStack/Solid on **Cloudflare Workers**, with **D1** account/session DB and **R2** asset storage. D1 is a Cloudflare service, not an AWS RDS database or directly transplantable runtime.
- `remote/api` is a Bun/Elysia signaling service; `remote/compose.yaml` includes ACME, WebSocket Signal and **coturn** for WebRTC P2P/relay. COTURN has UDP/network constraints (and the inherited Compose uses `network_mode: host`). Never deploy it inside the existing Helena/GWD VPS network by copying the upstream Compose blindly.
- Production `apps/auth-api/wrangler.jsonc` **still points to openbot.run zone, api.openbot.run, signal.openbot.run, relay bindings and inherited app/service identifiers**. `HOSTED_SERVERS_ENABLED` is `true` and allowed IDs `*` in inherited configuration. **Deployment of this file verbatim is prohibited**: zone and API route references must be replaced, hosted server creation default OFF, secrets/keys issued independently, Stripe/GitHub apps/mobile push/webhook callbacks migrated or disabled.
- The inherited account OTP email uses SMTP/relay bindings and `hello@openbot.run`. No Atlas-authenticated production email endpoint exists yet. The current desktop can still reach upstream account services until explicitly isolated.
- The upstream application package still retains technical identifiers (`openbot.desktop`, package names and protocols). Rename only with a separately validated migration plan to protect users' local workspace data.
- Desktop uses PolyForm Noncommercial upstream rights; no Atlas commercial binary or installer is authorized just by rebranding.

## Architectural decision

**Atlas Control Plane** is the product-level API contract covering Atlas user accounts, organizations, tenancy, membership, sessions, device and agent-host enrollment, remote tickets and revocations, entitlements, update authorization, audit events and support. It is logically separate from agent execution and from any cloud vendor.

**Staging-first hybrid implementation (minimum change):**
1. Bootstrap **Atlas-owned Cloudflare Workers + D1 + R2** from `apps/auth-api` in a separate Atlas environment, with own project names, migration DB, binding identities, secrets and domain. First deploy in **staging only**. The existing OpenBot production config must not be deployed unchanged.
2. Use the **existing VPS OpenBot systemd** as the internal, already-running agent host for first Windows-to-agent tests. Never launch a duplicate server until account/remote compatibility is verified. New Atlas authentication will need explicit client/server configuration and migration; changing the API URL alone is insufficient.
3. Create an **AWS staging/production workload account** (subject to AWS Activate, spending guardrails and access approval) for future agent hosts, remote signaling/relay capacity and operational services. Signal/TURN can run on an independently controlled host with suitable fixed IP, certificates, WSS, UDP/relay ranges and isolation. AWS compute choices (EC2/ECS) require a sizing/design review.
4. Use a single portable Control Plane HTTP API contract and provider interfaces for `IdentityStore`, `EmailSender`, `ObjectStore`, `AgentHostProvisioner`, `SessionTicketSigner` and `BillingAdapter`. Preserve tenant and role authorization semantics in the application, not in AWS-only IAM or Cloudflare-only metadata.
5. **AWS-native alternative (P1):** implement the API in ECS/Fargate or other approved compute with PostgreSQL (RDS/Aurora), S3 and corresponding observability/secrets. This is a migration project (D1 SQLite semantics, API bindings, R2 operations, sessions and event outbox), not a lift-and-shift. Only do it after cost, licensing, scalability and portability analysis.

The architecture should enable third-party customer clouds using explicit enrollment, signed short-lived credentials, isolated host identity and per-tenant policies. Never assume all client hosts must be accessible on a public inbound port; use the remote signaling/ticket protocols when appropriate.

## Edition boundaries (product direction; dependent on rights clearance)

| Edition | Control plane dependencies | Data and hosts |
| --- | --- | --- |
| Local / Free candidate | Core local-agent workspace usable offline where technically supported; account only for cloud features | Customer device, local workspace |
| Atlas-managed Cloud | Atlas Control Plane, owned signaling, identity, revocation and entitled remote services | Atlas-managed agent host, separated tenant resources |
| Enterprise / Self-Hosted | Customer-run control plane or contractual managed identity and independently controlled host endpoints; no forced shared Atlas execution data plane | Customer VPS, AWS or independent cloud. Verify genuine full offline/independent operation before advertising |

**Do not claim a fully self-hostable edition until upstream account and signaling dependencies are replaced/tested.**

## Transactional email decision

**P0: Use Resend HTTP API** for Atlas onboarding one-time codes and recovery because it already fits the ecosystem and has a Cloudflare Workers integration. Maintain an `EmailSender` interface: `sendOtp`, `sendRecovery`, `sendSecurityAlert` and `sendServiceNotice`; permit AWS SES later without touching account session code.

- Suggested `From`: `AtlasBot <no-reply@atlas-si.com>` after domain verification. `support@atlashub.si` = support; `legal@atlas-si.com` = legal; neither should be used as the default one-time-code sender.
- Use independently scoped Resend API keys in a secrets store (Workers secrets or AWS Secrets Manager), never in GitHub. Verify sending domain SPF/DKIM/DMARC, return-path, testing inboxes, webhook signatures, bounces, complaints, retry/idempotency, per-IP and per-account OTP rate limits and suppression.
- Turn off OpenBot SMTP relay and Cloudflare Email fallback in Atlas deployment manifests **only after a tested Resend replacement is available**. Never copy `hello@openbot.run` or the upstream SMTP password, email relay or account key into Atlas.
- AWS SES can be a cost-oriented adapter at volume; verify identity and production/sandbox restrictions per AWS region. Resend and SES costs are usage dependent; see vendor pricing before approval.

## Deployment stages and explicit GO/NO-GO

**Stage 0 — Baseline/rights (P0):**
- [ ] Record current GPTWORK Desktop commit, compiled outputs and upstream licence/NOTICE.
- [ ] Audit Atlas own DNS, Cloudflare zone and current endpoints for name collisions; get Z.AI coordination for website-owned routes, without changing the website.
- [ ] Locate dependency map for every `openbot.run` default, webhook, callback and updater.
- [ ] Verify account rights for internal enterprise evaluation and future commercial usage.

**Stage 1 — Atlas account backend staging (P0):**
- [ ] Create isolated staging Worker service, **new** D1 database and migrations, new R2 bucket, secret/JWK issuance, sessions, audit and backup.
- [ ] `HOSTED_SERVERS_ENABLED=false`, no wildcard tenant create, billing and upstream OAuth/connectors disabled in staging until provider-owned configuration is audited.
- [ ] Configure Resend on verified domain, send/redeem/replay/revoke OTP test cases; test account email flows independently from real customer data.
- [ ] Route through an Atlas-owned *proposed* subdomain such as `api.atlas-si.com` only after DNS/ownership check; this ADR does not authorize DNS changes.

**Stage 2 — Existing VPS remote proof (P0):**
- [ ] Test Windows AtlasBot against **existing** `openbot.service`, v0.69.0, first through its currently supported account services if terms permit; prove connectivity/reconnect/persistence.
- [ ] Migrate a **separate test account** to new Atlas auth API; verify ticket signing/JWKS/session epoch compatibility and lack of upstream dependencies. Do not copy OpenBot credentials/tokens/data.
- [ ] Design and provision Atlas Signal/TURN only if required by the test. Stage independently; avoid conflicts with protected Caddy, Docker and GWD production.

**Stage 3 — Integrations and tenancy (P1):**
- [ ] Integrate Atlas-Agent/Hermes ACP without accessing Helena legacy secrets.
- [ ] New Atlas Memory Fabric private MCP with test data; Operational Knowledge approved Markdown; one reviewed Workforce role. WorkSwarms remains optional lab.
- [ ] Validate isolated tenancy, revocation, host credential rotation, update process and full client installation.

**Stage 4 — AWS/commercialization (P1/P2):**
- [ ] Provision AWS staging with cost budgets, account IAM, network segmentation, central logs and backups; evaluate EC2/ECS for agent hosts and realtime relays.
- [ ] Decide platform-agnostic API and eventual cloud-native datastore migration from D1 after product-market and cost validation.
- [ ] Signed installers, manifest and versioned update feeds only after commercial licensing and app identity migration.

**NO-GO:** `bun run api:deploy` with inherited production Wrangler; global `docker compose up` of inherited remote stack on Helena VPS; wildcard hosted server creation; third-party credentials in Atlas; any new DNS/Caddy route without designated owner; public commercial installers before rights.

## External documentation (reference URLs)
- https://developers.cloudflare.com/d1/worker-api/
- https://resend.com/cloudflare
- https://resend.com/pricing
- https://docs.aws.amazon.com/ses/latest/dg/request-production-access.html
- https://aws.amazon.com/ses/pricing/

This decision record documents **plans and dependencies**, not services provisioned or functionality validated in Atlas production.
