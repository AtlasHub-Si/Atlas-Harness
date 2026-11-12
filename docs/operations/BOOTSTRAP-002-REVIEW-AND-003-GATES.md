# Bootstrap 002 — Director review and proposed Bootstrap 003 gates

**Date:** 2026-11-12  
**Status:** Reviewed from the user's pasted summary, not independently verified host evidence. Supporting agent files not supplied to the Atlas-Harness repo. This document deliberately avoids exposing sensitive infrastructure findings in a public repository.

## Verified from presented report (not independently audited)

- Local OpenBot reported 0.68.0 with bundled OpenCode 2.2.7 and free-model use; no direct model API credentials visible to the audit agent. Provider path is explicitly separate from local FCC.
- Six workers including Director reportedly completed read-only discovery and generated seven detailed artifacts.
- The current AtlasHub VPS is a shared laboratory, not production, but holds preserved LearnHouse, CRM, ARO and Hermes/GWD state.
- Capacity and backup integrity require a remediation plan before onboarding.
- Atlas-Harness is currently architecture/documentation, not a working integrated distribution; forks are near upstream.
- CopilotKit Intelligence licensing and safe multiuser authentication remain prerequisites for any OpenBot server exposure.

## Reconciliation with actual upstream OpenBot implementation

The report's claim that there is 'no policy gateway or task ledger' needs precision:

- **Existing policy gateway:** OpenBot already enforces computer/tool action policies, persisted policy store, human approvals and audit at its API. See upstream `server/src/computer/policy-store.ts`, `server/src/approvals/types.ts`, `docs/architecture.md`.
- **Existing durable work queue:** OpenBot already implements Postgres `work_items` with claim leases, idempotence keys, retries and terminal failure handling. See `server/src/work/queue.ts`, `server/src/db/schema/work.ts`.
- **Still missing for Atlas:** a verified cross-component **enterprise mission admission/ledger contract** with tenant/BU scope, organization policy, delegated Hermes executions, correlated evidence, business workflows and support for multiple deployments. This is an **extension/integration need**, not a command to rewrite OpenBot's existing policy and queue.

Security note: upstream `docs/architecture.md` explicitly describes a permissive default action policy (`allow: ["true"]`) although the evaluation engine itself fails closed if there is no policy. Atlas must implement/test strict policy defaults for its deployments rather than assume the product is secure out of the box.

## Release/GO boundaries

**G0 — Preservation gate (must precede full install):**
- Obtain full privately stored service dependency and data inventory, classify stateful services, confirm validity of database dumps and demonstrate restoring important systems to an isolated destination.
- Encrypt backups, store offsite, document retention and owner, never put dumps or secrets in public GitHub.
- Investigate security findings privately, especially local-network service exposure and privileged Docker ports.
- This stage may require deliberate changes to create backups. Those steps need a scoped operational GO; they are NOT an approval to stop/delete existing services.

**G1 — Capacity gate:**
- Measure actual memory/swap/disk headroom after non-destructive cleanup only when reviewed; design resource limits and isolated network/ingress.
- Do not assume reported reclaimable disk usage is all safely deletable.

**G2 — Intelligence:**
- Determine supported commercial/evaluation license for the exact target environment and whether access uses managed Intelligence or self-hosted services. Alternative proprietary-independent implementation is a separate project, not a quick config switch.

**G3 — Identity/security:**
- Define safe IdP/SSO, session settings and admin grants, deny-by-default Atlas policy, host and container network exposure, secrets rotation, remote SSH scope, and action approvals.
- Local/Desktop single-admin mode must not become public server auth.
- Do not publish detailed host vulnerabilities to this public repository.

**G4 — Controlled LAB installation (requires explicit GO):**
- Version-pinned, separated Compose project; conservative CPU/RAM; private-only ingress; synthetic tenant first.
- Initial functional scope: Atlas-Bot + Atlas-Agent bridge + limited Memory/Knowledge + Workforce, with end-to-end audit/approval.
- Show install/rollback plan and preserve existing volumes/services.
- Do not make all forks mandatory; test reused existing infrastructure where technically and legally appropriate.

**G5 — DNS/public exposure (separate later GO):**
- Only after G0-G4 evidence, working IdP, HTTPS, least-privilege policies, monitoring, Intelligence license, backups/restore and user acceptance.
- Plan route deployment without uncontrolled interruption to shared ingress; deployment should remain useful with user's PC powered off.

## Needed detailed evidence (private only)

Seven reports were referenced but not attached. The security report claims 13 risks while eight appear in the summary; obtain all 13 privately, test method and severity, current mitigation status. Review model reports to verify exact identity and terms for free-provider inference. Obtain restoration test evidence, exact service classification, and scoped patch plan from the bootstrap team.

## Recommended next instruction to PC OpenBot

Proceed with **BOOTSTRAP 003A: preservation and implementation design**. Agent team should prepare a single change plan and safe order of operations, without deploying, stopping, restarting, destroying, altering DNS or spending cloud money until owner approves the exact change batch. The Director should report a concise GO/NO-GO matrix with proof for each gate.

**This document does not authorize production deployment, changes to host firewall, use of payment providers or public DNS.**
