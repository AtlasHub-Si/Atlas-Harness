# Atlas AI-Native Infrastructure Crew — V1 (proposed)

**Created:** 2026-11-18  
**Status:** DRAFT — operational team proposal, not a deployed team or granted authorization  
**Steward:** AtlasBot-Local (existing platform agent; mentor and original technical context holder)  
**Purpose:** Extract, verify, transfer and operationalize repeatable know-how about deploying and integrating AI-native VPS platforms while keeping AtlasBot-Local available for other assignments.

## Principle: three new specialized agents, not three copies of the mentor

Create an AtlasBot project/section named `ATLAS | AI-Native Infrastructure Crew` and a dedicated team channel. Use the AtlasBot's actual supported agent creation, persistent identity, delegation and messaging features. The original AtlasBot-Local **is not part of the three-agent permanent roster**; it is the mentor and source of technical transfer.

| Agent role | Suggested agent ID | Accountabilities | Initial access |
|---|---|---|---|
| **Platform Crew Lead** | `ATLAS-PLATFORM-LEAD-01` | Architecture and delivery ownership; delegates missions; creates change plans and deployment gate checklists; liaison with GWD NEXUS and owner | GitHub read, agent/team coordination; no production credentials |
| **Infrastructure Integration Engineer** | `ATLAS-INFRA-ENG-01` | Inventories actual hosts; prepares Docker/Compose, networks, stateful DBs, MCP integration, provisioning and reversibility plans; proposes changes on branches | Read-only host inventory only where explicitly granted; no unrestricted shell or Docker socket |
| **Reliability & Knowledge Engineer** | `ATLAS-RELIABILITY-KNOW-01` | Independently checks backups, boundaries, service health, secret hygiene, QA, rollback, evidence, runbooks and lessons learned; challenges self-reported PASS | GitHub read/test artifacts; no privileged host access |

### Workforce references (templates, not operators or permissions)

- `AtlasHub-Si/Atlas-Workforce/engineering/engineering-devops-automator.md`
- `AtlasHub-Si/Atlas-Workforce/engineering/engineering-sre.md`
- `AtlasHub-Si/Atlas-Workforce/engineering/engineering-multi-agent-systems-architect.md`
- `AtlasHub-Si/Atlas-Workforce/engineering/engineering-technical-writer.md`
- `AtlasHub-Si/Atlas-Workforce/specialized/agentic-identity-trust.md`

Select and tailor patterns rather than blindly installing every agent; agent profile text never grants permission.

## Required onboarding and knowledge handoff

AtlasBot-Local delivers a versioned **Evidence-Based Knowledge Transfer Dossier**, using `AI-NATIVE-PLATFORM-HANDOFF-TEMPLATE.md`. It is not acceptable to claim the new team built the original deployment. Separate:

- Original creator's confirmed actions and sources;
- Live host observations (timestamp and operator identity), if available;
- README/PR/documentary claims not yet live-verified;
- Inferences, unresolved questions, uncertain paths/versions.

No raw chat history, private keys, passwords, env files, SSH material, customer content, or production configurations belong in the public Harness. The GWD-specific annex belongs in its private operational vault, sanitized and reviewed. Grant access per mission, not by cloning the mentor's broad tool permissions.

### Explicit teaching cycle

1. **Mentor interviews its own evidence**: list past project milestones, repositories, pull requests, target host inventory references, failures and corrections, deployment logic, integration contracts, how to verify and safely roll back.
2. **Crew Lead validates scope**: confirm what the new team may do, what must be escalated, owners of GWD resources, and its first mission. Delegate narrow tasks.
3. **Infrastructure Engineer reproduces understanding**: produce fresh read-only architecture map and implementation/rollback plan without relying only on mentor narrative.
4. **Reliability & Knowledge Engineer independently audits**: compare against files, commits, actual host and tests; mark each claim VERIFIED, DOCUMENTED-UNVERIFIED or UNKNOWN.
5. **Teach-back exercise**: all three answer: how is AtlasBot hosted, where does GBrain run, how is the GWD Vault ingested, how does MCP auth work, who may deploy, how to restore. Include evidence.
6. **Owner acceptance**: after reviewed handoff, mark initial onboarding accepted. The mentor remains available for exceptions but no longer is the execution bottleneck.

## First assigned mission — GWD GBrain integration

Implement only **planning/read-only inventory first** for the existing GWD VPS and AtlasBot agent. The GWD agent NEXUS is the business integration coordinator; this technical team owns the platform deployment design. It must consume the approved GWD Charter and proposed Atlas-Cortex ADR through authorized access.

Deliver: actual host inventory; independent GBrain sidecar/DB design with capacity and backup; authorized private MCP integration plan; threat model; smoke/evaluation tests with real citations; rollback; draft change proposal. No host write/install/deploy/role grant before named authorization.

## Durable learning — record every mission

For every mission create or update a reviewed, structured operational record with:
`mission_id`, `tenant`, `project`, `requester`, `responsible_agent`, `delegates`, `scope`, `source_commits`, `environment`, `actions_proposed`, `actions_executed`, `observations`, `test_evidence`, `failures`, `fixes`, `rollback`, `permissions`, `lessons`, `reusable_pattern_candidate`, `approval`, `status`.

- GitHub PR/reviewed Markdown = authoritative reusable documented procedure.
- Ops task service of the recipient tenant = authoritative mission state.
- GBrain = governed retrieval/index, not authority for deployment state.
- Future Atlas skill = optional after at least one evidenced repeatable run; **do not build or publish a skill in this mission**.
- Separate Atlas reusable patterns from GWD-specific private values and relationships.

## Security and approval gates

- No root credentials, no standing sudo, no Docker socket, no unrestricted agent SSH, no installing packages/scripts from unreviewed URLs, no production changes or public endpoint exposure on the strength of this document alone.
- Work through reviewed code + a least-privileged supervised runner for approved actions. Maintain backup, failure/rollback proof and decision/event audit.
- Changes requiring owner approval: installing system services, enabling privileged tools, host/database changes, opening network ingress, production deploys, migrations and secret administration.
- Stop if a tenant boundary is unclear, backup is absent, or evidence is contradictory.

## Acceptance — roster is real only if verified

Record actual agent IDs returned by the running AtlasBot, each agent's prompt/version, team channel/section, rights, handoff dossier link, tool/integration test, and first task ownership. If the runtime cannot create or message agents using its current API, create only profiles/workspaces and report the precise missing capability, not a fictional team.
