function calculation()
    result = 0.0
    n = 1000_000
    for i in 1:n
        result += sin(rand())
    end
    return result 
end

show(calculation())

@time include("1_5_func_better.jl")
459310.8032323998  0.026413 seconds (2.48 k allocations: 124.761 KB)