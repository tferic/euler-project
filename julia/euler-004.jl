"""
Problem 4: Largest palindrome product
A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
Find the largest palindrome made from the product of two 3-digit numbers.
"""

# Find results for each of the following number of digits:
digits = (2, 3, 6, 7)

function is_palindrome(input)
    """
    This function returns "true" if input (number or string) is a palindrome, and "false" if it is not
        expects: number or string (potential palindrome)
        returns: Boolean
    """
    # if the input is the same as the reversed input, it is a palindrome (return true)
    return string(input) == reverse(string(input))
end

function is_palindrome_handmade(input)
    """
    Re-invent the wheel, rather than simply using "reverse()"
    This function returns "true" if input (number or string) is a palindrome, and "false" if it is not
        expects: number or string (potential palindrome)
        returns: Boolean
    """
    # convert input to array of single characters
    str = collect(string(input))
    # determine the middle position of the string
    middle = fld(length(str), 2)

    # compare the leftmost to the rightmost character of the input
    # then the (leftmost + 1) to the (rightmost - 1 character), and so on, until the middle of the string is reached
    for left in 1:middle
        right = left - 1
        if str[left] != str[end-right]
            return false
        end
    end
    return true
end

function get_range_by_digits(dig)
    """
    This function returns the minimum and maximum number for a given number of digits
        expects: number (number of digits)
        return: Dictionary with minimum value in "min", maximum value in "max"
    """
    # e.g. 3-digits: 100
    min = 1 * 10 ^ (dig - 1)
    # e.g. 3-digits: 999
    max = (1 * 10 ^ dig) - 1

    min_max = Dict("min" => min, "max" => max)
    return min_max
end

function find_biggest_palindrome(dig)
    """
    This function finds the biggest palindome number of two products
        expects: number (how many digits should the numbers for the two products have?)
        returns: array (element1: palindome number; element2: factor1 element3: factor2)
    """
    f = get_range_by_digits(dig)
    min = f["min"]
    max = f["max"]
    palindrome_max = false
    f1_max = false
    f2_max = false

    # nested iteration counting backwards. Is the product a palindrome?
    for f1 = max:-1:min, f2 = max:-1:min
        prod = f1 * f2
        if is_palindrome(prod)
            if prod > palindrome_max
                palindrome_max = prod
                f1_max, f2_max = f1, f2
            end
        else
            # Stop looping when there is a palindrome number and both factors are smaller than the ones found
            if palindrome_max != false
                if (f1 < f1_max && f2 < f2_max) || (f1 < f2_max && f2 < f1_max)
                    return [palindrome_max, f1_max, f2_max]
                end
            end
        end
    end
    return [palindrome_max, f1_max, f2_max]
end

for d in digits
    @time results = find_biggest_palindrome(d)
    println("Biggest palindrome for ", d, " digits: ", results[1], " ; factors: ", results[2], ", ", results[3] )
end
