# Code for Video 1.7: 

[1, 2, 3]
# 3-element Array{Int64,1}:
#  1
#  2
#  3
Array{Int64, 1} == Vector{Int64} # true

[1 2 3]
# 1x3 Array{Int64,2}:
#  1  2  3
Array{Int64, 2} == Matrix{Int64} # true

ma = [1 2 3; 4 5 6]
# 2x3 Array{Int64,2}:
#  1  2  3
#  4  5  6

size(ma, 1) # 2
size(ma, 2) # 3
ndims(ma) # 2
eltype(ma) # Int64

rand(3, 3)
# 3x3 Array{Float64,2}:
#  0.768931   0.504026  0.272933
#  0.0635822  0.160217  0.0623945
#  0.433924   0.64907   0.920496

rand(10:20, 5, 5)
# 5x5 Array{Int64,2}:
#  11  10  19  16  10
#  19  14  18  20  11
#  14  18  16  18  19
#  18  16  11  11  14
#  10  10  18  11  19

eye(3)
# 3x3 Array{Float64,2}:
#  1.0  0.0  0.0
#  0.0  1.0  0.0
#  0.0  0.0  1.0

plus = [n + m for n in 1:4, m in 1:4]
# 4x4 Array{Int64,2}:
#  2  3  4  5
#  3  4  5  6
#  4  5  6  7
#  5  6  7  8

ma = [1 2 3; 4 5 6; 7 8 9]
# 3x3 Array{Int64,2}:
#  1  2  3
#  4  5  6
#  7  8  9

ma[1, 1] # 1
ma[2, 3] # 6
ma[2, :] # 1x3 Array{Int64,2}: 4  5  6
ma[:, 3] # 3-element Array{Int64,1}:
 # 3
 # 6
 # 9

ma[1:2, 2:3]
# 2x2 Array{Int64,2}:
#  2  3
#  5  6

ma[2:end, 2:end]
# 2x2 Array{Int64,2}:
#  5  6
#  8  9

ma[2, 2] = 0 # 0
# ma
# 3x3 Array{Int64,2}:
#  1  2  3
#  4  0  6
#  7  8  9

ma[2:3, 3] = -1 # -1
# ma
# 3x3 Array{Int64,2}:
#  1  2   3
#  4  0  -1
#  7  8  -1

a = [1 2; 3 4]
# 2x2 Array{Int64,2}:
#  1  2
#  3  4

b = [5 6; 7 8]
# 2x2 Array{Int64,2}:
#  5  6
#  7  8

c = [a b]
# 2x4 Array{Int64,2}:
#  1  2  5  6
#  3  4  7  8

c = hcat(a, b)
# 2x4 Array{Int64,2}:
#  1  2  5  6
#  3  4  7  8

c = [a; b]
# 4x2 Array{Int64,2}:
#  1  2
#  3  4
#  5  6
#  7  8

c = vcat(a, b)
# 4x2 Array{Int64,2}:
#  1  2
#  3  4
#  5  6
#  7  8

reshape(a, 1, 4)
# 1x4 Array{Int64,2}:
#  1  3  2  4

a
# 2x2 Array{Int64,2}:
#  1  2
#  3  4

b
# 2x2 Array{Int64,2}:
#  5  6
#  7  8

a + b
# 2x2 Array{Int64,2}:
#   6   8
#  10  12

a * b
# 2x2 Array{Int64,2}:
#  19  22
#  43  50

a .* b
# 2x2 Array{Int64,2}:
#   5  12
#  21  32

a
# 2x2 Array{Int64,2}:
#  1  2
#  3  4

a'
# 2x2 Array{Int64,2}:
#  1  3
#  2  4

inv(a)
# 2x2 Array{Float64,2}:
#  -2.0   1.0
#   1.5  -0.5

a * inv(a)
# 2x2 Array{Float64,2}:
#  1.0          0.0
#  8.88178e-16  1.0

a - 2
# 2x2 Array{Int64,2}:
#  -1  0
#   1  2

a * 5
# 2x2 Array{Int64,2}:
#   5  10
#  15  20