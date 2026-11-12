# Atlas-Harness

**Open blueprint for governed AI-native enterprises.**

> Status: **pre-alpha architecture**, not a production-ready integrated platform. Version: `0.1.0`. Founded by AtlasHub. Updated 2026-11-12.

Atlas-Harness defines the enterprise architecture connecting a control plane, autonomous agent execution, organizational workforce, shared memory, operational knowledge, and auditable business operations. We treat AI agents as accountable roles in a real organization, not as a collection of disconnected chatbots.

This repository is the **canonical architecture and integration contract**, not a fork and not the complete runtime. Its component repositories retain their upstream history and licenses.

## Start here

1. [Official strategic decision (ADR-0001)](docs/adr/0001-atlas-harness-architecture.md) · [ADR-0003: laboratory consolidation](docs/adr/0003-lab-consolidation-aws-gwd-rollout.md)
2. [Architecture, boundaries and single authority model](docs/architecture.md)
3. [Repository map, source of truth and migration](docs/repository-map.md)
4. [Memory domains and operational knowledge](docs/memory-knowledge.md)
5. [Team directive and responsibilities](docs/team-directive-2026-11-12.md) — [Role-by-role distribution briefings](docs/briefings-role-by-role.md)
6. [Phase 01 plan and acceptance gates](docs/phase-01-roadmap.md) · [VPS lab read-only onboarding checklist](docs/lab-onboarding-readiness.md)
7. [AWS staging and startup credits research](docs/aws-staging-credits.md)
8. [Public vs internal information policy](docs/security-publication.md)

**LAB strategy and decision:** [ADR-0003](docs/adr/0003-lab-consolidation-aws-gwd-rollout.md) · [VPS audit + AWS decision issue](https://github.com/sergiomonteiro-atlas/Atlas-Harness/issues/9).\n\n**Phase 01 tracking:** [Team acknowledgment](https://github.com/sergiomonteiro-atlas/Atlas-Harness/issues/1) · [AWS and credits](https://github.com/sergiomonteiro-atlas/Atlas-Harness/issues/2) · [First end-to-end pilot](https://github.com/sergiomonteiro-atlas/Atlas-Harness/issues/3).\n\n**Operational clarification (12 Nov 2026):** The existing AtlasHub VPS is classified by the project owner as a non-production laboratory and may be reorganized after inventory and backups. Public briefing documents have **not yet been distributed to team members**; the team is not considered notified.\n\n## Platform map

| Atlas project | Responsibility | Origin |
| --- | --- | --- |
| [Atlas-Bot](https://github.com/sergiomonteiro-atlas/Atlas-Bot) | Enterprise interface, identity, admission, policy and approvals | Fork: CopilotKit/OpenBot |
| [Atlas-Agent](https://github.com/sergiomonteiro-atlas/Atlas-Agent) | Restricted execution runtime; tools, skills, subagents | Fork: NousResearch/hermes-agent |
| [Atlas-Memory-Fabric](https://github.com/sergiomonteiro-atlas/Atlas-Memory-Fabric) | Governed memory access and knowledge graph | Fork: garrytan/gbrain |
| [Atlas-Operational-Knowledge](https://github.com/sergiomonteiro-atlas/Atlas-Operational-Knowledge) | Controlled Markdown playbooks, FAQs and scripts | Atlas original; Obsidian-compatible |
| [Atlas-Workforce](https://github.com/sergiomonteiro-atlas/Atlas-Workforce) | Canonical role, SOUL and skills catalog | Fork: msitarzewski/agency-agents |
| [Atlas-WorkSwarms](https://github.com/sergiomonteiro-atlas/Atlas-WorkSwarms) | Experimental swarms and federation | Fork: ruvnet/ruflo |
| [Atlas-Crm-OS](https://github.com/sergiomonteiro-atlas/Atlas-Crm-OS) | BU sales/CRM application, not core harness | Fork: melgarafael/DeskcommCRM |

**Labs / BU applications** such as AtlasClub, Academy, ARO, and future Desktop remain independently operated and integrate through versioned contracts.

## Design invariants

- Exactly **one enterprise task owner** and one authorization decision path per external action. Agent-internal delegation may run within an approved scope; it cannot grant itself further permissions.
- Each agent has a stable identity, department/BU, tool grants, budget, escalation path and audit trail.
- Corporate/executive memory, operational knowledge, customer records and agent working memory are **separate domains** with enforced access control.
- Markdown/Obsidian may be a *knowledge authoring surface*, never an uncontrolled transactional database.
- No credentials, customer personal data, confidential HR records, infrastructure access details, or live billing details in public GitHub repositories.
- Upstream MIT notices and provenance preserved. The OpenBot fork depends on separately licensed CopilotKit Intelligence; independence and production rights require explicit due diligence.

## First milestone: governed read-only mission

A department manager requests a bounded task from Atlas-Bot. Atlas policy admits it, Atlas-Agent executes with restricted tools, retrieves an approved operational document through a scoped Memory Fabric adapter and returns evidence, cost, events and an auditable result. **No messages to real customers, financial activity or production mutations** in this first pilot.

## Contribution and maturity

Architecture changes require an ADR and a reviewed PR. Integration schemas are proposed in this initial phase; compatibility should not be assumed until exercised in end-to-end tests.

Copyright and software licenses of upstream repositories remain with their respective owners. Project-specific licensing for this original blueprint requires a separate approved decision.
