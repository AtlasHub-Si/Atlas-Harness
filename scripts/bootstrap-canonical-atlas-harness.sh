#!/usr/bin/env bash
# ATLAS-HARNESS V0.1: canonical source-only checkout.
# Default --plan (read-only). --apply only creates missing directories and clones.
set -Eeuo pipefail
mode="--plan"
if [[ "$#" -gt 0 ]]; then mode="$1"; fi
if [[ "$mode" != "--plan" && "$mode" != "--apply" ]]; then echo "Usage: $0 [--plan|--apply]" >&2; exit 2; fi
root="/srv/atlas-harness"
repos="$root/repos"
owner="AtlasHub-Si"
command -v git >/dev/null || { echo "Missing git" >&2; exit 1; }
specs=(
  "Atlas-Harness:main"
  "Atlas-Agent:main"
  "Atlas-Memory-Fabric:master"
  "Atlas-Operational-Knowledge:main"
  "Atlas-Workforce:main"
  "Atlas-WorkSwarms:main"
)
# Atlas-Bot-Desktop excluded: GPTWORK currently owns repository hygiene.
# NO modifications to /opt/atlas-pilot/src, /root/.hermes, /srv/gwd,
# /srv/atlas-bot-desktop, systemd, Docker, secrets, DNS or Caddy.
if [[ "$mode" == "--apply" ]]; then
  mkdir -p "$repos" "$root/deploy" "$root/data" "$root/ops/inventory" "$root/ops/health" "$root/ops/runbooks"
fi
records=()
printf '%-29s %-8s %-12s %s\n' "REPOSITORY" "BRANCH" "STATUS" "COMMIT / NEXT"
for spec in "${specs[@]}"; do
  IFS=: read -r name branch <<< "$spec"
  url="https://github.com/$owner/$name.git"
  dir="$repos/$name"
  if [[ -e "$dir" || -L "$dir" ]]; then
    if ! git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      echo "CONFLICT: $dir exists but is not a git checkout; do not overwrite" >&2
      exit 1
    fi
    actual="$(git -C "$dir" remote get-url origin 2>/dev/null || true)"
    if [[ "$actual" != "$url" && "$actual" != "git@github.com:$owner/$name.git" ]]; then
      echo "CONFLICT: $dir has unexpected origin; do not overwrite" >&2
      exit 1
    fi
    sha="$(git -C "$dir" rev-parse --short=12 HEAD)"
    printf '%-29s %-8s %-12s %s\n' "$name" "$branch" "EXISTS" "$sha (unchanged)"
    records+=("$name,$branch,$sha,existing")
  elif [[ "$mode" == "--apply" ]]; then
    git clone --single-branch --branch "$branch" --depth 1 --filter=blob:none "$url" "$dir"
    sha="$(git -C "$dir" rev-parse --short=12 HEAD)"
    printf '%-29s %-8s %-12s %s\n' "$name" "$branch" "CLONED" "$sha"
    records+=("$name,$branch,$sha,cloned")
  else
    printf '%-29s %-8s %-12s %s\n' "$name" "$branch" "MISSING" "$url"
  fi
done
if [[ "$mode" == "--apply" ]]; then
  manifest="$root/ops/inventory/CANONICAL-SOURCES.csv"
  { printf 'name,branch,commit,action\n'; printf '%s\n' "${records[@]}"; } > "$manifest"
  chmod 644 "$manifest"
  echo "Inventory saved: $manifest"
  echo "Only missing code checkouts and target folders were created."
fi
