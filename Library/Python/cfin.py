#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#  myscript
#  
#
#  Created by Maxim Puchkov on 2020-04-21.
#  Copyright © 2020 Maxim Puchkov. All rights reserved.

from Cryptodome.Util.number import getPrime, isPrime, inverse
import random
import subprocess
import sys

MOD_BASE = 13

global argc
global argv


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



#print('MOD_BASE =', MOD_BASE)

# MUL
def mmul(x, y, m = 0):
    if (m == 0):
        m = MOD_BASE
    return (x * y) % m

def mmulv(x, y, m = 0):
    result = mmul(x, y, m)
    print('>  ', x, '*', y, '=', result, '  mod', m)
    return result

# ADD
def madd(x, y, m = 0):
    if (m == 0):
        m = MOD_BASE
    return (x + y) % m
    
def maddv(x, y, m = 0):
    result = madd(x, y, m)
    print('>  ', x, '+', y, '=', result, '  mod', m)
    return result

# POW
def mpow(x, y, m = 0):
    if (m == 0):
        m = MOD_BASE
    return pow(x, y, m)

def mpowv(x, y, m = 0):
    result = mpow(x, y, m)
    print('>  ', x, '^', y, '=', result, '  mod', m)
    return result

# INV
def minv(number, m = 0):
    if (m == 0):
        m = MOD_BASE
    return inverse(number, m)

def minvv(number, m = 0):
    i = inverse(number, m)
    print('Multiplicative inverse of', number, 'mod', m, ':')
    return i


#re=exit(0)
def re():
    exit(0)

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

def main(c, v):
    #print_args()
    #require_args(1)
    
    print_args()
    cg = cyclic_group_generator(5, 3)
    print(cg)

if (__name__ == '__main__'):
    print('Running myscript.py')
    print('-----\n')
    main(len(sys.argv) - 1, sys.argv)
