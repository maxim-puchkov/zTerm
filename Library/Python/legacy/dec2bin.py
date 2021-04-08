#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#  dec2bin.py
#  
#
#  Created by Maxim Puchkov on 2020-04-22.
#  Copyright © 2020 Maxim Puchkov. All rights reserved.


import sys

argc = len(sys.argv)
if (argc < 2):
    exit(1)


base_10 = int(sys.argv[1])
base_2  = int(bin(base_10), 2)


print(base_2)
