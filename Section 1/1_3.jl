# Code for Video 1.3:

year = 2015
condition = true
letter = 'J'
mass_sun = 1.98855e30 # in kg
flower = "iris"

year == 2015 # true
year != 2016 # true

# getting the types of data:
typeof(year)  #Int64
typeof(condition) # Bool
typeof(letter) # Char
typeof(mass_sun) # Float64
typeof(flower) # ASCIIString

# some errors:
#  typeof(mass_sum)
# ERROR: UndefVarError: mass_sum not defined

#  flower + 28
# ERROR: MethodError: `+` has no method matching +(::ASCIIString, ::Int64)
# Closest candidates are:
#   +(::Any, ::Any, ::Any, ::Any...)
#   +(::Int64, ::Int64)
#   +(::Complex{Bool}, ::Real)
#   ...

isa(flower, ASCIIString) # true

convert(Float32, year) # 2015.0f0
Float32(year)
# convert(Int64, mass_sun) # ERROR: InexactError() in convert at int.jl:209

1:24
1.0:0.5:20.0
typeof(1:24) # UnitRange{Int64}
typeof(1.0:0.5:20.0) # FloatRange{Float64}
range(1, 10) # 1:10

char1 = 'I'
char2 = 'β'
Int(char2) # 946
char3 = '\u4E80' # '亀'

species1 = "I. setosa"     # "I. setosa"
typeof(species1) # ASCIIString

arab1 = "الله" # "الله"
typeof(arab1) # UTF8String

species2 = "I. versicolor" # "I. versicolor"
species3 = "I. virginica"  # "I. virginica"
species1[1] # 'I'
species1[1:3] # "I. "

julia> species1[0]
# ERROR: BoundsError: attempt to access 9-element Array{UInt8,1}:
#  0x49
#  0x2e
#  0x20
#  0x73
#  0x65
#  0x74
#  0x6f
#  0x73
#  0x61
#   at index [0]
#  in getindex at ascii.jl:13

# species1[5] = '3' # ERROR: MethodError: `setindex!` has no method matching setindex!(::ASCIIString,
                  # ::Char, ::Int64)

println("The first iris species is: $species1") # The first iris species is: I. setosa
@printf("The 3rd iris species is: %s", species3) # The 3rd iris species is: I. virginica

s1 = :male
typeof(s1) # Symbol

println("")
for c in species2
    print(c, " - ")
end
# I - . -   - v - e - r - s - i - c - o - l - o - r -

search(species1, '.') # 2

email_pattern = r"(.+)@(.+)"
input = "john.doe@mit.edu"
ismatch(email_pattern, input) # true

split(species1) # 2-element Array{SubString{ASCIIString},1}:
                # "I."
                # "setosa"

temperature = [98.1, 98.6, 101.4] # 3-element Array{Float64,1}:
flu_status = [false, false, true] # 3-element Array{Bool,1}:
iris_species = [species1, species2, species3]
# 3-element Array{ASCIIString,1}:
#  "I. setosa"
#  "I. versicolor"
#  "I. virginica"

iris_species[3] # "I. virginica"
iris_species[2:3] # 2-element Array{ASCIIString,1}:
 # "I. versicolor"
 # "I. virginica"
iris_species[3] = "I. albicans"
iris_species
# 3-element Array{ASCIIString,1}:
#  "I. setosa"
#  "I. versicolor"
#  "I. albicans"
length(iris_species) # 3

arr1 = collect(1:5)
# 5-element Array{Int64,1}:
#  1
#  2
#  3
#  4
#  5

arr2 = Float64[] # 0-element Array{Float64,1}
push!(arr2, 5.1) # 1-element Array{Float64,1}: 5.1
push!(arr2, 3.5) # 2-element Array{Float64,1}: 5.1 3.5
println("")
show(arr2) # [5.1,3.5]
println("")

randn(5)
5-element Array{Float64,1}:
 -1.01086
 -0.154656
 -1.8495
  1.01637
  0.184996

for s in iris_species
    print(s, " / ")
end
# I. setosa / I. versicolor / I. albicans /
println("")

arr3 = [11, "Julia", 3.14, 'α']
# 4-element Array{Any,1}:
#  11
#  "Julia"
#  3.14
#  'α'

iris_species
# 3-element Array{ASCIIString,1}:
#  "I. setosa"
#  "I. versicolor"
#  "I. albicans"

push!(iris_species, "I. virginica")
# 4-element Array{ASCIIString,1}:
#  "I. setosa"
#  "I. versicolor"
#  "I. albicans"
#  "I. virginica"

pop!(iris_species)
# "I. virginica"

sort!(iris_species)
# 3-element Array{ASCIIString,1}:
#  "I. albicans"
#  "I. setosa"
#  "I. versicolor"