function calculation()
    result = 0
    n = 1000_000
    for i in 1:n
        result += sin(rand())
    end
    return result 
end

show(calculation())

# julia> @time include("1_5_func.jl")
# 460301.1496469646  0.063448 seconds (2.00 M allocations: 30.646 MB, 2.94% gc time)