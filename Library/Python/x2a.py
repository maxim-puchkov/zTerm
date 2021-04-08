#!/usr/local/bin/python3

#  x2a
#  Hex to Ascii
#
#  Created on 2020-09-23.
#


import sys

input_text = str().join(sys.argv[1:])
if not sys.stdin.isatty():
  input_text = sys.stdin.read() + input_text

b = bytes.fromhex(input_text)
print(repr(b)[2:-1], end='')
