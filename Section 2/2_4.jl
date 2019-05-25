# Code for video 2_4:

Pkg.init()
# INFO: Initializing package repository C:\Users\CVO\.julia\v0.4
# INFO: Cloning METADATA from git://github.com/JuliaLang/METADATA.jl

Pkg.add("IJulia")
# INFO: Updating cache of ZMQ...
# INFO: Installing BinDeps v0.3.19
# INFO: Installing Compat v0.7.7
# INFO: Installing Conda v0.1.8
# INFO: Installing IJulia v1.1.8
# INFO: Installing JSON v0.5.0
# INFO: Installing LibExpat v0.1.0
# INFO: Installing Nettle v0.2.0
# INFO: Installing SHA v0.1.2
# INFO: Installing URIParser v0.1.1
# INFO: Installing WinRPM v0.1.13
# INFO: Installing ZMQ v0.3.1
# INFO: Installing Zlib v0.1.12
# INFO: Building WinRPM
# INFO: Recompiling stale cache file C:\Users\CVO\.julia\lib\v0.4\Compat.ji for mo
# dule Compat.
# INFO: Recompiling stale cache file C:\Users\CVO\.julia\lib\v0.4\URIParser.ji for
#  module URIParser.

Pkg.status()
# 1 required packages:
#  - IJulia                        1.1.8
# 11 additional packages:
#  - BinDeps                       0.3.19
#  - Compat                        0.7.7
#  - Conda                         0.1.8
#  - JSON                          0.5.0
#  - LibExpat                      0.1.0
#  - Nettle                        0.2.0
#  - SHA                           0.1.2
#  - URIParser                     0.1.1
#  - WinRPM                        0.1.13
#  - ZMQ                           0.3.1
#  - Zlib                          0.1.12

using IJulia
# INFO: Recompiling stale cache file C:\Users\CVO\.julia\lib\v0.4\IJulia.ji for mo
# dule IJulia.
# INFO: Recompiling stale cache file C:\Users\CVO\.julia\lib\v0.4\ZMQ.ji for modul
# e ZMQ.
# INFO: Recompiling stale cache file C:\Users\CVO\.julia\lib\v0.4\Nettle.ji for mo
# dule Nettle.


Pkg.update()
# INFO: Updating METADATA...
# INFO: Computing changes...
# INFO: No packages to install, update or remove


Pkg.pin("HDF5", v"0.4.3")

Pkg.clone("git@github.com:EricChiang/ANN.jl.git")

Pkg.add("Winston")
using Winston

# example 1:
plot(randn(100))

# example 2:
plot(x -> x * sin(3x) * exp(-0.3x), 0, 3pi)

# example 3:
x = linspace(0, 10, 100)
g = gamma(x)
p = FramedPlot(
         title="Gamma function",
         xlabel="x-coord",
         ylabel="y-coord")
add(p, Curve(x, g, color="green"))
