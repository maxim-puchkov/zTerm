#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Cyclic Groups


from Cryptodome.Util.number import getPrime, isPrime
import random


def getZ(P):
    return set( [i
        for i in range(1, P)] )


# g - value of generator    g = 3
# p - prime of group Z_p    (i.e., mod p)
# q - ord(g), |<g>|         q = 7
def cg(E, P):
    Z_p = set( [i for i in range(1, P)] )
    g = set( [pow(E, i, P) for i in range(0, (P-2)+1)] )
#    print('Z_p = ', Z_p)
#    print('<g> = ', g)
    print('\n\n')
    a=isPrime(1)
    print('Z_p == g?', Z_p == g)
    print('|(Z_p)*| =', len(Z_p))
    print('|<g>| =', len(g))
    return (g, Z_p == g, (isPrime(len(g)),  len(g)))






def rand_groups(g, p):
    a = random.randint(1, p)
    b = random.randint(1, p)
    groups(g, p, a, b)

def groups(g, p, a = 22, b = 4):
    ga = pow(g, a, p)
    gb = pow(g, b, p)
    gab = pow(ga, b, p)
    gba = pow(gb, a, p)
    k = pow(g, a*b, p) # g^(ab)
    print('\n\n')
    print('a =', a, '; g^a =', ga, '; (g^a)^b =', gab)
    print('b =', b, '; g^b =', gb, '; (g^b)^a =', gba)
    print('k = g^(ab) =', k)



def sq(g, p, a = 22, b = 4):
    ga = pow(g, a, p)
    ga2 = pow(g, pow(a, 2), p)
    print('\n\n')
    print('a =', a, 'g^a =', ga, 'g^(a^2) =', ga2)

# x^e = c   -   x is e'th root of c
#def me(x, e, c):


g = 5  ; p = 53
a = 22 ; b = 4

ga = pow(g, a, p) ; gab = pow(pow(g,a), b, p)
gb = pow(g, b, p) ; gba = pow(pow(g,b), a, p)

ga2 = pow(g, pow(a, 2), p)

GAB = pow(g, a*b, p) # kAB = g^ab



def od(E, P):
    g = set( [pow(E, i, P) for i in range(0, (P-2)+1)] )
    return len(g)

import pcr.maths

def inv(i, p):
    return pcr.maths.mult_inv(i, p)

# Multiply with mod
def ml(x, y):
    prod = (x * y) % p
    print(x, '*', y, '=', prod, '\t mod', p)
    print(x*y, '=', prod % p, '\t in Z_',p )
    print('\n\n')
    return prod

# Modular e'th roots of C in Z_p are
def mr(c, e = 2, p = 11):
    roots = set()
    for x in range(1, p):
        xe = pow(x, e, p)
        if xe == c:
            roots.add(x)
    return roots

# Legendre symbol of x over p
def ls(x, p = 11):
    (n, _) = divmod(p-1, 2)
    return pow(x, n, p)


def qr(g = 5, p = 53):
    legendre = ls(g, p)
    return (legendre == 1)
    
    
#            print(x, '^2 =', xe)




#    g_b = 1 / pow(g, b, p)
#    g_2b = 1 / pow(g, 2*b, p)
#    ga_2b = pow(g, a, p) * 1 / pow(g, 2*b, p)
#    ga2 = pow(g, 2*a, p)

#    print('g^(-b) =', g_b, '; g^(-2b) =', g_2b)
#    print('g^(a-2b) =', ga_2b, '; g^2a =', ga2)
#
