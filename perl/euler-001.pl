=pod
Problem 1: Multiples of 3 and 5
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
Find the sum of all the multiples of 3 or 5 below 1000.
https://projecteuler.net/problem=1
=cut

use strict;

sub sum_multiples {
  my $maxval = shift @_;
  my $sum = 0;

  foreach my $i (1..($maxval - 1)) {
    if ( ($i % 3 == 0) || ($i % 5 == 0) ) {
        $sum += $i;
    }
  }
  return $sum;
}

print "Sum(10):   ",sum_multiples(10),"\n";
print "Sum(1000): ",sum_multiples(1000),"\n";
