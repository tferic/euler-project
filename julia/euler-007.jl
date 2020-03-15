#=
Problem 7: 10001st prime
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
What is the 10 001st prime number?
https://projecteuler.net/problem=7
=#

using Printf
using Primes

find_nth_prime = (6, 25, 10001, 1000000, 10000000, 100000000)

function get_lastprime_by_n(n::Integer)
    #= This function returns the last prime number for n primes
    =#

    max_prime_guess = guess_maxprime_by_n(n)
    primes = get_primelist_eratosthenes(max_prime_guess)

    last_prime = primes[end]
    count_prime = length(primes)

    if count_prime >= n
        # max_prime_guess was too big (most often)
        # return exactly the nth prime
        return primes[n]
    else
        # max_prime_guess was too small (should never happen)
        println("Warning: Entering slow prime searching. Starting at $count_prime")
        while count_prime < n
            last_prime = get_nextprime(last_prime)
            count_prime += 1
        end
    end
end

function guess_maxprime_by_n(n::Integer)
    #= This function returns a best guess on what the biggest prime number will be for n number of primes
       Function may not return a prime but an arbitrary number. But the effective maxprime is smaller.
       https://en.wikipedia.org/wiki/Prime_number_theorem#Approximations_for_the_nth_prime_number
    =#
    return Integer(round((log(n) + log(log(n))) * n) + 1)
end

function get_primelist_eratosthenes(upperlimit::Integer)
    #= This function returns a list of primes from 1:upperlimit
       Implementation: Sieve of Eratosthenes (using BitArray)
    =#

    if upperlimit < 2
        return
    elseif upperlimit == 2
        return [2]
    end

    sq_root = Integer(round(sqrt(upperlimit)))

    # Create BitArray from 1:max and initialize all as true (all are considered primes until we find they are not)
    primes_mask = BitArray(trues(upperlimit))
    primes_mask[1] = false    # 1 is not a prime
    primes_mask[2] = true     # 2 is a prime

    function remove_multiples(testprime)
        # This subfunction removes all multiples of a prime number from the BitArray
        multiple = 2
        noprime = testprime * multiple
        while noprime <= upperlimit
            primes_mask[noprime] = false
            multiple += 1
            noprime = testprime * multiple
        end
    end

    remove_multiples(2)

    for testprime = 3:2:sq_root
        if primes_mask[testprime]
            # true means this is a prime
            last_prime = testprime

            # Set all multiples of this prime to false in the boolean array
            remove_multiples(testprime)
        end
    end
    return findall(primes_mask)
end

function get_nextprime(n::Integer)
    #= This function returns the next higher prime number of a given number
       If used iteratively against a large range, it will be slow.
    =#
    if iseven(n)
        n += 1
    end
    while true
        if isprime(n)
            return n
        else
            n += 2
        end
    end
end

function print_results(n::Integer, lastprime::Integer)
    #=
    This function prints the results in a formatted way
       expects: number of primes (integer), last prime number (integer)
    =#
    @printf("%19dth prime is: %20d\n", n, lastprime)
end

# Actually invoking the stuff here (main)
for n in find_nth_prime
    @time lastprime = get_lastprime_by_n(n)
    print_results(n, lastprime)
end
