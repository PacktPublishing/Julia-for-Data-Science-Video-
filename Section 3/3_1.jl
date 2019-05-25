# Code for video 3_1:

fname = "iris.txt"
open(fname) do file
    for line in eachline(file)
        # process line
    end
end

type Iris
    sepal_length::Float64
    sepal_width::Float64
    petal_length::Float64
    petal_width::Float64
    species::ASCIIString
end

iris1 = Iris(5.1, 3.5, 1.4, 0.2, "I. setosa")

fname = "example.dat"
open(fname, "w") do filemode(file)
    write(file, string(iris1))
    write(file, "\n")
    # returns 33 (bytes written)
    println(file, "*** End of data ***")
end

# reading delimited files:
fname = "iris.csv"
data = readcsv(fname)
# 150x5 Array{Any,2}:
#  5.1  3.5  1.4  0.2  "I. setosa"
#  4.9  3.0  1.4  0.2  "I. setosa"
#  4.7  3.2  1.3  0.2  "I. setosa"
#  4.6  3.1  1.5  0.2  "I. setosa"
#  5.0  3.6  1.4  0.2  "I. setosa"
#  5.4  3.9  1.7  0.4  "I. setosa"
#  4.6  3.4  1.4  0.3  "I. setosa"
#  5.0  3.4  1.5  0.2  "I. setosa"
#  4.4  2.9  1.4  0.2  "I. setosa"
#  4.9  3.1  1.5  0.1  "I. setosa"
#  5.4  3.7  1.5  0.2  "I. setosa"
#  4.8  3.4  1.6  0.2  "I. setosa"
#  ⋮
#  6.0  3.0  4.8  1.8  "I. virginica"
#  6.9  3.1  5.4  2.1  "I. virginica"
#  6.7  3.1  5.6  2.4  "I. virginica"
#  6.9  3.1  5.1  2.3  "I. virginica"
#  5.8  2.7  5.1  1.9  "I. virginica"
#  6.8  3.2  5.9  2.3  "I. virginica"
#  6.7  3.3  5.7  2.5  "I. virginica"
#  6.7  3.0  5.2  2.3  "I. virginica"
#  6.3  2.5  5.0  1.9  "I. virginica"
#  6.5  3.0  5.2  2.0  "I. virginica"
#  6.2  3.4  5.4  2.3  "I. virginica"
#  5.9  3.0  5.1  1.8  "I. virginica"

data = readdlm(fname, ',')
# data = readdlm(fname, ';', Float64, '\n', header=true)

fname = "iris.dlm"
writedlm(fname, data, ';')

# HDF5 format: 
# https://en.wikipedia.org/wiki/Hierarchical_Data_Format
# https://github.com/timholy/HDF5.jl
Pkg.add("HDF5")
using HDF5

h5open("iris.h5", "w") do file
    write(file, "iris1", string(iris1))
    # alternatively: @write file iris1
end

data = h5read("iris.h5", "iris1") # "Iris(5.1,3.5,1.4,0.2,\"I. setosa\")"
# alternatively:
data = h5open("iris.h5", "r") do file
    read(file, "iris1")
end

file = h5open("iris.h5", "w")
g = g_create(file, "iris") # create a group
g["dset1"] = 150           # create a scalar dataset inside the group, equivalent: write(g, "dset1", 150)
attrs(g)["Description"] = "This group contains the number of iris measurements" # an attribute
close(file)

file = h5open("iris.h5", "r") # HDF5 data file: iris.h5
g = file["iris"] # HDF5 group: /iris (file: iris.h5)
n = read(g, "dset1") # 150 - read dataset dset1 from group g

dump(file)
# HDF5.HDF5File len 1
#   iris: HDF5.HDF5Group len 1
#     dset1: HDF5Dataset () : 150

# JLD format:
# https://github.com/JuliaLang/JLD.jl
Pkg.add("JLD")
using JLD

species = "I. virginica"
save("d:\\temp\\iris.jld", "species", species) # on Windows
# save("/temp/iris.jld", "species", species) # on Linux
new = load("d:\\temp\\iris.jld")
# Dict{ByteString,Any} with 1 entry:
#   "species" => "I. virginica"
new = load("d:\\temp\\iris.jld", "species") # "I. virginica"

jldopen("d:\\temp\\iris.jld", "w") do file
    write(file, "length", 5.1) 
end

data = jldopen("d:\\temp\\iris.jld", "r") do file
    read(file, "length")
end # 5.1

using HDF5
file = jldopen("d:\\temp\\iris.jld", "w")
g = g_create(file, "iris") # create a group
g["dset1"] = 150           # create a scalar dataset inside the group, equivalent: write(g, "dset1", 150)
close(file)

new = load("d:\\temp\\iris.jld")
# Dict{ByteString,Any} with 1 entry:
#   "iris" => Dict{ByteString,Any}("dset1"=>150)

# JSON
Pkg.add("JSON")
using JSON

fname = "iris.json"
data = readall(fname)
data = replace(data, "\r\n", "")
data = replace(data, " ", "")
# "{\"species\":\"I.setosa\",\"sepal_length\":5.1,\"sepal_width\":3.5,\"petal_lengt
# h\":1.4,\"petal_width\":0.2}{\"species\":\"I.setosa\",\"sepal_length\":4.9,\"sepa
# l_width\":3.0,\"petal_length\":1.4,\"petal_width\":0.2}{\"species\":\"I.virginica
# \",\"sepal_length\":5.9,\"sepal_width\":3.0,\"petal_length\":5.1,\"petal_width\":
# 1.8}"
data = replace(data, "}{", "}-{") # to split the string in an array pn '-'
data = split(data, "-")
for rec in data
    iris = JSON.parse(rec)
    @printf "Species: %s, sepal_length: %1.1f\n" iris["species"] iris["sepal_length"]
end
# Species: I.setosa, sepal_length: 5.1
# Species: I.setosa, sepal_length: 4.9
# Species: I.virginica, sepal_length: 5.9

d = Dict(:species=>"I.setosa",:sepal_length=>5.1,:sepal_width=>3.5,:petal_
length=>1.4,:petal_width=>0.2)
# Dict{Symbol,Any} with 5 entries:
#   :sepal_width  => 3.5
#   :sepal_length => 5.1
#   :petal_length => 1.4
#   :species      => "I.setosa"
#   :petal_width  => 0.2

julia> JSON.json(d)
# "{\"sepal_width\":3.5,\"sepal_length\":5.1,\"petal_length\":1.4,\"species\":\"I.s
# etosa\",\"petal_width\":0.2}"

download("https://www.googleapis.com/books/v1/volumes?q=isbn:1408855895")
# "C:\\Users\\CVO\\AppData\\Local\\Temp\\jul2BE0.tmp"
download("https://www.googleapis.com/books/v1/volumes?q=isbn:1408855895", "book.json")
#"book.json"