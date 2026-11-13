# Atlas source provenance & licence matrix — V0.1, preliminary

**Purpose:** inventory of declared GitHub repository metadata and original upstream; NOT a completed third-party licence audit or permission to redistribute. Check the actual LICENSE, NOTICE and package/subdirectory licences and the specific commit before releases.

| Atlas repository | Upstream identity / original | Metadata / public status | Release decision |
| --- | --- | --- | --- |
| `Atlas-Harness` | Atlas-authored architecture | Original-materials LICENSE added | Rights reserved only in owned Atlas contributions |
| `Atlas-Bot-Desktop` | fork via `sergiomonteiro-atlas/Atlas-Bot-Desktop` of `nightly-labs/openbot` | **Imported public source fork**, upstream **PolyForm Noncommercial 1.0.0** | **NO commercial or Atlas public installer until appropriate rights**; new Git repo does not alter rights |
| `Atlas-Agent` | fork `NousResearch/hermes-agent` | Repo metadata MIT | Preserve notices; verify bundled dependencies |
| `Atlas-Memory-Fabric` | fork `garrytan/gbrain` | Repo metadata MIT | Audit integrated packages and tenant security |
| `Atlas-Operational-Knowledge` | Atlas-authored | Original-materials LICENSE added | Separate open-release decision |
| `Atlas-Workforce` | fork `msitarzewski/agency-agents` | Repo metadata MIT | Preserve original author attribution |
| `Atlas-WorkSwarms` | fork `ruvnet/ruflo` | Repo metadata MIT | Lab only; check subprojects/transitives |
| `Atlas-Crm-OS` | fork `melgarafael/DeskcommCRM` | Repo metadata MIT | BU product; dependency and data privacy review |
| `AtlasHub.Si` | Atlas original institutional docs | Original-materials LICENSE added | Rights reserved as applicable |
| `Projeto-Genesis` | Atlas-original Genesis documents | Original-materials LICENSE added | Rights reserved as applicable |
| `atlas-si-website` | Website owned by Z.AI / GLM 5.3 | Independent web workstream | GPT changes reversed via PR #3 |

## Release preflight

1. Confirm each exact upstream commit, licence at that commit and mandatory notice.
2. Review external image, logo, font, icon, video, text, template and data rights separately.
3. Identify network services, telemetry, keys and assets provided by an upstream that require independent replacement.
4. Establish build signing, downloadable checksums, repeatable CI and integrity checks.
5. Confirm whether derivative work will be internal, open/community, paid enterprise, or SaaS; assess each right explicitly.
6. Confirm contract/licensing with rights holders for any commercial derivative that needs it.
7. Store legal evidence and signed agreements in controlled private storage, not public repository.

**No umbrella MIT declaration.** Some repos are forks with MIT metadata; their dependency graph and other assets may differ. The Atlas-original Harness/Knowledge repositories do not automatically acquire the upstream forks' licence.

## Current platform plan

- **Public V0.1:** architecture and early access only.
- **Private lab:** must still pass usage-rights review for work performed as part of a commercial enterprise.
- **Open/community edition:** only independently authored or suitably licensed modules.
- **Commercial edition:** appropriate upstream commercial rights or independent code.

Relevant origin: [nightly-labs/openbot](https://github.com/nightly-labs/openbot), [OpenBot commercial licensing](https://openbot.run/commercial-license), [CopilotKit/OpenBot](https://github.com/CopilotKit/OpenBot).

## Atlas legal references

Atlas Global Tech Ltd (UK 17401190); ATLASHUB DIGITAL LTD (UK 17379237). Legal: legal@Atlas-SI.com; support: support@AtlasHub.SI. Atlas curator: https://github.com/sergiomonteiro-atlas. The companies' listing does not transfer upstream copyright.
