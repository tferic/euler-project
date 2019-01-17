=pod
Problem 4: Largest palindrome product
A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
Find the largest palindrome made from the product of two 3-digit numbers.
=cut

use strict;

# Find results for each of the following number of digits:
my @digits = (2, 3, 6, 7);

sub is_palindromic {
    # This function returns "True" if input (number or string) is a palindrome, and "False" if it is not
    #    expects: number or string (potential palindrome)
    #    returns: Boolean

    my $input = shift @_;

    # if the input is the same as the reversed input, it is a palindrome (return True)
    return $input == reverse($input);
}

sub is_palindromic_handmade {
    # Re-invent the wheel, rather than simply using "reverse()"
    # This function returns "True" if input (number or string) is a palindrome, and "False" if it is not
    #     expects: number or string (potential palindrome)
    #     returns: Boolean

    my $input = shift @_;

    my @chars = split("", $input);

    # determine the middle position of the string
    my $middle = int(length($input) / 2);

    # compare the leftmost to the rightmost character of the input
    # then the (leftmost + 1) to the (rightmost - 1 character), and so on, until the middle of the string is reached
    foreach my $left (0 .. $middle) {

        my $right = $left + 1;
        if( $chars[$left] != $chars[-$right] ) {
            return (1==0); #false
        }
    }
    return (1==1); #true
}

sub get_range_by_digits {
    # This function returns the minimum and maximum number for a given number of digits
    #     expects: number (number of digits)
    #     return: array with minimum value in [0], maximum value in [1]

    my $dig = shift @_;

    # e.g. 3-digits: 100
    my $min = 1 * 10 ** ($dig - 1);
    # e.g. 3-digits: 999
    my $max = (1 * 10 ** $dig) - 1;

    return ($min, $max);
}

sub find_biggest_palindrome {
    # This function finds the biggest palindome number of two products
    #     expects: number (how many digits should the numbers for the two products have?)
    #     returns: array (element1: palindome number; element2: factor1 element3: factor2)

    my $dig = shift @_;
    
    my ($min, $max) = get_range_by_digits($dig);

    my ($pal_max, $f1_max, $f2_max) = (undef, undef, undef);

    # nested iteration counting backwards. Is the product a palindrome?
    for my $f1 (reverse $min .. $max) {
        for my $f2 (reverse $min .. $max) {

            my $pal_test = $f1 * $f2;

            if( is_palindromic($pal_test) ) {
                if( $pal_test > $pal_max ) {
                    $pal_max = $pal_test;
                    $f1_max = $f1;
                    $f2_max = $f2;
                }
            }
            else {
                # stop looping if a palidrome number was previously found and if f1, f2 are smaller than the previous factors
                if( $pal_max != undef ) {
                    if( ($f1 < $f1_max && $f2 < $f2_max ) || ($f2 < $f1_max && $f1 < $f2_max) ) {
                        return ($pal_max, $f1_max, $f2_max);
                    } 
                }
            }
        }
    }
    return ($pal_max, $f1_max, $f2_max);
}

for my $d (@digits) {

    my ($pal, $f1, $f2) = find_biggest_palindrome($d);

    print("Biggest palindrome for ", $d, " digits: ", $pal, " ; factors: ", $f1, ", ", $f2, "\n" );
}
