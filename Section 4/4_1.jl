# code for Video 4.1:

julia> fname = "iris.csv"
julia> using DataFrames
julia> data = readtable(fname, separator = ',')

julia> describe(data)
sepal_length
Min      4.3
1st Qu.  5.1
Median   5.8
Mean     5.843333333333334
3rd Qu.  6.4
Max      7.9
NAs      0
NA%      0.0%

sepal_width
Min      2.0
1st Qu.  2.8
Median   3.0
Mean     3.054
3rd Qu.  3.3
Max      4.4
NAs      0
NA%      0.0%

petal_length
Min      1.0
1st Qu.  1.6
Median   4.35
Mean     3.758666666666666
3rd Qu.  5.1
Max      6.9
NAs      0
NA%      0.0%

petal_width
Min      0.1
1st Qu.  0.3
Median   1.3
Mean     1.1986666666666665
3rd Qu.  1.8
Max      2.5
NAs      0
NA%      0.0%

species
Length  150
Type    UTF8String
NAs     0
NA%     0.0%
Unique  3

julia> summarystats(data[:sepal_length])
Summary Stats:
Mean:         5.843333
Minimum:      4.300000
1st Quartile: 5.100000
Median:       5.800000
3rd Quartile: 6.400000
Maximum:      7.900000

julia> minimum(data[:sepal_length]) # 4.3
julia> maximum(data[:sepal_length]) # 7.9
julia> extrema(data[:sepal_length]) # (4.3,7.9)

julia> mean(data[:sepal_length]) # 5.843333333333334
julia> length(data[:sepal_length]) # 150
julia> median(data[:sepal_length]) # 5.8
julia> std(data[:sepal_length]) # 0.828066127977863
julia> var(data[:sepal_length]) # 0.6856935123042507 = std * std
julia> variation(data[:sepal_length]) # 0.14171125977944032
julia> mode(data[:sepal_length]) # 5.0
julia> sem(data[:sepal_length]) # 0.0676113162275986
julia> trimmean(data[:sepal_length], 0.1) # 5.8096296296296295
julia> iqr(data[:sepal_length]) # 1.3000000000000007

julia> quantile(data[:sepal_length])
5-element Array{Float64,1}:
 4.3
 5.1
 5.8
 6.4
 7.9

julia> hist(data[:sepal_length])
(4.0:0.5:8.0,[5,27,27,30,31,18,6,6])

julia> countmap(data[:species])
Dict{Union{DataArrays.NAtype,UTF8String},Int64} with 3 entries:
  "I. virginica"  => 50
  "I. versicolor" => 50
  "I. setosa"     => 50

julia> proportionmap(data[:species])
Dict{Union{DataArrays.NAtype,UTF8String},Float64} with 3 entries:
  "I. virginica"  => 0.3333333333333333
  "I. versicolor" => 0.3333333333333333
  "I. setosa"     => 0.3333333333333333

julia> skewness(data[:sepal_length]) # 0.31175305850229673
julia> kurtosis(data[:sepal_length]) # -0.5735679489249748
julia> round(skewness(data[:sepal_length]),3) # 0.312

julia> cor(data[:sepal_width], data[:sepal_length]) # -0.10936924995064931
julia> cor(data[:sepal_length], data[:petal_length])# 0.8717541573048717

julia> cov(data[:sepal_width], data[:sepal_length]) # -0.03926845637583893
julia> cov(data[:sepal_length], data[:petal_length]) # 1.2736823266219242