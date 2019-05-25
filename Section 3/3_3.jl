# Code for video 3_3:

Pkg.add("RDatasets")
using RDatasets
data = dataset("datasets", "iris")
head(data)
# 6x5 DataFrames.DataFrame
# | Row | SepalLength | SepalWidth | PetalLength | PetalWidth | Species  |
# |-----|-------------|------------|-------------|------------|----------|
# | 1   | 5.1         | 3.5        | 1.4         | 0.2        | "setosa" |
# | 2   | 4.9         | 3.0        | 1.4         | 0.2        | "setosa" |
# | 3   | 4.7         | 3.2        | 1.3         | 0.2        | "setosa" |
# | 4   | 4.6         | 3.1        | 1.5         | 0.2        | "setosa" |
# | 5   | 5.0         | 3.6        | 1.4         | 0.2        | "setosa" |
# | 6   | 5.4         | 3.9        | 1.7         | 0.4        | "setosa" |

summary(data)
"150x5 DataFrames.DataFrame"

features = convert(Array, data[:, 1:4]);
show(features)
150x4 Array{Float64,2}:
 5.1  3.5  1.4  0.2
 4.9  3.0  1.4  0.2
 4.7  3.2  1.3  0.2

labels = convert(Array, data[:, 5]);
labels
150-element Array{ASCIIString,1}:
 "setosa"
 "setosa"
 ...

data[:SepalWidth] 
# 150-element DataArrays.DataArray{Float64,1}:
#  3.5
#  3.0
#  3.2
#  ...

julia> eltype(data[:SepalWidth])
Float64

data[2]
150-element DataArrays.DataArray{Float64,1}:
 3.5
 3.0
 3.2
...

data_sub = data[end-9:end,2:3]
10x2 DataFrames.DataFrame
| Row | SepalWidth | PetalLength |
|-----|------------|-------------|
| 1   | 3.1        | 5.6         |
| 2   | 3.1        | 5.1         |
| 3   | 2.7        | 5.1         |
| 4   | 3.2        | 5.9         |
| 5   | 3.3        | 5.7         |
| 6   | 3.0        | 5.2         |
| 7   | 2.5        | 5.0         |
| 8   | 3.0        | 5.2         |
| 9   | 3.4        | 5.4         |
| 10  | 3.0        | 5.1         |

data_matrix = convert(Matrix, data)
150x5 Array{Any,2}:
 5.1  3.5  1.4  0.2  "setosa"
 4.9  3.0  1.4  0.2  "setosa"
 4.7  3.2  1.3  0.2  "setosa"
 4.6  3.1  1.5  0.2  "setosa"
 5.0  3.6  1.4  0.2  "setosa"
 5.4  3.9  1.7  0.4  "setosa"
 4.6  3.4  1.4  0.3  "setosa"
 5.0  3.4  1.5  0.2  "setosa"
 4.4  2.9  1.4  0.2  "setosa"

data_matrix = convert(Matrix, data[1:2])
150x2 Array{Float64,2}:
 5.1  3.5
 4.9  3.0
 4.7  3.2
 4.6  3.1
 5.0  3.6
 5.4  3.9
 4.6  3.4

sort(unique(data[:SepalWidth]))
23-element DataArrays.DataArray{Float64,1}:
 2.0
 2.2
 2.3
 2.4
 2.5
 ...
 2.6
 2.7
 2.8
 2.9
 3.0
 3.1
 3.2
 3.3
 3.4
 3.5
 3.6
 3.7
 3.8
 3.9
 4.0
 4.1
 4.2
 4.4


data[ data[:SepalWidth].==3.2, : ]
# 13x5 DataFrames.DataFrame
# | Row | SepalLength | SepalWidth | PetalLength | PetalWidth | Species      |
# |-----|-------------|------------|-------------|------------|--------------|
# | 1   | 4.7         | 3.2        | 1.3         | 0.2        | "setosa"     |
# | 2   | 4.7         | 3.2        | 1.6         | 0.2        | "setosa"     |
# | 3   | 5.0         | 3.2        | 1.2         | 0.2        | "setosa"     |
# | 4   | 4.4         | 3.2        | 1.3         | 0.2        | "setosa"     |
# | 5   | 4.6         | 3.2        | 1.4         | 0.2        | "setosa"     |
# | 6   | 7.0         | 3.2        | 4.7         | 1.4        | "versicolor" |
# | 7   | 6.4         | 3.2        | 4.5         | 1.5        | "versicolor" |
# | 8   | 5.9         | 3.2        | 4.8         | 1.8        | "versicolor" |
# | 9   | 6.5         | 3.2        | 5.1         | 2.0        | "virginica"  |
# | 10  | 6.4         | 3.2        | 5.3         | 2.3        | "virginica"  |
# | 11  | 6.9         | 3.2        | 5.7         | 2.3        | "virginica"  |
# | 12  | 7.2         | 3.2        | 6.0         | 1.8        | "virginica"  |
# | 13  | 6.8         | 3.2        | 5.9         | 2.3        | "virginica"  |

colwise(mean,data[1:4])
4-element Array{Any,1}:
 [5.843333333333334]
 [3.0573333333333332]
 [3.7579999999999996]
 [1.1993333333333331]

for row in eachrow(data[1:4])
    println(mean(convert(Array,row)))
end
2.55
2.375
2.35
2.3499999999999996
...


by(data, :Species, size)
3x2 DataFrames.DataFrame
| Row | Species      | x1     |
|-----|--------------|--------|
| 1   | "setosa"     | (50,5) |
| 2   | "versicolor" | (50,5) |
| 3   | "virginica"  | (50,5) |

by(data, :Species, df -> mean(df[:SepalLength]))
3x2 DataFrames.DataFrame
| Row | Species      | x1    |
|-----|--------------|-------|
| 1   | "setosa"     | 5.006 |
| 2   | "versicolor" | 5.936 |
| 3   | "virginica"  | 6.588 |

julia> by(data, :Species, df -> DataFrame(μ = mean(df[:SepalLength])))
3x2 DataFrames.DataFrame
| Row | Species      | μ     |
|-----|--------------|-------|
| 1   | "setosa"     | 5.006 |
| 2   | "versicolor" | 5.936 |
| 3   | "virginica"  | 6.588 |

julia> by(data, :Species) do df
           DataFrame(μ = mean(df[:SepalLength]), σ² = var(df[:SepalLength]))
       end
3x3 DataFrames.DataFrame
| Row | Species      | μ     | σ²       |
|-----|--------------|-------|----------|
| 1   | "setosa"     | 5.006 | 0.124249 |
| 2   | "versicolor" | 5.936 | 0.266433 |
| 3   | "virginica"  | 6.588 | 0.404343 |

aggregate(data, :Species, mean)
3x5 DataFrames.DataFrame
| Row | Species      | SepalLength_mean | SepalWidth_mean | PetalLength_mean |
|-----|--------------|------------------|-----------------|------------------|
| 1   | "setosa"     | 5.006            | 3.428           | 1.462            |
| 2   | "versicolor" | 5.936            | 2.77            | 4.26             |
| 3   | "virginica"  | 6.588            | 2.974           | 5.552            |

| Row | PetalWidth_mean |
|-----|-----------------|
| 1   | 0.246           |
| 2   | 1.326           |
| 3   | 2.026           |

for subdf in groupby(data, :Species)
    println(size(subdf, 1))
    @printf "%6.3f\t" mean(subdf[:SepalLength])
    @printf "%6.3f\t" mean(subdf[:SepalWidth])
    @printf "%6.3f\t" mean(subdf[:PetalLength])
    @printf "%6.3f\n" mean(subdf[:PetalWidth])
end
50
 5.006   3.428   1.462   0.246
50
 5.936   2.770   4.260   1.326
50
 6.588   2.974   5.552   2.026


d = stack(data, :SepalLength, :Species)
150x3 DataFrames.DataFrame
| Row | variable    | value | Species     |
|-----|-------------|-------|-------------|
| 1   | SepalLength | 5.1   | "setosa"    |
| 2   | SepalLength | 4.9   | "setosa"    |
| 3   | SepalLength | 4.7   | "setosa"    |
| 4   | SepalLength | 4.6   | "setosa"    |
| 5   | SepalLength | 5.0   | "setosa"    |
| 6   | SepalLength | 5.4   | "setosa"    |
| 7   | SepalLength | 4.6   | "setosa"    |
| 8   | SepalLength | 5.0   | "setosa"    |
| 9   | SepalLength | 4.4   | "setosa"    |
| 10  | SepalLength | 4.9   | "setosa"    |
| 11  | SepalLength | 5.4   | "setosa"    |
⋮
| 139 | SepalLength | 6.0   | "virginica" |

sort!(data, cols = [:SepalWidth])
150x5 DataFrames.DataFrame
| Row | SepalLength | SepalWidth | PetalLength | PetalWidth | Species      |
|-----|-------------|------------|-------------|------------|--------------|
| 1   | 5.0         | 2.0        | 3.5         | 1.0        | "versicolor" |
| 2   | 6.0         | 2.2        | 5.0         | 1.5        | "virginica"  |
| 3   | 6.0         | 2.2        | 4.0         | 1.0        | "versicolor" |
| 4   | 6.2         | 2.2        | 4.5         | 1.5        | "versicolor" |
| 5   | 4.5         | 2.3        | 1.3         | 0.3        | "setosa"     |
| 6   | 5.0         | 2.3        | 3.3         | 1.0        | "versicolor" |
| 7   | 5.5         | 2.3        | 4.0         | 1.3        | "versicolor" |
| 8   | 6.3         | 2.3        | 4.4         | 1.3        | "versicolor" |

sort!(data)
150x5 DataFrames.DataFrame
| Row | SepalLength | SepalWidth | PetalLength | PetalWidth | Species     |
|-----|-------------|------------|-------------|------------|-------------|
| 1   | 4.3         | 3.0        | 1.1         | 0.1        | "setosa"    |
| 2   | 4.4         | 2.9        | 1.4         | 0.2        | "setosa"    |
| 3   | 4.4         | 3.0        | 1.3         | 0.2        | "setosa"    |
| 4   | 4.4         | 3.2        | 1.3         | 0.2        | "setosa"    |
| 5   | 4.5         | 2.3        | 1.3         | 0.3        | "setosa"    |
| 6   | 4.6         | 3.1        | 1.5         | 0.2        | "setosa"    |
| 7   | 4.6         | 3.2        | 1.4         | 0.2        | "setosa"    |
| 8   | 4.6         | 3.4        | 1.4         | 0.3        | "setosa"    |
| 9   | 4.6         | 3.6        | 1.0         | 0.2        | "setosa"    |
| 10  | 4.7         | 3.2        | 1.3         | 0.2        | "setosa"    |
| 11  | 4.7         | 3.2        | 1.6         | 0.2        | "setosa"    |
⋮
| 139 | 7.1         | 3.0        | 5.9         | 2.1        | "virginica" |
| 140 | 7.2         | 3.0        | 5.8         | 1.6        | "virginica" |
| 141 | 7.2         | 3.2        | 6.0         | 1.8        | "virginica" |
| 142 | 7.2         | 3.6        | 6.1         | 2.5        | "virginica" |

sort!(data, rev=true)
150x5 DataFrames.DataFrame
| Row | SepalLength | SepalWidth | PetalLength | PetalWidth | Species     |
|-----|-------------|------------|-------------|------------|-------------|
| 1   | 7.9         | 3.8        | 6.4         | 2.0        | "virginica" |
| 2   | 7.7         | 3.8        | 6.7         | 2.2        | "virginica" |
| 3   | 7.7         | 3.0        | 6.1         | 2.3        | "virginica" |
| 4   | 7.7         | 2.8        | 6.7         | 2.0        | "virginica" |
| 5   | 7.7         | 2.6        | 6.9         | 2.3        | "virginica" |
| 6   | 7.6         | 3.0        | 6.6         | 2.1        | "virginica" |
| 7   | 7.4         | 2.8        | 6.1         | 1.9        | "virginica" |
| 8   | 7.3         | 2.9        | 6.3         | 1.8        | "virginica" |
| 9   | 7.2         | 3.6        | 6.1         | 2.5        | "virginica" |
| 10  | 7.2         | 3.2        | 6.0         | 1.8        | "virginica" |
| 11  | 7.2         | 3.0        | 5.8         | 1.6        | "virginica" |
⋮
| 139 | 4.8         | 3.0        | 1.4         | 0.1        | "setosa"    |
| 140 | 4.7         | 3.2        | 1.6         | 0.2        | "setosa"    |
| 141 | 4.7         | 3.2        | 1.3         | 0.2        | "setosa"    |

sort!(data, cols = [:Species, :SepalLength, :SepalWidth],
            rev = [true, false, false])
150x5 DataFrames.DataFrame
| Row | SepalLength | SepalWidth | PetalLength | PetalWidth | Species     |
|-----|-------------|------------|-------------|------------|-------------|
| 1   | 4.9         | 2.5        | 4.5         | 1.7        | "virginica" |
| 2   | 5.6         | 2.8        | 4.9         | 2.0        | "virginica" |
| 3   | 5.7         | 2.5        | 5.0         | 2.0        | "virginica" |
| 4   | 5.8         | 2.7        | 5.1         | 1.9        | "virginica" |
| 5   | 5.8         | 2.7        | 5.1         | 1.9        | "virginica" |
| 6   | 5.8         | 2.8        | 5.1         | 2.4        | "virginica" |
| 7   | 5.9         | 3.0        | 5.1         | 1.8        | "virginica" |

