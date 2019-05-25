# code for Video 5.1:
julia> using RDatasets
julia> iris = dataset("datasets", "iris")
julia> features = convert(Array, iris[:, 1:4]) # measurements or independent variables
# 1) sepal_length, 2) sepal_width, 3) petal_length, 4) petal_width
julia> labels = convert(Array, iris[:, 5])     # targets or dependent variable, here the species name

# general application cycle of an algorithm:
train = # Array of length nrow(iris) and random true / false values
# then the training data set can be constructed as:
features[train]
labels[train]
# and the testing data set is then:
test = !train
features[test]
labels[test]

train  = Array(Bool, nrow(iris)) # this has the right dimension, but contains only false values

julia> using Distributions
julia> rand(Bernoulli(0.75), nrow(iris))
150-element Array{Int64,1}:
 1
 1
 0
 1
 1
 1
 1
 1
 1
 1
 1
 1
 ⋮

julia> train = rand(Bernoulli(0.75), nrow(iris)) .== 1
150-element BitArray{1}:
  true
  true
  true
  true
  true
  true
  true
 false
  true
 false
  true

# training and testing a model:
model = build_model(labels[train], features[train, :])
model = prune_model(model, 0.7)
print_tree(model))
predictions = apply_model(model, features[test,:])

### MLBase:
julia> Pkg.add("MLBase")
julia> using MLBase
## Data preprocessing:
julia> species = ["setosa", "virginica", "versicolor"]
3-element Array{ASCIIString,1}:
 "setosa"
 "virginica"
 "versicolor"

julia> arrs = repeach(species, [2,1,5])
8-element Array{ASCIIString,1}:
 "setosa"
 "setosa"
 "virginica"
 "versicolor"
 "versicolor"
 "versicolor"
 "versicolor"
 "versicolor"

julia> lm = labelmap(species)
LabelMap (with 3 labels):
[1] setosa
[2] virginica
[3] versicolor

julia> labelencode(lm, arrs)
8-element Array{Int64,1}:
 1
 1
 2
 3
 3
 3
 3
 3

julia> groupindices(lm, arrs)
3-element Array{Array{Int64,1},1}:
 [1,2]
 [3]
 [4,5,6,7,8]

# Performance evaluation:
julia> gt = ["setosa", "versicolor", "virginica", "setosa", "virginica"]
5-element Array{ASCIIString,1}:
 "setosa"
 "versicolor"
 "virginica"
 "setosa"
 "virginica"

julia> pred = ["setosa", "virginica", "setosa", "setosa", "virginica"]
5-element Array{ASCIIString,1}:
 "setosa"       # correct predition
 "virginica"    # error predition
 "setosa"       # error predition
 "setosa"       # correct predition
 "virginica"    # correct predition

julia> gtl = labelencode(lm, gt)
5-element Array{Int64,1}:
 1
 3
 2
 1
 2

julia> predl = labelencode(lm, pred)
5-element Array{Int64,1}:
 1
 2
 1
 1
 2

julia> correctrate(gtl, predl)
0.6

julia> errorrate(gtl, predl)
0.4

julia> confusmat(3, gtl, predl)
3x3 Array{Int64,2}:
 2  0  0
 1  1  0
 0  1  0

 ### Receiver Operating Characteristics (ROC)
julia> r = roc(gtl, predl)
MLBase.ROCNums{Int64}
  p = 5     # positive in ground-truth
  n = 0     # negative in ground-truth
  tp = 3    # true positives
  tn = 0    # true negatives
  fp = 0    # false positives
  fn = 0    # false negatives

true_positive_rate(r) # 0.6
true_negative_rate(r) # NaN
precision(r)          # 1.0
recall(r)             # 0.6

# for a real example: see section 2 and code file 5_2.jl

### Cross validation schemes
# for real examples: see section 2 and code file 5_2.j
