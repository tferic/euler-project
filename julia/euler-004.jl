#=
Problem 4: Largest palindrome pal_testuct
A palindromic number reads the same both ways. The largest palindrome made from the pal_testuct of two 2-digit numbers is 9009 = 91 × 99.
Find the largest palindrome made from the pal_testuct of two 3-digit numbers.
https://projecteuler.net/problem=4
=#

# Find results for each of the following number of digits:
digits = (2, 3, 6, 7)

function is_palindromic(input)
    #=
    This function returns "true" if input (number or string) is a palindrome, and "false" if it is not
        expects: number or string (potential palindrome)
        returns: Boolean
    =#

    # if the input is the same as the reversed input, it is a palindrome (return true)
    return string(input) == reverse(string(input))
end

function is_palindromic_handmade(input)
    #=
    Re-invent the wheel, rather than simply using "reverse()"
    This function returns "true" if input (number or string) is a palindrome, and "false" if it is not
        expects: number or string (potential palindrome)
        returns: Boolean
    =#
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
    #=
    This function returns the minimum and maximum number for a given number of digits
        expects: number (number of digits)
        return: List with two elements ("min", "max")
    =#
    # e.g. 3-digits: 100
    min = 1 * 10 ^ (dig - 1)
    # e.g. 3-digits: 999
    max = (1 * 10 ^ dig) - 1

    return (min, max)
end

function find_biggest_palindrome(dig)
    #=
    This function finds the biggest palindome number of two products
        expects: number (how many digits should the numbers for the two products have?)
        returns: list (element1: palindome number; element2: factor1 element3: factor2)
    =#
    min, max = get_range_by_digits(dig)

    pal_max, f1_max, f2_max = (false, false, false)

    # nested iteration counting backwards. Is pal_test a palindrome?
    for f1 = max:-1:min
        for f2 = max:-1:min
            
            pal_test = f1 * f2
            #println("Palindrom Loop: digits: ", dig, " ; min: ", min, " ; max: ", max, " ; f1: ", f1, " ; f2: ", f2, " ; product: ", pal_test)
            
            if is_palindromic(pal_test)
                if pal_test > pal_max
                    pal_max = pal_test
                    f1_max = f1
                    f2_max = f2
                end
            else
                # stop looping if a palidrome number was previously found and if f1, f2 are smaller than the previous factors
                if pal_max != false
                    if (f1 < f1_max && f2 < f2_max) || (f2 < f1_max && f1 < f2_max)
                        return (pal_max, f1_max, f2_max)
                    end
                end
            end
        end
    end
    return (pal_max, f1_max, f2_max)
end

for d in digits
    @time palindrome_max, f1, f2 = find_biggest_palindrome(d)
    println("Biggest palindrome for ", d, " digits: ", palindrome_max, " ; factors: ", f1, ", ", f2)
end
