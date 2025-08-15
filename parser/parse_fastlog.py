#!/usr/bin/env python3
import sys, re, collections
def summarize(path):
    counts = collections.Counter()
    for line in open(path, 'r', errors='ignore'):
        parts = line.split('[**]')
        if len(parts) >= 3:
            msg = parts[2].strip()
            counts[msg] += 1
    return counts
if __name__ == '__main__':
    path = sys.argv[1] if len(sys.argv) > 1 else '/var/log/snort/fast.log'
    c = summarize(path)
    if not c:
        print('No alerts parsed.')
        sys.exit(0)
    print('=== Snort Alert Summary ===')
    for msg, n in c.most_common():
        print(f'{msg}: {n}')
