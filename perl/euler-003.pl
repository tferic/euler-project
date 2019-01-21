=pod
Problem 3: Largest prime factor
The prime factors of 13195 are 5, 7, 13 and 29.
What is the largest prime factor of the number 600851475143 ?
https://projecteuler.net/problem=3
=cut

use strict;
use warnings;
use bignum;

# we want to obtain prime factorization for the following numbers:
my @numbers = (13195, 600851475143, 12345678901234, 1234567890123456789);

sub prime_factorization {
    # This function returns all prime factors of a given number
    #   expects: scalar (positive integer)
    #   returns: reference to array of scalars (positive integers)
    # Implementation: Trial division (https://en.wikipedia.org/wiki/Trial_division)

    my $num = shift @_;

    # The number (that needs to be prime factorized) is going to be reduced by division of each found prime factor
    my $remaining = $num;
    my @results;

    # Exception case for prime factor 2 (after this, we can skip all even numbers)
    while ( $remaining % 2 == 0 ) {
        push @results, 2;
        $remaining /= 2;
    }

    # primetest is the number, by which we are testing division (potential prime factor)
    # From 3, increment by 2 (test only for odd numbers, skip even numbers)
    my $primetest = 3;

    # Check our number, to be prime factorized (becoming smaller by each found prime factor),
    #   against each potential number, that could be a prime factor (becoming bigger)
    while ( $primetest * $primetest <= $remaining ) {
        if ( $remaining % $primetest == 0 ) {
            # Division fits - it must be a prime factor
            push @results, $primetest;
            # New number (to be prime factorized) := old number divided by prime factor
            $remaining /= $primetest;
        }
        else {
            # Division did not fit (not a prime factor), try next number
            $primetest += 2
        }
    }
    if ( $remaining != 1 ) {
        # Every remaining number (except 1) must be a prime factor (the last)
        push @results, $remaining;
    }
    return \@results;
}

sub print_results {
    # This function calculates and prints the results in a formatted way
    #   expects: number (integer)
    my $num = shift @_;
    my $aref_results = prime_factorization($num);

    # printf not capable of printing BigInt. Print as string as workaround.
    printf("Highest prime factor for  %20s: %20s\n", $num, $$aref_results[-1] );
    printf("List of prime factors for %20s: %20s\n", $num, join(',',@$aref_results) );
}


# Actually invoking everything here (main entry point)
foreach my $n (@numbers) {
    print_results($n);
}
