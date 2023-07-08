#!/usr/bin/env python3.9
"""Toggle the bit at the specified offset.

Syntax: <cmdname> filename [bit-pos]"""

import os
import random
import argparse

parser = argparse.ArgumentParser(description='Flip bits in file.')
parser.add_argument('fname', type=str, help='Name of the file')
parser.add_argument('-b', '--bitpos', type=int, help='Bit position')
parser.add_argument('-c', '--count', type=int, default=1, help='Total number of flips')
parser.add_argument('-g', '--group', type=int, default=1, help='Number of bits in group (default: 1)')
parser.add_argument('-v', '--verbose', type=bool, default=False, action=argparse.BooleanOptionalAction, help='Verbose output')
args = parser.parse_args()

# exit(0)


def flip_bit(fp, bitpos):
    # Convert bit offset to bytes + leftover bits
    nbytes, nbits = divmod(bitpos, 8)
    fp.seek(nbytes, 0)
    c = fp.read(1)
    # print(f"bitpos={bitpos}, nbytes={nbytes}, nbits={nbits}")
    # Toggle bit at byte position `nbits`
    toggled = bytes( [ ord(c)^(1<<nbits) ] )
    # Back up one byte, write out the modified byte
    fp.seek(-1, 1)  # or absolute: fp.seek(nbytes, 0)
    fp.write(toggled)


def get_bitpos(fsize):
    return random.randint(0, fsize*8 - 1)


count = args.count
group = args.group

fname = args.fname
fsize = os.path.getsize(fname)

# Open file in read+write, binary mode
fp = open(fname, "r+b")

flipped_bits = []
for i in range(0, count):
    bitpos = args.bitpos or get_bitpos(fsize)
    for j in range(0, group):
        try:
            flip_bit(fp, bitpos+j)
            flipped_bits.append(bitpos+j)
        except:
            print(f"Failed to write bit {bitpos}")
            break

# Close file
fp.close()


print(f"Flipped {len(flipped_bits)} bits")
if args.verbose:
    print(sorted(flipped_bits))

exit(0)
