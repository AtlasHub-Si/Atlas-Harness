# Atlas source provenance & licence matrix — V0.1, preliminary

**Purpose:** inventory of declared GitHub repository metadata and original upstream; NOT a completed third-party licence audit or permission to redistribute. Check the actual LICENSE, NOTICE and package/subdirectory licences and the specific commit before releases.

| Atlas repository | Upstream identity / original | Metadata / public status | Release decision |
| --- | --- | --- | --- |
| `Atlas-Harness` | Atlas-authored architecture | No top-level LICENSE observed | Publication of docs allowed by owner; decide licence for Atlas-original code separately |
| `Atlas-Bot-Desktop` | planned independent copy via `sergiomonteiro-atlas/Atlas-Bot-Desktop` of `nightly-labs/openbot` | **Empty as at 13 November 2026**, publicly visible; upstream **PolyForm Noncommercial 1.0.0** | **NO commercial or Atlas public installer until appropriate rights**; new Git repo does not alter rights |
| `Atlas-Bot` | fork `CopilotKit/OpenBot` (unrelated to nightly-labs) | Repo metadata MIT, verify Intelligence/service-specific terms | Research only; separate rights assessment |
| `Atlas-Agent` | fork `NousResearch/hermes-agent` | Repo metadata MIT | Preserve notices; verify bundled dependencies |
| `Atlas-Memory-Fabric` | fork `garrytan/gbrain` | Repo metadata MIT | Audit integrated packages and tenant security |
| `Atlas-Operational-Knowledge` | Atlas-authored | No top-level LICENSE observed | Separate open-release decision |
| `Atlas-Workforce` | fork `msitarzewski/agency-agents` | Repo metadata MIT | Preserve original author attribution |
| `Atlas-WorkSwarms` | fork `ruvnet/ruflo` | Repo metadata MIT | Lab only; check subprojects/transitives |
| `Atlas-Crm-OS` | fork `melgarafael/DeskcommCRM` | Repo metadata MIT | BU product; dependency and data privacy review |
| `atlas-si-website` | Atlas website with inherited OpenBot reference site material under evaluation | No top-level LICENSE observed | V0.1 homepage has new original design; unused legacy source/media still require provenance cleanup |

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
