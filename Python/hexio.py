#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#  hexio
#  P-Functions
#
#  Created by Maxim Puchkov on 2020-04-10.
#  Copyright © 2020 Maxim Puchkov. All rights reserved.


import sys
import codecs


# Write (append) bytes represented
# as a hexstring to a file.
#   Input:              [0x]1234567890ABCDEF
#   File (hexdump):     12 34 56 78 90 ab cd ef
def write_hex_as_bytes(filepath, hexstring):
    file = open(filepath, 'ab')
    buffer = bytes.fromhex(hexstring.lstrip('0').lstrip('xX'))
    file.close()
    return file.write(buffer)


def read_bytes(filepath):
    file = open(filepath, 'rb')
    buffer = file.read()
    file.close()
    return buffer

def read_bytes_as_text(filepath):
    file = open(filepath, 'rb')
    buffer = file.read()
    file.close()
    codecs.decode(buffer, 'hex_codec').decode('raw_unicode_escape')
    return buffer
    

#
#f_path = sys.argv[1]
#_bytes = bytes.fromhex( sys.argv[2] )
##value = int( sys.argv[3], base=16 )
#
#f = open( f_path, 'ab' )
#
##_bytes = int.to_bytes( value, 1, 'big' )
#f.write( _bytes )
#
#
#f.close()
#print( 'OK: hex \"', _bytes, '\" is written to file.' )
