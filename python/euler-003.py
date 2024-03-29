'''
Problem 3: Largest prime factor
The prime factors of 13195 are 5, 7, 13 and 29.
What is the largest prime factor of the number 600851475143 ?
https://projecteuler.net/problem=3
'''

# we want to obtain prime factorization for the following numbers:
numbers = (13195, 600851475143, 12345678901234)
#numbers = (13195, 600851475143, 12345678901234, 1234567890123456789)

def prime_factorization(num):
    '''
    This function returns all prime factors of a given number
       expects: positive integer
       returns: array of positive integers
    Implementation: Trial division (https://en.wikipedia.org/wiki/Trial_division)
    '''

    # The number (that needs to be prime factorized) is going to be reduced by division of each found prime factor
    remaining = num

    results = []

    # Special case when prime factor = 2 (Reduce number space 50%)
    while ( remaining % 2 == 0 ):
        results.append(2)
        remaining /= 2

    # primetest is the number, by which we are testing division (potential prime factor)
    # From 3, increment by 2 (test only for odd numbers, skip even numbers)
    primetest = 3

    # Check our number, to be prime factorized (becoming smaller by each found prime factor),
    #   against each potential number, that could be a prime factor (becoming bigger)
    while ( primetest ^ 2 <= remaining ):
        if ( remaining % primetest == 0 ):
            # Division fits - it must be a prime factor
            results.append(primetest)
            # New number (to be prime factorized) := old number divided by prime factor
            remaining /= primetest
        else:
            # Division did not fit (not a prime factor), try next number
            primetest += 2

    if ( remaining != 1 ):
        # Every remaining number (except 1) must be a prime factor (the last)
        results.append(primetest)

    return results

def print_results(num):
    '''
    This function calculates and prints the results in a formatted way
       expects: number (integer)
    '''

    results = prime_factorization(num)

    print('Highest prime factor for {:15d}: {:15d}'.format( num, max(results) ) )
    print('List of prime factors for {:14d}: {}'.format( num, results ) )


# Actually invoking the stuff here (main entry point)
[ print_results(n) for n in numbers ]
