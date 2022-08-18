#!/usr/bin/env python3
"""Delete all null bytes from file.

Syntax: <cmdname> filename"""


from functools import partial
import argparse

parser = argparse.ArgumentParser(description='Delete all null bytes from file.')
parser.add_argument('fname', type=str, help='Name of the file.')

args = parser.parse_args()
# exit(0)

outfile = open("/tmp/delete-null-bytes.out", "wb")

with open(args.fname, "rb") as fp:
    for bit in iter(partial(fp.read, 1), b''):
        if bit != b'\x00':
            outfile.write(bit)

outfile.close()

print(f"File created: {outfile.name}")
