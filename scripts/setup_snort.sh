#!/usr/bin/env bash
set -euo pipefail
IFACE=${IFACE:-ens3}
RULES_DIR=/etc/snort/rules
CONF=/etc/snort/snort.conf
sudo mkdir -p $RULES_DIR
sudo cp snort/local.rules $RULES_DIR/local.rules
sudo cp snort/snort.conf $CONF
sudo nohup snort -i $IFACE -A fast -c $CONF >/tmp/snort.out 2>&1 &
echo "Snort started. Logs -> /var/log/snort/fast.log"
