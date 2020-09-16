#!/usr/bin/env python3


# RSA Encryption
import subprocess
import codecs
#from rsa_keygen import *
from cryp.util.save_key import save_key
from _sha256 import sha256
from Cryptodome.Cipher import AES
from cryp.util.euclid import extended_euclid

PK_FILE = '/Users/admin/Developer/var/rsa.key'
PK_FILE_2 = '/Users/admin/Developer/var/rsa.key.dec'
CIPHERTEXT = '/Users/admin/Developer/var/ciphertext.enc'

def encrypt():
    # Public key (N, E)
    (n, e) = public_key()
    x = 1468369091346689468057626077110561
    # Compute Y
    y = (pow(x, e) % n)
    y = hex(y)
    # Compute K: the image of X under RSA TDP
    k = sha256(str(x).encode()).hexdigest()
    message='Hello World!!!'
    save_key(PK_FILE, k)
    # Encrypt the message
    output = subprocess.check_output(['rsa_encrypt.py.subprocess', message, PK_FILE])
    c = hex(int(output.decode(), base = 16))
    return (y, c)

#
#print('\n\n')
#print('ENCRYPT')
#print(encrypt())

#def encrypt_Q():
#    # Public key (N, E)
#    (n, e) = (57279432182124301775578541821, 16619159)
#    x = 983102832781777267923396
#    # Compute Y
#    y = pow(x, e, n)
#    y = hex(y)
#    # Compute K: the image of X under RSA TDP
#    k = sha256(str(x).encode()).hexdigest()
#    message='The quick brown fox jumps over the lazy dog.'
#    save_key(PK_FILE, k)
#    # Encrypt the message
#    output = subprocess.check_output(['rsa_encrypt.py.subprocess', message, PK_FILE])
#    c = hex(int(output.decode(), base = 16))
#    return (y, c)

#print(encrypt_Q())

#http://wawa
def decrypt():
    (n, d) = secret_key()
    y = 0xa12c6555895811fcf162d368d60c22e3a094ef3ed5f072eb1952383ec84eae0418c96fef2110698a2bfd940e4a359f84f70195b64c7a37cca48a3fc6a27eb85d
    x = pow(y, d, n)
    k = sha256(str(x).encode()).hexdigest()
    print(x, k)
    save_key(PK_FILE_2, k)
    output = subprocess.check_output(['rsa_decrypt.py.subprocess', '', PK_FILE])
    OUT_MESSAGE=codecs.decode(output, 'hex_codec').decode()
    return OUT_MESSAGE
    
#def decrypt():
#    (n, d) = secret_key()
##    y = 0xa12c6555895811fcf162d368d60c22e3a094ef3ed5f072eb1952383ec84eae0418c96fef2110698a2bfd940e4a359f84f70195b64c7a37cca48a3fc6a27eb85d
#    y = (b'\xa1,eU\x89X\x11\xfc\xf1b\xd3h\xd6\x0c"\xe3\xa0\x94\xef>\xd5\xf0r\xeb\x19R8>\xc8N\xae\x04\x18\xc9o\xef!\x10i\x8a+\xfd\x94\x0eJ5\x9f\x84\xf7\x01\x95\xb6Lz7\xcc\xa4\x8a?\xc6\xa2~\xb8]').hex()
#
#
#    z = (p-1)*(q-1)
#    (_, e, _) = extended_euclid(d, z)
#    print(e)
#    print(y)
##    x = pow(int(y, base=16), e)
##    res = extended_euclid(d, y)
##    x = pow(y, ret)
##    file_c = open(CIPHERTEXT, 'r')
##    c = file_c.read()
##    output = subprocess.check_output(['rsa_decrypt.py.subprocess', CIPHERTEXT, SK_FILE])
#
##    x = (pow(y, e * d) % n)
#    return y
##    k = sha256()
#
#


#print('\n\n')
#print('DECRYPT')
#print(decrypt())


#def decrypt_Q():
#    (n, d) = (66530478113202998952352077397, 1056198455521220575186639411)
#    y = 0xCEA6D93586A0C87F7E96F9DB
#    c = 0xD9CC05E26300219FED6AC31BBCC56DF30BFD694C86C6848BA875FB00F606A20EDD7109C75FD6A0CF27874938E108EE0B
#    x = pow(y, d, n)
#    k = sha256(str(x).encode()).hexdigest()
#    print(x, k)
#    save_key(PK_FILE_2, k)
#    output = subprocess.check_output(['rsa_decrypt.py.subprocess', '', PK_FILE])
#    OUT_MESSAGE=codecs.decode(output, 'hex_codec').decode()
#    return OUT_MESSAGE
#    
#    
#print(decrypt_Q())
#
#
#(n, d) = (66530478113202998952352077397, 1056198455521220575186639411)
#y = 0xCEA6D93586A0C87F7E96F9DB
#c = 0xD9CC05E26300219FED6AC31BBCC56DF30BFD694C86C6848BA875FB00F606A20EDD7109C75FD6A0CF27874938E108EE0B
