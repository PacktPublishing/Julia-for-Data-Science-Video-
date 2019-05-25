# Code for video 2_3:

Pkg.add("Winston")
Pkg.add("Gadfly")

import Winston, Gadfly

Winston.plot(rand(4))

Gadfly.plot(x=collect(1:10), y=rand(10))

###

using Winston

plot(rand(4))

using Gadfly
#WARNING: using Gadfly.plot in module Main conflicts with an existing identifier.

Gadfly.plot(x=collect(1:10), y=rand(10))

###
whos()
                          # Base  23586 KB     Module : Base
                          # Core   2936 KB     Module : Core
                          # Main  26292 KB     Module : Main
                          #  ans      0 bytes  Void : nothing


e
# e = 2.7182818284590...

pi
# π = 3.1415926535897...

ans
# π = 3.1415926535897...

a = 10 # 10

whos()
                          # Base  23713 KB     Module : Base
                          # Core   2936 KB     Module : Core
                          # Main  26366 KB     Module : Main
                          #    a      8 bytes  Int64 : 10
                          #  ans      8 bytes  Int64 : 10


include("iris_tools.jl") # IrisTools

using IrisTools

whos()
                     #      Base  23787 KB     Module : Base
                     #      Core   2939 KB     Module : Core
                     # IrisTools     18 KB     Module : IrisTools
                     #      Main  26459 KB     Module : Main
                     #         a      8 bytes  Int64 : 10
                     #       ans      0 bytes  Void : nothing


LOAD_PATH
# 2-element Array{ByteString,1}:
#  "c:\\Julia\\local\\share\\julia\\site\\v0.4"
#  "c:\\Julia\\share\\julia\\site\\v0.4"

push!(LOAD_PATH, "new/path/to/search")