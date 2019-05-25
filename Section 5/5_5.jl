# code for Video 5.5:
julia> using RDatasets
julia> iris = dataset("datasets", "iris")
julia> labels = iris[:Species]
150-element DataArrays.PooledDataArray{ASCIIString,UInt8,1}:
 "setosa"
 "setosa"
 "setosa"
 ...
 julia> features = convert(Array, iris[:, 1:4])
150x4 Array{Float64,2}:
 5.1  3.5  1.4  0.2
 4.9  3.0  1.4  0.2
 4.7  3.2  1.3  0.2
 4.6  3.1  1.5  0.2
 5.0  3.6  1.4  0.2
 
julia> Pkg.add("LIBSVM")
julia> using LIBSVM

features_train, features_test = features[1:2:end, :], features[2:2:end, :]
(
75x4 Array{Float64,2}:
 5.1  3.5  1.4  0.2
 4.7  3.2  1.3  0.2
 5.0  3.6  1.4  0.2
 4.6  3.4  1.4  0.3
 4.4  2.9  1.4  0.2
 5.4  3.7  1.5  0.2
 4.8  3.0  1.4  0.1
 5.8  4.0  1.2  0.2
 5.4  3.9  1.3  0.4
 ...
 )
75x4 Array{Float64,2}:
 4.9  3.0  1.4  0.2
 4.6  3.1  1.5  0.2
 5.4  3.9  1.7  0.4
 5.0  3.4  1.5  0.2
 4.9  3.1  1.5  0.1
 4.8  3.4  1.6  0.2
 4.3  3.0  1.1  0.1
 ...
 )

julia> labels_train, labels_test = labels[1:2:end], labels[2:2:end]
(ASCIIString["setosa","setosa","setosa","setosa","setosa","setosa","setosa","seto
sa","setosa","setosa"  …  "virginica","virginica","virginica","virginica","virgin
ica","virginica","virginica","virginica","virginica","virginica"],ASCIIString["se
tosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","se
tosa"  …  "virginica","virginica","virginica","virginica","virginica","virginica"
,"virginica","virginica","virginica","virginica"])

julia> features_train' # we need a transposed matrix for our SVM model
4x75 Array{Float64,2}:
 5.1  4.7  5.0  4.6  4.4  5.4  4.8  5.8  5.4  5.7  …  7.4  6.4  6.1  6.3  6.0  6.7  5.8  6.7  6.3  6.2
 3.5  3.2  3.6  3.4  2.9  3.7  3.0  4.0  3.9  3.8     2.8  2.8  2.6  3.4  3.0  3.1  2.7  3.3  2.5  3.4
 1.4  1.3  1.4  1.4  1.4  1.5  1.4  1.2  1.3  1.7     6.1  5.6  5.6  5.6  4.8  5.6  5.1  5.7  5.0  5.4
 0.2  0.2  0.2  0.3  0.2  0.2  0.1  0.2  0.4  0.3     1.9  2.2  1.4  2.4  1.8  2.4  1.9  2.5  1.9  2.3
# Rows: 1) SepalLength, 2) SepalWidth, 3) PetalLength, 4) PetalWidth

julia> model = svmtrain(labels_train, features_train')
LIBSVM.SVMModel{ASCIIString}(Ptr{Void} @0x00000000044e9620,[LIBSVM.SVMParameter(0,2,3,0.25,0.0,100.0,0.001,1.0,0,Ptr{Int32} @0x00007ef9f467d800,Ptr{Float64} @0x00007ef9f467d840,0.5,0.1,1,0)],[LIBSVM.SVMProblem(75,Ptr{Float64} @0x00007ef9f3f37a00,Ptr{Ptr{LIBSVM.SVMNode}} @0x00007ef9f4bc0040)],5x75 Array{LIBSVM.SVMNode,2}:
 LIBSVM.SVMNode(1,5.1)   LIBSVM.SVMNode(1,4.7)   …  LIBSVM.SVMNode(1,6.2) 
 LIBSVM.SVMNode(2,3.5)   LIBSVM.SVMNode(2,3.2)      LIBSVM.SVMNode(2,3.4) 
 LIBSVM.SVMNode(3,1.4)   LIBSVM.SVMNode(3,1.3)      LIBSVM.SVMNode(3,5.4) 
 LIBSVM.SVMNode(4,0.2)   LIBSVM.SVMNode(4,0.2)      LIBSVM.SVMNode(4,2.3) 
 LIBSVM.SVMNode(-1,NaN)  LIBSVM.SVMNode(-1,NaN)     LIBSVM.SVMNode(-1,NaN),[Ptr{LIBSVM.SVMNode} @0x00000000044e7710,Ptr{LIBSVM.SVMNode} @0x00000000044e7760,Ptr{LIBSVM.SVMNode} @0x00000000044e77b0,Ptr{LIBSVM.SVMNode} @0x00000000044e7800,Ptr{LIBSVM.SVMNode} @0x00000000044e7850,Ptr{LIBSVM.SVMNode} @0x00000000044e78a0,Ptr{LIBSVM.SVMNode} @0x00000000044e78f0,Ptr{LIBSVM.SVMNode} @0x00000000044e7940,Ptr{LIBSVM.SVMNode} @0x00000000044e7990,Ptr{LIBSVM.SVMNode} @0x00000000044e79e0  …  Ptr{LIBSVM.SVMNode} @0x00000000044e8b60,Ptr{LIBSVM.SVMNode} @0x00000000044e8bb0,Ptr{LIBSVM.SVMNode} @0x00000000044e8c00,Ptr{LIBSVM.SVMNode} @0x00000000044e8c50,Ptr{LIBSVM.SVMNode} @0x00000000044e8ca0,Ptr{LIBSVM.SVMNode} @0x00000000044e8cf0,Ptr{LIBSVM.SVMNode} @0x00000000044e8d40,Ptr{LIBSVM.SVMNode} @0x00000000044e8d90,Ptr{LIBSVM.SVMNode} @0x00000000044e8de0,Ptr{LIBSVM.SVMNode} @0x00000000044e8e30],ASCIIString["setosa","versicolor","virginica"],Int32[],Float64[],4,false)

julia> (predicted_labels, decision_values) = svmpredict(model, features_test')

(ASCIIString["setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa"  …  "virginica","versicolor","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica"],
3x75 Array{Float64,2}:
 1.07954   1.07629   1.05125   1.16964   …  -0.809238  -0.897749  -0.936477
 1.10042   1.07671   1.03685   1.1533       -1.00333   -1.0383    -1.07345 
 0.263692  0.254304  0.358478  0.282262     -0.810783  -0.571849  -0.315681)

julia> @printf "Accuracy: %.2f%%\n" mean((predicted_labels .== labels_test))*100
Accuracy: 93.33%

julia> using DecisionTree

julia> confusion_matrix(convert(Array, labels_test), predicted_labels)
Classes:  ASCIIString["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 25   0   0
  0  24   1
  0   4  21

Accuracy: 0.9333333333333333
Kappa:    0.9

### Take 80% of records (120) for training and 20% of records (30) for testing
julia> julia> n_test = Int(length(labels) * 0.2) # 30

julia> collect(1:length(labels)) .> n_test
150-element BitArray{1}:
 false   # first 30 boolean values are false
 false
 false
 false
 false
 false
 false
 false
 false
 false
 false
 false
     ⋮
  true
  true

julia> train_rows = shuffle(collect(1:length(labels)) .> n_test) # shuffle randomizes the true and false values
150-element BitArray{1}:
  true  # shuffle randomizes the true and false values
  true
  true
  true
  true
 false
  true
  ...

julia> features_train, features_test = features[train_rows, :], features[!train_rows, :]
julia> labels_train, labels_test = labels[train_rows], labels[!train_rows]

julia> model = svmtrain(labels_train, features_train')
julia> (predictions, decision_values) = svmpredict(model, features_test')

julia> confusion_matrix(labels_test, predictions)
Classes:  ASCIIString["setosa","versicolor","virginica"]
Matrix:   3x3 Array{Int64,2}:
 15  0  0
  0  9  1
  0  0  5
Accuracy: 0.9666666666666667
Kappa:    0.9459459459459458