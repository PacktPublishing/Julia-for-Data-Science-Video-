# The "iris" dataset contains 150 measurements on 3 species
# of Iris flowers, namely I. setosa, I. versicolor and I. virginica.
# The columns 1 to 4 respectively contain the:
# sepal length - sepal width -petal length - petal width.
# The species is specified in the last column.
# The dataset can be found in the file iris.txt

# 1- extracting the length measurements from the dataset in the array:
lengths = Array(Float64, 1, 4) # create an empty (initialized with arbitrary values) array 
# with 1 row, 4 columns 
fname = "iris.txt"
open(fname) do file
    for line in eachline(file)
        # The columns 1 to 16 respectively contain the lengths of 1 measurement:
        mlengths = line[1:16] # measurement lengths
        arr_temp = split(mlengths) # split on spaces to an array of strings
        # convert to an array of Float64 values (a column vector 4 x 1)
        arr_mlength = [parse(Float64, str) for str in arr_temp]
        # transpose arr_mlength to obtain a 1 x 4 array with the ' operator
        # and append it vertically to lengths with vcat
        global lengths = vcat(lengths, arr_mlength') 
        # we must indicate that we mean the variable lengths 
        # defined in global scope by prepending it with global
    end
end
lengths = lengths[2:end, :] # cut off the first row which contained arbitrary values
# println(lengths) # 
show(lengths) #
println()
show(typeof(lengths)) # Array{Float64,2}
println()
show(size(lengths, 1)) # 150 rows
println()
show(size(lengths, 2)) # 4 columns
println()


# 2- calculations on the array lengths containing all measurements:
sum(lengths) # 2078.7
sum(lengths, 1) # sum of each column
# 1x4 Array{Float64,2}:
#  876.5  458.6  563.7  179.9
sum(lengths, 2) # sum of each row
# 150x1 Array{Float64,2}:
#  10.2
#   9.5
#   9.4
#   9.4
#   ...

lengths_setosa = lengths[1:50, :]
# 50x4 Array{Float64,2}:
#  5.1  3.5  1.4  0.2
#  4.9  3.0  1.4  0.2
#  4.7  3.2  1.3  0.2
sum(lengths_setosa, 1)
# 1x4 Array{Float64,2}:
#  250.3  171.4  73.1  12.3

mean(lengths_setosa, 1)
# 1x4 Array{Float64,2}:
#  5.006  3.428  1.462  0.246

mean(lengths, 1)
# 1x4 Array{Float64,2}:
#  5.84333  3.05733  3.758  1.19933

# smallest value:
sort(lengths_setosa, 1)[1, :]
# 1x4 Array{Float64,2}:
#  4.3  2.3  1.0  0.1

# largest value:
sort(lengths_setosa, 1)[end, :]
# 1x4 Array{Float64,2}:
#  5.8  4.4  1.9  0.6

sortrows(lengths_setosa) # sorts array by the first element in each row
# 50x4 Array{Float64,2}:
#  4.3  3.0  1.1  0.1
#  4.4  2.9  1.4  0.2
