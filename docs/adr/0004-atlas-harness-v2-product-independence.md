# ADR-0004 — Atlas Harness V2: owned product, native installers, independent Intelligence

Date: 2026-11-12
Status: Proposed implementation direction for owner review; not evidence that commercial independence, licensing, deployment or installers are complete.
Supersedes no V1 operational safeguards. V2 is a separate product track.

## Strategic intent

AtlasHub will publish a distributable Atlas Harness product for local PCs, customer's VPS, assisted installs and Atlas Cloud. OpenBot-derived Atlas-Bot is the preferred rich UI/desktop candidate; Hermes-derived Atlas-Agent is the default execution runtime; Atlas-Workforce supplies versioned Agency Packs; Ruflo remains optional lab tooling. Product name: **Atlas Harness** (not Atlas-Hardness).

The desktop client must be able to operate local runtime and independently connected remote instances. Remote agents continue to run when the user's PC is off. Connections, credentials, threads, memory, tool permissions and costs must never cross installation/tenant boundaries by default.

## Confirmed repos and build facts (2026-11-12)

All 8 architecture repositories were found in the AtlasHub-Si organization: Atlas-Harness, Atlas-Bot, Atlas-Agent, Atlas-Memory-Fabric, Atlas-Operational-Knowledge, Atlas-Workforce, Atlas-WorkSwarms, Atlas-Crm-OS.

`Atlas-Bot/desktop/` contains Tauri app and the existing GitHub Desktop build/release workflows. Current product name is OpenBot and bundle identity `ai.copilotkit.openbot.desktop`. It still uses deployment/release paths under `CopilotKit/OpenBot` and a pinned Intelligence CLI URL `pkg.pr.new/CopilotKit/Intelligence`. `server/package.json` imports `@copilotkit/runtime` and `@copilotkit/shared`. The existing PR build uses `bundle_cli: false`; successful unsigned packaging does not prove a working local Intelligence stack.
`Atlas-Agent/apps/desktop/` contains its own Hermes Desktop, Electron/React and local/remote Hermes gateway capabilities.

Active compile experiment: https://github.com/AtlasHub-Si/Atlas-Bot/pull/1 (DRAFT). This PR is for source compilation only; not a product release. At audit time the GitHub repository returned no Actions runs; check fork Actions activation/permissions and job artifacts before claiming build success.

## Rights and independence

- Preserve all upstream MIT license, copyright, attribution and NOTICE obligations.
- Rebranding permitted for code under applicable permissive licenses, but brands/trademarks and third-party services require distinct review.
- CopilotKit Intelligence is separately licensed; its local preview is not a production entitlement. It is not enough to control an OpenBot fork to obtain the Intelligence source or commercial distribution rights.
- Engineering may build independent replacements using lawful open-source building blocks and original implementations; NEVER remove licensing checks as a workaround, bypass subscription enforcement or copy closed-source code.
- Review license/version for each dependency before publishing a public download or service.
- Map and allow opt-out/removal of telemetry; no customer secrets in public repository or build logs.

## Two distinct deployment products

1. **Atlas Desktop** Tauri native client; unique Tauri application/bundle id, name, icon, file locations, custom protocol, auto-update signing, release base URLs, Atlas-owned GHCR images and project manifests. Modes: PC local, connect to existing VPS, Atlas Cloud workspace. It must not overwrite or upgrade installed official OpenBot.
2. **Atlas Harness Server** independently installable via Docker Compose on VPS / AWS; policy/approval API; durable task store; memory; Hermes agents; restricted computers and audited egress; served web workspace; no optional desktop shell required.

The existing `bot.atlas-si.com` web deployment is NOT interchangeable with the Tauri Desktop. Test a separate V2 stack behind a distinct port/hostname once approved, never replace or disrupt existing host without backup and rollback.

## Independence implementation plan

**S0 source audit**: dependency bill of materials / provenance; third-party runtime/license matrix; identify every `copilotkit`, `openbot`, upstream downloads, reporting, identity, Intelligence API and codegen path. Classify retain-permissively-licensed / adapt / replace / optional external service.

**S1 compile**: smoke-build unsigned Desktop with the organization's own CI, no bundled proprietary Intelligence CLI. Logs + artifacts, same commit SHA, protected branch. NOT suitable for end-user install. Ensure GitHub Actions fork permissions and hosted runners are available.

**S2 Atlas branding + delivery**: own product ID, icons, paths, release manifests, image digests, GHCR namespace, updater URLs and signing. Provide a no-op or clear error when Atlas runtime is not configured, not silent fallback to upstream CopilotKit.

**S3 internal Intelligence replacement**: design Atlas Threads & Events service (PostgreSQL task ledger, durable conversations, WebSocket/SSE streaming, AG-UI events), Atlas Memory scoped to tenant; skills publishing, learning and routines in later increments. Bridge OpenBot UX through an adapter and avoid mixing local/remote state. Components that are not yet implemented must be visible as absent, not falsely functioning.

**S4 Hermes integration**: scoped Hermes gateway; AG-UI/JSON-RPC streaming bridge; tool approval proxy, audit, cancellation, idempotency and bounded delegated subagents. Atlas-Workforce Creator pack first.

**S5 local + VPS acceptance**: clean install on Windows/macOS; two isolated connection profiles; remote jobs keep running when desktop is closed; denied cross-instance memory and secret access; rollback and backup restored; no default all-allow policy.

**S6 AWS staging**: only after Terraform plan/code review, isolated VPC/account scope, IAM GitHub OIDC, Secrets Manager/SSM, CloudWatch, S3 remote locked/encrypted state, AWS Budgets, backup/restore, capacity benchmarks and explicit spend GO. Terraform `plan` before `apply`. AWS infrastructure and bills are reversible to a significant extent; not an irreversible product migration.

**S7 release**: review legal distribution rights, code-signing, notarization, software bill of materials, vulnerability scanning, update rollback, first customer-alpha acceptance, documentation and onboarding.

## Scope separation and ownership

- **Antigravity:** Terraform/AWS staging, isolated infrastructure and infra cost/security readiness, product architecture consolidation.
- **OpenBot Local:** Atlas-Bot Tauri UI and local/server installers, dependency audit, branded paths and build artifacts.
- **Atlas-Agent/Hermes:** core runtime/remote gateway integration and first Agency Pack.
- **Independent QA (e.g. GPT Work):** compile evidence, dependency/legal review and E2E gates.

No unreviewed simultaneous writes to the same branch. All changes on feature branches via PR, no direct main merge. Preserve Helena and existing VPS laboratory state.

## Next decision / immediate blocker

Confirm whether GitHub Actions are enabled for the new AtlasHub-Si/Atlas-Bot fork; internal PR build is opened but no workflow run was observed. If Actions are disabled by fork settings, a repository owner must enable workflows in GitHub's Actions UI. After enabling, rerun PR checks; confirm each artifact.

References:
- https://github.com/AtlasHub-Si/Atlas-Bot/pull/1
- https://github.com/AtlasHub-Si/Atlas-Bot/blob/feat/atlas-harness-v2-aws/docs/atlas-harness-v2-aws-plan.md
- https://github.com/AtlasHub-Si/Atlas-Agent/blob/feat/atlas-harness-v2-aws/docs/atlas-harness-v2-runtime.md
- https://docs.copilotkit.ai/intelligence/overview
- https://docs.copilotkit.ai/intelligence/self-hosting-local
