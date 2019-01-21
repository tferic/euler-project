=pod
Problem 5: Smallest multiple
2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
=cut

use strict;
use warnings;
#use bignum;

# List of upper limits (for any divisor ranges) to run calculations on
my @maxnum_range = (10, 20, 30, 50, 100, 200, 400);

sub least_common_multiple {
    # This function returns the least common multiple from two given numbers
    #     expects: number1, number2
    #     returns: number (least common multiple of the two numbers)
    # Implementation: Algorithm "Reduction by the greatest common divisor" https://en.wikipedia.org/wiki/Least_common_multiple
    my ($n1, $n2) = (@_);
    
    my $result = int( ($n1 * $n2) / (greatest_common_divisor($n1, $n2)) );
    return $result;
}

sub greatest_common_divisor {
    # This function returns the greatest common divisor from two given numbers
    #     expects: number1, number2
    #     returns: number (greatest common divisor of the two numbers)
    my ($n1, $n2) = (@_);

    #print "DEBUG: gcd: n1: $n1 ; n2: $n2\n";

    if( $n2 == 0 ) {
        return $n1;
    }
    elsif( $n1 == 0 ) {
        return $n1;
    }
    else {
        # Recursive function invocation. The work is happening here.
        return greatest_common_divisor($n2, $n1 % $n2);
    }
}

sub find_smallest_common_multiple {
    # This function the smallest common multiple on a list of numnbers from 2-maxnum
    #     expects: number (upper limit of number list: 2-maxnum)
    #     returns: number (smallest common multiple)
    my $maxnum = shift @_;

    # Initialize the resulting "smallest common multiple" with 1
    my $result_lcm = 1;

    # We don't need to interate from 1-maxnum. It's enough to iterate from (maxnum/2)-maxnum
    # e.g. if a number is divisible by 16, it will also be divisible by 2,4,8
    my $lower = int($maxnum / 2);
    my $upper = $maxnum;

    # We can't find the "least common mulitple" from all numbers together, but only from two numbers at the time
    # Iterate over the list of numbers, and get lcm( previous result, iteration number )
    # Avoid recursive function calls here, due to risk of stack overflow
    foreach my $i ($lower..$upper) {
        $result_lcm = least_common_multiple($result_lcm, $i);
    }

    return $result_lcm;
}

# Invoking stuff here (main entry point)
foreach my $n (@maxnum_range) {
    my $result = find_smallest_common_multiple($n);
    printf("The smallest multiple for all numbers from 1-%d : %s\n", $n, $result);
}

