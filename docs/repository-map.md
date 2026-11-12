# Repository map and ownership v0.1

## Canonical Atlas family

| Repository | Class | Origin / state | Change policy |
| --- | --- | --- | --- |
| `Atlas-Harness` | Public architecture, policy/contracts | New original Atlas repo | PR + ADR for breaking decisions |
| `Atlas-Bot` | User-facing enterprise control plane | Fork of `CopilotKit/OpenBot` | Preserve upstream and licensing |
| `Atlas-Agent` | Bounded execution runtime | Fork of `NousResearch/hermes-agent` | Maintain upstream patch review |
| `Atlas-Memory-Fabric` | Scoped knowledge and memory adapter | Fork of `garrytan/gbrain`, default `master` | Verify access boundaries before multi-tenant use |
| `Atlas-Operational-Knowledge` | Controlled knowledge authorship | New original Atlas repo | Publish only fictional/public records |
| `Atlas-Workforce` | Specialist role catalog | Fork of `msitarzewski/agency-agents` | Avoid confusing role definitions with permissions |
| `Atlas-WorkSwarms` | Experimental coordination | Fork of `ruvnet/ruflo` | Lab only, separate deployments |
| `Atlas-Crm-OS` | Replaceable BU Sales OS | Fork of `melgarafael/DeskcommCRM` | BU integration and privacy review |

## Retained legacy / laboratory

- `atlas-blueprint-legacy`: previous validated contracts and specifications; preserve before migration.
- `atlas-agent-legacy`: original TypeScript bounded harness and reality auditor; study the critical architecture, do not misrepresent it as a Hermes fork.
- `atlas-workforce-legacy`: previous Atlas templates, converters, Souls and starter Vault; selective migration.
- `atlas-desktop`: exploratory UI/desktop; review before deciding to fork/replace later.
- REA (`morluto/rea`) is an engineering research tool, not the core runtime.
- `Atlas-Crm-OS`, Academy/AtlasClub (incl. `atlas-club-campus`), Atlas MAIC Lab, ARO and commercial BU sites are **operational applications**. Integrate through published APIs/events; do not bundle into the core harness.

## Upstream and licensing

Retain GitHub fork relationships and original notices. Do not squash provenance into uncredited original Atlas code. For OpenBot verify separately licensed CopilotKit Intelligence as a gating requirement. Mark production independence as **unverified**.

## Version and release protocol

`Atlas-Harness` architecture follows `0.x` pre-alpha release cadence. Each integration contract must state version, compatibility matrix, owners, migration and test evidence. Avoid claiming that upstream versions deployed to the staging VPS match their GitHub tip until explicit pinning.

## Links

- Architecture: [ADR-0001](adr/0001-atlas-harness-architecture.md).
- Team directive: [12 Nov 2026](team-directive-2026-11-12.md).
- Pilot milestone: [Phase 01](phase-01-roadmap.md).
