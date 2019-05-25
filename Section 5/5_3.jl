# code for Video 5.3:
julia> using RDatasets, Distributions, DecisionTree, MLBase
julia> iris = dataset("datasets", "iris")
julia> features = convert(Array, iris[:, 1:4]) # measurements of length
# 1) sepal_length, 2) sepal_width, 3) petal_length, 4) petal_width
julia> labels = convert(Array, iris[:, 5])     # species

### Train model, make predictions on test records
julia> train = rand(Bernoulli(0.75), nrow(iris)) .== 1
julia> test = !train

julia> model = build_tree(labels[train], features[train, :])
Decision Tree
Leaves: 9
Depth:  5

julia> model = prune_tree(model, 0.7)
Decision Tree
Leaves: 8
Depth:  5

julia> print_tree(model)
Feature 3, Threshold 3.0
L-> setosa : 35/35
R-> Feature 4, Threshold 1.8
    L-> Feature 3, Threshold 5.1
        L-> Feature 1, Threshold 5.0
            L-> Feature 2, Threshold 2.5
                L-> versicolor : 1/1
                R-> virginica : 1/1
            R-> versicolor : 36/36
        R-> virginica : 3/4
    R-> Feature 3, Threshold 4.9
        L-> Feature 1, Threshold 6.0
            L-> versicolor : 1/1
            R-> virginica : 2/2
        R-> virginica : 39/39


julia> predictions = apply_tree(model, features[test,:])
37-element Array{Any,1}:
 "setosa"
 "setosa"
 "setosa"
 "setosa"
 "setosa"
 "setosa"
 "setosa"
 "setosa"
 "setosa"
 "versicolor"
 "versicolor"
 "versicolor"
 ⋮
 "virginica"
 "virginica"
 "virginica"
 "virginica"
 "virginica"
 "virginica"
 "virginica"
 "virginica"
 "virginica"
 "virginica"
 "virginica"
 "virginica"

julia> species = ["setosa", "virginica", "versicolor"]

 # let's calculate the ROC of these predictions:
julia> lm = labelmap(species)
LabelMap (with 3 labels):
[1] setosa
[2] virginica
[3] versicolor

julia> labels_test = labelencode(lm, labels[test])
37-element Array{Int64,1}:
 1
 1
 1
 1
 1
 1
 1
 1
 1
 3
 3
 3
 ⋮
 2
 2
 2
 2
 2
 2
 2
 2
 2
 2
 2
 2

julia> predictions_test = labelencode(lm, convert(Array{ASCIIString}, predictions))
37-element Array{Int64,1}:
 1    
 1
 1
 1
 1
 1
 1
 1
 1
 3
 3
 3
 ⋮
 2
 2
 2
 2
 2
 2
 2
 2
 2
 2
 2
 2

julia> cor(labels_test, predictions_test) # 0.910473114440612
julia> R2(labels_test, predictions_test) # 0.8145363408521302

julia> for i in 1:length(labels_test)
         println(labels_test[i], " - ", predictions_test[i])
       end
1 - 1
1 - 1
1 - 1
1 - 1
1 - 1
1 - 1
1 - 1
1 - 1
1 - 1
3 - 3
3 - 3
3 - 3
3 - 3
3 - 3
3 - 3
3 - 3
3 - 3
3 - 3
3 - 3
3 - 3
3 - 1       <-- wrong prediction!
3 - 3
2 - 2
2 - 2
2 - 2
2 - 2
2 - 2
2 - 2
2 - 2
2 - 2
2 - 2
2 - 2
2 - 2
2 - 2
2 - 2
2 - 2
2 - 2



julia> using Winston
julia> scatter(labels_test, predictions_test, "^")

julia> r = roc(labels_test, predictions_test)
MLBase.ROCNums{Int64}
  p = 37
  n = 0
  tp = 36
  tn = 0
  fp = 0
  fn = 0

true_positive_rate(r) # 0.972972972972973
true_negative_rate(r) # NaN
precision(r)          # 1.0
recall(r)             # 0.972972972972973

julia> nfoldCV_tree(labels[train], features[train,:], 0.7, 10)

Fold 1
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 4  0  0
 0  6  0
 0  0  2

Accuracy: 1.0
Kappa:    1.0

Fold 2
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 3  0  0
 0  5  1
 0  0  3

Accuracy: 0.9166666666666666
Kappa:    0.870967741935484

Fold 3
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 8  0  0
 0  1  0
 0  0  3

 Accuracy: 1.0
Kappa:    1.0

Fold 4
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 1  0  0
 0  5  0
 0  1  5

Accuracy: 0.9166666666666666
Kappa:    0.8554216867469879

Fold 5
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 3  0  0
 0  2  0
 0  2  5

Accuracy: 0.8333333333333334
Kappa:    0.7391304347826089

Fold 6
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 3  0  0
 0  3  1
 0  0  5

Accuracy: 0.9166666666666666
Kappa:    0.870967741935484

Fold 7
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 3  0  0
 1  2  0
 0  1  5

Accuracy: 0.8333333333333334
Kappa:    0.7419354838709679

Fold 8
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 6  0  0
 0  1  2
 0  2  1

 Accuracy: 0.6666666666666666
Kappa:    0.4666666666666666

Fold 9
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 4  0  0
 0  5  0
 0  1  2

Accuracy: 0.9166666666666666
Kappa:    0.8695652173913044

Fold 10
Classes:  Any["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 6  0  0
 0  4  0
 0  0  2

Accuracy: 1.0
Kappa:    1.0

Mean Accuracy: 0.9
10-element Array{Float64,1}:
 1.0
 0.916667
 1.0
 0.916667
 0.833333
 0.916667
 0.833333
 0.666667
 0.916667
 1.0

# If we do this for a range of purities:
accuracy_cv = DataFrame()
accuracy_cv[:purity]   = collect(0.1:0.025:1.0)
accuracy_cv[:accuracy] = map(x -> mean(nfoldCV_tree(labels[train], features[train,:], x, 10)), accuracy_cv[:purity])

## Folding results ommited ##

Mean Accuracy: 0.9166666666666666
37-element DataArrays.DataArray{Any,1}:
 0.183333
 0.258333
 0.233333
 0.25
 0.191667
 0.216667
 0.216667
 0.2
 0.225
 0.233333
 0.483333
 0.583333
 ⋮
 0.916667
 0.908333
 0.908333
 0.908333
 0.908333
 0.925
 0.916667
 0.908333
 0.925
 0.916667
 0.916667
 0.916667

julia> using Gadfly
julia> plot(accuracy_cv, x = :purity, y = :accuracy, Geom.point) # see image accuracy_cv.png
