# code for Video 4.5:
### RDatasets:

Pkg.add("RDatasets")
using RDatasets
data = dataset("datasets", "iris")

 RDatasets.packages()
33x2 DataFrames.DataFrame
| Row | Package        |
|-----|----------------|
| 1   | "COUNT"        |
| 2   | "Ecdat"        |
| 3   | "HSAUR"        |
| 4   | "HistData"     |
| 5   | "ISLR"         |
| 6   | "KMsurv"       |
| 7   | "MASS"         |
| 8   | "SASmixed"     |
| 9   | "Zelig"        |
...

julia> RDatasets.datasets("COUNT")
15x5 DataFrames.DataFrame
| Row | Package | Dataset      | Title        | Rows  | Columns |
|-----|---------|--------------|--------------|-------|---------|
| 1   | "COUNT" | "affairs"    | "affairs"    | 601   | 18      |
| 2   | "COUNT" | "azdrg112"   | "azdrg112"   | 1798  | 4       |
| 3   | "COUNT" | "azpro"      | "azpro"      | 3589  | 6       |
| 4   | "COUNT" | "badhealth"  | "badhealth"  | 1127  | 3       |
| 5   | "COUNT" | "fasttrakg"  | "fasttrakg"  | 15    | 9       |
| 6   | "COUNT" | "lbw"        | "lbw"        | 189   | 10      |
| 7   | "COUNT" | "lbwgrp"     | "lbwgrp"     | 6     | 7       |
| 8   | "COUNT" | "loomis"     | "loomis"     | 410   | 11      |
| 9   | "COUNT" | "mdvis"      | "mdvis"      | 2227  | 13      |
| 10  | "COUNT" | "medpar"     | "medpar"     | 1495  | 10      |
| 11  | "COUNT" | "rwm"        | "rwm"        | 27326 | 4       |
| 12  | "COUNT" | "rwm5yr"     | "rwm5yr"     | 19609 | 17      |
| 13  | "COUNT" | "ships"      | "ships"      | 40    | 7       |
| 14  | "COUNT" | "titanic"    | "titanic"    | 1316  | 4       |
| 15  | "COUNT" | "titanicgrp" | "titanicgrp" | 12    | 5       |

### reading in .rda files:
# R code to make iris.rda:
# iris = read.table("iris.csv", header=TRUE, sep = ",") 
# save(iris, file = "iris.rda")

using DataArrays, DataFrames
rdata = read_rda("iris.rda")
Dict{ASCIIString,Any} with 1 entry:
  "iris" => DataFrames.RVector{Any,0x13}(Any[DataFrames.RVector{Float64,0x0e}([5…

### RCall:
Pkg.add("RCall")
using RCall

# rprint:
rprint(:iris)
    Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
1            5.1         3.5          1.4         0.2     setosa
2            4.9         3.0          1.4         0.2     setosa
3            4.7         3.2          1.3         0.2     setosa
4            4.6         3.1          1.5         0.2     setosa
5            5.0         3.6          1.4         0.2     setosa
6            5.4         3.9          1.7         0.4     setosa
...
148          6.5         3.0          5.2         2.0  virginica
149          6.2         3.4          5.4         2.3  virginica
150          5.9         3.0          5.1         1.8  virginica

# global environment:
g = globalEnv
RCall.RObject{RCall.EnvSxp}
<environment: R_GlobalEnv>

julia> globalEnv[:z] = [collect(1:10)]
10-element Array{Int64,1}:
  1
  2
  3
  4
  5
  6
  7
  8
  9
 10

julia> rprint(:z)
 [1]  1  2  3  4  5  6  7  8  9 10

# R types:
RCall.CharSxp   # character string
RCall.StrSxp    # character string vector
RCall.IntSxp    # integer vector
RCall.LglSxp    # logical vector
RCall.RealSxp   # real vector
RCall.VecSxp    # list
RCall.CplxSxp   # complex vector
RCall.ClosSxp   # function closure
RCall.Sxp       # symbolic expression
RCall.NilSxp    # R's null value
RCall.RObject   # Julia wrapper for an R object

julia> RObject(10:20)
RCall.RObject{RCall.IntSxp}
 [1] 10 11 12 13 14 15 16 17 18 19 20

# reval:
julia> reval("0.1:1.0")
RCall.RObject{RCall.RealSxp}
[1] 0.1


julia> reval("'Julia is nice!'")
RCall.RObject{RCall.StrSxp}
[1] "Julia is nice!"


julia> reval("x <- list(val = 3.14)")
RCall.RObject{RCall.VecSxp}
$val
[1] 3.14

reval("plot(1:100)");                
reval("dev.off()")                  

# rcall:
x = [0:0.01:pi]
y = cos(x)
rprint(rcall(:plot, x, y, xlab = "x", ylab = "cos(x)"))
reval("dev.off()")

# rcopy:
julia>rcopy("V <- runif(100, 1, 5)")
100-element Array{Float64,1}:
 3.06808
 4.6234
 4.5018
 ...
 julia>rcopy("hist(V)")
 julia>reval("dev.off()")
 RCall.RObject{RCall.IntSxp}
null device
          1

julia> rcopy("ls()")
4-element Array{ASCIIString,1}:
 "dfls"
 "V"
 "x"
 "z"

 julia> rprint(:x)
$val
[1] 3.14


julia> rprint(:z)
 [1]  1  2  3  4  5  6  7  8  9 10

julia> rprint(:V)
  [1] 3.068083 4.623404 4.501800 2.437669 4.128898 4.861698 3.012756 4.891440
  [9] 3.350561 4.791128 2.049340 1.947154 3.770557 1.221948 1.007942 3.359711
 [17] 4.338644 2.712553 4.263887 2.711554 2.945623 1.717035 2.083531 2.262899
 [25] 1.186694 4.646604 2.155006 2.757616 1.425041 1.394638 2.476713 3.235536
 [33] 4.356797 2.773285 2.885660 2.617869 4.587544 2.731121 4.124488 4.072608
 [41] 2.442061 2.058243 1.829554 3.372161 4.750352 2.410379 4.970044 3.017737
 [49] 2.910501 2.998271 1.672793 2.152949 2.292460 1.880926 4.081929 1.008254
 [57] 3.206837 4.826909 3.350008 1.040392 2.601423 1.249924 3.210415 2.971683
 [65] 2.951253 3.452599 3.583535 1.142748 3.778362 1.699750 3.909784 4.060263
 [73] 3.054700 2.055832 3.026260 3.359913 2.419350 4.900414 2.526388 1.627130
 [81] 4.716158 2.262563 3.905570 4.149724 3.466545 1.327037 3.255447 4.308987
 [89] 3.593277 1.124265 4.675755 1.463580 1.191946 2.303455 4.885928 3.767980
 [97] 2.055996 4.927590 4.352627 4.888622

julia> rprint(:dfls)
NULL