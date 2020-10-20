#!/usr/bin/env python3

import sys

#if ( len(sys.argv) < 3 ):
#    print( 'save_key [output file] [the bytes to write]' )
#    print( '~ save_key file.txt ABCDEF' )
#    exit()

def save_key(filepath, hexstring):
    _bytes = bytes.fromhex( hexstring )
    f = open( filepath, 'wb' )
    f.write( _bytes )
    f.close()
    return f
