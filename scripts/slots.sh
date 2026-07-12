#!/usr/bin/env bash
set -euo pipefail

echo "========================================"
echo "PCIe Slots"
echo "========================================"

dmidecode -t slot | awk '
BEGIN { RS=""; FS="\n" }
/System Slot Information/ {
    designation=""
    usage=""
    bus=""
    for (i=1;i<=NF;i++) {
        if ($i ~ /Designation:/) gsub(/.*Designation:[ \t]*/,"",$i), designation=$i
        if ($i ~ /Current Usage:/) gsub(/.*Current Usage:[ \t]*/,"",$i), usage=$i
        if ($i ~ /Bus Address:/) gsub(/.*Bus Address:[ \t]*/,"",$i), bus=$i

    }

    printf "%-35s %-10s %s\n", designation, usage, bus
}'