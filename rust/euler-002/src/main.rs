/*
Problem 2: Even Fibonacci numbers
Each new term in the Fibonacci sequence is generated by adding the previous two terms. 
By starting with 1 and 2, the first 10 terms will be:
1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
By considering the terms in the Fibonacci sequence whose values do not exceed four million, 
find the sum of the even-valued terms.
https://projecteuler.net/problem=2
*/

fn main() {
    // Set ceiling to 4'000'000
    let fib_limit: u64 = 4000000;

    // Initialize start numbers of fibonacci sequence
    let fib_init: [u8; 2] = [1, 2];

    println!("Sum(90):        {}", sum_even_fibonacci_numbers(fib_init, 90));
    println!("Sum(4'000'000): {}", sum_even_fibonacci_numbers(fib_init, fib_limit));
}

fn sum_even_fibonacci_numbers(fib_init: [u8; 2], fib_limit: u64) -> u64 {
    let (mut fib1, mut fib2) = (fib_init[0] as u64, fib_init[1] as u64);
    let mut sum = 0;
    while fib2 <= fib_limit {
        if fib2 % 2 == 0 {
            sum += fib2
        }
        // Calculate next fibonacci number, and remember only the last two values
        (fib1, fib2) = (fib2, (fib1 + fib2));
    }
    return sum;
}
