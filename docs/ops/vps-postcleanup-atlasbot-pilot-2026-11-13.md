# AtlasHub VPS — Post-cleanup gate and AtlasBot remote pilot V0.1
**Owner:** OpenBot Local (remote test) with Helena (VPS operations).  
**Date:** 13 November 2026.  
**Change scope:** **one** isolated evaluation container, only after P0 verification.  
**Tracking:** [VPS issue #13](https://github.com/AtlasHub-Si/Atlas-Harness/issues/13), [launch issue #14](https://github.com/AtlasHub-Si/Atlas-Harness/issues/14).

## Current information (Helena report, NOT independently verified on SSH)
- Disk: 309 GB total, 239 GB used (~78%), ~70 GB free (~22%).
- Helena reported 79 -> 71 running containers after cleanup; no reconciled immutable list of removed IDs.
- **Inconsistent figures:** 54 -> 70 GB free is ~16 GB, not 26 GB, for the last cleanup stage. Build-cache figures are not additive without remeasurement.
- Missing: CPU, RAM, swap, OOM history, health of removed GWD knowledge dependencies, actual remaining OpenBot systemd services.
- Removed per report: `atlas-pilot-bot`, older `pixbrasil-api`/`pixbrasil-redis`, selected ClubOS UIV and LevelAB containers, and `gwd-gbrain`, `gwd-ops-core`, `gwd-knowledge-gateway`. **Treat this last group as a regression risk, not proof of redundancy.**
- Retained: Hermes legacy **Helena, Diana, Elisa, Maia**; new `Atlas-Agent`/Hermes config and model providers; GWD Cockpit, both LearnHouse/ClubOS tracks, ARO, CRM, streaming/media pipeline, identity, storage and proxy.

## GATE 0 — Read-only health and capacity (must pass before Docker changes)

Run locally on the VPS as an authorized operator; sanitize information before placing evidence into a public GitHub issue.

```bash
date -Is
df -h /
free -h
swapon --show
docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'
docker stats --no-stream
docker system df
systemctl is-active openbot.service || true
systemctl list-units --all --type=service | grep -Ei 'openbot|atlasbot|hermes' || true
docker ps -a --format '{{.ID}} {{.Names}} {{.Image}} {{.Status}}' | grep -Ei 'atlasbot|openbot|hermes|gwd' || true
journalctl -k --since '24 hours ago' --no-pager | grep -Ei 'out of memory|oom-kill|killed process' | tail -n 40 || true
```

**NO-GO** if RAM or swap pressure/active OOM remains high, service mapping is inconsistent, or protected workflows fail. Do not run any further `prune`/cleanup, and do not restart Docker or modify global daemon configuration.

Helena verifies in the actual applications: (1) Telegram/Discord for each of Helena, Diana, Elisa, Maia where configured; (2) GWD Cockpit login/read-only status; (3) ClubOS/AtlasClub and GWD LearnHouse login plus playback of one existing authorized test media asset; (4) ARO/CRM read-only health; (5) GWD knowledge workflow to detect possible breakage caused by removal of `gwd-gbrain`, `gwd-ops-core` or `gwd-knowledge-gateway`. Verify the new Hermes `Atlas-Agent` and model selection without disclosing secrets.

## GATE 1 — Resolve duplicate servers BEFORE creating one

The Windows app may show two entries that point to the same actual host. Determine which processes really exist:
- `openbot.service` from the upstream `install-server.sh` may run **outside Docker**.
- A Docker `openbot`/Atlas pilot might use a different persistent volume.
- `bot.atlas-si.com` currently serves a web application; the OpenBot remote host **is not an HTTP site**.

Inspect exact process, location and data-volume mapping; identify which server entries are visible from Windows. If a healthy, isolated correct family instance already exists, **reuse that installation**, rather than creating duplicates. Do not uninstall shared packages, erase identities or touch DNS/Caddy.

## GATE 2 — Prepare a genuinely isolated remote test host

The template lives in [`deploy/atlasbot-pilot/compose.yaml`](../../deploy/atlasbot-pilot/compose.yaml) and [`.env.example`](../../deploy/atlasbot-pilot/.env.example). It is deliberately a technical evaluation of the **original `nightly-labs/openbot` image**. No Atlas-branded/custom image has been built. Its source is PolyForm Noncommercial; verify evaluation rights before use by a commercial entity and obtain appropriate rights for any commercial deployment.

**Version pinned at authoring:** `v0.70.0` (release published 13 Nov 2026). First verify it is available on GHCR and compatible with the Windows client; no auto-update to `latest`.

```bash
# After GATE 0 and 1 pass, as a VPS operator:
sudo mkdir -p /srv/atlas-bot-desktop
# Place compose.yaml and .env.example from the GitHub Harness repository there.
cd /srv/atlas-bot-desktop
cp .env.example .env
chmod 600 .env

# Fetch matching sandbox profile for the pinned source release.
curl --fail --silent --show-error --location \
  https://raw.githubusercontent.com/nightly-labs/openbot/v0.70.0/docker/seccomp.json \
  --output seccomp.json

# Validate before changes, then start ONLY this Compose project.
docker compose -p atlasbot-pilot config --quiet
docker compose -p atlasbot-pilot pull
docker compose -p atlasbot-pilot up -d
docker compose -p atlasbot-pilot ps
docker compose -p atlasbot-pilot exec atlasbot openbot status
```

**First ensure the source files have not been replaced by unknown revisions.** Confirm using the repository and tag before executing. If the image is unavailable, stop rather than silently swapping in `latest`. The Compose sample limits the container to 2 CPUs / 4 GB memory and reserves 1 GB shared memory; **lower or postpone based on actual host headroom**. It has persistent `/data`, no host network, no published ports, no root host-directory mounts, no Docker socket and log rotation. The named bridge network is *not* a hard private-address firewall: **verify outbound network restrictions**, especially access to the host and Helena services, before connecting any tools that can access sensitive systems.

If the operator needs stronger containment, use a dedicated VM or a separate host; agents in the upstream software run with broad permissions **within** their container.

## GATE 3 — Login and functional proof

```bash
cd /srv/atlas-bot-desktop
docker compose -p atlasbot-pilot exec atlasbot openbot login
docker compose -p atlasbot-pilot exec atlasbot openbot status
docker compose -p atlasbot-pilot logs --tail 80 --no-color atlasbot
```

Log in interactively with the same account as the Windows OpenBot app. Never paste the OTP, tokens, credentials or the full diagnostic logs into GitHub. The account service and Signal/TURN can remain the existing upstream test services **only if permitted by their terms and appropriate for the evaluation**; an independent Atlas Account API is not deployed by this template.

From Windows:
1. Find exactly **one** canonical Atlas VPS server (record server ID/label, not secrets).
2. Create two disposable agents using non-sensitive data; ensure message and task delegation; check browser/network restrictions.
3. Restart **only** the atlasbot-pilot container, then verify persistent conversations and agents.
4. Confirm the four protected legacy Hermes agents and other standby apps still function.

### Hermes ACP is a SEPARATE integration gate

The upstream container invokes a Hermes installation through local `hermes acp` and uses **its own** home directory. It does not automatically see the configured **host** Atlas-Agent Hermes. Do NOT mount `~/.hermes` from Helena or the new Atlas-Agent, and do NOT copy production provider credentials into the evaluation container.

Options for a later approved task: (a) install and configure isolated Hermes in this container with its own least-privilege provider credentials; (b) create a separately authenticated, bounded ACP adapter to the new runtime. Validate provider rights, credential boundary, message exchange and audit before calling Hermes integration complete.

## Rollback (only if created by this runbook)

```bash
cd /srv/atlas-bot-desktop
docker compose -p atlasbot-pilot down
# Named data volume stays intact. Do not use --volumes or global prune.
```

## Acceptance evidence

- Helena's protected perimeter read-only checks PASS; four agent channels operable; media playback confirmed; GWD knowledge regression resolved or explicitly documented.
- CPU/RAM/swap/disk measured after cleanup, no active pressure/OOM.
- `openbot.service` and existing UI-created server checked to avoid duplicate instances.
- Exactly one remote host appears in Windows, with ephemeral agent delegation, persistence after restart and no sensitive tool exposure.
- Exact image tag/digest, data volume, egress rules, rollback and before/after resource usage recorded.
- Hermes ACP reported separately as **not tested / passed / failed** with evidence.

**No installer or commercial distribution is authorized by this internal technical runbook. No Caddy or DNS changes.**
