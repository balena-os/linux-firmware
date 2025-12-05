# Linux Firmware

This repository contains the Linux Firmware package for balenaOS. It is deployed
as a
[Balena Block](https://docs.balena.io/learn/develop/blocks/#develop-with-blocks).

## Description

This block provides the necessary firmware files for hardware support on
balenaOS devices. It is intended for host OS system level use.

> [!NOTE] While the `balena` branch contains workflows and deploy infra, the
> `main` branch is a mirror of the upstream
> [linux-firmware](https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git)
> repo and is force-synced regularly. Local changes to `main` will not persist.

## Maintenance

This repository includes automated workflows for maintenance and deployment:

- **Repo Sync**: A daily cron job (`repo-sync.yml`) synchronizes the `main`
  branch and tags from the upstream repository.
- **Deploy**: Triggered by new tags or manually (`deploy.yml`). It builds and
  deploys the firmware to the `balena_os/linux-firmware-x86` and
  `balena_os/linux-firmware-arm` fleets.

### Release Lifecycle

| Trigger | Release Created | Finalized |
|---------|-----------------|-----------|
| **Pull Request** to `balena` branch | ✅ Yes | ❌ No (draft) |
| **Manual dispatch** (default) | ✅ Yes | ❌ No (draft) |
| **Manual dispatch** with `finalize: true` | ✅ Yes | ✅ Yes |
| **Repo Sync** completes (new upstream tags) | ✅ Yes | ✅ Yes |

#### Revisions

When manually triggering the deploy workflow, the `allow-revisions` input
(default: `true`) controls behavior when a finalized release already exists for
the specified firmware tag:

- **`allow-revisions: true`** — A new release (revision) is pushed regardless of
  existing releases.
- **`allow-revisions: false`** — No new release is created if a matching
  finalized release already exists.

> [!IMPORTANT]
> Merging changes to the `balena` branch does **not** automatically create a new
> release. Releases are only created when triggered by the deploy workflow—either
> manually or after the repo sync workflow detects new upstream tags.

## Usage

This block is primarily used by balenaOS build systems.
