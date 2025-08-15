#!/usr/bin/env bash
set -euo pipefail
TARGET="${1:-10.10.10.10}"
echo "[*] ICMP flood (short burst)"
sudo hping3 --icmp -i u10000 -c 2000 $TARGET || true
echo "[*] TCP SYN scan (first 200 ports)"
sudo hping3 -S -p ++1 -c 200 $TARGET || true
echo "[*] Slow HTTP HEAD"
for i in $(seq 1 10); do
  echo -ne "HEAD / HTTP/1.0\r\n\r\n" | nc -w1 $TARGET 80 || true
done
echo "[*] Done."
