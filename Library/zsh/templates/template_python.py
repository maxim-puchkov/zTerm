___SHEBANG___
# -*- coding: utf-8 -*-

#  ___FILENAME___
#  ___PACKAGE_NAME___
#
#  Created by ___USERNAME___ on ___DATE_FULL___.
#  Copyright © ___DATE_YEAR___ ___OWNER___. All rights reserved.

from Cryptodome.Util.number import getPrime, isPrime, inverse
import random
import subprocess
import sys


# Cyclic Group
def cyclic_group(order):
    return set( [i
        for i in range(1, order)] )


# Cyclic Group Generators
#   element - value of an element in the group
#   order   - order of the cyclic group
def cyclic_group_generator(element, order):
    Zp = cyclic_group(order)
    generator = set( [pow(element, i, order)
        for i in range(0, (order-2)+1)] )
    
    if (Zp != generator):
        print('Element', element, 'is not a generator of', Zp)
        print('|Zp| =', len(Zp))
        print('|<generator>| =', len(generator))
    if (not isPrime(len(generator))):
        print('|<generator>| - not prime order')
    
    return generator


def inv(number, group_base):
    return inverse(number, group_base)


def invv(number, group_base):
    i = inverse(number, group_base)
    print('Multiplicative inverse of', number, 'mod', group_base, ':')
    print(i)
    return i






# Print script input
def print_args():
    print(argv[0] + ':\n\t' +
        'argc = ' + str(argc) + '\n\t'
        'argv = ' + str(argv) + '\n')
# Exit if missing arguments
def require_args(n):
    if (argc < n):
        print('Arguments given: ' + str(argc) + '\n'
              '       required: ' + str(n))
        print('Exiting...')
        exit(2)



def main():
    #print_args()
    #require_args(1)
    cg = cyclic_group_generator(5, 3)
    print(cg)

if (__name__ == '__main__'):
    print('Running ___FILENAME___.py')
    print('-----\n')
    global argc; argc = len(sys.argv) - 1
    global argv; argv = sys.argv
    main()
