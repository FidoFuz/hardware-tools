#!/usr/bin/env bash
set -euo pipefail

echo "========================================"
echo "PCIe Slots"
echo "========================================"

dmidecode -t slot 2>/dev/null | awk '
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

    printf "%-35s %-10s %s\n", designation, usage, bus
}'