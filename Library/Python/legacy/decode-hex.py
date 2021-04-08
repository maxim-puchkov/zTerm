#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#  encode
#  Python
#
#  Created by Maxim Puchkov on 2020-05-06.
#  Copyright © 2020 Maxim Puchkov. All rights reserved.


import sys
import codecs

argc = len(sys.argv)
if not (argc == 2):
    exit(2)

arg = sys.argv[1]
if not (len(arg) % 2 == 0):
    exit(1)

b = codecs.decode(sys.argv[1], 'hex')
print(b.decode('unicode_escape'))
