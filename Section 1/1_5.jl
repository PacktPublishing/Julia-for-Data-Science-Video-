# Code for Video 1.5: 

function sum(x, y, z)
  return x + y + z
end

show(sum(2, 3, 4)) # 9
show(sum(2.1, 3.2, 4.3)) # 9.600000000000001
show(sum(true, false, true)) # 2

typeof(sum) # Function

function sum_prod(x, y)
    x + y, x * y
end

# sum("Iris", 7, true)
# ERROR: MethodError: `+` has no method matching +(::ASCIIString, ::Int64)

function sum(x:: Int64, y::Int64, z::Int64)
    return x + y + z
end

function sump(x:: Int64, y::Int64, z::Int64)
    p::Int64 = x * y * z
    return x + y + z + p
end

 sum(x, y, z) = x + y + z

function sumvar(args...)
    sum = 0
    for n in args
        sum += n
    end
    return sum
end

sumvar(2,3,4,100,-9) # 100
sumvar(2,3,4) # 9
sumvar() # 0

function sum(n1, n2, n3=5; n4=-9)
    return n1 + n2 + n3 + n4
end

sum(2, 3) # 1 (= 2 + 3 + 5 -9)
sum(2, 3, 4) # 0  (= 2 + 3 + 4 -9)
sum(2, 3, 4, n4=100) # 109 (= 2 + 3 + 4 + 100)

(x, y, z) -> x + y + z
# (anonymous function)

arr = rand(100)
# 100-element Array{Float64,1}:
#  0.0552819
#  0.319113
#  0.488649
#  ...

arr2 = map(x -> x^2, arr)
# 100-element Array{Float64,1}:
#  0.00305609
#  0.101833
#  0.238778

arr2 = [x^2 for x in arr]
# 100-element Array{Any,1}:
#  0.00305609
#  0.101833
#  0.238778

isodd(n) = (n % 2 != 0)

filter(isodd, round(Int64, rand(100) * 100))
# 50-element Array{Int64,1}:
#  57
#  99
#  23

filter(n -> n %2 != 0, round(Int64, rand(100) * 100))

map(collect(1:100)) do x
        7x^2 - 3.14x + sin(x) + 4
end
# 100-element Array{Float64,1}:
#      8.70147
#     26.6293
#     57.7211
#    102.683
# ...