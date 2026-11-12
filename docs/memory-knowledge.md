# Atlas Memory Fabric and Operational Knowledge v0.1

## The five data domains

| Domain | Canonical source | Readers | Writer authority | Examples |
| --- | --- | --- | --- | --- |
| Executive & strategic | Board-approved decision ledger / corporate systems | Council, authorized executives | Council-appointed roles | Strategy, goals, decisions, risk |
| Internal corporate & HR | HR/legal/finance systems with stricter isolation | Role-authorized employees/agents | Respective process owner | Private personnel cases, contracts |
| Operational knowledge | Approved and versioned Markdown knowledge published via Atlas-Operational-Knowledge | Relevant BU roles and agents | Knowledge editorial workflow | FAQ, sales scripts, product playbooks |
| Operational transaction & customer history | CRM, ERP, ARO and other application databases | Scoped service APIs and authorized agents | Authoritative application API | Leads, messages, prices, orders |
| Agent working / episodic memory | Atlas-Agent session and job state | Session-appropriate agent and reviewers | Scoped runtime | Checkpoints, tool outputs, progress |

**One search interface does not mean one physical store or global write authority.** Retrieval requires tenant, BU, role, purpose, classification and document publication state. Source metadata must survive summarization.

## Knowledge publication pipeline

`draft -> review_requested -> approved -> published -> deprecated|revoked`.

Documents must include `document_id`, `tenant_id`, `business_unit_id`, `department_id`, `document_type`, `classification`, `version`, `status`, `owner_role`, `approved_by`, `effective_at`, `review_due_at`, `source_url` where relevant. No agent can independently promote its newly discovered answer to approved product knowledge.

Retrieve approved docs by stable IDs and return citation ID and version alongside generated responses. A product's **live prices** must resolve from authorized commercial API, not copy-pasted Markdown as real-time truth.

## Customer-service example (fictional)

A BU03 sales attendant receives a WhatsApp request. The approved Atlas-Agent run loads an allowed role profile and approved script, asks the CRM for the actual customer record and product catalog service for current price, replies within policy and writes the conversation through the CRM channel adapter. The Control Plane logs customer-visible actions. New objection-handling insight is submitted for human review before becoming a new approved script.

Initial pilot: no live WhatsApp or personal customer data.

## Technical responsibilities

- Obsidian: optional human knowledge editor; the server uses Markdown and APIs, no Obsidian client dependency.
- Atlas-Operational-Knowledge: git versioning and publishing workflows for **approved knowledge artifacts**, not sensitive raw conversations.
- GBrain fork: candidate indexing, relation/provenance and retrieval behind Atlas auth adapter. Verify multi-tenant capabilities and permission enforcement before production.
- PostgreSQL: authoritative task/event and business transactional stores.
- Atlas-Agent: only transient authorized working memory and job checkpoints; may promote proposals, not facts by itself.

## Mandatory tests

1. Deny a BU01 agent any retrieval of BU03 private material; no cross-tenant leaks in embeddings, summaries or cache.
2. Reject an unapproved or expired sales script.
3. Revoke published knowledge and show it is no longer retrievable after index invalidation.
4. Preserve source, hash/version and approval identity in evidence.
5. Ensure confidential HR and customer records never reach public code or LLM tools without explicit scoped authorization and appropriate data controls.

See [ADR-0001](adr/0001-atlas-harness-architecture.md) and [Atlas-Operational-Knowledge](https://github.com/sergiomonteiro-atlas/Atlas-Operational-Knowledge).
