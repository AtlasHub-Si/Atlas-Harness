# ADR-0001 — Atlas-Harness as an original, governed AI-native enterprise platform

- **Date:** 2026-11-12
- **Status:** Accepted as strategic direction; implementation and production claims are NOT accepted without evidence.
- **Scope:** Architecture, repository ownership, platform integration, knowledge domains, staged deployment.
- **Authority:** AtlasHub project direction / product owner.

## Context

A real multi-business-unit AI-native enterprise needs a clear separation between enterprise governance, task admission, operational execution, source-of-truth data, workforce roles and memory. Overlapping agent platforms must not create competing task routers, three independent persistent memories or uncontrolled access to company systems.

The existing Atlas prototypes are preserved as `atlas-blueprint-legacy`, `atlas-agent-legacy`, `atlas-workforce-legacy`, and `atlas-desktop`. The replacement component forks are created by GitHub forks, not by copying their files into a new repository.

## Decision

1. **Atlas-Harness** is a new public original architecture and contract repository. It is not a fork or executable orchestration engine.
2. **Atlas-Bot** (CopilotKit/OpenBot fork) is the enterprise interaction and control-plane entry point: human-facing governance, task admission, scopes, approvals, visibility and audit. Its proprietary dependencies require licensing review.
3. **Atlas-Agent** (NousResearch/hermes-agent fork) runs bounded, authorized work, subagents and skills. Internally it may coordinate subtasks, but cannot independently grant enterprise permissions, release external actions or override a parent mission budget.
4. **Atlas-Memory-Fabric** (garrytan/gbrain fork) contributes memory/knowledge capability behind an Atlas access-control interface. It does not automatically become an unrestricted shared database.
5. **Atlas-Operational-Knowledge** is an original Markdown-based, Obsidian-compatible controlled knowledge repository and publishing pipeline, not a fork of the Obsidian application.
6. **Atlas-Workforce** (msitarzewski/agency-agents fork) supplies role definitions and specialist templates; it is not an autonomous production organization by itself.
7. **Atlas-WorkSwarms** (ruvnet/ruflo fork) remains a lab. **Atlas-Crm-OS** (melgarafael/DeskcommCRM fork) is a replaceable BU operational app, not a mandatory part of Atlas-Harness.
8. AtlasClub/Academy/ARO and other business products remain BU/service systems integrated through contracts.

## Ownership and authority

There is one canonical enterprise **task ID**, **actor/agent identity**, **business-unit scope**, **policy decision**, **approval chain**, **budget**, **result record**, and **audit lineage**. Transport events may be replicated, but one transactional task ledger owns state transitions.

The central control plane may delegate a mission to Atlas-Agent. The agent may spawn specialist subagents within that mission's scoped authority. Every privileged tool action MUST pass a common policy enforcement point (including retries and scheduled jobs). A model saying 'approved' is not a valid permission grant.

## Separation of memory

Executive, internal department, operational knowledge, operational/customer transactions and agent working state each have distinct access scopes. No global unfiltered retrieval. Record ownership, provenance, sensitivity, retention, versions, publication status and revocation.

## Risks and non-goals

- OpenBot app code is MIT but CopilotKit Intelligence is separately licensed. A fork alone does not prove independent or commercial production rights.
- Runtime forks can diverge from upstream; regularly review security notices, releases and upstream diffs.
- Project names and repositories do not prove a working integration or deployment.
- Avoid simultaneous installation of OpenBot, Hermes, Ruflo and CRM on a small VPS without sizing and staged benchmarks.
- No company secrets, customer PII, private HR or live infrastructure configuration in public repositories.
- Credit eligibility is not proof of credit approval; billing protection is required before provisioning.
- **Not in phase 01:** production customer conversations, payment execution, autonomous GitHub main pushes, DNS changes, unfenced shell access, direct production infrastructure access.

## Consequences

The organization gains a stable platform identity and a replaceable runtime; integrations and enterprise policy are work to build and test. Stage-1 acceptance is an auditable read-only cross-component task, not 'all forks run'.

## Review triggers

Revisit this ADR if OpenBot licensing prevents production use, a direct AG-UI bridge is impossible without excessive complexity, gbrain cannot enforce required access boundaries, or AWS cost/capacity makes the proposed topology unsuitable.
