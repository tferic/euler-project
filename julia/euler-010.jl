#=
Problem 10: Summation of primes
The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
Find the sum of all the primes below two million.
https://projecteuler.net/problem=10
=#

using Printf

maxprimes = (3, 10, 1000, 2000000, 100000000)

function get_primelist_eratosthenes(upperlimit::Integer)
    #= This function returns a list of primes from 1:upperlimit
       Implementation: Sieve of Eratosthenes (using BitArray)
    =#

    if upperlimit < 2
        return
    elseif upperlimit == 2
        return [2]
    end

    last_prime = 3
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

function print_results(max::Integer, sum::Integer)
    #=
    This function prints the results in a formatted way
       expects: Number (Primes below this number), Number (sum of all primes)
    =#
    @printf("Sum of all primes below (%15d): %20d\n\n", max, sum)
end

# Actually invoking the stuff here (main)
for max in maxprimes
    @time primes = get_primelist_eratosthenes(max-1)
    @time primesum = sum(primes)
    print_results(max, primesum)
end
