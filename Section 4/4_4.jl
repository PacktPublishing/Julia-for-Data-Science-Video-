# code for Video 4.4:
fname = "iris.csv"
using DataFrames
data = readtable(fname, separator = ',')

###Distributions:
Pkg.add("Distributions")
using Distributions

typeof(Normal) # DataType
super(Normal) # Distributions.Distribution{Distributions.Univariate,Distributions.Continuous}
super(Poisson) # Distributions.Distribution{Distributions.Univariate,Distributions.Discrete}

n1 = Normal(10, 1.5) # Distributions.Normal(μ=10.0, σ=1.5)
params(n1) # (10.0,1.5)
fieldnames(n1) # 2-element Array{Symbol,1}:  :μ :σ

rand(n1, 100)
# 100-element Array{Float64,1}:
#   8.48529
#   7.90919
#  13.2968
#   6.55532
#   ...
 # 13.1982
 # 10.7262
 # 11.1575
 # 11.5623

randn(50)
50-element Array{Float64,1}:
  1.34669
 -1.73781
  0.801373
 -1.11795
 ...

b = Binomial(10, 0.7) # binomial distribution with 10 trials and succes rate 0.7
# Distributions.Binomial(n=10, p=0.7)
rand(b, 1000)
1000-element Array{Int64,1}:
 6
 9
 7
 7
 6
 6
 9


### Kernel density:
using Winston, KernelDensity
x = convert(Array, data[1:50, :sepal_width])
y = convert(Array, data[1:50, :sepal_length])
kx = kde(x) # kernel density function
ky = kde(y)
plot(kx.x, kx.density, "r--", ky.x, ky.density, "b;")

###
using Gadfly
set_default_plot_size(20cm, 12cm)
Gadfly.plot(data, x = "petal_length", y = "petal_width", color = "species", Geom.point)

### K-means Clustering
Pkg.add("Clustering")
using Clustering
features = convert(Array, data[:, 1:4])' # 4x150 Array{Float64,2}:
# group the data onto 3 clusters
initseeds(:rand, features, 3) # choose 3 random starting points (centroids)
# 3-element Array{Int64,1}:
#  36
#  93
#  41
result = kmeans( features, 3) # make 3 clusters
# Clustering.KmeansResult{Float64}(4x3 Array{Float64,2}:
#  5.006  5.90161  6.85
#  3.418  2.74839  3.07368
#  1.464  4.39355  5.74211
#  0.244  1.43387  2.07105,[1,1,1,1,1,1,1,1,1,1  …  3,3,
Gadfly.plot(data, x = "petal_length", y = "petal_width", color = result.assignments, Geom.point)

### HypothesisTests
Pkg.add("HypothesisTests")
using HypothesisTests
# test sepal_length I. setosa versus I. versicolor:
xset = convert(Array, data[1:50, :sepal_length])
xver = convert(Array, data[51:100, :sepal_length])

uneqtt = UnequalVarianceTTest(xset, xver)
# Two sample t-test (unequal variance)
# ------------------------------------
# Population details:
#     parameter of interest:   Mean difference
#     value under h_0:         0
#     point estimate:          -0.9299999999999997
#     95% confidence interval: (-1.1057073727210804,-0.7542926272789189)

# Test summary:
#     outcome with 95% confidence: reject h_0
#     two-sided p-value:           3.74674261398387e-17 (extremely significant)

# Details:
#     number of observations:   [50,50]
#     t-statistic:              -10.52098626754911
#     degrees of freedom:       86.53800179765493
#     empirical standard error: 0.08839475466938762

pvalue(uneqtt) # 3.74674261398387e-17
ci(uneqtt) # (-1.1057073727210804,-0.7542926272789189)