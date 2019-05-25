# Code for video 3_2:

Pkg.add("DataArrays")
using DataArrays

108 + NA # NA
10.5 * NA # NA

darr = @data([7.1, 3.14, NA, 5.01, 42.8])
# 5-element DataArrays.DataArray{Float64,1}:
#   7.1
#   3.14
#    NA
#   5.01
#  42.8

sum(darr) # NA
mean(darr) # NA
sum(dropna(darr)) # 58.05
mean(dropna(darr)) # 14.5125

repl = 2.5 # 2.5
sum(convert(Array, darr, repl)) # 60.55
mean(convert(Array, darr, repl)) # 12.11

# Pooling or factors (categorical data)
pdarr = @pdata(["B", "O", "AB", "AB", "A", "O"])
# 6-element DataArrays.PooledDataArray{ASCIIString,UInt32,1}:
#  "B"
#  "O"
#  "AB"
#  "AB"
#  "A"
#  "O"
pdarr = pool(["B", "O", "AB", "AB", "A", "O"])
# same result

levels(pdarr)
# 4-element Array{ASCIIString,1}:
#  "A"
#  "AB"
#  "B"
#  "O"

Pkg.add("DataFrames")
using DataFrames

df = DataFrame()
df[:sepal_length] = @data([5.1, 4.9, 5.9])
df[:sepal_width] = @data([3.5, 3.0, 3.0])
df[:petal_length] = @data([1.4, 1.4, 5.1])
df[:petal_width] = @data([0.2, 0.2, 1.8])
df[:species] = @data(["I. setosa", "I. setosa", "I. virginica"])
show(df)
3x5 DataFrames.DataFrame
| Row | sepal_length | sepal_width | petal_length | petal_width |
|-----|--------------|-------------|--------------|-------------|
| 1   | 5.1          | 3.5         | 1.4          | 0.2         |
| 2   | 4.9          | 3.0         | 1.4          | 0.2         |
| 3   | 5.9          | 3.0         | 5.1          | 1.8         |

| Row | species        |
|-----|----------------|
| 1   | "I. setosa"    |
| 2   | "I. setosa"    |
| 3   | "I. virginica" |

names = DataFrame(ID = [1, 2, 3], Name = ["Alex Smith", "Melissa Fields", "Brad Pitt"])
3x2 DataFrames.DataFrame
| Row | ID | Name             |
|-----|----|------------------|
| 1   | 1  | "Alex Smith"     |
| 2   | 2  | "Melissa Fields" |
| 3   | 3  | "Brad Pitt"      |

names[:Name]
3-element DataArrays.DataArray{ASCIIString,1}:
 "Alex Smith"
 "Melissa Fields"
 "Brad Pitt"

blood_types = DataFrame(ID = [2, 1, 3], blood_type = ["O", "AB", "B"])
3x2 DataFrames.DataFrame
| Row | ID | blood_type |
|-----|----|------------|
| 1   | 2  | "O"        |
| 2   | 1  | "AB"       |
| 3   | 3  | "B"        |

full = join(names, blood_types, on = :ID)
3x3 DataFrames.DataFrame
| Row | ID | Name             | blood_type |
|-----|----|------------------|------------|
| 1   | 1  | "Alex Smith"     | "AB"       |
| 2   | 2  | "Melissa Fields" | "O"        |
| 3   | 3  | "Brad Pitt"      | "B"        |

rename!(blood_types, :blood_type, :BloodType)
3x2 DataFrames.DataFrame
| Row | ID | BloodType |
|-----|----|-----------|
| 1   | 2  | "O"       |
| 2   | 1  | "AB"      |
| 3   | 3  | "B"       |

fname = "iris.csv"
data = readtable(fname, separator = ',')
150x5 DataFrames.DataFrame
| Row | sepal_length | sepal_width | petal_length | petal_width |
|-----|--------------|-------------|--------------|-------------|
| 1   | 5.1          | 3.5         | 1.4          | 0.2         |
| 2   | 4.9          | 3.0         | 1.4          | 0.2         |
| 3   | 4.7          | 3.2         | 1.3          | 0.2         |
| 4   | 4.6          | 3.1         | 1.5          | 0.2         |
| 5   | 5.0          | 3.6         | 1.4          | 0.2         |
...
| Row | species        |
|-----|----------------|
| 1   | "I. setosa"    |
| 2   | "I. setosa"    |
| 3   | "I. setosa"    |
| 4   | "I. setosa"    |
| 5   | "I. setosa"    |
typeof(data) # DataFrames.DataFrame
size(data) # (150, 5)

show(data[2])
# [3.5,3.0,3.2,3.1,3.6,3.9,3.4,3.4,2.9,3.1,3.7,3.4,3.0,3.0,4.0,4.4,3.9,3.5,3.8,3.8,
# 3.4,3.7,3.6,3.3,3.4,3.0,3.4,3.5,3.4,3.2,3.1,3.4,4.1,4.2,3.1,3.2,3.5,3.1,3.0,3.4,3
# .5,2.3,3.2,3.5,3.8,3.0,3.8,3.2,3.7,3.3,3.2,3.2,3.1,2.3,2.8,2.8,3.3,2.4,2.9,2.7,2.
# 0,3.0,2.2,2.9,2.9,3.1,3.0,2.7,2.2,2.5,3.2,2.8,2.5,2.8,2.9,3.0,2.8,3.0,2.9,2.6,2.4
# ,2.4,2.7,2.7,3.0,3.4,3.1,2.3,3.0,2.5,2.6,3.0,2.6,2.3,2.7,3.0,2.9,2.9,2.5,2.8,3.3,
# 2.7,3.0,2.9,3.0,3.0,2.5,2.9,2.5,3.6,3.2,2.7,3.0,2.5,2.8,3.2,3.0,3.8,2.6,2.2,3.2,2
# .8,2.8,2.7,3.3,3.2,2.8,3.0,2.8,3.0,2.8,3.8,2.8,2.8,2.6,3.0,3.4,3.1,3.0,3.1,3.1,3.
# 1,2.7,3.2,3.3,3.0,2.5,3.0,3.4,3.0]
show(data[:sepal_width])
# [3.5,3.0,3.2,3.1,3.6,3.9,3.4,3.4,2.9,3.1,3.7,3.4,3.0,3.0,4.0,4.4,3.9,3.5,3.8,3.8,
# 3.4,3.7,3.6,3.3,3.4,3.0,3.4,3.5,3.4,3.2,3.1,3.4,4.1,4.2,3.1,3.2,3.5,3.1,3.0,3.4,3
# .5,2.3,3.2,3.5,3.8,3.0,3.8,3.2,3.7,3.3,3.2,3.2,3.1,2.3,2.8,2.8,3.3,2.4,2.9,2.7,2.
# 0,3.0,2.2,2.9,2.9,3.1,3.0,2.7,2.2,2.5,3.2,2.8,2.5,2.8,2.9,3.0,2.8,3.0,2.9,2.6,2.4
# ,2.4,2.7,2.7,3.0,3.4,3.1,2.3,3.0,2.5,2.6,3.0,2.6,2.3,2.7,3.0,2.9,2.9,2.5,2.8,3.3,
# 2.7,3.0,2.9,3.0,3.0,2.5,2.9,2.5,3.6,3.2,2.7,3.0,2.5,2.8,3.2,3.0,3.8,2.6,2.2,3.2,2
# .8,2.8,2.7,3.3,3.2,2.8,3.0,2.8,3.0,2.8,3.8,2.8,2.8,2.6,3.0,3.4,3.1,3.0,3.1,3.1,3.
# 1,2.7,3.2,3.3,3.0,2.5,3.0,3.4,3.0]

data[2:3, :]
# 2x5 DataFrames.DataFrame
# | Row | sepal_length | sepal_width | petal_length | petal_width | species     |
# |-----|--------------|-------------|--------------|-------------|-------------|
# | 1   | 4.9          | 3.0         | 1.4          | 0.2         | "I. setosa" |
# | 2   | 4.7          | 3.2         | 1.3          | 0.2         | "I. setosa" |

julia> data[145:150, [:petal_length, :species]]
6x2 DataFrames.DataFrame
# | Row | petal_length | species        |
# |-----|--------------|----------------|
# | 1   | 5.7          | "I. virginica" |
# | 2   | 5.2          | "I. virginica" |
# | 3   | 5.0          | "I. virginica" |
# | 4   | 5.2          | "I. virginica" |
# | 5   | 5.4          | "I. virginica" |
# | 6   | 5.1          | "I. virginica" |

julia> names(data)
5-element Array{Symbol,1}:
 :sepal_length
 :sepal_width
 :petal_length
 :petal_width
 :species

julia> head(data)
6x5 DataFrames.DataFrame
| Row | sepal_length | sepal_width | petal_length | petal_width | species     |
|-----|--------------|-------------|--------------|-------------|-------------|
| 1   | 5.1          | 3.5         | 1.4          | 0.2         | "I. setosa" |
| 2   | 4.9          | 3.0         | 1.4          | 0.2         | "I. setosa" |
| 3   | 4.7          | 3.2         | 1.3          | 0.2         | "I. setosa" |
| 4   | 4.6          | 3.1         | 1.5          | 0.2         | "I. setosa" |
| 5   | 5.0          | 3.6         | 1.4          | 0.2         | "I. setosa" |
| 6   | 5.4          | 3.9         | 1.7          | 0.4         | "I. setosa" |

julia> tail(data)
6x5 DataFrames.DataFrame
| Row | sepal_length | sepal_width | petal_length | petal_width |
|-----|--------------|-------------|--------------|-------------|
| 1   | 6.7          | 3.3         | 5.7          | 2.5         |
| 2   | 6.7          | 3.0         | 5.2          | 2.3         |
| 3   | 6.3          | 2.5         | 5.0          | 1.9         |
| 4   | 6.5          | 3.0         | 5.2          | 2.0         |
| 5   | 6.2          | 3.4         | 5.4          | 2.3         |
| 6   | 5.9          | 3.0         | 5.1          | 1.8         |

| Row | species        |
|-----|----------------|
| 1   | "I. virginica" |
| 2   | "I. virginica" |
| 3   | "I. virginica" |
| 4   | "I. virginica" |
| 5   | "I. virginica" |
| 6   | "I. virginica" |

eltypes(data)
5-element Array{Type{T},1}:
 Float64
 Float64
 Float64
 Float64
 UTF8String

fname = "iris.dat"
writetable(fname, data, separator = '/', header = false)

whos()
    data   9660 bytes  150x5 DataFrames.DataFrame : 150x5 …
pool!(data, [:species])
whos()
    data   5744 bytes  150x5 DataFrames.DataFrame : 150x5 …
