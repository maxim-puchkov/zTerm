#!/usr/bin/env python3

import sys

if len(sys.argv) != 2:
    print("Usage: print-ff.py N")
    sys.exit(1)

try:
    n = int(sys.argv[1])
except ValueError:
    print("N must be an integer")
    sys.exit(1)

output = b'\xff' * n
sys.stdout.buffer.write(output)
