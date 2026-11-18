# ADR-0006 (PROPOSED) — Atlas-Cortex as a governed context gateway, not an immediate GBrain replacement

**Date:** 2026-11-18  
**Status:** PROPOSED / architecture review only — NOT an authorization to deploy, migrate, deprecate or cut over  
**References:** Atlas-Cortex `docs/HARNESS_INTEGRATION_PROPOSAL.md`, `docs/RFC-002-REVIEW-v2.0.md`, [Atlas-Cortex Issue #1 / GPT review](https://github.com/AtlasHub-Si/Atlas-Cortex/issues/1#issuecomment-6984457065), ADR-0001, ADR-0002, `docs/memory-knowledge.md`, GWD `docs/GBRAIN-SOURCE-MAP.md`.

## Context
Cortex proposes a lean four-layer enterprise memory model and MCP/HTTP context-pack orchestration, but its v2.0 implementation does not yet satisfy the Atlas-Harness multi-tenant authorization and evidence contracts. In particular, current SQL schema lacks tenant/memory-tier columns and vector data, Context Pack fetchers are stubs, API/Docker build inputs are absent, and the proposed Kùzu backend is archived. Its deployment assumptions also conflict with the current architecture: `atlas-si.com` is a Vercel site; the dedicated `signal.atlas-si.com`/TURN backend is on a separate Atlas VPS.

## Proposed decision
1. **Cortex = candidate knowledge/context gateway**: expose context-pack APIs, evidence references, policy decisions, and reviewed publication workflow. Do not make it a second Atlas-Harness task orchestrator or a source of transactional business truth.
2. **Atlas-Harness = authority** for tenant admission, mission scope, BU/department, agent/user role, classifications, purposes, budget, approvals and auditing. Never trust agent-provided `tenant_id` as a grant.
3. **Atlas-Operational-Knowledge and private GWD vaults = canonical authored knowledge**. Git review and version/hash publication receipts are required. Obsidian remains an optional editor. CRM, cockpit and other business systems own their live transactional data; Cortex indexes authorized references rather than copying unbounded customer data.
4. **Atlas-Memory-Fabric / GBrain = incumbent retrieval engine and migration comparator**. Preserve its installed state and data; measure its sources/brains, Git-canonical/indexing, provenance and access behavior against Cortex. Deprecation requires independent functional/security evidence, export/restore and rollback.
5. **Graph = optional projection**, not a mandatory archived database in the MVP. Prefer tenant-filtered relational edges in PostgreSQL as Sprint 0 baseline; decide graph specialization using measured workloads.
6. **Atlas-Agent / Hermes = per-mission episodic working memory**, with TTL and explicit promotion proposals, not unrestricted write access to approved knowledge.
7. **GWD operational and executive knowledge remain physically and cryptographically isolated** when the data owner/authorization perimeter differs.

## Mandatory retrieval contract (versioned)
Every request must identify authenticated `principal_id`, `tenant_id`, `environment_id`, `business_unit_id`, `department_id`, purpose/mission, role/scope and policy version. Resolve rights on the server **before** document, vector, graph, cache or context assembly. Responses include `document_id`, source repository/path/commit, content hash, version, classification, publication state, policy decision, extraction timestamp and citation. Deny on missing metadata, ambiguity or revoked documents. Every cache key and background job is partitioned by authorization context.

## Required acceptance tests
- Same-tenant authorized published record retrieved with exact versioned citation.
- Unapproved, stale, revoked and restricted records denied; immediate revocation invalidates SQL/graph/vector/cache projections.
- Two synthetic tenants plus GWD BU01/BU03 and GWD executive/operational roles cannot cross-read via MCP, SQL, vector similarity, graph edges, logs, background jobs or temporary sharing.
- Short-lived audience-bound access token revocation and enforced one-use/limited-use receipts; no service-role bypass exposed to agents.
- Publish via PR + review, concurrent author conflict detection, dry-run, recovery from interrupted ingest and full export/restore.
- Benchmark existing GBrain vs candidate Cortex with same inputs: retrieval precision/recall, citation correctness, latency p95, storage/compute cost, unauthorized disclosures and operational maintenance.

## Rollout sequence
**Stage 0** reproducible isolated development/synthetic tenant with negative RLS tests and real health endpoints; no DNS on Signal host.  
**Stage 1** shadow, read-only pilot alongside GBrain with parallel evaluations.  
**Stage 2** reviewed per-tenant canary with explicit GO and rollback.  
**Stage 3** optional migration after gates pass; keep GBrain until durable read/write parity and restore evidence.

## Status / governance
The Atlas-Harness registry should list Cortex as **CANDIDATE — EVALUATION**, not LIVE/REPLACES-GBRAIN. No Supabase provisioning, Cortex deploy, DNS, secrets or service termination is authorized by this ADR. The current AtlasBot Desktop↔GWD connection and Signal/TURN control plane must remain untouched.
