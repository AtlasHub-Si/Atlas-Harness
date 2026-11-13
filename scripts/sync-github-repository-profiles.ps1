#requires -Version 5.1
<#
.SYNOPSIS
  AtlasHub-Si GitHub repository Description/Homepage profile sync.
.DESCRIPTION
  Default is DRY RUN. Requires authenticated gh CLI with organization repository
  administration permission. Excludes atlas-si-website, owned by Z.AI/GLM 5.3.
  Does not alter visibility, fork relationships, code, topics, branches, or licenses.
.EXAMPLE
  ./sync-github-repository-profiles.ps1
.EXAMPLE
  ./sync-github-repository-profiles.ps1 -Apply
#>
[CmdletBinding()]
param([switch]$Apply)
$ErrorActionPreference = 'Stop'

$org = 'AtlasHub-Si'
$profiles = @(
  @{ Name = 'AtlasHub.Si'; Description = 'AtlasHub.SI | Corporate ecosystem, Genesis community, AI-native business architecture.'; Homepage = 'https://atlashub.si' }
  @{ Name = 'Projeto-Genesis'; Description = 'Genesis | AtlasHub and GWD organizational model, governance, learning and AI-native business units.'; Homepage = 'https://club.atlashub.si' }
  @{ Name = 'Atlas-Harness'; Description = 'Atlas Harness | Governed AI-native enterprise architecture, multi-agent workforce, memory and operations.'; Homepage = 'https://atlas-si.com' }
  @{ Name = 'Atlas-Bot-Desktop'; Description = 'AtlasBot Desktop | Multi-agent workspace integration; derived from nightly-labs/OpenBot under its original license.'; Homepage = 'https://atlas-si.com' }
  @{ Name = 'Atlas-Agent'; Description = 'Atlas-Agent | Hermes agent integration via ACP; upstream NousResearch attribution preserved.'; Homepage = 'https://atlas-si.com' }
  @{ Name = 'Atlas-Memory-Fabric'; Description = 'Atlas Memory Fabric | GBrain-derived memory, provenance and governed retrieval research.'; Homepage = 'https://atlas-si.com' }
  @{ Name = 'Atlas-Operational-Knowledge'; Description = 'Atlas Operational Knowledge | Approved Markdown playbooks and Obsidian-compatible authoring.'; Homepage = 'https://atlas-si.com' }
  @{ Name = 'Atlas-Workforce'; Description = 'Atlas Workforce | Agent identities, roles and skills based on agency-agents.'; Homepage = 'https://atlas-si.com' }
  @{ Name = 'Atlas-WorkSwarms'; Description = 'Atlas WorkSwarms | Experimental agent swarms and orchestration, based on Ruflo.'; Homepage = 'https://atlas-si.com' }
  @{ Name = 'Atlas-Crm-OS'; Description = 'Atlas CRM-OS | DeskcommCRM-derived conversational CRM and sales operating system research.'; Homepage = 'https://atlas-si.com' }
)

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  throw 'GitHub CLI (gh) is required. Install and authenticate gh before applying.'
}
& gh auth status
if ($LASTEXITCODE -ne 0) { throw 'GitHub CLI authentication failed.' }

foreach ($p in $profiles) {
  $repo = "$org/$($p.Name)"
  Write-Host ('{0}: {1}' -f $(if ($Apply) { 'APPLY' } else { 'DRY-RUN' }), $repo)
  Write-Host ("  Description: " + $p.Description)
  Write-Host ("  Homepage:    " + $p.Homepage)
  if ($Apply) {
    & gh repo edit $repo --description $p.Description --homepage $p.Homepage
    if ($LASTEXITCODE -ne 0) { throw "Failed to update $repo. Stopping." }
  }
}
Write-Host 'Completed. No source files, licenses, branches, visibility or website have been modified.'
