# Atlas ecosystem — source-of-truth and repository ownership (2026-11-13)

This document supersedes the November 12 repository map where it treats `CopilotKit/OpenBot` as the only interface or assumes its Intelligence dependency is required for the Electron branch.

## GitHub organization and provenance

| Canonical repo (all under `AtlasHub-Si/`) | Category | Source | Approved usage |
| --- | --- | --- | --- |
| `Atlas-Harness` | Original governing architecture | AtlasHub original | Public architecture V0.1 |
| `Atlas-Bot-Desktop` | Candidate Desktop + remote host | Independent Git copy planned from `sergiomonteiro-atlas/Atlas-Bot-Desktop`, a fork of `nightly-labs/openbot` | Reference/evaluation; PolyForm Noncommercial; import still pending |
| `Atlas-Bot` | Parallel enterprise UI/control plane R&D | Fork `CopilotKit/OpenBot` (Tauri + React) | Research, NOT Electron source |
| `Atlas-Agent` | Hermes via ACP | Fork `NousResearch/hermes-agent` | Agent runtime; validate API/secret isolation |
| `Atlas-Memory-Fabric` | GBrain / knowledge graph adapters | Fork `garrytan/gbrain` | Research behind tenant access controls |
| `Atlas-Operational-Knowledge` | Approved Markdown vault | Atlas original; Obsidian editor optional | Public synthetic playbooks only |
| `Atlas-Workforce` | SOUL / skill roles | Fork `msitarzewski/agency-agents` | Templates do not convey permissions |
| `Atlas-WorkSwarms` | Swarm federation | Fork `ruvnet/ruflo` | Experimental isolated lab |
| `Atlas-Crm-OS` | CRM BU candidate | Fork `melgarafael/DeskcommCRM` | Isolated BU system, not Harness dependency |
| `atlas-si-website` | Public website | Atlas Next.js app; original V0.1 home, inherited content pending audit | Early access, no installer |

There are **two unrelated projects called OpenBot**. `nightly-labs/openbot` is the Electron client currently matching the operator's Windows desktop. `CopilotKit/OpenBot` is a different Tauri/React enterprise-oriented project. Merging their source histories or claiming their protocols are interchangeable is an architectural error.

## Development lanes

1. **Reference fork** `sergiomonteiro-atlas/Atlas-Bot-Desktop`: sync upstream, no Atlas branding.
2. **Product repository** `AtlasHub-Si/Atlas-Bot-Desktop`: freeze a reviewed upstream commit; build integration branches and PRs, not automatic updates. Must verify import succeeded before claiming code available.
3. **Harness**: contracts, scope, evidence and governance. Separate from Desktop process internals.
4. **Infrastructure**: existing VPS lab (Helena boundary preserved) and separately approved AWS staging, never a shared unconstrained Docker root.

## Upstream sync

Record exact upstream SHA and licence at each baseline. Git diff and tests first; targeted REA investigation only for difficult structural changes. Changes affecting SQLite migrations, ACP adapter, identity, user-profile persistence, remote Signal/TURN and Electron sandbox need isolated integration and rollback before merge. No upstream direct deployment to Atlas production.

## Licence rules

Each project retains source-level rights and attribution; **do not declare all Atlas repositories MIT**. The latest `nightly-labs/openbot` is PolyForm Noncommercial; the copy repository does not confer commercial distribution rights. Future Atlas Community edition must contain only code under licences allowing its distribution and usage; a separate Enterprise edition requires necessary permissions.

## Useful technical links

- [Architecture](architecture.md) · [Memory](memory-knowledge.md)
- [Atlas SI launch](atlas-platform-v01-release-alignment.md)
- [Security and publication](security-publication.md)
- [AWS staging](aws-staging-credits.md)
