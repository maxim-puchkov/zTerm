#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Signature
import random

msgs = [ i for i in range(1, 101) ]


def m(i):
    return msgs[i - 1]
    

#X = 'XXXX-xxxx'
X = 1
m = m(98)
def KEY():
    val = random.randint(0,1)
    if val == 0:
        return -1
    else:
        return 1

#def F2(x = X, i = m):
#    if (i == 0):
#        return x
#    return F(x + '-' + str(i), i - 1)



def F(m=m):
    val = 0
    for i in range(0, m):
        val = val + i
    return val


def F3(i = m, res=0):
    print(i)
    if (i == 0):
        return res
#    print(-x, i-1)
    return F(i-1, (res+i))

def sign(x = X, i = m):
    o = F(101-i)
#    signature = (i, y)
    return (i,o)

def ver(y = 1, i=m, o = (1,1)): #o = (m, 'XXXX-xxxx-3-2-1')):
    (oi, oo) = o
    return (y-F(i),y-oo)
#    return (F(i, ),y)
    #F(
    #return (oi,F(oi)),(oo)#(F(X, oi), oy)

#for i in range(1,53):
#    for j in range(1,53):
#        R=pow(g,pow(inv(j,53),i),p)
#        g,i,j,R
#        print('g^j)^i')
#        if (R == 49):
#            print('-------!!!!!')
x = KEY()
y = F(101)
print("SECRET KEY = ", x)
print("P KEY = ", y, "\n\n")

(sk, pk) = (x,y)
o = sign(sk, m)
ver(pk, m, o) #, o)



#m = msgs[99]
