#!/usr/local/bin/python3

#  New File
#
#
#  Created on 2020-09-23
#


import sys


if len(sys.argv) == 1:
  print('No input')
  exit(1)


for arg in sys.argv[1:]:
  for char in arg:
    print(ord(char), end='')
  print('', end=' ')
print('')
