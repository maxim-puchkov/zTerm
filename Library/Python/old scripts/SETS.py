#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import math

def printPowerSet(set):
    # set_size of power set of a set
    # with set_size n is (2**n -1)
    set_size = len(set)
    pow_set_size = (int) (math.pow(2, set_size));
    counter = 0;
    j = 0;
    pow_set = []
    # Run from counter 000..0 to 111..1
    for counter in range(0, pow_set_size):
        for j in range(0, set_size):
            # Check if jth bit in the
            # counter is set If set then
            # print jth element from set
            if((counter & (1 << j)) > 0):
                print(set[j], end = "")
                pow_set.append(set[j])
        print("");
    return pow_set


#ps = [1, 2, 3]
#pps = printPowerSet(ps)

def P(S):
    P = list()
    s_size = len(S)
    p_size = pow(2, s_size)
    for i in range(0, p_size):
        subset = list()
        for j in range(0, s_size):
            if ((i & (1 << j)) > 0):
                subset.append(S[j])
#        print(i, j, S[j], subset)
        P.append(subset)
    return P

def powerset(S):
    p = P(S)
    print('set S =       ', S)
    print('power set P = ', p)
    print('|S| =', len(S), '|P| =', len(p))
    return p
#            print(S.pop())
#            print('OK')
#        print('-----')

def listToSet(l):
    if (type(l) != type([])):
        return l
    s = set()
    for i in range(0, len(l)):
        element = listToSet(l[i])
        s.add(element)
    return s

def searchP(P, e):
    count = 0
    for i in range(0, len(P)):
        s1 = set(P[i])
        s2 = set({e})
        print(s1, '==', s2, '\t', s1==s2)
        if (s1 == s2):
            count += 1
    return count


a = P([[],[1],[2],[1,2]])


#2
from itertools import combinations, chain


_empty_powerset = ((), )

def P2(someset):
    try:
        # duck typing
        someset.isdisjoint
    except AttributeError:
        raise TypeError(
            f"{powerset.__name__} accepts only a set-like object as parameter"
        ) from None
    
    size = len(someset)
    combs = (combinations(someset, k) for k in range(1, size+1))
    
    return chain(_empty_powerset, *combs)

# Example:
#print(tuple(powerset({1, 2, 3})))
# ((), (1,), (2,), (3,), (1, 2), (1, 3), (2, 3), (1, 2, 3))
