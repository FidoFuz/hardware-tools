# Hardware Tools

Portable Docker container for hardware diagnostics and management on Linux and Unraid servers.

## Goals

- Build once, run anywhere.
- Version controlled with Git.
- Support Jupiter, Neptune, Saturn and future servers.
- Provide a consistent toolbox regardless of the host OS.

## Included tools

- bash
- curl
- dmidecode
- ethtool
- ipmitool
- jq
- lshw
- nvme-cli
- pciutils
- smartmontools
- usbutils

## Planned additions

- Dell RACADM
- Redfish helper scripts
- Inventory scripts
- Health check scripts
- GPU information scripts
- Storage inventory scripts

## Usage

Build:

```bash
docker compose build
```

Run:

```bash
docker compose up -d
```

Shell:

```bash
docker exec -it hardware-tools bash
```