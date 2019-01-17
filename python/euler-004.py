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
    for left in range(0, (middle - 1)):
        right = left + 1
        if strarr[left] != strarr[-right]:
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

    return (min, max)

def find_biggest_palindrome(dig):
    '''
    This function finds the biggest palindome number of two products
        expects: number (how many digits should the numbers for the two products have?)
        returns: array (element1: palindome number; element2: factor1 element3: factor2)
    '''
    min, max = get_range_by_digits(dig)

    pal_max, f1_max, f2_max = (False, False, False)

    # nested iteration counting backwards. Is the product a palindrome?
    for f1 in range(max, min, -1):
        for f2 in range(max, min, -1):

            pal_test = f1 * f2

            if is_palindromic(pal_test):
                if pal_test > pal_max:
                    pal_max = pal_test
                    f1_max = f1
                    f2_max = f2
            else:
                # stop looping if a palidrome number was previously found and if f1, f2 are smaller than the previous factors
                if pal_max != False:
                    if (f1 < f1_max and f2 < f2_max) or (f2 < f1_max and f1 < f2_max):
                        return (pal_max, f1_max, f2_max)

    return (pal_max, f1_max, f2_max)

for d in digits:
    palindrome_max, f1, f2 = find_biggest_palindrome(d)
    print("Biggest palindrome for", d, "digits:", palindrome_max, "; factors:", f1, ",", f2)
