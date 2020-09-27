#!/usr/local/bin/python3

#  a2x
#  Ascii to Hex
#
#  Created on 2020-09-23.
#


import sys

input_text = str().join(sys.argv[1:])
if not sys.stdin.isatty():
  input_text = sys.stdin.read() + input_text

b = bytes.hex(input_text.encode())
print(b, end='')
