# AtlasHub VPS — Lab readiness, inventory and safe onboarding

**Purpose:** A read-only checklist, not authorization for any destructive action. Keep operational identifiers, IP addresses, usernames, keys and private detailed inventory outside this public repository.

## First inspection

An authorized operator should gather the current timestamp, OS, kernel, uptime, CPU, free RAM and swap, disk space/inodes, Docker build cache, container status, restart/OOM events, Compose projects, volumes, networks, port listeners, Caddy ownership, scheduled jobs and health checks. Identify each service and its dependencies.

Sanitized report template:

| Category | Value / evidence | Decision |
| --- | --- | --- |
| Host CPU/RAM/swap/disk | Current anonymized resource metrics | Capacity |
| Container count and restart loops | Summary only, avoid leaking internal services | Cleanup candidates |
| Caddy and network edge | Public TLS ingress conflict review | Dedicated internal reverse proxy |
| Helena/Hermes | Profiles, Souls, jobs, skills, runtime data with private backup | Preserve |
| AtlasClub / LearnHouse | DB, media and configuration with verified restore | Isolate/preserve |
| CRM | DB, migrations, tokens and integrations | Isolate/preserve |
| ARO | Webhooks, entitlements, state and possible real effects | Isolate/preserve |
| Other experiments | Owner, dependencies, state and rollback | Selective stop/archive |

## Read-only host commands

Execute only with host-owner authorization. Do not paste full raw output into public GitHub Issues.

~~~bash
date -Is
uptime
free -h
df -h
df -i
swapon --show
docker system df
docker compose ls
docker ps --format 'table {{.Names}}	{{.Status}}	{{.Ports}}'
docker network ls
docker volume ls
~~~

Additional inspection for Docker OOM, mounts, bind paths, backup status, SSH/service configuration and Caddy must remain in private operational records.

## Safe shutdown procedure — design only

1. Establish the data owner and mark PRESERVE, ISOLATE, STOP_AFTER_BACKUP, ARCHIVE or UNKNOWN.
2. Verify a recoverable backup and restore path and record what happens to webhook endpoints and public routes.
3. Produce an exact list of service names to stop and a matching rollback list.
4. Obtain explicit execution GO from the owner of that subsystem.
5. Stop only those named services, observe regressions and measure reclaimed resources.
6. Never run a blanket container/volume wipe or delete persistent database/CRM/ARO/LearnHouse volumes before verified recovery.

## LAB acceptance

- Same version-pinned Atlas-Harness core can initialize in LAB and on a clean alternate VM.
- Organization creation is configuration-driven; demonstrate two fictional tenants.
- Atlas-Bot, Atlas-Agent, Memory Fabric, Operational Knowledge and Workforce complete read-only test tasks.
- Approval, denial, audit, knowledge version, resource budgets, error handling and restore are demonstrated.
- No external paid transactions, customer messaging or publishing are enabled.
- AtlasClub, adapted CRM, ARO and Helena/Hermes artifacts remain recoverable and isolated.

## Cloud decision

AWS is preferred as the clean GWD reference environment **if Activate credits, eligibility and forecast cost are verified**. AtlasHub LAB is the short path to test product onboarding. The actual decision follows the measured capacity and funding gates, not assumptions.
