# ADR-0004 — Desktop OpenBot as remote bootstrap controller; CopilotKit Intelligence and OpenCode provider boundaries

**Date:** 2026-11-12  
**Status:** Proposed onboarding strategy; no remote actions or VPS changes authorized.  
**Parents:** [ADR-0001](0001-atlas-harness-architecture.md), [ADR-0003](0003-lab-consolidation-aws-gwd-rollout.md).

## Hypothesis

The project owner already operates an original OpenBot installation on a personal computer that can access the AtlasHub VPS. Instead of manually installing Atlas-Harness on the host, use this local OpenBot as the **first bootstrap operator**, then instantiate the Atlas-controlled fork of OpenBot (Atlas-Bot), Atlas-Agent, Memory Fabric and the other core services on the VPS. The PC controller can then connect as a remote user, but the installation must function with the PC fully offline.

This is a **product test of onboarding by an agent**, not just a one-off remote setup. Future customers could use a similar local bootstrap assistant to deploy Atlas-Harness onto an authorized server, inspect prerequisites, configure an organization and run acceptance tests.

## Distinct roles

- **PC OpenBot original:** temporary operator/orchestrator, inventory and installer interface. It is not the target product. Use the owner's existing OS/SSH connection with explicit scoped permissions.
- **Atlas-Harness:** own product manifest, installation plans, migration checks, versioning, readiness tests and rollback; provider-neutral architecture.
- **Atlas-Bot:** **new instance deployed from Atlas fork**, enterprise UI, identity, approval and audit. Must have properly licensed Intelligence or authorized compatible independent solution.
- **Atlas-Agent:** runtime from NousResearch Hermes fork, on VPS with restricted permissions and scoped tool execution.
- **Memory and Knowledge:** scoped memory and approved operational content, separate from user session persistence.
- **GWD:** initial organization provisioned from configuration templates, not custom changes to the product core.

## What CopilotKit Intelligence actually provides

It is **not an LLM provider** or alternative to Hermes. It provides CopilotKit platform services for durable Rich Threads, realtime gateway/synchronization, memories, learning insights, skills, analytics, messaging channels and related project-level capabilities. OpenBot expects configured Intelligence API/gateway credentials.

OpenBot Desktop personal edition uses a local evaluation Intelligence instance; its personal edition intentionally lacks the team edition's personal memory capability. The OpenBot application code is MIT; Intelligence is **separately licensed**, requiring the correct evaluation or commercial rights. Do not assume that pointing OpenBot to Hermes or GBrain makes the Intelligence dependency disappear.

Official references:
- https://github.com/CopilotKit/OpenBot/blob/main/docs/architecture.md
- https://github.com/CopilotKit/OpenBot/blob/main/docs/personal-edition.md
- https://github.com/CopilotKit/OpenBot/blob/main/README.md
- https://docs.copilotkit.ai/intelligence/overview

## Why OpenCode free models may work without a typed API key

OpenCode has a built-in free-model catalogue and may work without pasting individual DeepSeek/GLM provider API keys. This does **not** imply local inference; the models may run on hosted infrastructure. Nor is it proof that the OpenBot process directly calls OpenCode free inference APIs. Inspect its configured agent harness/provider and local OpenCode process before making claims.

Current OpenCode docs state that **free-tier chat models require OpenCode**; other harnesses, including Hermes, receive HTTP 403 for these direct API requests, even with a Console key. Paid OpenCode Console or Go providers are separately supported by Hermes via their keys; use them only within their license/billing terms.

Official references:
- https://opencode.ai/docs/models
- https://opencode.ai/docs/console/models
- https://opencode.ai/docs/console/harnesses/hermes/
- https://github.com/CopilotKit/OpenBot/blob/main/docs/configuration.md

## Bootstrap lifecycle

1. **Preflight, read-only:** PC OpenBot checks SSH connectivity, user identity, authorized command set, host health, Docker/Compose/Caddy ownership, backups, sensitive services and current Hermes profiles. Collect sanitized summary; no raw secrets/log dumps in model prompts or public issues.
2. **Plan and approve:** produce targeted preserve/isolate/stop-after-backup matrix and a concrete `install-plan.json` with pinned images, resources and rollback. Operator approves exact plan.
3. **Prepare environment:** operator creates dedicated non-root service user and SSH principal; least privilege; short-lived bootstrap access; no broad root permanent credentials. Preserve AtlasClub/CRM/ARO and existing Hermes artifacts per [ADR-0003](0003-lab-consolidation-aws-gwd-rollout.md).
4. **Install Atlas distribution:** fetch signed/version-pinned Atlas-Harness release from GitHub, launch isolated core profile with configuration files and secret references. Existing OpenBot Desktop is **not** migrated as a running process or used as a production runtime.
5. **Provision tenant:** create synthetic GWD-like organization with council, director, worker agent, an approved knowledge document, controls and budgets; do **not** transfer real user credentials.
6. **Acceptance:** verify start/stop, recoverability, scoped knowledge, unauthorized BU denial, policy approval, end-to-end read-only mission, audit evidence, cost and replication on a second VM.
7. **Cutover of bootstrap controller:** revoke/expire temporary access, preserve deployment manifest/receipt and test that the VPS Atlas-Bot still functions with PC off. PC OpenBot may reconnect to its API as a client; no server dependency.
8. **GWD reference:** once tested and budget/licensing approved, repeat same installer on AWS or the approved deployment target; GWD configuration remains tenant data.

## Delivery design

Prefer a deterministic installer/CLI (not unrestricted LLM-generated shell). The conversational assistant gathers information, proposes a plan and invokes only whitelisted installer steps with explicit human consent for impacts. The underlying installer must be idempotent, pinned and repeatable.

Outputs should include `preflight-report.json`, `install-plan.json`, `deployment-receipt.json`, a sanitized audit log, `rollback-plan.md` and `acceptance-report.json`. These are **specifications**, not implemented files yet.

## Milestone proof

- Onboard a synthetic organization from a desktop agent on a remote VPS.
- Disconnect or power off the desktop agent.
- Access Atlas-Bot directly on the VPS and continue the same approved tenant workflow.
- Reproduce the installation on an alternate machine without adjusting core code.
- Demonstrate removal/rotation of bootstrap access and backup/restore.

## Blockers

OpenBot Intelligence evaluation/commercial licensing, PC OpenBot actual provider/harness identity, local SSH privilege model, VPS capacity and backing volumes, and the source of paid vs free model inference. Do not claim direct OpenCode free API support in Atlas-Agent.
