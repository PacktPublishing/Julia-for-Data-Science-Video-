# Code for Video 2.3: 
# The "iris" dataset contains 150 measurements on 3 species
# of Iris flowers, namely I. setosa, I. versicolor and I. virginica.
# The columns 1 to 4 respectively contain the:
# sepal length - sepal width -petal length - petal width.
# The species is specified in the last column.
# The dataset can be found in the file iris.txt

module IrisTools

### exports:
export Iris
export species
export read_file, counting_species, length_matrix, calculations_setosa, to_string

### module variables:
###################################################
fname = "iris.txt"
species = ["I. setosa", "I. versicolor", "I. virginica"]

irism = [] # will contain the measurements of the dataset, each array element is a line containing 4 measurements 
iris = [] # temporary array  to contain the names of iris specimens
lengths = [] # matrix with the length measurements 
species_freq = Dict{ASCIIString, Int64}()

### types:
###################################################
type Iris
    sepal_length::Float64
    sepal_width::Float64
    petal_length::Float64
    petal_width::Float64
    species::ASCIIString
end

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

### functions:
###################################################
"executed when the module is loaded"
function __init__()
    read_file()
end

"reads in the file iris.txt with iris measurements"
function read_file()
    open(fname) do file
        global irism = readlines(file)
    end
    # println(irism)
end

"gives a count of measurements for each species"
function counting_species()
    # gather names of species in iris array:
    for line in irism
        # println(line)
        # the species name starts from column 17:
        species = line[17:end]
        # removes the trailing \r\n:
        species = strip(species)
        push!(iris, species)
    end
    # count species in dictionary species-freq:
    for species in iris
        haskey(species_freq, species) ? 
            species_freq[species] += 1 : 
            species_freq[species] = 1
    end
    # sort the the keys and print out the frequencies:
    println("Species : frequency \n")
    species = sort!(collect(keys(species_freq)))
    for sp in species
        println("$sp : $(species_freq[sp])")
    end
end

" extracts a matrix with the length measurements"
function length_matrix()
    # extract the measurements as numbers in a matrix lengths:
    lengths_temp = Array(Float64, 1, 4)
    for line in irism
        # The columns 1 to 16 respectively contain the lengths of 1 measurement:
        mlengths = line[1:16] # measurement lengths
        arr_temp = split(mlengths) # split on spaces to an array of strings
        # convert to an array of Float64 values (a column vector 4 x 1)
        arr_mlength = [parse(Float64, str) for str in arr_temp]
        # transpose arr_mlength to obtain a 1 x 4 array
        # and append it vertically to lengths
        lengths_temp = vcat(lengths_temp, arr_mlength') 
        # we must indicate that we mean the variable lengths 
        # defined in global scope by prepending it with global
    end
    # cut off the first row which contained arbitrary values
    global lengths = lengths_temp[2:end, :]
end

" performs some calculations on I. setosa measurements"
function calculations_setosa()
    # extract I. setosa measurements:
    lengths_setosa = lengths[1:50, :]
    # do some calculations:
    println("sum of each column")
    println(sum(lengths_setosa, 1))
    println("mean of the features:")
    println(mean(lengths_setosa, 1))
    println("smallest values of the features:")
    println(sort(lengths_setosa, 1)[1, :])
    println("largest values of the features:")
    println(sort(lengths_setosa, 1)[end, :])
end

function show(i::Iris)
    println("This $(i.species) has measurements: ")
    println("Sepal length: $(i.sepal_length)")
    println("Sepal width: $(i.sepal_width)")
    println("Petal length: $(i.petal_length)")
    println("Petal width: $(i.petal_width)")
end

function to_string(i::Iris)
    "This $(i.species) has measurements: \n" * 
    "\tSepal length: $(i.sepal_length)\n" *
    "\tSepal width: $(i.sepal_width)\n" * 
    "\tPetal length: $(i.petal_length)\n" * 
    "\tPetal width: $(i.petal_width)\n"
end

end  # module end