# Phase 01 — Alignment, infrastructure qualification and first verifiable integration

**Status:** underway. **This plan contains no authority to provision resources or spend funds.**

## 01A. Direction & communication

- [x] Verify real GitHub repository names and fork origins.
- [x] Initialize public Atlas-Harness README and ADR.
- [x] Publish team directive, repository map and roles.
- [ ] Register reviews / acknowledgements by Infrastructure, Engineering, Memory, Security and BU pilot owner.
- [ ] Resolve critical licensing / production independence question for Atlas-Bot.

**Exit:** all role owners recorded, disputes and limitations visible in issues. Publishing a directive is not equivalent to receipt by people.

## 01B. Infrastructure and funding readiness

- [ ] Identify AWS account owner, Activate/Incubator affiliation, Org ID availability (do not publish), billing currency, current credit approval/balance/expiry.
- [ ] Budget, alert thresholds, AWS IAM/SSO/MFA, region and expected traffic defined.
- [ ] Produce AWS staging inventory, sizing hypothesis, network diagram, IaC plan, backup/restore and disaster recovery design.
- [ ] Assess cloud credits and LLM API credits separately; confirm which services are covered.
- [ ] Obtain operational GO prior to spending, provisioning, DNS or live secrets.

**Exit:** approved cost estimate + architecture, accountable account owner, and rollback plan. Never treat an incubator association as proof of received credits.

## 01C. Core integration contracts and implementation

- [ ] Define task envelope, event outbox, approval state machine and audit schema.
- [ ] Atlas-Bot API mission adapter with centralized scoped policy.
- [ ] Atlas-Agent restricted service profile/adapter and authenticated events.
- [ ] Atlas-Memory-Fabric governed read-only retrieval API.
- [ ] Atlas-Operational-Knowledge draft/review/publish lifecycle for a **fictional** BU03 product.
- [ ] Workforce mapping for one director, one specialist executor and one independent QA reviewer.

**Exit:** automated contract validation, no default broad allow rule, CI and basic security tests.

## 01D. First vertical slice

1. Director in Atlas-Bot requests a bounded analysis of an approved fictional product FAQ.
2. Task passes RBAC/ABAC, budget and permission decisions and enters a durable queue.
3. Atlas-Agent performs a read-only run, retrieves a versioned document using a scoped credential, and returns citation-backed evidence.
4. An independent reviewer validates output quality and tool evidence.
5. Atlas-Bot displays duration, events, cost and result; retries do not duplicate task side effects.

**Exit:** reproducible build/test evidence, failure/retry recovery, scope-denial proof, read-only integration, and demo transcript without real credentials or customers.

## Phase 02 — out of current GO

Live WhatsApp, CRM mutations, multi-BU automation, RUFLO swarms, desktop, paid production deployments, customer billing and expanded workforce. New explicit security approvals are prerequisites.
