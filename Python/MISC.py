#!/usr/bin/env python3
# -*- coding: utf-8 -*-


from Cryptodome.Util.number import getPrime, isPrime
import random

class CyclicGroup:
    def __init__(self, order):
        self.order = order
        self.z = set( [i for i in range(1, order)] )

    def gen(self, element):
        self.g = set( [pow(element, i, self.order)
            for i in range(0, (self.order - 2) + 1)] )

    def show(self):
        print('Z_p == g?', self.z == self.g)
        print('|(Z_p)*| =', len(self.z))
        print('|<g>| =', len(self.g))
