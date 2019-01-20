#=
Problem 5: Smallest multiple
2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
=#

# List of upper limits (for any divisor ranges) to run calculations on
maxnum_range = (10, 20, 30, 50, 100, 200, 400, 1000, 10000)

function get_basenumbers_list(maxnum::BigInt)
    """
    This function creates an optimized list of numbers, that should be used to calculate the smallest common multiple on
        expects: number (upper limit of numners list)
        returns: list of numbers (numbers)
    """
    # We don't need to process 1:maxnum, but (maxnum/2):maxnum
    # e.g. if a number is divisible by "16", then it is also divisible by "2","4","8"
    half::BigInt = fld(maxnum, 2)
    return collect(half:maxnum)
end

function least_common_multiple(n1::BigInt, n2::BigInt)
    """
    This function returns the least common multiple from two given numbers
        expects: number1, number2
        returns: number (least common multiple of the two numbers)
    Implementation: Algorithm "Reduction by the greatest common divisor" https://en.wikipedia.org/wiki/Least_common_multiple
    """
    result = BigInt
    result = div( (n1 * n2), ( greatest_common_divisor(n1, n2) ) )
    return BigInt(result)
end

function greatest_common_divisor(n1::BigInt, n2::BigInt)
    """
    This function returns the greatest common divisor from two given numbers
        expects: number1, number2
        returns: number (greatest common divisor of the two numbers)
    Implementation: "Binary Method" algorith https://en.wikipedia.org/wiki/Greatest_common_divisor
    """
    exp = BigInt
    exp = 0
    
    if n1 == 0
        return n2
    end

    while iseven(n1) && iseven(n2)
        n1 = div(n1, 2)
        n2 = div(n2, 2)
        exp += 1
    end
    
    while n1 != n2
        if iseven(n1)
            n1 = div(n1, 2)
        elseif iseven(n2)
            n2 = div(n2, 2)
        elseif n1 > n2
            n1 = div((n1 - n2), 2)
        else
            n2 = div((n2 - n1), 2)
        end
    end

    return n1 * 2 ^ exp
end

function find_smallest_common_multiple(maxnum::BigInt)
    """
    This function the smallest common multiple on a list of numnbers from 2-maxnum
        expects: number (upper limit of number list: 2-maxnum)
        returns: number (smallest common multiple)
    """
    result = BigInt
    result = reduce(least_common_multiple, get_basenumbers_list(maxnum))
    return result
end

# Invoking stuff here (main entry point)
for n::BigInt = maxnum_range
    result = BigInt

    @time result = find_smallest_common_multiple(n)
    println("The smallest multiple for all numbers from 1-", n, ": ", result)
end