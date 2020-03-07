#=
Problem 7: 10001st prime
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
What is the 10 001st prime number?
https://projecteuler.net/problem=7
=#

using Printf
using Primes

primecount = (6, 25, 10001, 1000000, 10000000)

function get_lastprime_by_n(n::Int)
    #= This function returns the last prime number for n primes
       Implementation: Sieve of Eratosthenes
    =#

    if n < 1
        return
    elseif n == 1
        return 2
    elseif n == 2
        return 3
    end

    last_prime = 3
    count_prime = 2
    max_prime_guess = guess_maxprime_by_n(n)
    sq_root = Integer(round(sqrt(max_prime_guess)))

    # Create bit-Array from 1:max and initialize all as true (all are considered primes until we find they are not)
    primes_mask::Array{Bool} = trues(max_prime_guess)
    primes_mask[1] = false    # 1 is not a prime
    primes_mask[2] = true     # 2 is a prime

    function remove_multiples(testprime)
        # This subfunction removes all multiples of a prime number from the bit-Array
        multiple = 2
        noprime = testprime * multiple
        while noprime <= max_prime_guess
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
            count_prime += 1

            # Set all multiples of this prime to false in the boolean array
            remove_multiples(testprime)
        end
    end

    last_prime = findlast(primes_mask)
    count_prime = count(b for b in primes_mask)

    if count_prime == n
        # max_prime_guess was exactly matching (rare)
        return last_prime
    elseif count_prime > n
        # max_prime_guess was too big (most often)
        # count primes until the nth prime
        c = 0
        for i in 3:2:length(primes_mask)
            if primes_mask[i]
                c += 1
                if c == n
                    return i
                end
            end
        end
    else
        # max_prime_guess was too small (should never happen)
        println("Warning: Entering slow prime searching. Starting at $count_prime")
        while count_prime < n
            last_prime = get_nextprime(last_prime)
            count_prime += 1
        end
    end
end

function guess_maxprime_by_n(n::Int)
    #= This function returns a best guess on what the biggest prime number will be for n number of primes
       Function may not return a prime but an arbitrary number. But the effective maxprime is smaller.
       https://en.wikipedia.org/wiki/Prime_number_theorem#Approximations_for_the_nth_prime_number
    =#
    return Integer(round( (log(n) + log(log(n)) ) * n) + 1)
end

function get_nextprime(n)
    #= This function returns the next higher prime number of a given number
       This implementation is quite slow.
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

function print_results(n::Int, lastprime::Int)
    #=
    This function prints the results in a formatted way
       expects: number of primes (integer), last prime number (integer)
    =#
    @printf("%19dth prime is: %20d\n", n, lastprime)
end

# Actually invoking the stuff here (main)
for n in primecount
    @time lastprime = get_lastprime_by_n(n)
    print_results(n, lastprime)
end
