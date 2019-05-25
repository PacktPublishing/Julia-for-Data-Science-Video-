# The "iris" dataset contains 150 measurements on 3 species
# of Iris flowers, namely I. setosa, I. versicolor and I. virginica.
# We want to know how many measurements there are for each species.
# Our input is an array named iris with for each measurement the name of its species.
# The dataset can be found in the file iris.txt

# 1- extracting the species from the dataset in the array:
iris = []
fname = "iris.txt"
open(fname) do file
    for line in eachline(file)
        # println(line)
        # the species name starts from column 17:
        species = line[17:end]
        # removes the trailing \r\n:
        species = strip(species)
        push!(iris, species)
    end
end
# println(length(iris)) # 150
# show(iris) # Any["I. setosa","I. setosa","I. s... ]

# 2- counting the species:
# make a dictionary with the species and count their frequencies:
species_freq = Dict{ASCIIString, Int64}()
for species in iris
    haskey(species_freq, species) ? 
        species_freq[species] += 1 : 
        species_freq[species] = 1
end
    
# 3- sort the the keys and print out the frequencies:
println("Species : frequency \n")
species = sort!(collect(keys(species_freq)))
for sp in species
    println("$sp : $(species_freq[sp])")
end
# Species : frequency 

# I. setosa : 50
# I. versicolor : 50
# I. virginica : 50