#!/usr/bin/env python3
"""Display file in binary.

Syntax: <cmdname> filename"""

from functools import partial
import argparse

parser = argparse.ArgumentParser(description='Display file in binary.')
parser.add_argument('fname', type=str, help='Name of the file.')
parser.add_argument('-r', '--row-length', type=int, default=6, help='Number of columns in a row.')
parser.add_argument('-p', '--print-bit-pos', type=bool, default=False, action=argparse.BooleanOptionalAction, help='Print bit positions after each row.')
args = parser.parse_args()
# exit(0)


def pad_binary(binary):
    return binary[2:].zfill(8)

def print_bitpos(n_printed):
    if args.print_bit_pos:
        if args.row_length == 0:
            startpos = 1
            endpos = n_printed*8
        else:
            currRow = n_printed//args.row_length
            startpos = (currRow-1) * (8*args.row_length) + 1
            endpos = startpos + (8*args.row_length) - 1
        print(f"\t({startpos}..{endpos})", end="")
        # print(f"curr row={currRow}, sp={startpos}")


n_printed = 0
try:
    with open(args.fname, "rb") as fp:
        for bit in iter(partial(fp.read, 1), b''):
            binary = pad_binary(bin(ord(bit)))
            n_printed += 1
            if args.row_length > 0:
                print(binary, end=" ")
                if n_printed % args.row_length == 0:
                    print_bitpos(n_printed)
                    print("")
            else:
                print(binary, end="")
        if (args.row_length == 0) or (n_printed % args.row_length != 0):
            print_bitpos(n_printed)
            print("")
except:
    pass
