# ATLAS-HARNESS — BOOTSTRAP 004
## Atlas Intelligence Lite — Parallel Open Source Proof of Concept

**Date:** 2026-11-12  
**Status:** Technical mission ready for owner to forward to the original PC OpenBot Director. **This GitHub commit is not transmission or execution.**  
**Dependencies:** Bootstrap 002 inventory, Bootstrap 003 clean-room LAB deployment directive, Atlas-Harness ADR-0001 and ADR-0004.  
**Decision:** Run two distinct deployments against an independently installed Atlas-Agent (Hermes). Never patch or disrupt existing AtlasHub services.

### Research baseline (verified from upstream code)

- CopilotKit OSS `@copilotkit/runtime/v2` provides `AgentRunner` and `InMemoryAgentRunner`.
- CopilotKit OSS `@copilotkit/sqlite-runner` provides `SqliteAgentRunner`, persisting AG-UI events and run history in SQLite when its `dbPath` is a **real persistent file**. Default `:memory:` is not persistent.
- It stores run history and ownership state; it is **not** the CopilotKit Intelligence service. Some thread management endpoints are Intelligence-only and a full useThreads sidebar/realtime gateway requires additional work.
- The OpenBot fork is integrated with Intelligence and currently requires `INTELLIGENCE_API_URL`, `INTELLIGENCE_GATEWAY_WS_URL`, and `CPK_INTELLIGENCE_API_KEY`. **Do not assume that swapping to SqliteAgentRunner makes OpenBot work**. Test B is a separate CopilotKit OSS minimal app, not a patched OpenBot pretending to be equivalent.
- OpenBot itself provides policy, approvals, audit, Postgres work queue and computer supervisor. Reuse these if a future Atlas UI extracts the functions; do not copy undocumented/proprietary Intelligence server code.
- See [CopilotKit AgentRunner docs](https://github.com/CopilotKit/CopilotKit/blob/main/showcase/shell-docs/src/content/docs/(shared)/backend/agent-runner.mdx), [sqlite-runner implementation](https://github.com/CopilotKit/CopilotKit/blob/main/packages/sqlite-runner/src/sqlite-runner.ts), [setup-intelligence](https://github.com/CopilotKit/CopilotKit/blob/main/dev-docs/architecture/setup-intelligence.md), [OpenBot architecture](https://github.com/CopilotKit/OpenBot/blob/main/docs/architecture.md).

### Test A: baseline — Atlas-Bot + managed Intelligence Cloud

Use the Bootstrap 003 clean-room installation **only if** capacity and security preflight PASS. Use new credentials/project provisioned by an authorized owner sign-in, never Desktop credentials. A legitimate model provider for the new Atlas-Agent must be available; free OpenCode chat models used by the Desktop may not work via Hermes.

**Goal:** Establish a known reference for Bot UI, threads, reconnect, agent tasks, policy, approvals, auditing and basic role scopes. This is not an independence test. No commercial use without applicable rights.

### Test B: open-source Atlas Intelligence Lite — NEW prototype, independent of Intelligence

Use `Atlas-Harness` as the canonical repository; create a dedicated branch `feat/intelligence-lite-poc` and put the POC at `prototypes/intelligence-lite/`, without modifying `Atlas-Bot` at first.

Core components:

1. Minimal React/Next.js interface using `@copilotkit/react-core/v2` and `@copilotkit/runtime/v2`.
2. A `CopilotRuntime` configured with `SqliteAgentRunner({ dbPath: "/data/atlas-threads.db" })` for **single-process** persisted run events, `better-sqlite3` and volume mounted to `/data`. This is a test choice, not a production multi-replica store.
3. A deterministic fixture agent first (zero model/API cost). Prove streaming, reconnection and restart persistence.
4. A minimal typed or AG-UI adapter to a **new** Hermes instance running with fresh configuration and authorized model access; do not import the old gateway state.
5. Bounded permission/approval middleware and audit as a test control (manual confirmation before write). This is not an enterprise policy claim until tested.
6. First tenant simulation: synthetic GWD org plus a second synthetic tenant; scope every request to authenticated `tenant_id` + `user_id`, enforce server-side and prove cross-tenant denial. Never rely on raw thread IDs.
7. Seed synthetic knowledge and one approved skill; verify memory after restarting the Hermes process as well as the UI process.
8. Do not configure `INTELLIGENCE_API_URL`, `INTELLIGENCE_GATEWAY_WS_URL`, or `CPK_INTELLIGENCE_API_KEY` in **Test B**. Confirm outbound traffic does not unexpectedly call CopilotKit Intelligence. Using optional standard SDK telemetry must be disclosed and controllable; disable for independence test if appropriate.

**Known deliberate gap:** SQLite runner does not automatically furnish the full Intelligence-compatible thread list/mutation/realtime service. If the minimal app cannot render thread sidebar on day 1, record as a gap, implement a small Atlas-owned local thread index/REST facade **only after base execution tests pass**. Never claim full OpenBot equivalent based on a simple chat demo.

### Phases (gated)

**P0 — Recon and design (safe; no VPS mutations):**
- Verify upstream packages/versions/SHAs, selected CLI/runtime model access and README commands; inspect recent incompatible changes. Map exact routes needed for A and B.
- Resource preflight on shared VPS (RAM, swap, disk, port binding, Docker networking). If unsafe, build and test B on isolated developer-machine Docker first; use a separate clean VPS for PC-off test when resources are approved. Never shut old containers down for this task without a separate GO.
- Prepare deployment manifest with CPU/RAM/pids/log limits, local-only ingress, no privileged Docker socket in app containers, unique Compose project/volumes.
- Model cost: begin with deterministic agent; before Hermes model tests, request specific owner-approved provider key or approved existing model endpoint. No charges by implication.

**P1 — Code-only first:**
- Branch and commit minimal frontend/backend/runner, health route, tests, Docker build and Compose for only NEW resources, example env with placeholders.
- Add server-side identity, thread/tenant constraints and test data factory. Scope is lab; still never publish unauthenticated.
- No need to create a new standalone Atlas-Intelligence repo now. Extract after POC success and architectural review.

**P2 — Functional demonstration:**
- Test B: with **no Intelligence keys**, perform deterministic agent test, restart new service, retrieve prior messages/events and resume task; validate isolation.
- Connect to fresh Hermes using a bounded AG-UI or API bridge and test browser/skill read plus an approval-gated mock write action.
- If Test A is live, run identical synthetic prompts against both systems; compare behavior, logs, reconnect, latency and operational overhead (actual measurements only). If A blocked, proceed B and explicitly report incomplete comparison.

**P3 — Owner validation:**
- Run private-only in VPS if capacity permits; prove PC-off autonomy via a separate, owner-approved private access method not tunneled through the powered-off PC.
- Demo first synthetic organization + agents + approved skill + auditable task. Document behavior delta against OpenBot.
- Owner separately authorizes any public DNS/HTTPS routing, service shutdown, cost-bearing provider or production data.

### Acceptance checklist — each needs evidence PASS/FAIL/BLOCKED

| ID | Test | Success criterion |
| --- | --- | --- |
| ATL-01 | Build from pinned sources | Fresh checkout, install/build, manifests reproducible |
| ATL-02 | No Intelligence requirement (Test B) | Fresh environment has no Intelligence key/endpoint; agent chat succeeds |
| ATL-03 | Persisted history | Run events and message history survive **pilot-only** restart |
| ATL-04 | Hermes bridge | One bounded request executes through new Hermes with correct identity |
| ATL-05 | Permission control | Unauthorized mock-write is denied, logged; valid approval is required |
| ATL-06 | Tenant separation | Synthetic user B cannot retrieve org A data by guessed thread IDs |
| ATL-07 | Learning baseline | Approved skill and permitted memory retrievable after restart |
| ATL-08 | PC-off | Remote deployment works when original PC and its SSH tunnel are offline |
| ATL-09 | Non-interference | Existing unrelated containers, edge, DNS and volumes unchanged |
| ATL-10 | Feature delta | Show table: A vs B threads, sidebar, realtime, memory, learning, analytics, channels, audit, cost |
| ATL-11 | Provider/legal | No unauthorised use of OpenCode free tier, paid cloud, or license-bypassing image |
| ATL-12 | Rollback | Only POC resources may be stopped; safe reinstallation proven without affecting old host workloads |

### Delivery paths

- `prototypes/intelligence-lite/` — runnable, self-contained implementation in a feature branch (not just Markdown).
- `docs/research/atlas-intelligence-lite-compatibility-matrix.md` — exact A/B feature matrix, OpenBot code paths to adapt and links to test evidence.
- `docs/operations/bootstrap-004-acceptance.md` — dated PASS/FAIL/BLOCKED, commands, sanitized logs, independent test evidence.
- `docs/operations/bootstrap-004-go-no-go.md` — benefits, gaps, blockers, deployment choice, projected operating costs **only when measured or quoted**.
- One PR with the source changes and test suite; no unsupported claims of 'complete replacement'.

### Ownership and authority

Original PC OpenBot Director coordinates existing Architect / Infra / Models / Security / QA crew. This directive authorizes **code creation and lab tests** and isolated new resources consistent with Bootstrap 003 if its P0 gates PASS. It **does not** authorize changing/removing existing services, public DNS, firewall, shared ingress, host Docker daemon, payment gateways, production data, credentials, or incurring unexpected costs.

**Owner action needed:** Forward this doc to the running PC OpenBot Director; complete interactive account/project authentication only if the baseline A requires it; explicitly approve any paid model usage or a separate clean VPS if required. No additional credential is required to begin mock-agent code testing B.

### Engineering decision after results

- If B meets objective with fewer dependencies, evolve to PostgreSQL-backed event/thread service and production-grade auth/tenant tests; then gradually reproduce required Atlas-Bot UX, **without copying proprietary Intelligence code**.
- If A is substantially better for first enterprise pilots, keep A for near-term validation while developing B behind feature flags.
- REA is optional for authorized interoperability analysis. Prefer first-party source code, documented APIs and direct tests.
