# code for Video 5.2:
julia> using RDatasets
julia> iris = dataset("datasets", "iris")
julia> features = convert(Array, iris[:, 1:4]) # measurements of length / width
# 1) SepalLength, 2) SepalWidth, 3) PetalLength, 4) PetalWidth
julia> labels = convert(Array, iris[:, 5])     # species

julia> Pkg.add("DecisionTree")
julia> using DecisionTree

### Pruned Tree classifier:
# train full-tree classifier
julia> model = build_tree(labels, features)
Decision Tree
Leaves: 9
Depth:  5

# prune tree: merge leaves having >= 90% combined purity (default: 100%)
julia> model = prune_tree(model, 0.9)
Decision Tree
Leaves: 8
Depth:  5

# pretty print of the tree, to a depth of 5 nodes
julia> print_tree(model, 5)
Feature 3, Threshold 3.0 # PetalLength
L-> setosa : 50/50                                      (1)
R-> Feature 4, Threshold 1.8 # PetalWidth
    L-> Feature 3, Threshold 5.0 # PetalLength
        L-> versicolor : 47/48                          (2)
        R-> Feature 4, Threshold 1.6 # PetalWidth
            L-> virginica : 3/3                         (3)
            R-> Feature 1, Threshold 7 # SepalLength
                L-> versicolor : 2/2                    (4)
                R-> virginica : 1/1                     (5)
    R-> Feature 3, Threshold 4.9 # PetalLength
        L-> Feature 1, Threshold 6.0 # SepalLength
            L-> versicolor : 1/1                        (6)
            R-> virginica : 2/2                         (7)
        R-> virginica : 43/43                           (8)

julia> print_tree(model, 3)
Feature 3, Threshold 3.0 # PetalLength
L-> setosa : 50/50                                      (1)
R-> Feature 4, Threshold 1.8 # PetalWidth
    L-> Feature 3, Threshold 5.0 # PetalLength
        L-> versicolor : 47/48                          (2)
        R->
    R-> Feature 3, Threshold 4.9 # PetalLength    
        L->
        R-> virginica : 43/43                           (3)


# apply learned model
## given feature measurements, predict the label (species)
julia> apply_tree(model, [5.9,3.0,5.1,1.9])
"virginica"
julia> apply_tree(model, [1.9,2.0,2.1,1.9])
"setosa"

# run n-fold cross validation for pruned tree,
# using 90% purity threshold purning, and 3 CV folds
accuracy = nfoldCV_tree(labels, features, 0.9, 3)

Fold 1
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 19   0   0
  0  16   2
  0   0  13

Accuracy: 0.96
Kappa:    0.9396135265700483

Fold 2
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 16   0   0
  1  14   2
  0   2  15

Accuracy: 0.9
Kappa:    0.8500299940011996

Fold 3
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 15   0   0
  0  14   1
  0   1  19

Accuracy: 0.96
Kappa:    0.9393939393939393

Mean Accuracy: 0.94
3-element Array{Float64,1}:
 0.96
 0.9
 0.96

julia> using Base.Test
julia> @test mean(accuracy) > 0.8

### Adaptive-Boosted Decision Stumps Classifier
# train adaptive-boosted stumps, using 10 iterations
julia> model, coeffs = build_adaboost_stumps(labels, features, 10)
(Ensemble of Decision Trees
Trees:      10
Avg Leaves: 2.0
Avg Depth:  1.0,[0.3465735902799731,0.3711532082590139,0.38544475784944743,0.4093
352070410545,0.39211215411428185,0.43271872450399823,0.41523729251553393,0.413565
85168239374,0.42054477554575537,0.4125278240602734])

julia> apply_adaboost_stumps(model, coeffs, [5.9,3.0,5.1,1.9])
"versicolor"

julia> accuracy = nfoldCV_stumps(labels, features, 10, 3)

Fold 1
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 19   0   0
  1  13   0
  0   1  16

Accuracy: 0.96
Kappa:    0.9394673123486682

Fold 2
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 15  0   0
  0  3  18
  0  0  14

Accuracy: 0.64
Kappa:    0.489795918367347

Fold 3
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 16   0   0
  0  14   1
  0   1  18

Accuracy: 0.96
Kappa:    0.9396863691194209

Mean Accuracy: 0.8533333333333334
3-element Array{Float64,1}:
 0.96
 0.64
 0.96

 ### Random Forest classifier
# train random forest classifier
# using 2 random features, 10 trees, and 0.5 portion of samples per tree (optional)
julia> model = build_forest(labels, features, 2, 10, 0.5)
Ensemble of Decision Trees
Trees:      10
Avg Leaves: 6.6
Avg Depth:  4.2

# apply learned model
julia> apply_forest(model, [5.9,3.0,5.1,1.9])
"virginica"

# run n-fold cross validation for forests
# using 2 random features, 10 trees, 3 folds and 0.5 of samples per tree (optional)
julia> accuracy = nfoldCV_forest(labels, features, 2, 10, 3, 0.5)
Fold 1
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 17   0   0
  0  15   1
  0   1  16

Accuracy: 0.96
Kappa:    0.9399759903961584

Fold 2
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 18   0   0
  0  14   2
  0   0  16

Accuracy: 0.96
Kappa:    0.9399038461538461

Fold 3
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 15   0   0
  0  18   0
  0   1  16

Accuracy: 0.98
Kappa:    0.9698976520168573

Mean Accuracy: 0.9666666666666667
3-element Array{Float64,1}:
 0.96
 0.96
 0.98