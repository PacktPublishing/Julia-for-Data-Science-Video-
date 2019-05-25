# code for Video 5.4:
julia> using RDatasets
julia> iris = dataset("datasets", "iris")
julia> features = convert(Array, iris[:, 1:4]) # measurements of length
# 1) SepalLength, 2) SepalWidth, 3) PetalLength, 4) PetalWidth
julia> labels = convert(Array, iris[:, 5])     # species

### MultivariateStats
julia> Pkg.add("MultivariateStats")
julia> using MultivariateStats

### GLM and GLMNet
julia> Pkg.add("GLM")
julia> Pkg.add("GLMNet")
julia> using GLM, GLMNet, DataFrames

#calculating a Generalized Linear Model:
julia> data = DataFrame();
julia> data[:x] = iris[1:50, :SepalWidth]
50-element DataArrays.DataArray{Float64,1}:
 3.5
 3.0
 3.2
 3.1
 3.6
 3.9
 3.4

julia> data[:y] = iris[1:50, :SepalLength]
50-element DataArrays.DataArray{Float64,1}:
 5.1
 4.9
 4.7
 4.6
 5.0
 5.4
 4.6
 5.0

# LINEAR REGRESSION ---------------------------------------------------------------------------------------------------
# Recall the linreg solution from section 4.3: SepalLength = 2.64466 + 0.690854 * SepalWidth
# Simple linear model:
julia> model = lm(y ~ x, data)
DataFrames.DataFrameRegressionModel{GLM.LinearModel{GLM.DensePredQR{Float64}},Flo
at64}:

Coefficients:
             Estimate Std.Error t value Pr(>|t|)
(Intercept)     2.639  0.310014 8.51251   <1e-10
x             0.69049 0.0898989 7.68074    <1e-9

# The model's formula is: SepalLength = 2.639 + 0.69049 * SepalWidth

# lm is a shortcut for:
julia> model = fit(LinearModel, y ~ x, data)
DataFrames.DataFrameRegressionModel{GLM.LinearModel{GLM.DensePredQR{Float64}},Flo
at64}:

## GLM general format:
julia> model = glm(formula, data, family, link)

# Family    Canonical Link Function (= optional)
# ------    -----------------------
# Normal    IdentityLink
# Binomial  LogitLink
# Binomial  ProbitLink
# Poisson   LogLink
# Gamma     InverseLink

# example for family = Normal() / link   = IdentityLink()
julia> model = glm(y ~ x, data, Normal(), IdentityLink())
DataFrames.DataFrameRegressionModel{GLM.GeneralizedLinearModel{GLM.GlmResp{Array{
Float64,1},Distributions.Normal,GLM.IdentityLink},GLM.DensePredChol{Float64,Base.
LinAlg.Cholesky{Float64,Array{Float64,2}}}},Float64}:

Coefficients:
             Estimate Std.Error z value Pr(>|z|)
(Intercept)     2.639  0.310014 8.51251   <1e-16
x             0.69049 0.0898989 7.68074   <1e-13
# The model's formula is: SepalLength = 2.639 + 0.0.69049 * SepalWidth

# Estimates for coefficients:
julia> coef(model)
2-element Array{Float64,1}:
 2.639
 0.69049

# Standard errors of coefficients:
julia> stderr(model)
2-element Array{Float64,1}:
 0.310014
 0.0898989

# Covariance of coefficients:
julia> vcov(model)
2x2 Array{Float64,2}:
  0.0961089  -0.0277044
 -0.0277044   0.00808181

# RSS:
julia> deviance(model)
2.731315191455518

julia> GLM.predict(model)
50-element Array{Float64,1}:
 5.05572
 4.71047
 4.84857
 4.77952
 5.12476
 5.33191
 4.98667
 4.98667
 4.64142
 4.77952
 5.19381
 4.98667
 ⋮
 4.71047
 4.98667
 5.05572
 4.22713
 4.84857
 5.05572
 5.26286
 4.71047
 5.26286
 4.84857
 5.19381
 4.91762

# Plot points along with fitted model
julia> using Gadfly
# plot in GLM_model.png
julia> plot(data, layer(x = :x, y = GLM.predict(model), Geom.line(), Theme(default_color = colorant"black")))

### GLMNet is a package for fitting generalised linear models via penalised maximum likelihood.
#
# The shrinkage method is selected via parameter α, where
#
#   α = 0 -> Ridge regression
#   α = 1 -> Lasso regression (the default).
#
# The strength of the penalty is determined by the (output) parameter λ.
#
# More information on GLMNet can be found at http://web.stanford.edu/~hastie/glmnet/glmnet_alpha.html.
# Mode information on GLMNet package is at https://github.com/simonster/GLMNet.jl.
#
julia> X = convert(Array, iris[1:50, [:SepalWidth, :PetalLength]])
50x2 Array{Float64,2}:
 3.5  1.4
 3.0  1.4
 3.2  1.3
 3.1  1.5
 3.6  1.4
 3.9  1.7
 3.4  1.4
 3.4  1.5
 2.9  1.4

julia> y = convert(Array, iris[1:50, :SepalLength])
# Fit model for varying values of λ.
#
julia> path = glmnet(X, y)
Least Squares GLMNet Solution Path (58 solutions for 2 predictors in 195 passes):
58x3 DataFrames.DataFrame
| Row | df | pct_dev   | λ          |
|-----|----|-----------|------------|
| 1   | 0  | 0.0       | 0.259109   |
| 2   | 1  | 0.0936139 | 0.236091   |
| 3   | 1  | 0.171334  | 0.215117   |
| 4   | 1  | 0.235858  | 0.196007   |
| 5   | 1  | 0.289428  | 0.178594   |
| 6   | 1  | 0.333902  | 0.162728   |
| 7   | 1  | 0.370825  | 0.148272   |
| 8   | 1  | 0.401479  | 0.1351     |
⋮
| 50  | 2  | 0.570155  | 0.00271447 |
| 51  | 2  | 0.570172  | 0.00247333 |
| 52  | 2  | 0.570187  | 0.0022536  |
| 53  | 2  | 0.570199  | 0.0020534  |
| 54  | 2  | 0.570209  | 0.00187098 |
| 55  | 2  | 0.570217  | 0.00170477 |
| 56  | 2  | 0.570224  | 0.00155332 |
| 57  | 2  | 0.57023   | 0.00141533 |
| 58  | 2  | 0.570234  | 0.00128959 |

# Intercepts for each model.
#
julia> path.a0
58-element Array{Float64,1}:
 5.006  
 4.79572
 4.60413
 4.42955
 4.27048
 4.12555
 3.99348
 3.87316
 3.76352
 3.66362
 ⋮      
 2.34439
 2.34078
 2.33749
 2.33449
 2.33176
 2.32927
 2.327  
 2.32494
 2.32305

# Coefficients for each model.
#
julia> path.betas
2x58 GLMNet.CompressedPredictorMatrix:
 0.0  0.0613412  0.117233  0.16816  0.214562  …  0.663901  0.664214  0.664498
 0.0  0.0        0.0       0.0      0.0          0.275747  0.276429  0.27705 

# Now have we models for a variety of λ, how do we know which one is best? Cross-validation!
#
julia> path = glmnetcv(X, y)
Least Squares GLMNet Cross Validation
58 models for 2 predictors in 10 folds
Best λ 0.044 (mean loss 0.065, std 0.018)

# Extract the average loss across cross-validation runs for each model.
#
julia> path.meanloss
58-element Array{Float64,1}:
 0.12247  
 0.115895 
 0.106013 
 0.0974243
 0.0903268
 0.084464 
 0.0796237
 0.07563  
 0.0728178
 0.0708761
 ⋮        
 0.068732 
 0.0687994
 0.0688611
 0.0689175
 0.068969 
 0.0690161
 0.069059 
 0.0690983
 0.0691341

# Which of these gives the smallest loss:
#
julia> indmin(path.meanloss)
20
#
# And what are the corresponding coefficients?
#
julia> path.path.betas[:,indmin(path.meanloss)]
2-element Array{Float64,1}:
 0.567314 
 0.0649205

# RIDGE REGRESSION ----------------------------------------------------------------------------------------------------

# α = 1 by default, but we can select α = 0 (or any other value between 0 and 1 for that matter!).
#
julia> path = glmnet(X, y, alpha = 0)
Least Squares GLMNet Solution Path (100 solutions for 2 predictors in 286 passes):
100x3 DataFrames.DataFrame
| Row | df | pct_dev    | λ         |
|-----|----|------------|-----------|
| 1   | 2  | 1.2581e-36 | 259.109   |
| 2   | 2  | 0.00183637 | 236.091   |
| 3   | 2  | 0.00201492 | 215.117   |
| 4   | 2  | 0.0022108  | 196.007   |
| 5   | 2  | 0.00242564 | 178.594   |
| 6   | 2  | 0.0026613  | 162.728   |
| 7   | 2  | 0.00291975 | 148.272   |
| 8   | 2  | 0.0032032  | 135.1     |
⋮
| 92  | 2  | 0.56081    | 0.0545401 |
| 93  | 2  | 0.562226   | 0.0496949 |
| 94  | 2  | 0.563442   | 0.0452801 |
| 95  | 2  | 0.564483   | 0.0412575 |
| 96  | 2  | 0.565374   | 0.0375923 |
| 97  | 2  | 0.566133   | 0.0342527 |
| 98  | 2  | 0.566779   | 0.0312098 |
| 99  | 2  | 0.567327   | 0.0284372 |
| 100 | 2  | 0.567792   | 0.0259109 |


# OTHER OPTIONS -------------------------------------------------------------------------------------------------------

# There are a range of other optional parameters which allow you to fine tune the performance of GLMNet. Amongst these
# are:
#
# - dfmax and pmax (maximum number of predictors);
# - nlambda, lambda_min_ratio and lambda (values of λ);
# - constraints (upper and lower bounds on each predictor);
# - weights (weight vector for samples).
