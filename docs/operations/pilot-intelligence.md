# Bootstrap 003 — Intelligence Cloud and the Hermes model provider

**Date:** 2026-11-12
**Author:** Models (Atlas)
**Mode:** read-only analysis. No VPS service, volume, DNS, credential or configuration was changed. No secret value appears in this document; only variable names.
**Scope:** the two external dependencies that decide whether the clean-room pilot can boot: a new CopilotKit Intelligence Cloud project, and an independent model provider for the Hermes fork (Atlas-Agent).

## 1. What was asked

1. The exact owner procedure to authenticate, create a project and issue a project API key for managed Intelligence, the environment values the fork needs, plan limits, and what is not allowed.
2. Whether the Atlas-Agent fork on the pilot VPS exposes an OpenAI-compatible `API_SERVER`, which providers its `.env.example` supports, and one recommended independent provider with cost and limit.
3. What stays blocked without these two, and what can run without them.

## 2. Evidence

| Claim | Evidence |
| --- | --- |
| The fork refuses to boot without three Intelligence values | `Atlas-Bot/server/src/config.ts` L1179–1199: `INTELLIGENCE_API_URL`, `INTELLIGENCE_GATEWAY_WS_URL`, `CPK_INTELLIGENCE_API_KEY` (or legacy `INTELLIGENCE_API_KEY`) are read together; the error is `CopilotKit Intelligence is required and is not configured` |
| Managed values are fixed public endpoints | `Atlas-Bot/.env.example` L122–149: `INTELLIGENCE_API_URL=https://api.intelligence.copilotkit.ai`, `INTELLIGENCE_GATEWAY_WS_URL=wss://realtime.intelligence.copilotkit.ai`, `CPK_INTELLIGENCE_API_KEY=` (empty, filled by CLI), `COPILOTKIT_LICENSE_TOKEN=` (blank by design) |
| The licence token is not part of managed setup | Same file L146–149; `config.ts` L1174–1177: entitlement comes from the project key |
| Hermes serves an OpenAI-compatible API | `Atlas-Agent/gateway/platforms/api_server.py` L3–5, route table L1551–1575: `/v1/chat/completions`, `/v1/responses`, `/v1/models`, `/v1/capabilities`, `/v1/runs`, `/api/sessions`, `/health*`; documented listener `http://localhost:8642/v1` with `API_SERVER_KEY` |
| `API_SERVER_*` is read from the environment but absent from `.env.example` | `gateway/config_env.py` L123–129 (`API_SERVER_KEY`, `API_SERVER_PORT`, `API_SERVER_HOST`, `API_SERVER_MODEL_NAME`); `agent/secret_scope.py` L214–215; grep of `.env.example` returns no `API_SERVER_` line |
| A custom OpenAI-compatible endpoint is supported | `hermes_cli/auth.py` L177 (provider `openai-api`, `OPENAI_BASE_URL` override); `hermes_cli/main.py` L1037–1044; `hermes_cli/main_provider_setup.py` L37 (provider `custom`) |
| The pilot VPS still runs its own FCC proxy | `systemctl is-active atlas-agent-engine` → `active`; `GET http://127.0.0.1:8082/health` → `200` (2026-11-12) |
| Docs consulted | `docs.copilotkit.ai/intelligence/managed-intelligence-platform`, `/intelligence/quickstart`, `/intelligence/plans`, `/intelligence/self-hosting-local`, `/intelligence/overview` |

## 3. Managed CopilotKit Intelligence

### 3.1 What it is

Cloud-hosted Intelligence is CopilotKit's managed service for durable AG-UI threads, User Memory and Automatic Learning. The app keeps its own runtime; the project key connects that runtime to one project. A project is one app or one environment, and its keys and threads are separate from every other project. It is the only supported path for this pilot: self-hosted production Intelligence is an Enterprise Helm/ECS deployment, and the CLI "local evaluation" stack is a macOS Docker Desktop preview (Linux unverified) that does not run on Windows.

### 3.2 Owner procedure

The owner must run this on their own machine, signed in to their own CopilotKit account. Nothing here needs the OpenBot Desktop installation, and no value from it may be reused.

1. Open <https://intelligence.copilotkit.ai> (or <https://dashboard.operations.copilotkit.ai/sign-in?post_auth_redirect=ready>) and sign in with the owner's account.
2. Accept the CopilotKit Self-Service Agreement on first use; it is asked once per account.
3. Create a new **organization** for Atlas (do not join the Desktop's organization), or select it if it already exists.
4. Choose the **Developer** plan — the no-cost plan, no card required. Do not start a paid plan for the pilot.
5. Create a **new project** for the pilot, for example `atlas-pilot-clean-room`. Do not reuse the Desktop project.
6. From the pilot repository directory on a machine with Node 22+, run:
   ```
   npx copilotkit@latest login
   npx copilotkit@latest project select
   ```
   `login` opens the browser; `project select` creates the project API key and writes it to `.env` in the current directory. The command does not print the key.
7. Confirm the key exists in `.env` as `CPK_INTELLIGENCE_API_KEY=cpk-...`. If the runtime reads a different file, copy the line there.
8. Optionally open the project's **API Keys** page to confirm the key and its creation time; a later `project select` issues another key for the same project.
9. Hand the three values to the deployment secret store (see 3.3). Never commit them, never paste them in chat, never put them in a frontend build variable.
10. Record the project name, organization and plan in the pilot build manifest so the same project is not silently re-created.

### 3.3 Environment contract

| Variable | Value | Required |
| --- | --- | --- |
| `INTELLIGENCE_API_URL` | `https://api.intelligence.copilotkit.ai` | yes |
| `INTELLIGENCE_GATEWAY_WS_URL` | `wss://realtime.intelligence.copilotkit.ai` | yes |
| `CPK_INTELLIGENCE_API_KEY` | `cpk-...`, issued by `project select` | yes |
| `COPILOTKIT_LICENSE_TOKEN` | empty — managed Intelligence issues none | no |
| `INTELLIGENCE_BROWSER_GATEWAY_WS_URL` | only when the browser reaches the gateway at a different address | no |
| `INTELLIGENCE_GATEWAY_PROXY` | `on` only when the server relays the browser socket itself; mutually exclusive with the line above | no |
| `INTELLIGENCE_SERVICE_TOKEN`, `INTELLIGENCE_PROJECT_ID` | only for a service token that may create Learning containers | no |
| `CPK_INTELLIGENCE_LEARNING_CONTAINER_ID`, `CPK_INTELLIGENCE_SKILLS_REVISION` | pin a Learning container or published skills revision | no |

A partial set is worse than none: the server fails at boot on any missing one of the three, by design.

### 3.4 Boot verification

- Start the runtime, then `curl --fail http://<host>:<port>/api/copilotkit/info`. The response must report `mode: "intelligence"` and the registered agent.
- Open the app on localhost, open Inspector (kite icon), Home must show **Intelligence connected**; send one message and confirm the thread appears under **Rich Threads** and in the cloud project's **Threads** page.
- A chat reply alone proves nothing: an SSE runtime answers with the key unread.

### 3.5 Plan, limits and trial

- **Developer** is free, needs no card, and includes AG-UI Streams, User Memory and Automatic Learning. Product Analytics and Automatic Learning are marked **TRIAL** during the Developer trial; full Product Analytics is Enterprise.
- Paid **Pro** and **Team** exist; **Enterprise** is custom and is the only route to production self-hosting.
- Exact numeric quotas (threads, events, retention, seats) are published on the dashboard **Pricing** page, not in the documentation text. The owner must read them at sign-up and record them; this analysis could not verify the numbers and does not assume them.
- The CLI local-evaluation licence lasts 30 days per renewal and is not a substitute for the managed project.

### 3.6 Not permitted

- Copying the Desktop's project key, licence token or thread/learning data into the pilot.
- Running self-hosted Intelligence under the Desktop evaluation licence on Linux, or describing that stack as production.
- Circumventing plan limits, quota checks or entitlement, or using unlicensed provider access.
- Putting the project key in a browser-visible variable, a public repo, a screenshot or a chat message.
- Treating a Developer-plan project as approval for public exposure or paid usage.

## 4. Hermes model provider on the pilot VPS

### 4.1 API surface (verified)

The fork exposes an OpenAI-compatible HTTP API next to the gateway: `POST /v1/chat/completions`, `POST /v1/responses`, `GET /v1/models`, `GET /v1/capabilities`, `POST /v1/runs` plus run status/events/approval/steer/stop, `GET /api/sessions`, `GET /v1/health`, `GET /health`. Authentication is `API_SERVER_KEY`; a missing or weak key is a hard error, not a warning. Documented default listener is loopback `8642`. The variables are `API_SERVER_ENABLED`, `API_SERVER_KEY`, `API_SERVER_HOST`, `API_SERVER_PORT`, `API_SERVER_MODEL_NAME`, `API_SERVER_CORS_ORIGINS`; **none of them appear in `.env.example`**, so they must be added explicitly and documented in the pilot manifest.

Consequence: Atlas-Bot can reach Hermes through an OpenAI-compatible client, and the same endpoint serves Open WebUI/LibreChat for tests, with no AG-UI adapter required for the first pilot step.

### 4.2 Providers supported by `.env.example`

Named, first-class: Fireworks, OpenRouter, NovitaAI, NVIDIA NIM, Google AI Studio / Gemini, Ollama Cloud, z.ai GLM, Kimi/Moonshot (plus China key), Arcee, MiniMax (global and China), OpenCode Zen, OpenCode Go, Hugging Face Inference Providers, DeepInfra, Qwen OAuth, Xiaomi MiMo, Upstage Solar, Ramp Router, Nebius Token Factory, Tencent TokenHub (OpenAI-compatible) and TokenPlan (Anthropic endpoint), Groq (speech). Generic escape hatch: provider `custom` with `OPENAI_API_KEY` + `OPENAI_BASE_URL`, or `openai-api` with the `OPENAI_BASE_URL` override.

Model selection lives in `~/.hermes/config.yaml` (`model.default`), not in `.env`; `LLM_MODEL` in `.env` is dead and kept only as a comment.

### 4.3 Options

| Option | Cost / limit | Independent of the owner's PC | Main risk |
| --- | --- | --- | --- |
| Google AI Studio (Gemini) | free tier, no card; per-model RPM/RPD quotas shown in AI Studio | yes | free-tier quota is per project and can change; model must be one Hermes lists |
| NVIDIA NIM | free API credits on sign-up, then metered | yes | credit exhaustion mid-test; catalogue naming |
| OpenRouter free models | free pool, low rate limits, shared capacity | yes | variable latency/availability; already the FCC upstream, so not independent in failure mode |
| Existing FCC on the VPS, loopback 8082 | no new key; reuses upstream keys and proxy token | yes for the proxy itself | proxy auth token + upstream keys must be owned by Atlas; version drift 6.19.4 (PC) vs 6.5.11 (VPS); single point; ToS of free upstream models is the owner's call |
| Self-hosted local model | hardware cost | yes | host has no measured headroom for this |

### 4.4 Recommendation

**Google AI Studio as the pilot provider.** It is native to the fork (`GOOGLE_API_KEY` or the `GEMINI_API_KEY` alias, optional `GEMINI_BASE_URL`), OpenAI-compatible, free at pilot volume, needs no card and no proxy, and keeps the model path independent of both the owner's PC and the FCC. Fallback: NVIDIA NIM (`NVIDIA_API_KEY`), same shape.

The owner must supply exactly one key, entered on the VPS into the pilot-scoped environment file, never in the repo and never in chat. Then set `model.default` in `~/.hermes/config.yaml` to a model that key can actually serve, and prove it with one bounded task, not with `/health`.

FCC stays a lab-only fallback: it is already running and healthy, but it adds a proxy credential, an upstream free-model dependency and a version drift, and it would make the pilot's model path depend on the same account the Desktop already uses.

## 5. Blockers

| Without | Blocked | Still runs |
| --- | --- | --- |
| Intelligence project key | Atlas-Bot does not start at all (explicit refusal); no threads, memory, Learning, Channels or Analytics | Atlas-Agent Hermes, Memory Fabric/GBrain, repo work, static UI work |
| Model provider key | Hermes answers `/health`, `/v1/models` and `/v1/capabilities` but cannot execute a task; Atlas-Bot chat has no model behind it | GBrain keyless paths, ingestion of synthetic data, policy and approval tests that do not call a model |

Both blockers are owner-only: one browser sign-in with the owner's CopilotKit account, and one provider key. Neither can be removed by an agent without borrowing the Desktop's credentials, which the mandate forbids.

## 6. Unknowns

- Numeric Developer-plan quotas and retention; only the dashboard Pricing page states them.
- Whether the pilot's chosen Gemini model is on the fork's supported list at the pinned revision; to confirm at first run.
- Whether a fresh project needs a Learning container created before Automatic Learning is useful; the helper `scripts/setup-learning.ts` exists but the service-token path is optional and unverified here.
- Real FCC traffic and its proxy-auth enforcement on the VPS were not exercised; only `/health` was read.
