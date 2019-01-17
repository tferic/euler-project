#=
Problem 5: Smallest multiple
2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
=#

# List of upper limits (for any divisor ranges) to run calculations on
divisors_max = (10, 20)

function get_divisor_list(maxnum)
    """
    This function creates an optimized list of numbers, that should be used as divisors.
        expects: number (upper limit of divisor list)
        returns: list of numbers (divisors)
    """
    half = fld(maxnum, 2)
    return collect(half:maxnum)
end

function is_multiple(num_test, divisors)
    """
    This function checks, if a given number is a smallest multiple from a list of divisors
        expects: number (potential smallest multiple), list of numbers (divisors)
        returs: true or false
    """
    for d in divisors
        if num_test % d != 0
            return false
        end
    end

    return true
end

function find_smallest_multiple(maxnum)
    """
    This function counts up potential smallest multiples of divisors 2-maxnum
        expects: number (upper limit of divisor list 1-maxnum)
        returns: number (smallest multiple)
    """

    divisors = get_divisor_list(maxnum)

    num_test = maxnum
    while ! is_multiple(num_test, divisors)
        num_test += 1
    end
    return num_test
end

# Invoking stuff here (main entry point)
for dmax = divisors_max
    num = find_smallest_multiple(dmax)
    println("The smallest multiple for all numbers from 1-", dmax, ": ", num)
end