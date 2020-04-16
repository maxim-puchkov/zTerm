#!/usr/bin/env python3


# RSA key generation
import sys
from cryp.util.euclid import extended_euclid


# Primes P and Q
p = 115298249408953906298939189175783351549219173898770205207152008519638746932703
q = 106934579549662309243376191428977731334267873165644052245494135513086209528559
# Exponent E
e = 65537
#
#p = 278498508427883
#q = 255807140504837
#e = 14106887

# Optionally choose different values of P, Q, and E
argc = len(sys.argv)
if (argc == 4):
    p = int(sys.argv[1])
    q = int(sys.argv[2])
    e = int(sys.argv[3])


# Compute product of P and Q
n = (p * q)
# Compute euler value
z = (p - 1) * (q - 1)
# Compute values of D and A
(r, d, _) = extended_euclid(e, z)
(_, _, a) = extended_euclid(z, e)
mod_inverse = (e * d) + (a * z)


# pk
def public_key():
    return (n, e)

# sk
def secret_key():
    return (n, d)


def keygen_printall():
    print('\033[35m===============  RSA KeyGen Algortihm  ===============\033[m')
    print('  PRIMES:    p =', p, '; q =', q)
    print('  EXPONENT:  e =', e)
    print('  MODULUS:   n =', n)
    print('  EULER\'S FUNCTION:  φ(n) = (p - 1)(q - 1) = z =', z)

    print('\n\n')
    print('\033[35m===========  Extended Euclidean Algortihm  ===========\033[m')
    print('  E-GCD          (r,_,_) = (',e, ',', z, ') =', r)
    print('  PRIVATE EXP    d =', d)
    print('  MULTIPLIER     a =', a)
    print('  MODULAR INVERSE  =>', mod_inverse)

    print('\n\n')
    print('\033[35m===================  RSA Key Pair  ===================\033[m')
    print('  PUBLIC KEY     (n, e) =', public_key())
    print('  SECRET KEY     (n, d) =', secret_key(), '\n')


# Print result of the function

#print('-- Computed value of a =', a)
#print('-- Computed value of d =', d, '\n')
# Inverse
#print('-- Inverse of e modulo n = (e * d) + (a * n) =', inverse, '\n')



# Print keys


#m = "Hello World!!!"

## Euler function
#def euler(p, q):
#    return (p - 1) * (q - 1)
