# Cloud IDS Lab – Results
## Environment
- OpenStack: <version/region>
- Sensor: Ubuntu <ver>, Snort <ver>, iface: <ens3>
- Attacker: Ubuntu <ver>, tools: hping3, nmap
## Attacks Executed
- ICMP flood via hping3 (2,000 packets)
- TCP SYN scan across common ports
- Slow HTTP HEAD requests to port 80
## Snort Alerts (sample)
<paste tail of /var/log/snort/fast.log here>
## Summary (parser output)
<paste output of parser/parse_fastlog.py here>
## Takeaways
- Snort detected abnormal ICMP and TCP SYN patterns.
- Rule tuning reduces noise; baseline normal traffic first.
- Continuous monitoring is key in cloud setups.
