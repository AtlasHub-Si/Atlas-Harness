# ADR-0003 — AtlasHub laboratory consolidation and AWS GWD reference installation

**Date:** 2026-11-12  
**Status:** Approved planning orientation from project owner; changes to servers, costs and service lifecycle require an explicit execution GO.  
**Updates:** ADR-0001, ADR-0002, infrastructure/communication plan.

## Updated operational assumption

The owner confirms that the current AtlasHub VPS and Helena/Hermes team are predominantly **experiments, pilots and development**, not a production estate requiring uninterrupted operation. This authorizes planning a comprehensive, reversible laboratory reorganization and a complete **Atlas-Harness core onboarding rehearsal**. It does not constitute approval to destroy data or disable unidentified live endpoints.

No instructions have yet been sent to team members by the owner. Existing GitHub documents and issues are public coordination drafts, **not evidence of distribution or acknowledgment**. The team briefing must use this new ADR.

## Service groups and handling

| Service class | Default disposition | Gate |
| --- | --- | --- |
| AtlasClub Campus / LearnHouse and GWD LearnHouse | Preserve and isolate; may pause after successful backup and restoration evidence | Check databases, volumes, branding work and integrations |
| Adapted CRM | Preserve and isolate until data, schema and adapters recorded | Verify backups and current external connections |
| ARO | Preserve and isolate; caution around payment/webhook/entitlements even if only being tested | Check side effects, callbacks and backup/restore |
| Helena and original Hermes | Export Soul, profiles, skills, job schedules, memory, agent catalog and relevant config before reorganization | No secrets in public repositories |
| GWD structure configured in original Hermes | Preserve source assets and use them to configure GWD later under Atlas-Harness | Compare before cutover |
| Other test services | Stop/archive candidates, case by case | Inventory, dependency map, approval, reversible shutdown |

## Two environments, one reproducible Atlas-Harness

**AtlasHub LAB:** controlled testing site for compatibility, onboarding installer, fictitious GWD-like organization, three-role pilot and two-tenant isolation tests. It can be reorganized, but only once capacity, backups and edge conflicts are verified. Earlier capacity reports suggest high swap use, disk pressure and numerous Docker containers; the current state must be re-measured.

**AWS GWD REFERENCE:** candidate first clean installation of GWD using the same installer/release as LAB and a tenant configuration rather than a GWD-specific product fork. This deployment starts after eligibility, awarded AWS Activate credits, model/Bedrock cost coverage, IAM, budget and licensing are verified. If AWS is not ready, keep working in the LAB; do not delay core engineering.

We do not need Kubernetes merely to test the Atlas-Harness core. Start with appropriately isolated containers and measured limits; a full OpenBot evaluation still requires suitable CopilotKit Intelligence access and license.

## Sequence

1. Read-only current-state inventory: containers, Compose projects, services, volumes, databases, backups, Caddy, DNS, users, cron, Hermes/Helena, LearnHouse, CRM, ARO, dependencies and outbound webhooks.
2. Classify every workload as PRESERVE, ISOLATE, STOP_AFTER_BACKUP, ARCHIVE, or UNKNOWN. UNKNOWN is not touched.
3. Capture versioned config, image digests and **private encrypted** backups; verify restore for services whose state matters.
4. Propose a selective shutdown and reclaim resources; no broad Docker prune with volumes, indiscriminate Compose volume deletion or unreviewed overwrites of secrets.
5. Prepare isolated Atlas-LAB with restricted network, designated ingress, memory/CPU limits and explicit access policy.
6. Test complete core onboarding: organization, Council/Directors, Atlas-Bot, Atlas-Agent, Memory Fabric, Operational Knowledge, Workforce, human approvals, policy, evidence and audit.
7. Verify two fictional organizations can be provisioned independently without code changes; deny cross-org and cross-BU retrieval.
8. Use AWS GWD REFERENCE once credits/costs and permissions are approved; progress from synthetic/shadow tasks to a reversible internal canary.
9. Migrate GWD configurations and operational processes from existing Hermes only after safety and rollback criteria are met.

## Meaning of full onboarding

Complete core onboarding means the whole **supported product core**, not starting every available fork. WorkSwarms, CRM, ARO, real WhatsApp, payments and all business units remain optional integrations beyond the first acceptance test.

## Gates before action

**Preservation** (backups/restoration); **capacity** (RAM, swap, disk, port ownership); **licensing** (CopilotKit Intelligence and providers); **funding** (actual credits, region, AWS budget, charge visibility); **security** (isolated identities/secrets); **pilot** (repeatable end-to-end evidence).

**This ADR changes planning assumptions; it makes no direct server change, performs no shutdown and does not notify any team member.**
