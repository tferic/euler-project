#=
Problem 5: Smallest multiple
2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
https://projecteuler.net/problem=5
=#

# List of upper limits (for number ranges) to find smallest multiple on
maxnum_range = (10, 20, 30, 50, 100, 200, 400, 1000, 10000, 100000)

function least_common_multiple(n1::BigInt, n2::BigInt)
    #=
    This function returns the least common multiple from two given numbers
        expects: number1, number2
        returns: number (least common multiple of the two numbers)
    Implementation: Algorithm "Reduction by the greatest common divisor" https://en.wikipedia.org/wiki/Least_common_multiple
    =#
    # Use floor division, because we don't want to get a floating point variable as the result
    result::BigInt = div( (n1 * n2), (greatest_common_divisor(n1, n2)) )
    return result
end

function greatest_common_divisor(n1::BigInt, n2::BigInt)
    #=
    This function returns the greatest common divisor from two given numbers
        expects: number1, number2
        returns: number (greatest common divisor of the two numbers)
    Implementation: "Euclid's Method" algorith https://en.wikipedia.org/wiki/Greatest_common_divisor
    =#
    if n2 == 0
        return n1
    elseif n1 == 0
        return n1
    else
        # Recursive function invocation. The work is happening here.
        return greatest_common_divisor(n2, n1 % n2)
    end
end

function find_smallest_common_multiple(maxnum::BigInt)
    #=
    This function finds the smallest common multiple on a list of numbers from 2-maxnum
        expects: number (upper limit of number list: 2-maxnum)
        returns: number (smallest common multiple)
    =#

    # Initialize the resulting "smallest common multiple" with 1
    result_lcm::BigInt = 1

    # We don't need to interate from 1-maxnum. It's enough to iterate from (maxnum/2)-maxnum
    # e.g. if a number is divisible by 16, it will also be divisible by 2,4,8
    lower::BigInt = maxnum // 2
    upper::BigInt = maxnum

    # We can't find the "least common mulitple" from all numbers together, but only from two numbers at the time
    # Iterate over the list of numbers, and get lcm( previous result, iteration number )
    # Avoid recursive function calls here, due to risk of stack overflow
    for i::BigInt = lower:upper
        result_lcm = least_common_multiple(result_lcm, i)
    end

    return result_lcm
end

# Invoking stuff here (main entry point)
for n::BigInt = maxnum_range
    result = BigInt
    @time result = find_smallest_common_multiple(n)
    println("The smallest multiple for all numbers from 1-", n, ": ", result)
end
