# Launch V0.1 — 13 November 2026

## Decisions

1. **Brand hierarchy:** Atlas SI (site, umbrella), Atlas Harness (architecture), AtlasBot Desktop (multiagent interface candidate), Atlas-Agent (Hermes agent runtime), Atlas Memory Fabric (GBrain), Atlas Operational Knowledge (Obsidian-compatible Markdown), Workforce (roles), WorkSwarms (experimental), CRM-OS (business application).
2. **Public promise:** an early-access architectural preview and verified development progress—not an already available commercial or open-source Desktop installer.
3. **Source import:** The Atlas-Bot-Desktop repository was populated successfully through a GitHub fork of SergioMonteiro-Atlas; a separate source rights and installer release gate remains.
4. **Rights:** `nightly-labs/openbot` current source PolyForm Noncommercial. Neither a renamed repository nor a clean URL grants commercial redistribution or operating rights. Separate licence negotiation from independently implementable Atlas components.
5. **Operations:** preserve Helena perimeter (four legacy agents Helena/Diana/Elisa/Maia, GWD Cockpit, LearnHouse/ClubOS, ARO, Deskcom CRM, media/webplayer) while isolating new AtlasBot + new Hermes with separate mounts/networks/permissions.
6. **AWS:** Antigravity leads account/Activate and architecture track. No paid resources or DNS production changes before account, approved budget and security architecture.
7. **Social launch:** one Atlas SI/AtlasHub umbrella voice first. Dedicated AtlasBot or Harness social handles are a later marketing decision based on audience and staffing capacity.

## Next measurable gates

| Gate | Owner | Evidence |
| --- | --- | --- |
| Public website controlled by Z.AI / GLM 5.3 | Z.AI | GPT website changes reverted in PR #3 |
| Installer licensing and public download gate | Z.AI + legal | Check actual downloads before any Atlas-branded release |
| Product repository complete | Engineering | GitHub main SHA, licence and NOTICE verified |
| AtlasBot Windows to VPS | OpenBot Local, Helena validates dependencies | Two agents delegate; restart preserves state; Hermes ACP |
| No regression in legacy protected agents | Helena | Health and Telegram/Discord tests for each configured agent |
| AWS staging plan, no surprise costs | Antigravity | Account/region, Activate status, risk/cost, IAM, budget alerts |
| Docs standardized | Atlas Architect | Canonical README, ADR, source/licence matrix, status badges |
| Genuine public comms | Comms | Announcement links to functioning site; no unsupported install promises |

## Reusable release policy

Upstream releases are monitored periodically. They are not directly shipped. Each candidate gets a diff, relevant security review, ACP/runtime tests, SQLite migration checks, licensing confirmation, release notes and a rollback plan. REA is optional deep investigation, not the default update path.

## Pointers

- [Launch #14](https://github.com/AtlasHub-Si/Atlas-Harness/issues/14)
- [VPS #13](https://github.com/AtlasHub-Si/Atlas-Harness/issues/13)
- [Site restoration PR #3](https://github.com/AtlasHub-Si/atlas-si-website/pull/3)
- [AWS readiness](aws-staging-credits.md)
- [Security](security-publication.md)
