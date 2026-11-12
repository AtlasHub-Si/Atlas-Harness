# ATLAS-HARNESS — BOOTSTRAP 003B: Publish secured LAB at bot.atlas-si.com and benchmark OpenBot-only

**Date:** 2026-11-12  
**Status:** Owner requested public-hostname test; **not executed** by writing this document.  
**Previous directives:** BOOTSTRAP-002 and BOOTSTRAP-003 clean-room VPS installation. This addendum grants **conditional, narrow G5 preparation/publishing for `bot.atlas-si.com` only** when all preflight checks PASS and authorized access to the correct DNS zone is available. It does not authorize disabling legacy containers or changing unrelated sites.

## Objective

Install/deploy a **new** Atlas-Bot (fork of CopilotKit/OpenBot) on AtlasHub VPS, using **separate CopilotKit Intelligence Cloud Developer project** and verified model routing, securely publish `https://bot.atlas-si.com`, and run the **OpenBot-only baseline with no Hermes**. This baseline is a functional benchmark, not a proof of a complete AI-native enterprise.

Then report whether/how integrating a **new** Atlas-Agent/Hermes adds measurable value on memory, skills, execution, delegated tasks, scheduling, cost, tool permissions, and recovery. **Do not install Hermes as a prerequisite for initial baseline.** Use synthetic people, departments and data only.

## Important factual/account limits

- Current connected Cloudflare session accessible to the reviewer includes zone `goworld.digital` but **does not include** `atlas-si.com`; publication requires the owner/PC agent to access the correct authoritative DNS provider/Cloudflare account. Do not add `atlas-si.com` to another account or change nameservers by assumption.
- Existing VPS report describes `platform-caddy` owning 80/443 across multiple sites with admin API disabled. A restart of that ingress is a potentially disruptive **shared-host change**. Prefer **Cloudflare Tunnel + Cloudflare Access** if supported in the correct zone and resource/security check permits; use an isolated `cloudflared` connector to the new app bound to loopback/private Docker net. Otherwise produce a tested, reviewable Caddy route/diff and explicit impact/rollback review before touching shared ingress.
- Intelligence Developer API key is **not** a Google/NVIDIA/OpenRouter/Kilo model key; verify the separate flow from app to Intelligence and from bot to LLM provider. Never export, log, commit or paste secrets into public GitHub.
- Four keys do not imply four auto-fallback providers. Verify official OpenBot `shared/model-providers.json` and `docs/configuration.md`, per-model tool calling/streaming, rate and quota terms. Direct Google is supported; OpenAI-compatible providers require independently validated endpoint, API shape, model ID. `OPENAI_BASE_URL` can redirect the deployment; do not assume multiple such endpoints can be mixed without additional routing logic.
- No inference from paid or free-tier API-key presence that a model is available or that usage is free. No unexpected expenses or model/provider ToS bypass.

## Critical publication gates (all MUST PASS)

1. **Isolated new instance**: verify network, volumes, DB, app image and env independent from old containers; health endpoints answer internally; no impact to previous workloads, enough RAM/disk, safe resource caps.
2. **Backend and identity**: `OPENBOT_SINGLE_USER=false`, configured/working identity provider supported by OpenBot (Google/Microsoft/Okta/OIDC), `BETTER_AUTH_URL` / `TRUSTED_ORIGINS` / `OPENBOT_PUBLIC_URL` / callback config set to the real hostname where needed, and `INITIAL_ADMIN_EMAILS` limited to authorized owner. Verify unauthenticated routes reject and ordinary logged-in user is NOT admin. **A Cloudflare Access perimeter does not remove the need for app auth.**
3. **Secrets & privileges**: unique strong encryption key, no dev tokens, private encrypted env, no privileged Docker socket available to agent app, least-privilege computers and policies, deny/approval rules for shell/network/external actions, no live payment/chat/email app grants.
4. **Intelligence**: verify fresh Cloud project key can create a thread, reload history, and reconnect; preserve owner sign-in and no Desktop-local services.
5. **Provider**: run a single inexpensive test prompt with one verified provider first (recommend Google AI Studio) using a chosen model that actually supports the OpenBot tasks; document model, tool-call support, errors and usage. Test other providers one at a time and avoid silent fallback claims.
6. **DNS & secure external access**: verify authoritative zone control. Preferred path Cloudflare Tunnel + Access with allowlisted identity and no direct public origin port; configure host `bot.atlas-si.com` only after Access, app sign-in and health tests. If Tunnel unavailable, stop and propose Caddy route and certificate provisioning with validated diff, a maintenance window and separate shared-ingress GO before changes. Never point DNS to an origin without secure authentication/HTTPS.
7. **Independent access**: app must remain online and accessible over approved secure route while original OpenBot Desktop and its SSH tunnel are offline.

## Sequenced execution

**Phase 1 — read-only preflight and deployment stabilization:** inventory new build health, port conflicts, RAM/swap, outbound Intelligence/LLM connectivity, DNS/zone authority, candidate ingress. Record PASS/FAIL. If preflight fails, do not publish.

**Phase 2 — authenticate and baseline:** configure real IdP and admin grants, verify model provider and Intelligence cloud, confirm API policies/audit, create synthetic Atlas Lab operator.

**Phase 3 — controlled public hostname**: attempt preferred Tunnel+Access with `bot.atlas-si.com`, verify TLS/domain and app login, negative unauthorized tests, cross-tenant checks. Only change DNS where explicitly authorized by the owner and accessible; NO old services/Caddy restarts as side effect.

**Phase 4 — OpenBot-only functional tests:** create test organization/roles for Council, Executive Leadership, Shared Services, BUs, Labs (roles can be representations, not unsupported native org hierarchy). Run 3 bounded missions: information synthesis, delegation/handoff among bots, mock action needing human approval. Verify policies, audit, persisted threads, developer-tier usage counters, no Hermes dependency, and PC-off operation.

**Phase 5 — decision report:** classify native OpenBot capabilities vs what would benefit from new Hermes:
- agency orchestration and handoffs;
- memory scope (conversation/project/organization), skills;
- tool and browser permission management;
- scheduling and automatic proactive work;
- model portability and token usage;
- recovery/restart, user+tenant isolation.

Return `OPENBOT_ONLY_ACCEPTED`, `OPENBOT_WITH_HERMES_RECOMMENDED`, or `BLOCKED`, with measured evidence and reason. Only then propose an isolated fresh Hermes installation and A/B using the **same missions**.

## Required evidence (sanitized; private details separately)

- Technical deployed commit(s), Compose project, health statuses, total memory use, no containers/services from old deployment modified.
- Provider table: provider, selected model, chat PASS/FAIL, tool calling PASS/FAIL, streaming PASS/FAIL, error codes, estimated/actual cost or free quota if verifiable. **Never show keys**.
- Cloud Intelligence project API + realtime status, test thread ID *redacted*, persistence PASS/FAIL.
- DNS: authoritative zone confirmed, `bot.atlas-si.com` record target without exposing origin secrets, HTTPS certificate, Access policy and application auth negative tests.
- User-access flow (valid/invalid admin), limited audit event proof.
- OpenBot-only 3-mission tests, PC-off outcome, realistic comparative next step.

## Stop and escalation boundaries

Stop any public publishing if `OPENBOT_SINGLE_USER` remains true, no IdP, no origin TLS/auth path, insufficient resources, cloud model/Intelligence license invalid, wrong DNS account, missing Tunnel/Access configuration, or risky Caddy change. Report the exact blocker; do not auto-compensate by bypassing authentication or reusing Desktop credential.

**No permission** to change legacy runtime, DNS except `bot.atlas-si.com` in the correct authorized zone, nameservers, shared Caddy, host firewall, other domains, cloud subscription, production customer data, or payment gateways. The owner’s current request is a bounded test of one secured LAB hostname only.
