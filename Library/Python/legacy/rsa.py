#!/usr/bin/env python3
# -*- coding: utf-8 -*-




# RSA Encryption
import sys
import subprocess
import codecs
from _sha256 import sha256

PK_FILE = '/Users/admin/Developer/var/rsa.key'
PK_FILE_2 = '/Users/admin/Developer/var/rsa.key.dec'
CIPHERTEXT = '/Users/admin/Developer/var/ciphertext.enc'


_X = 1468369091346689468057626077110561
_Y = 0xa12c6555895811fcf162d368d60c22e3a094ef3ed5f072eb1952383ec84eae0418c96fef2110698a2bfd940e4a359f84f70195b64c7a37cca48a3fc6a27eb85d


def save_key(filepath, hexstring):
    _bytes = bytes.fromhex( hexstring )
    f = open( filepath, 'wb' )
    f.write( _bytes )
    f.close()
    return f

def breakline(length = 80):
    return '\033[35m' + ('-' * length) + '\033[m' + '\n\n'


# Extended Euclidean Algorithm
def egcd(a, b):
    x, y = 0, 1
    u, v = 1, 0
    while (a != 0):
        q, r = b//a, b%a
        m, n = x-u*q, y-v*q
        b,a, x,y, u,v = a,r, u,v, m,n
    gcd = b
    return gcd, x, y

# Euler function
def euler(x, y):
    return (x - 1) * (y - 1)


#MARK: - RSA Key Generation
def keygen(keydata):
    (p, q, e) = keydata
    print('\n' + 'Key Data')
    print('p =', p)
    print('q =', q)
    print('e =', e)
    # Separator line
    l = len('p = ' + str(p))
    print(breakline())
    # Compute modulus
    n = (p * q)
    print('N=,', n)
    # Compute Euler value
    z = euler(p, q)
    print('EULER=', z)
    # Compute values of D and A
    (_, d, a) = egcd(e, z)
    print('D=', d)
    mod_inverse = (e * d) + (a * z)
    # Generate and print keys
    public_key = (n, e)
    secret_key = (n, d)
    print('RSA Public/Secret Key Pair')
    print('pk =', public_key)
    print('sk =', secret_key)
    print(breakline())
    return (public_key, secret_key)

def keygen_assignment():
    p = 115298249408953906298939189175783351549219173898770205207152008519638746932703
    q = 106934579549662309243376191428977731334267873165644052245494135513086209528559
    e = 65537
    keydata = (p, q, e)
    return keygen(keydata)

def keygen_quiz():
    p = 278498508427883
    q = 255807140504837
    e = 14106887
    keydata = (p, q, e)
    return keygen(keydata)




#MARK: - AES-256 (CBC) Cipher with RSA
def encrypt(public_key,
            message='Hello World!!!',
            x = _X):
    (n, e) = public_key
    # Compute Y
    y = pow(x, e, n)
    # Compute K: the image of X under RSA TDP
    k = sha256(str(x).encode()).hexdigest()
    save_key(PK_FILE, k)
    # Encrypt the message
    output = subprocess.check_output(['rsa_encrypt.py.subprocess', message, PK_FILE])
    c = hex(int(output.decode(), base = 16))
    return (y, c)


def decrypt(secret_key,
            y = _Y):
    (n, d) = secret_key
    x = pow(y, d, n)
    k = sha256(str(x).encode()).hexdigest()
    save_key(PK_FILE_2, k)
    output = subprocess.check_output(['rsa_decrypt.py.subprocess', '', PK_FILE])
    m = codecs.decode(output, 'hex_codec').decode()
    return m



def test():
    (pk, sk) = keygen_assignment()
    m = 'Cryptography is fun! :)'
    (y, c) = encrypt(pk, m)
    dec_m = decrypt(sk, y)
    assert(m == dec_m)
