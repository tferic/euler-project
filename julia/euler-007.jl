#=
Problem 7: 10001st prime
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
What is the 10 001st prime number?
https://projecteuler.net/problem=7
=#

using Plots
using Primes
using Printf

primecount = (6, 25, 10001, 1000000)

primecache = [2, 3, 5, 7, 11, 13, 17, 19, 23]
#primecache = convert(Array{BigInt}, [2, 3, 5, 7, 11, 13, 17, 19, 23])

function find_nth_prime(n)
    while length(primecache) < n
        push!(primecache, get_nextprime() )
        #push!(primecache, BigInt(get_nextprime()) )
    end
    return primecache[n]
end

function get_nextprime()
    lastprime = primecache[end]
    nextprime = lastprime + 2
    while true
        if isprime(nextprime)
            return nextprime
        else
            nextprime += 2
        end
    end
end

function print_results(n)
    #=
    This function calculates and prints the results in a formatted way
       expects: number (integer)
    =#
    @time p = find_nth_prime(n)
    @printf("%19dth prime is: %20d\n", n, p)
end

# Actually invoking the stuff here (main)
for n in primecount
    print_results(n)
end

#gr()
#plot(primecache, xaxis=:log, yaxis=:log)
