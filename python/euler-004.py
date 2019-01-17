'''
Problem 4: Largest palindrome product
A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
Find the largest palindrome made from the product of two 3-digit numbers.
'''

# Find results for each of the following number of digits:
digits = (2, 3, 6, 7)

def is_palindromic(input):
    '''
    This function returns "True" if input (number or string) is a palindrome, and "False" if it is not
        expects: number or string (potential palindrome)
        returns: Boolean
    '''
    # if the input is the same as the reversed input, it is a palindrome (return True)
    return str(input) == str(input)[::-1]

def is_palindromic_handmade(input):
    '''
    Re-invent the wheel, rather than simply using "reverse()"
    This function returns "True" if input (number or string) is a palindrome, and "False" if it is not
        expects: number or string (potential palindrome)
        returns: Boolean
    '''
    # convert input to array of single characters
    strarr = str(input)
    # determine the middle position of the string
    middle = len(strarr) // 2

    # compare the leftmost to the rightmost character of the input
    # then the (leftmost + 1) to the (rightmost - 1 character), and so on, until the middle of the string is reached
    for left in range(0, (middle - 1) ):
        right = left + 1
        if( strarr[left] != strarr[-right] ):
            return False
    return True

def get_range_by_digits(dig):
    '''
    This function returns the minimum and maximum number for a given number of digits
        expects: number (number of digits)
        return: Dictionary with minimum value in "min", maximum value in "max"
    '''
    # e.g. 3-digits: 100
    min = 1 * 10 ** (dig - 1)
    # e.g. 3-digits: 999
    max = (1 * 10 ** dig) - 1

    min_max = { "min": min, "max": max }
    return min_max

def find_biggest_palindrome(dig):
    '''
    This function finds the biggest palindome number of two products
        expects: number (how many digits should the numbers for the two products have?)
        returns: array (element1: palindome number; element2: factor1 element3: factor2)
    '''
    f = get_range_by_digits(dig)
    min = f["min"]
    max = f["max"]
    palindrome_max = False
    f1_max = False
    f2_max = False

    # nested iteration counting backwards. Is the product a palindrome?
    for f1 in range(max, min, -1):
        for f2 in range(max, min, -1):
            prod = f1 * f2
            if( is_palindromic(prod) ):
                if( prod > palindrome_max ):
                   palindrome_max = prod
                   f1_max, f2_max = f1, f2
            else:
               # Stop looping when there is a palindrome number and both factors are smaller than the ones found
               if( palindrome_max != False ):
                  if( (f1 < f1_max and f2 < f2_max) or (f1 < f2_max and f2 < f1_max) ):
                    return [palindrome_max, f1_max, f2_max]
    return [palindrome_max, f1_max, f2_max]

for d in digits:
    results = find_biggest_palindrome(d)
    print("Biggest palindrome for", d, "digits:", results[0], "; factors:", results[1], ",", results[2] )
