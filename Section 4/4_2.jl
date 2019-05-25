# code for Video 4.2:
Pkg.add("Winston")
Pkg.add("Gadfly")
Pkg.add("PyPlot")
using Winston, Gadfly, PyPlot

fname = "iris.csv"
using DataFrames
data = readtable(fname, separator = ',')
hist(data[:sepal_length])  # (4.0:0.5:8.0,[5,27,27,30,31,18,6,6])

# drawing the histogram with Winston:
p = FramedPlot(title="Histogram sepal length", xlabel="Sepal Length", ylabel="Frequency")
add(p, Winston.Histogram(hist(data[:sepal_length])...))
display(p) # not necessary in the REPL
savefig(p, "Winston_Histogram.png")

# plotting with Gadfly:
using Gadfly
p = plot(data, x="sepal_length", y="petal_length", color="species", Geom.smooth, 
    Guide.title("Lengths (\"length_width\")"))
draw(PDF("lengths.pdf", 14cm, 10cm), p)

# drawing with PyPlot:
using PyPlot
x = data[:sepal_width]
nbins = 50
ax = axes()
h = plt[:hist](x, nbins) # Histogram
PyPlot.grid("on")
PyPlot.xlabel("sepal width")
PyPlot.ylabel("frequency")
PyPlot.title("Histogram")