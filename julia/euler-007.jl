#=
Problem 7: 10001st prime
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
What is the 10 001st prime number?
https://projecteuler.net/problem=7
=#

using Printf

primecount = (6, 10001, 10000000)

function get_lastprime_by_n(n::Int)
    #= This function returns the last prime number for n primes
       Implementation: Sieve of Eratosthenes
    =#
    last_prime = 0
    max = guess_maxprime_by_n(n)

    # Create a boolean array from 1:max and initialize all as true (all are considered primes until we find they are not)
    primesmask::Array{Bool} = trues(max)
    primesmask[1] = false    # 1 is not a prime

    for testprime = 2:max
        if primesmask[testprime]
            # true means this is a prime
            last_prime = testprime

            # Set all multiples of this prime to false in the boolean array
            multiple = 2
            while testprime * multiple <= max
                primesmask[testprime * multiple] = false
                multiple += 1
            end
        end
    end
    return last_prime
end

function guess_maxprime_by_n(n::Int)
    #= This function returns a best guess on how many primes there will be for n number of primes
       https://en.wikipedia.org/wiki/Prime_number_theorem#Approximations_for_the_nth_prime_number
    =#
    return Integer(round( (log(n) + log(log(n)) ) * n) + 1)
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
