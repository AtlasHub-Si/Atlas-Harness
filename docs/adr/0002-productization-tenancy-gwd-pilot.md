# ADR-0002 — Atlas-Harness as a replicable product; GWD as first reference tenant

- **Date:** 2026-11-12
- **Status:** Proposed for architecture and commercial/legal review (NOT production approval).
- **Parent:** [ADR-0001](0001-atlas-harness-architecture.md)
- **Product scope:** original Atlas-Harness architecture plus forked, independently licensed components.
- **First target:** GWD (GoWorld Digital) as internal reference organization / pilot tenant.

## Thesis

Atlas-Harness is a **product platform**, not a hard-coded GWD deployment. GWD becomes the first deployment and acceptance customer. Later editions may serve AtlasClub community members, individual self-host users, and external client organizations, subject to licensing, data separation, security and economics.

## Non-negotiable separation

| Product layer | Owned by | Variation |
| --- | --- | --- |
| Atlas-Harness architecture, contracts, policy gateway, provisioning, audit interfaces | Atlas core | Versioned code and schemas, common to every tenant |
| Atlas-Bot control plane and UI | Atlas fork of CopilotKit/OpenBot | Brand, themes, roles, language, clients, approval flows |
| Atlas-Agent execution backend | Atlas fork of NousResearch/hermes-agent | Per-org agents, model routes, tools, tasks and runtime isolation |
| Atlas-Memory-Fabric | Atlas fork of garrytan/gbrain | Per-org namespace, access policy, provenance, retention |
| Atlas-Operational-Knowledge | Atlas original | Per-org approved product playbooks, SOPs, FAQ, scripts and schemas |
| Atlas-Workforce | Atlas fork of msitarzewski/agency-agents | Installable role templates, per-org organization directory and SOUL identity |
| GWD organizational configuration | GWD | Council, divisions, BUs, approvers, live operations, knowledge and KPIs |
| Customer organizational configuration | The customer | Identical product, separate tenant, personnel and business data |

No GWD-specific roles, policies, secrets, data or hard-coded domains in core runtime.

## Tenant specification (proposed)

- Stable `tenant_id`, `organization_id`, `environment_id`, `business_unit_id`, `department_id`, `agent_slug`, `role_id`, `policy_version` and `deployment_id`.
- Every task, authorization, memory query, event and audit record carries tenant and environment context.
- Per-tenant encryption/secrets, permissions, approved model providers, budgets, retention, backup and export rules.
- Test negative cross-tenant isolation including cache/vector search, async jobs, log access and model prompts.
- Enterprise tenants may need **dedicated deployment** and database; community tenants may use shared multi-tenant infrastructure only after security evaluation.
- Single installation command/manifest and a documented update/rollback process; restore/export for customer portability.

## Proposed distribution tracks (not yet offers)

1. **Community / Developer:** personal evaluation, local or own VPS, self-managed, limited resources and clear third-party requirements; free Atlas product tier is a future decision, not a promise of unrestricted compute or API usage.
2. **Team / Cloud:** Atlas-managed service or paid dedicated instance, SSO/team roles, quotas, backups, approvals, support and measurable LLM usage.
3. **Enterprise / Private:** dedicated tenancy or on-prem/private cloud, stronger controls and integration/service contracts.

Separate platform subscription, infrastructure charges, provider LLM consumption, support and professional services. Never finance external customer usage by passing on the AtlasHub AWS Activate credit allocation; AWS Activate credits cannot be passed to end customers (AWS Activate terms).

## Brand and third-party license boundaries

- UI branding may become Atlas; do not claim all third-party code was independently authored by Atlas.
- Preserve original MIT copyright/license notices, bundled third-party notices and historical provenance; do not use upstream trademark/logo as Atlas brand.
- **OpenBot / CopilotKit Intelligence:** MIT OpenBot application does **not** grant the separately licensed CopilotKit Intelligence production, commercial hosting or redistribution rights. Validate commercial terms OR build a fully authorized independent replacement/adapter before claiming Atlas-Bot is standalone and resellable.
- **Obsidian:** Markdown vaults are Atlas-owned content; Obsidian is an optional external editor. Do not redistribute/fork the Obsidian application or include it in a customer installer unless separately licensed.
- Verify every component's dependency notices, model/provider usage terms, and license compatibility; legal review before commercial launch.
- Distribution status is NOT equal to production readiness.

## First GWD tenant migration: no big bang

The project owner clarified that existing GWD/Hermes and AtlasHub VPS workloads are predominantly non-production experiments. They may be reorganized after a read-only inventory, recoverable backups, service classification and explicit GO. AtlasHub LAB may host a full core onboarding rehearsal; AWS is the preferred GWD reference target if credits and security gates pass. See [ADR-0003](0003-lab-consolidation-aws-gwd-rollout.md).

### Stage A — Inventory (read-only)

Capture current GWD/Hermes profiles, Souls, system prompts, agent roles, skills, tasks/cron, providers, integrations, memory layout, records, dependencies, current volumes, backups, and channel assignments. **Do not copy tokens or private data into public repos.** Classify what is actually running vs planned.

### Stage B — Reproducible synthetic tenant

Provision a **fictional GWD-like** organization manifest in Atlas staging with Council, directors, Shared Services, BUs, Labs, and three pilot roles. Run approved knowledge queries using fictional product docs.

### Stage C — Shadow mode

Integrate Atlas-Agent in a sandbox from the Hermes fork and run the same **non-mutating** GWD sample task under Atlas admission, policy, memory and audit. Compare outputs, costs, errors, accuracy and security to incumbent GWD/Hermes behavior. No production sends, API writes or active schedule duplication.

### Stage D — Canary

After documented approval, migrate **one bounded, reversible internal GWD workflow** (e.g., internal report/research), with rollback, independent monitoring, and explicit tool scopes. No client conversations, financial systems, production publishing or irreversible side effects in first canary.

### Stage E — Controlled progressive migration

Expand by BU and workflow only after compatibility, data separation, latency, recovery, risk and cost evidence. Use dual-run where safe; never allow two execution systems to send the same external message. Define cutover and rollback per channel.

## Definition of Done — Productization v0.1

- [ ] One Atlas-Harness build deploys **two different fictional organizations** from manifests, without source edits.
- [ ] Distinct agents, data stores/scopes, model budgets, audit and policy decisions per organization.
- [ ] Demonstrate cross-tenant denial, knowledge revocation, update/rollback and portable export.
- [ ] A restricted read-only mission is traceable end-to-end in Atlas-Bot.
- [ ] Identify explicit license plan for CopilotKit Intelligence or authorized independent alternative.
- [ ] GWD read-only inventory and migration mapping approved by Infra/Helena, operational lead and QA.
- [ ] GWD canary approved only after infrastructure/finance/security gates.

## Open questions requiring explicit decision

1. Atlas-original core license (MIT, Apache-2.0, or another scheme) and whether commercial extensions will be separate.
2. Commercial dependency model for OpenBot Intelligence.
3. SaaS shared vs dedicated runtime by tier.
4. Tenant-level data residency and SLA commitments.
5. Model budget and billing responsibility; provider credit eligibility.
6. Scope of the first GWD internal read-only workflow.

**No production deployment, customer billing or migration is authorized by this ADR.**
