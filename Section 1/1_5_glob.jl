result = 0
n = 1000_000
for i in 1:n
    result += sin(rand())
end
show(result) 

# @time include("1_5_glob.jl")
# 459652.1136757382  0.351386 seconds (5.00 M allocations: 91.616 MB, 3.12% gc time)
