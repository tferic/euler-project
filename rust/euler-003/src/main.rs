/*
Problem 3: Largest prime factor
The prime factors of 13195 are 5, 7, 13 and 29.
What is the largest prime factor of the number 600851475143 ?
https://projecteuler.net/problem=3
*/

//extern crate num_bigint_dig as num_bigint;
//use num_bigint::BigUint;
use std::time::{Instant};

fn main() {
    let numbers: Vec::<u64> = vec![13195, 600851475143, 12345678901234, 1234567890123456789];

    for i in numbers {
        let start = Instant::now();
        print_results(i as u64);
        println!("Runtime: {:?}\n", start.elapsed());
    }
}

fn print_results(num: u64) {
    /*
    This function calculates and prints the results in a formatted way
       expects: number (integer)
    */
    let results: Vec::<u64> = prime_factorization(num);

    println!("Highest prime factor  for {}: {:?}", num, results.iter().max() );
    println!("List of prime factors for {}: {:?}", num, results );
}

fn prime_factorization(num: u64) -> Vec::<u64> {
    /*
    This function returns all prime factors of a given number
       expects: positive integer
       returns: array of positive integers
    Implementation: Trial division (https://en.wikipedia.org/wiki/Trial_division)
    */

    // The number (that needs to be prime factorized) is going to be reduced by division of each found prime factor
    let mut factorize_me: u64 = num;

    // list of all prime factors
    let mut results: Vec<u64> = Vec::new();

    // Special case when prime factor = 2 (Reduce number space 50%)
    while factorize_me % 2 == 0 {
        results.push(2);
        factorize_me /= 2;
    }

    // primefactor_test is the number, by which we are testing division (potential prime factor)
    // From 3, increment by 2 (test only for odd numbers, skip even numbers)
    let mut primefactor_test: u64 = 3;

    let mut primefactor_test_sq: u64 = primefactor_test ^ 2;
    let mut start_inside = Instant::now();
    // Check our number, to be prime factorized (becoming smaller by each found prime factor),
    //   against each potential number, that could be a prime factor (becoming bigger)
    while primefactor_test_sq <= factorize_me {
        if factorize_me % primefactor_test == 0 {
            println!("DEBUG: Found new prime factor: {} ; for number: {} ; performance: {:?}", primefactor_test, factorize_me, start_inside.elapsed());
            // Division fits - it must be a prime factor
            results.push(primefactor_test as u64);
            
            // New number (to be prime factorized) := old number divided by prime factor
            factorize_me /= primefactor_test;

            // Cache primefactor_test ^ 2 for performance reasons
            primefactor_test_sq = primefactor_test ^ 2;
            start_inside = Instant::now();
        }
        else {
            // Division did not fit (not a prime factor), try next number
            primefactor_test += 2;
        }
    }

    if factorize_me != 1 {
        // Every remaining number (except 1) must be a prime factor (the last one)
        results.push(factorize_me);
    }
    return results;
}
