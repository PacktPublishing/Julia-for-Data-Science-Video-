include("iris_tools.jl") # IrisTools

using IrisTools # 

# fname # ERROR: UndefVarError: fname not defined
println(species) # ASCIIString["I. setosa","I. versicolor","I. virginica"]

import IrisTools.fname
println(fname) # iris.txt

iris1 = Iris(5.1, 3.5, 1.4, 0.2, "I. setosa")
println(to_string(iris1))
# This I. setosa has measurements: 
#     Sepal length: 5.1
#     Sepal width: 3.5
#     Petal length: 1.4
#     Petal width: 0.2

# reloading:
workspace()

include("iris_tools.jl")
using IrisTools
