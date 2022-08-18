#!/usr/bin/env python3
"""Display file in binary.

Syntax: <cmdname> filename"""

from functools import partial
import argparse

parser = argparse.ArgumentParser(description='Display file in binary.')
parser.add_argument('fname', type=str, help='Name of the file.')
parser.add_argument('-r', '--row-length', type=int, default=6, help='Number of columns in a row.')
parser.add_argument('-b', '--bit-pos', type=bool, default=False, action=argparse.BooleanOptionalAction, help='Print bit positions after each row.')

args = parser.parse_args()

# exit(0)


def pad_binary(binary):
    return binary[2:].zfill(8)

file_binary = []
with open(args.fname, "rb") as fp:
    for bit in iter(partial(fp.read, 1), b''):
        binary = pad_binary(bin(ord(bit)))
        file_binary.append(binary)




def print_binary(file_binary, row_length):
    if row_length > 0:
        n_printed = 0
        def print_bitpos():
            if args.bit_pos:
                currRow = n_printed//row_length
                begin = currRow * 8 - 8
                end = begin + (row_length * 8) - 1
                print(f"\t({begin}..{end})", end="")

        for b in file_binary:
            print(f"{b} ", end="")
            n_printed += 1
            if n_printed % row_length == 0:
                print_bitpos()
                print("")
        if n_printed % row_length != 0:
            print_bitpos()
        print("")
    else:
        for b in file_binary:
            print(b, end="")
        print("")

print_binary(file_binary, row_length=args.row_length)
