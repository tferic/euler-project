'''
Problem 2: Even Fibonacci numbers
Each new term in the Fibonacci sequence is generated by adding the previous two terms. 
By starting with 1 and 2, the first 10 terms will be:
1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
By considering the terms in the Fibonacci sequence whose values do not exceed four million, 
find the sum of the even-valued terms.
https://projecteuler.net/problem=2
'''

# Set ceiling to 4'000'000
fib_limit = 4000000

# Initialize start numbers of fibonacci sequence
fib = [1, 2]

def sum_even_fibonacci_numbers(fib, fib_limit):
    sum = 0
    while ( fib[-1] < fib_limit ):
        if ( fib[-1] % 2 == 0 ):
            sum += fib[-1]
        fib.append(fib[-1] + fib[-2])
    return sum
  
print("Sum(90):        ",sum_even_fibonacci_numbers(fib, 90))
print("Sum(4'000'000): ",sum_even_fibonacci_numbers(fib, fib_limit))
