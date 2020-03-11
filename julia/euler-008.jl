#=
Problem 8: Largest product in a series
The four adjacent digits in the 1000-digit number that have the greatest product are 9 × 9 × 8 × 9 = 5832.

73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450

Find the thirteen adjacent digits in the 1000-digit number that have the greatest product.
What is the value of this product?
https://projecteuler.net/problem=8
=#

digits_counts = (4, 6, 13, 20, 50, 65, 100)

# Define a big number as an array of characters
bignum = collect("73167176531330624919225119674426574742355349194934")
bignum = vcat(bignum, collect("96983520312774506326239578318016984801869478851843"))
bignum = vcat(bignum, collect("85861560789112949495459501737958331952853208805511"))
bignum = vcat(bignum, collect("12540698747158523863050715693290963295227443043557"))
bignum = vcat(bignum, collect("66896648950445244523161731856403098711121722383113"))
bignum = vcat(bignum, collect("62229893423380308135336276614282806444486645238749"))
bignum = vcat(bignum, collect("30358907296290491560440772390713810515859307960866"))
bignum = vcat(bignum, collect("70172427121883998797908792274921901699720888093776"))
bignum = vcat(bignum, collect("65727333001053367881220235421809751254540594752243"))
bignum = vcat(bignum, collect("52584907711670556013604839586446706324415722155397"))
bignum = vcat(bignum, collect("53697817977846174064955149290862569321978468622482"))
bignum = vcat(bignum, collect("83972241375657056057490261407972968652414535100474"))
bignum = vcat(bignum, collect("82166370484403199890008895243450658541227588666881"))
bignum = vcat(bignum, collect("16427171479924442928230863465674813919123162824586"))
bignum = vcat(bignum, collect("17866458359124566529476545682848912883142607690042"))
bignum = vcat(bignum, collect("24219022671055626321111109370544217506941658960408"))
bignum = vcat(bignum, collect("07198403850962455444362981230987879927244284909188"))
bignum = vcat(bignum, collect("84580156166097919133875499200524063689912560717606"))
bignum = vcat(bignum, collect("05886116467109405077541002256983155200055935729725"))
bignum = vcat(bignum, collect("71636269561882670428252483600823257530420752963450"))

# Convert the array of characters to an array of Int
bignum = map(x -> parse(UInt8, x), bignum)

println("Digits in big number: ", length(bignum))

function get_digits(bignum, index, d)
    #= This function accepts:
       - an array of characters (which should be digits of a big number)
       - the index (offset) in the digits array
       - the number of digits required
       The function returns the required adjacent digits from the digits array at the index
    =#
    return bignum[index:(index+d-1)]
end

function get_product_by_digits(digits)
    #= This function accepts an array of characters (which are digits)
       The function returns the product of all digits
    =#
    prod = BigInt(digits[1])
    if length(digits) > 1
        for d in digits[2:end]
            prod *= BigInt(d)
        end
    end
    return prod
end

function find_biggest_product(bignum, dig_c)
    #= This function accepts
       - an array of characters (which are digits)
       - the number of adjacent digits
       The function returns the digits that cause the max product and the corresponding product
    =#
    index = 1
    lastindex = length(bignum)-dig_c+1
    maxproduct = BigInt(0)
    maxdigits = []

    while index ≤ lastindex
        digits = get_digits(bignum, index, dig_c)
        product = get_product_by_digits(digits)
        if product > maxproduct
            maxproduct = product
            maxdigits = digits
        end
        index += 1
    end
    return (maxdigits, maxproduct)
end

function print_result(digits, dig_c, prod)
    #= This function prints the result in a formatted way
       This function accepts:
       - array of int (digits)
       - number of adjacent digits
       - number (product)
    =#

    # Convert array of int to a number as string
    digits = join(string.(digits))

    println("Digits(", dig_c,"): ", digits, " ; Max. product: ", prod)
end

for dig_c in digits_counts
    @time digits, prod::BigInt = find_biggest_product(bignum, dig_c)
    print_result(digits, dig_c, prod)
end
