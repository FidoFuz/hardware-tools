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
    type=""
    width=""

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

        if (line ~ /Type:/) {
            sub(/.*Type:[ \t]*/, "", line)
            type=line
        }

        if (line ~ /Data Bus Width:/) {
            sub(/.*Data Bus Width:[ \t]*/, "", line)
            width=line
        }
    }

    printf "%s\n", designation
    printf "  Status : %s\n", usage
    printf "  Type   : %s\n", type
    printf "  Width  : %s\n", width

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