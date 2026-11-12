# AWS staging, cloud funding and LLM credits — readiness plan

**Status:** research and planning only, **not deployed**. Information checked 2026-11-12; provider terms and program availability may change.

## Startup funding priority

The proposed first environment is AWS because the business reports an incubator relationship. **Do not assume any credit is active or transferable.**

| Program | Opportunity | Mandatory verification | Official source |
| --- | --- | --- | --- |
| AWS Activate | AWS cloud credits; some eligible Amazon Bedrock use can be offset. Portfolio tier may offer up to US$200k depending on affiliation and stage. | AWS account status; Activate profile; incubator Activate Provider Org ID; eligibility; actual award, expiration and excluded services | https://aws.amazon.com/startups/credits/ |
| Google for Startups Cloud | Credits on eligible Google Cloud services; AI startups may be eligible for higher tiers. | Company type, age, funding, actual account, billing ID and restrictions. Google notes **third-party models are billed directly and not covered** by program credits. | https://cloud.google.com/startup |
| Microsoft for Startups | Startup Azure credits and related model infrastructure through eligible Azure services. | Company eligibility, Microsoft startup account and benefit status; actual credits and restrictions | https://learn.microsoft.com/pt-br/startups/benefits/azure-for-startups |
| OpenAI for Startups | API credits possible through participating VC partners. | Participating VC referral and OpenAI organization; not automatic for all startups | https://openai.com/startups |

Do not present maximum advertised credit amounts as Atlas approved funding. Record `program`, `owner`, `application_status`, `account_reference_private`, `approved_value`, `currency`, `expiry`, `eligible_services`, `evidence_date` in a **private** funding register; public repository stores only status without account identifiers.

## AWS architecture hypothesis

One new AWS EC2 staging node is sufficient to begin a controlled bounded test. **Initial hypothesis**, not sizing approval: 4 vCPU, 16 GiB RAM, ~80 GiB encrypted storage; Ubuntu LTS, Docker Compose, Postgres, Caddy/TLS, private Redis if required, S3 backups, monitoring. Reassess after benchmarking the actual OpenBot/Intelligence and Hermes profiles. Cloud-native IAM, security group, network, VPC and snapshots may be required; they also incur costs.

Do **not** install all forks as production services together on day 1. OpenBot has a separately licensed Intelligence dependency and may require more capacity than the initial node. Ruflo, CRM and multiple browser-computer containers are excluded from Phase 01 runtime.

### Required governance before provisioning

1. Use separate project AWS account or designated isolated account boundary; enable MFA/SSO and least privilege. Avoid static root access.
2. Agree region, budget, on-demand/on-stop strategy, log and data retention, DNS/subdomain ownership.
3. AWS Budgets + cost anomaly detection + alerts at agreed thresholds; billing alerts are **not** automatic hard spending caps.
4. Apply restrictive network rules: only ingress TLS exposed, SSH behind SSM/VPN/bastion if needed, internal databases not publicly reachable.
5. Define encryption, backup location, restore test, patching and secret storage (e.g. AWS Secrets Manager / SSM Parameter Store).
6. Confirm commercial license requirements for OpenBot and whether a constrained evaluation runtime is appropriate.
7. Secure formal infrastructure GO before creating chargeable services.

### Infra lead deliverables

- AWS account program eligibility and current credit status **reported without disclosing IDs or secret provider codes publicly**.
- Approved monthly burn cap, estimated baseline EC2/storage/egress/monitoring/LLM costs and alarm owner.
- Staging VPC/security groups/IAM/backup/rollback runbook and least-privilege deployment role.
- Evidence of a test backup restoration, audited secrets access, smoke tests and budget alerts.
- A plan to keep **current AtlasHub VPS / Helena services untouched**.

## Model API strategy

Define an Atlas Model Gateway with route policy (`model_capability`, `BU`, `privacy_class`, `budget_limit`, `provider`, `fallback`). Prefer funded providers when compatible, but benchmark latency, quality, support, regions, terms and data-processing guarantees. Credits for cloud compute do **not** universally cover external LLM APIs.

For the first read-only demo, restrict provider set to one low-cost model with a per-run hard budget, and log model ID, tokens, cost estimate and outcome.

## Application document pack (private submission)

One-page product profile, active project website, product ownership/founder/organization eligibility, concise architecture diagram, technical differentiation, roadmap, startup/accelerator affiliation, funding stage, cost projection, expected APIs/Bedrock or Azure/Google AI usage, business contact and any required IDs. Store company identifiers and application responses privately.

## Information to request from account owner (later phase)

- Is the AWS account already linked to the incubator's Activate Provider? Is an eligible Org ID available?
- Are credits **approved**, **pending** or merely **available for application**?
- What is the actual balance and expiration date?
- What region and monthly spending cap should be approved?

No account-number, billing email, org ID, API key or token should be pasted into public GitHub issues.
