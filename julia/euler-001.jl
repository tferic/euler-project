#=
Problem 1: Multiples of 3 and 5
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
Find the sum of all the multiples of 3 or 5 below 1000.
https://projecteuler.net/problem=1
=#

function sum_multiples(maxval)
  sum = 0
  for i = 1:(maxval - 1)
    if i % 3 == 0 || i % 5 == 0
      sum += i
    end
  end
  return sum
end

println("Sum(10):   ",sum_multiples(10))
println("Sum(1000): ",sum_multiples(1000))
