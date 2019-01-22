#=
Problem 6: Sum square difference
The sum of the squares of the first ten natural numbers is:
        1² + 2² + ... + 10² = 385
The square of the sum of the first ten natural numbers is:
        (1 + 2 + ... + 10)² = 55² = 3025
Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
https://projecteuler.net/problem=6
=#

# List of upper limits (for number ranges) to find smallest multiple on
maxnum_range = (10, 100, 1000000, BigInt(1000000000000000000000000000000))

function sum_number_range(last::BigInt)
    #=
    This function creates the sum of all natural numbers between 1 and last
        expects: number (first/last number of number range)
        returns: number (sum of all numbers)
    Implementation: https://en.wikipedia.org/wiki/1_%2B_2_%2B_3_%2B_4_%2B_%E2%8B%AF
    =#
    result::BigInt = div(last * (last + 1), 2)
    return result
end

function sum_squared_number_range(last::BigInt)
    #=
    This function creates the sum of all squared natural numbers between 1 and last
        expects: number (first/last number of number range)
        returns: number (sum of all squared numbers)
    Implementation: https://en.wikipedia.org/wiki/Square_number
    =#
    result::BigInt = div( (last * (last + 1) * (2 * last + 1)), 6 )
    return result
end

for n::BigInt = maxnum_range
    # sum of squares - e.g. 1² + 2² + ... + 10² = 385
    sum_of_squares::BigInt = sum_squared_number_range(n)

    # square of sum - e.g. (1 + 2 + ... + 10)² = 55² = 3025
    square_of_sum::BigInt = sum_number_range(n) ^ 2

    println("Result (",n,"): ", (square_of_sum - sum_of_squares))
end
