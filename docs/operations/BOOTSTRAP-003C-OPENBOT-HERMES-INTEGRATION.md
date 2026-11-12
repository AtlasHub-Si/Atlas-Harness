# ATLAS-HARNESS — BOOTSTRAP 003C: OpenBot ↔ Hermes live integration

**Date:** 2026-11-12  
**Status:** Ready to dispatch to the original PC OpenBot Director. Publication in GitHub is **not** transmission or VPS execution.  
**Goal:** Demonstrate a working governed **Atlas-Bot/OpenBot** user interface and orchestrator with a **separate, fresh Atlas-Agent/Hermes** execution backend, on the existing AtlasHub VPS, using a one-bot internal AG-UI adapter. DNS `bot.atlas-si.com` has been configured by owner, final published health/auth still requires evidence.

## Start point and priorities

The PC OpenBot is already coordinating the VPS deployment. **Do not restart the Bootstrap 003 audit, republish DNS, reconfigure model providers or block this phase on Atlas Intelligence Lite.** Let the current deploy finish and establish a baseline. Use existing newly created Atlas-Bot app, Intelligence Cloud Developer project and an authorized model provider, and keep all previous AtlasHub legacy services untouched.

Only create *new* Hermes profile/deployment, memory, skills, sessions and volumes. Never point the pilot at the old Hermes instance or old persistent storage. Do not use port 8642 if existing services own it. Keep new instance isolated with no public container port.

### Technical facts verified in official source

- OpenBot supports an agent attached to a private **AG-UI endpoint** via Bot configuration: see `CopilotKit/OpenBot` README, section *Bring your own agent*, and `docs/configuration.md`.
- `AGENT_ENDPOINT_ALLOWED_HOSTS` accepts internal exact host/port entries for remote AG-UI Bot registration. It is not a permission to access every internal service.
- Hermes official `website/docs/user-guide/features/api-server.md` documents `API_SERVER_ENABLED`, bearer `API_SERVER_KEY`, `GET /health`, `GET /v1/models`, `POST /v1/chat/completions`, `POST /v1/responses`, `POST /v1/runs`, streamed run events, approval operations, and stable session headers (`X-Hermes-Session-Id`, `X-Hermes-Session-Key`).
- **Hermes does not advertise a native AG-UI endpoint in this source review.** Implement a small API→AG-UI bridge; never claim its Chat Completions API is directly AG-UI compatible.
- Hermes HTTP API is an **agent with tools running on Hermes host**, not just a hosted LLM provider. A tool executed inside Hermes does **not** by default route through OpenBot's computer/policy gateway; do not assume OpenBot audits/approves Hermes-internal tools. The bridge must enforce bounded privileges and explicit approval contract before any side effect.
- See: https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/api-server.md, https://github.com/CopilotKit/OpenBot/blob/main/README.md.

## Execution phases

### 1 — Publish baseline and verify without changing existing infrastructure

1. Verify `https://bot.atlas-si.com` resolves, HTTPS valid, public UI signin redirect works, `OPENBOT_SINGLE_USER=false`, ordinary anonymous browser does not get admin access. Record failures accurately.
2. Verify newly created Atlas-Bot service/worker/database healthy, its Intelligence Cloud thread and reconnect behavior work, and one test prompt succeeds on one approved configured LLM; avoid claiming four keys imply fallback.
3. No further DNS/Caddy/Cloudflare changes are authorized by this directive. If site is unhealthy, finish preexisting publication task without introducing Hermes; report blocker.

### 2 — Fresh Hermes API sidecar (separate, restricted)

1. Pin `sergiomonteiro-atlas/Atlas-Agent` revision and reconcile with supported newer upstream `NousResearch/hermes-agent` changes; record exact SHA.
2. Build new scoped profile, volumes and explicit resource CPU/memory/pids/log limits. Do not import any old Hermes sessions, SOULs, skills, or env. Use only narrowly scoped, explicitly approved, valid provider credentials. Prefer test with a single provider; no reuse of free OpenCode chat-only provider from desktop.
3. Enable **Hermes API Server** with a new strong `API_SERVER_KEY`. Bind only within isolated internal network, not directly to the Internet. In-container interface can listen on `0.0.0.0` for Docker connectivity only if **no host ports are published**, ingress blocked, network membership limited; alternatively sidecar loopback in a shared pod/network namespace.
4. Verify authenticated `/v1/models`, `/health` and a harmless synthetic `/v1/chat/completions` or `/v1/runs` request. Capture redacted response and usage only. Disable shell/browser/payment/email/customer integrations for phase 1. Start with read-only memory and harmless summarization tools.

### 3 — Build minimal AG-UI bridge and register coworker

1. Implement `atlas-hermes-agui-bridge` as a small internal Docker service, versioned in an Atlas-owned repo (prefer a feature branch in `Atlas-Harness/prototypes/hermes-agui-bridge` or `Atlas-Agent/integrations/openbot` after repo ownership decision).
2. Accept AG-UI RunAgentInput requests, enforce allowed tenant/bot/user and authenticated server-to-server calls, and map `threadId` to distinct persistent Hermes conversation/session identifiers. Avoid inadvertent sharing across coworkers and tenants.
3. Convert Hermes stream/run events into truthful AG-UI events (run started, messages, text deltas, run finished, run error). Preserve cancellation, failure and error semantics; keep reconnect and idempotency stable. Treat Hermes custom tool-progress events explicitly (do not inject as assistant prose when unsafe). Never claim tool approval/audit propagation before implemented and tested.
4. Use backend-only bearer credentials for Hermes, and separate auth token for OpenBot→bridge. Bridge reachable only within newly isolated app network.
5. In Atlas-Bot create one test Bot: `Atlas | Hermes Executor`, remote AG-UI endpoint at internal bridge hostname/port. Add the exact internal host to `AGENT_ENDPOINT_ALLOWED_HOSTS` only if required; do not globally allow private networks. Keep all other OpenBot Bots using existing configured model providers.
6. Test OpenBot message → AG-UI bridge → Hermes → response in same OpenBot thread.

### 4 — Acceptance and benchmark

Use synthetic organization `GWD LAB` and compare **OpenBot-only** vs **OpenBot + Hermes** on the *same* tasks:

- **H01** OpenBot-only still works on public hostname with safe auth after new service starts.
- **H02** Hermes health, models and auth are reachable **only internally**.
- **H03** Test coworker `Atlas | Hermes Executor` accepts one message in OpenBot and produces Hermes output.
- **H04** Real streaming and terminal status PASS/FAIL, including deliberate harmless error/cancellation.
- **H05** Send a synthetic memory fact, restart *new Hermes process*, verify recalling the approved fact; do not rely solely on LLM remembering from the chat prompt.
- **H06** Invoke one benign read-only skill/tool and capture evidence of execution location and limitations.
- **H07** Two distinct synthetic users/tenants may not read each other's conversations, sessions, local files or skills.
- **H08** Side-effecting tool command cannot execute without an independent, enforceable authorization/approval mechanism. Until this is implemented, keep all side effects disabled and report H08 BLOCKED / not yet compliant.
- **H09** Server-side session mapping survives pilot restarts; no duplicate accidental side effects.
- **H10** The owner shuts down PC OpenBot and access/tunnels; Atlas-Bot + Hermes continue working through authorized external access path.
- **H11** Old Hermes/GBrain/Caddy/CRM/ARO/AtlasClub containers and their volumes unchanged, resource limits respected.
- **H12** Comparison table: memory, skill creation, tools, browser, policies, delegations, context continuity, latency, tokens and resource consumption. Measurements, not guesses.

### 5 — Results and decision

Provide a GitHub PR for bridge implementation, deployment recipe and automated protocol test suite, redacted test results, and explicit conclusion:
1. Keep **OpenBot-only** if Hermes adds little value to mission needs.
2. Keep **OpenBot + Hermes** if tangible gains in persistent operational memory, tooling and complex tasks exceed resource/security/maintenance overhead.
3. If adapter exposes unacceptable policy bypasses, isolate Hermes and return to design instead of enabling writes.
4. No DNS exposure of Hermes API or bridge and no changes to preexisting infrastructure are allowed.

**Stop conditions:** host pressure, identity/authentication failure, unlicensed provider/model usage, key leaks, unintended egress, insufficient audit/approval controls, legacy service changes, unexpected bills. Revert only newly created pilot resources and inform owner.

**Deliverable summary required for owner:** exact running services, branch/commit URL, test URLs (never secrets), H01–H12 PASS/FAIL/BLOCKED, brief architecture diagram and recommended next GO.
