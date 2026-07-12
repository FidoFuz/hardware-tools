#!/usr/bin/env bash
set -euo pipefail

tmp=$(mktemp)
lspci -Dnn | sed G > "$tmp"

echo "========================================"
echo "PCIe Slots"
echo "========================================"

dmidecode -t slot 2>/dev/null | awk -v pci="$tmp" '
BEGIN {
    RS=""
    FS="\n"
}

/System Slot Information/ {
    designation=""
    usage=""
    bus=""

    for (i = 1; i <= NF; i++) {
        line=$i

        if (line ~ /Designation:/) {
            sub(/.*Designation:[ \t]*/, "", line)
            designation=line
        }

        if (line ~ /Current Usage:/) {
            sub(/.*Current Usage:[ \t]*/, "", line)
            usage=line
        }

        if (line ~ /Bus Address:/) {
            sub(/.*Bus Address:[ \t]*/, "", line)
            bus=line
        }
    }

    printf "%s\n", designation
    printf "  Status : %s\n", usage

    if (bus != "") {
        printf "  Bus    : %s\n", bus

        while ((getline dev < pci) > 0) {
            if (index(dev, bus) == 1) {
                sub(/^[^ ]+ /, "", dev)
                printf "  Device : %s\n", dev
                break
            }
        }
        close(pci)
    }

    print ""
}
'

rm -f "$tmp"