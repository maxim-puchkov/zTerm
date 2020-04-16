#!/usr/bin/env python3


# Extended Euclidean Algorithm
def extended_euclid(x, y):
    old_r = x;  r = y
    old_a = 1;  a = 0
    old_b = 1;  b = 0
    while (r > 0):
        (q, _) = divmod(old_r, r)
        (old_r, r) = (r, old_r - q * r)
        (old_a, a) = (a, old_a - q * a)
        (old_b, b) = (b, old_b - q * b)
    old_a = old_a % y
    old_b = old_b % y
    return (old_r, old_a, old_b)

# Euclidean Algorithm (gcd)
def euclid(x, y):
    return extended_euclid(x, y)[0]
