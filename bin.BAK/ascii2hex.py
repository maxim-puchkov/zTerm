#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#  ascii2hex
#  P-Functions
#
#  Created by Maxim Puchkov on 2020-04-16.
#  Copyright © 2020 Maxim Puchkov. All rights reserved.


import sys

# Convert ASCII strings to hexadecimal strings.
#   'Hello, World!'    ->    '48656c6c6f2c20576f726c6421'
argc = len(sys.argv)
if (argc < 2):
    exit(1)

ascii = sys.argv[1]
hex_string = bytes.hex(ascii.encode())
for i in range(2, argc):
    ascii = sys.argv[i]
    hex_string += bytes.hex(b' ' + ascii.encode())

print(hex_string)
exit(0)
