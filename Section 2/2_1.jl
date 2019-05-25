# Code for Video 2.1: 

Array{Float64, 2} 
Dict{Symbol, Float64}

# Array{T, 2} 
# Dict{K, V}

function double(f::Float64)
    f * 2
end

local n::Int32 = 7
# (31 + 42)::Float64
# ERROR: TypeError: typeassert: expected Float64, got Int64

super(Int64) # Signed

subtypes(Signed)
# 5-element Array{Any,1}:
#  Int128
#  Int16
#  Int32
#  Int64
#  Int8

Int32 <: Signed # true
Float64 <: Number # true

type Iris
    sepal_length::Float64
    sepal_width::Float64
    petal_length::Float64
    petal_width::Float64
    species::ASCIIString
end

fieldnames(Iris)
# 5-element Array{Symbol,1}:
#  :sepal_length
#  :sepal_width
#  :petal_length
#  :petal_width
#  :species

iris1 = Iris(5.1, 3.5, 1.4, 0.2, "I. setosa")
# Iris(5.1,3.5,1.4,0.2,"I. setosa")
iris1.petal_width # 0.2
iris1.petal_width = 0.3 # 0.3
iris1 # Iris(5.1,3.5,1.4,0.3,"I. setosa")

immutable Iris2
    sepal_length::Float64
    sepal_width::Float64
    petal_length::Float64
    petal_width::Float64
    species::ASCIIString
end
iris2 = Iris2(5.1, 3.5, 1.4, 0.2, "I. setosa")
# iris1.petal_width = 0.2 # ERROR: LoadError: type Iris2 is immutable

arr_iris = Iris[] # 0-element Array{Iris,1}
push!(arr_iris, iris1)
# 1-element Array{Iris,1}:
#  Iris(5.1,3.5,1.4,0.2,"I. setosa")

type IrisG{T <: Real}
   sepal_length::T
   sepal_width::T
   petal_length::T
   petal_width::T
   species::ASCIIString
end

add{T}(x::T, y::T) = x + y
# add (generic function with 1 method)
add{T <: Number}(x::T, y::T) = x + y

# add("I. setosa", "I. versicolor")
# ERROR: MethodError: `+` has no method matching +(::ASCIIString, ::ASCIIString)
# Closest candidates are:
#   +(::Any, ::Any, ::Any, ::Any...)
#  in add at none:1

function add(x::Float64, y::Float64) 
    println("Adding 2 floating point numbers:")
    println(x + y)
    x + y
end

methods(add)
# 3 methods for generic function "add":
# add(x::Float64, y::Float64) at none:2
# add{T<:Number}(x::T<:Number, y::T<:Number) at none:1
# add{T}(x::T, y::T) at none:1

add(2, 5) # 7
add(3.1, 5.4)
# Adding 2 floating point numbers:
# 8.5

methods(+)
# 171 methods for generic function "+":
# +(x::Bool) at bool.jl:33
# +(x::Bool, y::Bool) at bool.jl:36
# +(y::AbstractFloat, x::Bool) at bool.jl:46
# +(x::Int64, y::Int64) at int.jl:8
# +(x::Int8, y::Int8) at int.jl:16
# +(x::UInt8, y::UInt8) at int.jl:16
# ....

type Setosa
    # some fields
end

type Versicolor
    # some fields
end

type Virginica
    # some fields
end

IrisU = Union{Setosa, Versicolor, Virginica}
Union{Setosa,Versicolor,Virginica}

set1 = Setosa() # Setosa() value
isa(set1, IrisU) # true