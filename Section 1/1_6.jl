# Code for Video 1.6: 

t1 = (108, 3.14,"Julia",'α') # (108,3.14,"Julia",'α')
typeof(t1) # Tuple{Int64,Float64,ASCIIString,Char}

a, b, c, d = t1 # (108,3.14,"Julia",'α')

a # 108
b # 3.14
c # "Julia"
d # 'α'

a, b = b, a # (3.14,108)
println("a is now $a, b is now $b") 
# a is now 3.14, b is now 108

t1[3] # "Julia"

for e in t1
    print(e, " - ")
end
# 108 - 3.14 - Julia - α -

# t1[4] = 'β'
# ERROR: MethodError: `setindex!` has no method matching setindex!(::Tuple{Int64,F
# loat64,ASCIIString,Char}, ::Char, ::Int64)

s = Set(Int64[11, 14, 13, 7, 14, 11])
# Set([7,14,13,11])
s2 = Set(Any[11, 3.14, "Julia", 'α'])
# Set(Any[3.14,'α',"Julia",11])
intersect(s, s2) # Set([11])

diris = Dict("I. setosa" => 50,
             "I. versicolor" => 50,
             "I. virginica" => 50)
# Dict{ASCIIString,Int64} with 3 entries:
#   "I. virginica"  => 50
#   "I. versicolor" => 50
#   "I. setosa"     => 50

diriss = Dict( :setosa => 50,
               :versicolor => 50,
               :virginica => 50)
# Dict{Symbol,Int64} with 3 entries:
#   :versicolor => 50
#   :virginica  => 50
#   :setosa     => 50

diris["I. setosa"] # 50
diriss[:setosa] # 50

diriss[:setosa] = 53
diriss
# Dict{Symbol,Int64} with 3 entries:
#   :versicolor => 50
#   :virginica  => 50
#   :setosa     => 53

haskey(diris, "I. setosa") # true

keys(diris)
# Base.KeyIterator for a Dict{ASCIIString,Int64} with 3 entries. Keys:
#   "I. virginica"
#   "I. versicolor"
#   "I. setosa"

values(diris)
# Base.ValueIterator for a Dict{ASCIIString,Int64} with 3 entries. Values:
#   50
#   50
#   50

for k in keys(diris)
    print(k, " - ")
end
# I. virginica - I. versicolor - I. setosa -

for (k, v) in diris
    println("$k has $v measurements")
end
# I. virginica has 50 measurements
# I. versicolor has 50 measurements
# I. setosa has 50 measurements