#=
A Pythagorean triplet is a set of three natural numbers, a < b < c, for which, a² + b² = c²
For example, 3² + 4² = 9 + 16 = 25 = 5².
There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.
https://projecteuler.net/problem=9
=#

triplets_sum = (12, 1000, 360000000)

function get_pythag_triplet_by_sum(s)
    #= This function returns a pythagorean triple for a given sum representing (a+b+c)
       where a < b < c
    =#

    #c_min = Int(round(s/3)) + 1
    c_max = s - 3
    triplets = []

    # Factors for Euclid's formula
    m_max = Int(round(sqrt(c_max)))
    n_max = m_max - 1

    for m in 1:m_max, n in 1:n_max
        if n ≥ m
            continue
        end
        (x, y, z) = get_triplet_by_euclid(m, n)
        if x + y + z == s
            push!(triplets, (x, y, z))
        end
    end
    return triplets
end

function get_triplet_by_euclid(m, n)
    #= This function returns a Pythagorean triple based on Euclid's formula
       https://en.wikipedia.org/wiki/Pythagorean_triple#Generating_a_triple
    =#

    x = m^2 - n^2
    y = 2*m*n
    z = m^2 + n^2
    return (x, y, z)
end

function print_results(s, list)
    println("Pythagorean triplets for a+b+c=$s: ", list, "\n")
end

for s in triplets_sum
    @time list = get_pythag_triplet_by_sum(s)
    print_results(s, list)
end
