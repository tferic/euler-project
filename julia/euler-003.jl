#=
Problem 3: Largest prime factor
The prime factors of 13195 are 5, 7, 13 and 29.
What is the largest prime factor of the number 600851475143 ?
https://projecteuler.net/problem=3
=#

using Printf

# we want to obtain prime factorization for the following numbers:
numbers = (13195, 600851475143, 12345678901234, 1234567890123456789)

function prime_factorization(num)
    #=
    This function returns all prime factors of a given number
       expects: positive integer
       returns: array of positive integers
    Implementation: Trial division (https://en.wikipedia.org/wiki/Trial_division)
    =#

    # The number (that needs to be prime factorized) is going to be reduced by division of each found prime factor
    remaining = num

    results = []

    # Exception case for prime factor 2 (after this, we can skip all even numbers)
    while remaining % 2 == 0
        push!(results, 2)
        remaining /= BigInt(2)
    end

    # primetest is the number, by which we are testing division (potential prime factor)
    # From 3, increment by 2 (test only for odd numbers, skip even numbers)
    primetest = 3

    # Check our number, to be prime factorized (becoming smaller by each found prime factor),
    #   against each potential number, that could be a prime factor (becoming bigger)
    while primetest ^ 2 <= remaining
        if remaining % primetest == 0
            # Division fits - it must be a prime factor
            push!(results, primetest)
            # New number (to be prime factorized) := old number divided by prime factor
            remaining /= BigInt(primetest)
        else
            # Division did not fit (not a prime factor), try next number
            primetest += 2
        end
    end

    if remaining != 1
        # Every remaining number (except 1) must be a prime factor (the last one)
        push!(results, BigInt(remaining))
    end
    return results
end

function print_results(num)
    #=
    This function calculates and prints the results in a formatted way
       expects: number (integer)
    =#
    results = prime_factorization(num)

    @printf("Highest prime factor for %20d: %20d\n", num, maximum(results) )
    @printf("List of prime factors for %19d: %20s\n", num, results )
end

# Actually invoking the stuff here (main)
map(print_results, numbers)
