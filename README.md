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
  `balena_os/linux-firmware-arm` fleets. It also updates the version in
  `balena.yml` based on the tag date.

## Usage

This block is primarily used by balenaOS build systems.
