#!/usr/bin/env bash
set -euo pipefail

echo "========================================"
echo "Host"
echo "========================================"
hostnamectl 2>/dev/null || hostname

echo
echo "========================================"
echo "PCIe Slots"
echo "========================================"
dmidecode -t slot

echo
echo "========================================"
echo "PCI Devices"
echo "========================================"
lspci -Dnn

echo
echo "========================================"
echo "PCI Tree"
echo "========================================"
lspci -tv

echo
echo "========================================"
echo "NVMe"
echo "========================================"
nvme list || true

echo
echo "========================================"
echo "Storage"
echo "========================================"
lsblk -o NAME,SIZE,TYPE,MODEL,SERIAL

echo
echo "========================================"
echo "Network"
echo "========================================"
lspci -nn | grep -Ei 'ethernet|network'

echo
echo "========================================"
echo "GPU"
echo "========================================"
lspci -nn | grep -Ei 'vga|3d|display'