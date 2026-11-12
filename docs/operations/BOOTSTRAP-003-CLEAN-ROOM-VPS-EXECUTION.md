# ATLAS-HARNESS — BOOTSTRAP 003: CLEAN-ROOM VPS INSTALLATION

**Date:** 2026-11-12  
**Mandate:** Owner-approved FIRST TEST of a **new, isolated Atlas-Harness installation on existing AtlasHub VPS**, operated by the existing original OpenBot Desktop Director and previously created specialist team. **No import of old running Hermes/GBrain/DB/SOULs, no destructive cleanup, no DNS/public launch.**  
**Status:** Directive available for owner to transmit to their PC's OpenBot. **Writing this file is not transmission or VPS execution.**

## Why this directive supersedes 003A planning-only

The owner clarified that most old AtlasHub deployments are non-operational LAB. We should **not copy/migrate those runtime instances** into the proof of concept. Use the **host machine** if capacity permits, but build **new isolated containers, volumes, identities, configuration, networks and data** entirely from Atlas repos, as a commercially repeatable onboarding prototype.

The owner authorizes reasonable **isolated new-instance installation/test actions within the scope below** after preflight gates are satisfied; no blanket host reconfiguration. Do not make discretionary destructive or public changes.

## Authority boundaries

**Permitted for this test when preflight PASS:**
- Read repos and host status (without exposing secrets), pin source commits and dependencies.
- Create an isolated working directory/project for `atlas-harness-pilot`, scoped Docker networks/volumes and correctly permissioned new secrets.
- Prepare/build/start/stop ONLY newly created pilot services, with conservative cgroup CPU/memory/pids limits, health checks and predictable rollback.
- Use a fresh, separate CopilotKit Intelligence Cloud project under the owner's authorized account **only if the owner can authenticate it, free/evaluation usage rights fit, and no paid subscription or unexpected bill is triggered**. Do **not** copy the Desktop private key or import its conversation/learning data. Cloud URL/API key path must be verified from the code and securely configured.
- Install a new Atlas-Agent (Hermes fork) revision validated against upstream, with an independently valid LLM provider (no assumption that free OpenCode chat models are usable via Hermes).
- Implement small missing integration glue in a dedicated branch/PR in Atlas-owned repo after tests; preserve upstream licensing and attribution. Code work and isolated LAB changes are authorized; never alter the existing running host service configurations.
- Use an internal/private-only access path, authenticated, whose operation does not depend on the owner's PC.
- Create synthetic GWD tenant data and perform bounded non-production tests.
- Save sanitized implementation decisions and evidence to GitHub; secrets, private logs, infrastructure scan details, user data stay outside public repos.

**NOT permitted without a separate, explicit owner GO:**
- Stop/restart/remove/change ANY existing containers, Hermes, GBrain, Helena, CRM, ARO, AtlasClub/LearnHouse, Caddy, firewall, SSH, core Docker daemon, DNS or external callbacks.
- Delete or prune **any old volumes, images, caches or snapshots**. Never use `docker system prune --volumes`, `compose down -v` on shared stack, or broad deletion.
- Bind test services to `0.0.0.0` on public interfaces or expose a single-user/admin mode over internet.
- Install self-hosted CopilotKit Intelligence under Desktop evaluation license on Linux; circumvent license limits, bypass paid services, or use unlicensed provider access.
- Connect live email/messaging, banking, payment providers, CRM customers, production workloads, or copy real secrets into test.
- Incur paid cloud/model services, increase VPS plan, create AWS infra, or change public DNS.
- Treat the owner-approved 'pilot install' as approval to alter other services or compromise host stability.

## Team delegation

Use existing six-member crew. Director owns one execution queue, checkpoints and final report:
- **Architect:** inventory true fork branch/version; pin commits; check OpenBot run-from-source and AG-UI Hermes adapter; reuse upstream policy/approvals/queue rather than rebuild; define the Atlas tenant/task envelope.
- **Infra/SRE:** recheck current host RAM/swap, disk pressure, OOM events, overlay storage, Docker/Caddy ports and resource fit; create safe isolated Compose/profile and rollback.
- **Models:** verify PC's *actual* Intelligence usage (owner says Cloud) without copying its credentials; create separate provider project through authorized sign-in, validate terms and a legally supported Hermes model provider.
- **Security:** threat-model tenant, secrets, approvals, network egress, privilege/Docker socket, Caddy avoidance; inspect preflight and installation artifacts before executing.
- **QA:** end-to-end deterministic acceptance; unattended restart, persistence, mock tenant, tool approval/audit; verify independence from PC.
- **Director:** integrate and enforce approval boundaries; avoid simultaneous mutations of shared host resources; report evidence and stop conditions.

## Gate P0 — safe preflight (mandatory, read-only)

1. Confirm SSH target and named user, authorized privileges, free disk space, currently available RAM, swap pressure/OOM logs, published Docker ports and exact project/network names. Confirm previous reports are current.
2. Determine specific minimum RAM/disk/CPU requirements from chosen versions and intended runtime mode. The host was previously reported as resource-constrained. **If minimum safe operational headroom is absent, STOP** and return a clean-server/VPS requirement; do not compensate by suspending unrelated containers.
3. Confirm no port conflicts, no new public listener, no touching main Caddy, database, Redis, existing Hermes, existing gbrain, or common Docker resources. Use scoped prefix names and ports bound to `127.0.0.1` or isolated network only.
4. Verify backup/rollback requirements for the **new** pilot and preserve existing host services. The previously identified invalid legacy backup dumps mean no legacy destructive maintenance; they do not require migrating legacy data into the pilot.
5. Review intelligence model access, account, license, free-tier constraints; if unavailable, launch only independent components as **partial pilot**, not claim full Atlas-Bot stack success.
6. Confirm no remote attack surface is opened. If desired access path requires modifying host firewall/edge or public network, PAUSE that part for separate owner GO.

## Gate P1 — clean deployment

- Repo source only: `Atlas-Harness`, `Atlas-Bot`, `Atlas-Agent`, `Atlas-Memory-Fabric`, `Atlas-Operational-Knowledge`, `Atlas-Workforce`. `Atlas-WorkSwarms` and `Atlas-Crm-OS` are **optional/not boot requirements**.
- Use a dedicated GitHub branch, version lock and build manifest; never deploy arbitrary latest in production-like server after verification.
- New isolated environment: distinct Compose project, network, DB, volumes, secret files, container labels and service accounts, no old Docker volumes mounted, no `.env` or home directory imports.
- Frontend/agent baseline: fresh Atlas-Bot as OpenBot fork; CopilotKit Intelligence **managed/cloud** with a separately authorized fresh project, unless a compliant alternative is ready; fresh Atlas-Agent from fork using Hermes with valid provider credentials; fresh memory/knowledge seeded with synthetic entries.
- Set **secure auth** before remote access; disable `OPENBOT_SINGLE_USER=true` for any network-facing deployment. If valid team/auth config is not ready, keep test isolated on loopback. Use deny-by-default policy, least-privilege agent tools and manual approval for risky actions.
- Existing OpenBot source already provides persisted policy, approvals, audit and work queue; implement **only** missing Atlas organization/BU/task-level contracts.
- Establish restart/recreate survival without data loss, bounded logging and rollback using only pilot-scoped resources.

## Gate P2 — functional tests

1. Fresh install from code/manifests: PASS/FAIL.
2. Atlas-Bot UI + secure sign-in without desktop dependency: PASS/FAIL.
3. Intelligence Cloud connection from VPS (threads/reconnect): PASS/FAIL; never rely on Desktop local endpoints.
4. Atlas-Agent Hermes bridge: a bounded task through AG-UI or adapted typed API: PASS/FAIL.
5. Policy: unauthorized action denied and audited; sensitive action requires distinct human approval: PASS/FAIL.
6. GWD synthetic org: Governance, Executive, Shared Services, BUs and Labs mapped to roles and test agents; no real customers: PASS/FAIL.
7. Persistence: same conversation and memory entry after restart of **pilot services**: PASS/FAIL.
8. PC-off autonomy: close local OpenBot, disconnect/turn off PC and access running VPS from another authorized device/network route independent of the PC; execute a bounded read-only task: PASS/FAIL.
9. Isolation: other pilot tenant cannot read GWD synthetic private data: PASS/FAIL.
10. Cleanup: fully reverse **only pilot changes**, with no effect on existing services, and prove clean reinstall possible; avoid deleting pilot persistent volumes without owner-authorized data disposition: PASS/FAIL.

## Gate P3 — public access deferred

Desired future DNS: `bot.atlas-si.com` (Atlas LAB), `bot.goworld.digital` (GWD reference). **No public DNS/Caddy/Cloudflare changes in this mandate.** When auth, resource, license, safe HTTPS, operational continuity and user acceptance are proven, request separate G5 approval and an ingress plan that does not interrupt existing sites.

## Deliverables

- `pilot-preflight.md` — sanitized PASS/FAIL, resource recommendation and blockers.
- `pilot-build-manifest.md` — git SHAs, images/builds, license and operational requirements, reproducible commands.
- `pilot-deployment.md` — compose architecture, isolated paths/ports, dependencies, monitoring and rollback.
- `pilot-acceptance.md` — 10 criteria with evidence and truthfully reported outcome.
- `pilot-go-no-go.md` — what ran, what was blocked and exactly what next owner authorization would change.
- Implementation branches/PRs for Atlas glue if required. Publish **sanitized** reports only; no secrets/private host maps in public repo.

## Stop condition

Any failed gate P0; uncontrolled host memory pressure; lack of valid provider license/API credentials; need to change existing workloads; need to expose a network service publicly; unexpected cloud billing; ambiguity around tenancy isolation or credentials: **pause the impacted installation step and provide a concrete alternative** (fresh VPS or private test), while progressing independent coding/tests.

**Operational success criterion:** the installer recreates a fresh Atlas-Harness instance from pinned sources, synthetic organization and approved model path; runs when the owner's PC is off; restores threads/skills across pilot restart; and can repeat independently on a second clean host.
