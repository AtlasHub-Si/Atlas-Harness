# CopilotKit Intelligence and ecosystem — Atlas-Harness technical due diligence

**Assessment date:** 2026-11-12  
**Status:** Research / architectural recommendation. No deployment, license acquisition or repo import performed.  
**Repositories indexed:** 106 public repositories found in the CopilotKit GitHub organization: 61 non-archived, 45 archived (GitHub search at assessment time). This does not enumerate hidden/private repositories or prove production readiness.

## Executive conclusion

1. **CopilotKit OSS code** provides interface/runtime capabilities; its flagship `CopilotKit/CopilotKit` and `CopilotKit/OpenBot` repositories are MIT.
2. **CopilotKit Intelligence** is a separately licensed production services layer for durable Rich Threads/AG-UI Streams, realtime sync, User Memories, Product Analytics, Automatic Learning, and managed Channels.
3. We did **not find the complete server source of CopilotKit Intelligence as a separately available public OSS repository** in the 106 public repositories. SDK/client integration and deployment instructions exist; self-host license and released service packages are separate. Do not infer that a container/Helm chart grants the right to modify and redistribute the complete server.
4. OpenBot **uses** Intelligence for durable conversations and realtime events. Hermes and GBrain do **not** automatically implement the same Intelligence protocol.
5. OpenDots, OpenDuet and OpenMuse are candidate UI experiences/skins, not reasons to replace Atlas-Bot with multiple overlapping control planes. Assess exact version compatibility.

## Intelligence capability map

| Feature | Verified purpose | Atlas alternative/subsystem | Gap |
| --- | --- | --- | --- |
| Rich Threads / AG-UI Streams | Durable conversation, events, UI state, continuation after reconnect | PostgreSQL thread/event log, AG-UI replay API | Design and implement Intelligence-compatible frontend/runtime contracts |
| Realtime Gateway | WebSocket events, catch-up, synchronization | Redis pub/sub or Postgres notifications with persistent cursor + outbox | Ordering, backfill, reconnect, fan-out, auth, versioning |
| User Memories | Scoped user/project facts and preferences, deduplication and provenance | GBrain + Atlas access-control adapter | Scope isolation, sync and lifecycle semantics not equivalent by default |
| Automatic Learning | Completed thread evidence -> Insights -> proposed versioned Skills -> human review/publication | Atlas-Operational-Knowledge + versioned Workforce skills + review pipeline | Not shipped, require evidence trace and policy/QA gates |
| Product Analytics | Interaction and tool/usage analysis | OpenTelemetry + audit/event warehouse + dashboards | Aggregation and analytics UI |
| Channels | Managed Slack and Teams integrations; separate open-source Channels SDK exists | Self-managed Channels SDK adapters and trusted messaging gateway | Platform tokens, delivery/retry, auth and independent support |
| Inspector / dashboard | Inspect threads and learning | Atlas Cockpit + audit UI | Context-specific built-in services and UI |

**Critical distinction:** The OpenBot service's authorization, approvals and computer action gateway are principally in OpenBot, not simply replaced by Intelligence. Atlas-Harness must keep an explicit tenant/BU policy decision and one enterprise task admission authority.

## Deployment and legal models

| Option | Description | Commercial issue |
| --- | --- | --- |
| Cloud-hosted Intelligence | CopilotKit runs platform; Atlas runs app, execution and model | Check plan limits, white-label/customer hosting and per-tenant data terms |
| Local CLI evaluation | Docker/desktop preview; local eval license | Not a blanket commercial/production license |
| Licensed self-hosted | CopilotKit release via Helm/K8s or AWS ECS/Fargate and own Postgres, Redis, OIDC, TLS | Requires valid self-hosted rights; software license not derived from OpenBot MIT |
| Atlas-independent compatible platform | Implement own thread/realtime/storage/learning/analytics/channels services | Engineering and full behavior/compatibility testing required; comply with legal boundaries, no copying proprietary service |

**Important:** official local preview docs list minimum 4 CPUs, 12 GiB RAM and 40 GiB free disk per Intelligence stack for a supported macOS Docker evaluation. This is not a production sizing formula. Helm deployment calls for Kubernetes, networking, OIDC, PostgreSQL and Redis; ECS/Fargate requires separate AWS setup and approved release access.

Licensing must be checked with CopilotKit in writing before selling third-party hosted instances or a bundled commercial Atlas-Bot image. Retain original OSS notices and do not represent the Intelligence service as MIT.

## CopilotKit public repository shortlist

| Repo | Observed license | Function | Atlas relevance | Priority |
| --- | --- | --- | --- | --- |
| [CopilotKit](https://github.com/CopilotKit/CopilotKit) | MIT | Core SDK, runtime, gen-UI, AG-UI integration | Atlas UX interfaces and runtime base | P0 |
| [OpenBot](https://github.com/CopilotKit/OpenBot) | MIT | Agent workspace, computers, policy, audit, sign-in | Atlas-Bot chosen control plane | P0 |
| [OpenDots](https://github.com/CopilotKit/OpenDots) | MIT | Persistent multi-coworker UI, Spaces, voice/calls/Slack integration; also OpenBot skin | Team/Community UX inspiration | P1 (skin first) |
| [OpenDuet](https://github.com/CopilotKit/OpenDuet) | MIT | Proactive briefings, triage, routines; also OpenBot skin | Executive assistant and proactive director | P1 (skin first) |
| [openmuse](https://github.com/CopilotKit/openmuse) | MIT | Cross-platform personal agent for web/mobile; browser/files/tasks; alpha | Atlas personal/mobile product research | P2 |
| [OpenIntelligentUI](https://github.com/CopilotKit/OpenIntelligentUI) | MIT | Chat experience that generates interactive visual answers | AtlasClub/Analytics dashboards | P1 |
| [channels-sdk](https://github.com/CopilotKit/channels-sdk) | MIT | SDK for AG-UI agents across messaging channels | Self-managed team/channel adapters | P1 |
| [OpenTag](https://github.com/CopilotKit/OpenTag) | MIT | Slack/Teams knowledge-work agent starter | GWD operator integration demo | P1 |
| [open-multi-agent-canvas](https://github.com/CopilotKit/open-multi-agent-canvas) | MIT per README | Multi-agent conversation canvas/demo | UI reference, not parallel orchestrator | P2 |
| [generative-ui](https://github.com/CopilotKit/generative-ui) | Verify root/dependency licenses | Examples for AG-UI/A2UI/MCP Apps | Copilot/UI R&D | P2 |
| [harness-sdk](https://github.com/CopilotKit/harness-sdk) | Apache-2.0 | Upstream Strands Agents SDK fork | Research alternative, not replace Hermes | P3 |
| [atomic-crm](https://github.com/CopilotKit/atomic-crm) | MIT; fork | CRM example/fork | Compare with Atlas-Crm-OS only | P3 |

**OpenDots and OpenDuet explicitly state that their experiences already ship as OpenBot skins.** Prefer evaluating them in the Atlas-Bot fork to introducing redundant platforms. OpenMuse README describes separate app and OpenBot compatibility adapter with unfinished work. Do not claim seamless migration.

**Archived examples:** 45 of 106 public org repositories were archived during inventory; treat such projects as examples with version drift and dependency risks, not platform-core candidates.

## Recommended approach

**Track A — Rapid compliant Atlas-Bot pilot**
- Keep MIT OpenBot core and current provider's Intelligence services **only under an appropriate evaluation/commercial entitlement**.
- Deploy Atlas-Agent with bridge, scope/policy, GBrain approved-read adapter, and test GWD synthetic organizational configuration.
- Try OpenDots/OpenDuet **skins** to test experience options without changing control-plane architecture.
- Begin Channels SDK integration only after core mission and security boundary are verified.

**Track B — Atlas Intelligence research**
- Define versioned contract and event protocol for threads, persisted tool calls and UI state.
- Recreate required behavior from public documented protocols and original engineering, not by assuming proprietary service code is OSS.
- Use PostgreSQL + durable outbox for authoritative records, SSE/WS gateway for replay and fan-out, GBrain with Atlas access policy for durable memory, Operational Knowledge editorial approvals for Skills, OpenTelemetry for analytics, and a self-hosted channels adapter.
- Replace Intelligence only if all required enterprise flows, reconnect/resume, permissions, legal constraints, performance and costs are validated.

## Specific questions for CopilotKit commercial/legal team

1. Which Intelligence rights cover Atlas-Bot as a branded fork deployed for GWD and third-party clients?
2. Is sub-licensing, managed hosting for third parties, multi-tenant use or per-customer dedicated hosting permitted?
3. How are users, organizations, projects, concurrent agents, chats, learning, messages, channels and compute metered? Any platform, per-seat, per-project or cluster limits?
4. Does the Intelligence local evaluation entitlement extend to Linux VPS remote trials? (Do not assume.)
5. Are ECS/Fargate images/Helm artifacts accessible under the proposed plan? License prerequisites and renewal/offline terms?
6. Are data export/migration, retention, deletion, region and backup semantics covered contractually?
7. Is public white-label marketing permitted with full OSS attribution and proper brand separation?
8. What responsibilities and terms apply to external LLM providers, connector access, channels and user data?

## Primary sources

- [CopilotKit Intelligence overview](https://docs.copilotkit.ai/intelligence/overview)
- [OSS vs Intelligence](https://docs.copilotkit.ai/teams/mastra/concepts/oss-vs-enterprise)
- [Self-hosting / Helm](https://docs.copilotkit.ai/deepagents/intelligence/self-hosting)
- [AWS ECS/Fargate Intelligence](https://docs.copilotkit.ai/slack/ag2/intelligence/self-hosting-ecs)
- [Local evaluation](https://docs.copilotkit.ai/intelligence/self-hosting-local)
- [Automatic Learning](https://docs.copilotkit.ai/vue/learning)
- [OpenBot architecture](https://github.com/CopilotKit/OpenBot/blob/main/docs/architecture.md)
- [OpenBot README and licensing](https://github.com/CopilotKit/OpenBot/blob/main/README.md)
- [OpenDots README](https://github.com/CopilotKit/OpenDots)
- [OpenDuet README](https://github.com/CopilotKit/OpenDuet)
- [OpenMuse README](https://github.com/CopilotKit/openmuse)
