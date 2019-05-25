# code for Video 4.3:
fname = "iris.csv"
using DataFrames
data = readtable(fname, separator = ',')

### scatter plots:
using Gadfly
set_default_plot_size(15cm, 15cm/golden)
p = plot(data, x="sepal_width", y="sepal_length", Geom.point,
         Guide.xlabel("Sepal Width"),  
         Guide.ylabel("Sepal Length"), 
         Guide.title("Scatterplot of Sepal Length versus Width") )
draw(PDF("Length_versus_Width.pdf", 14cm, 10cm), p)

cor(data[:sepal_width], data[:sepal_length]) # -0.10936924995064931

# add colour dimension:
p = plot(data, x="sepal_width", y="sepal_length", color="species",
         Guide.xlabel("Sepal Width"),  
         Guide.ylabel("Sepal Length"), 
         Guide.title("Scatterplot of Sepal Length versus Width") )
draw(PDF("Length_versus_Width_Color.pdf", 14cm, 10cm), p)

cor(data[1:50, :sepal_width], data[1:50, :sepal_length]) # 0.7467803732639265
cor(data[51:100, :sepal_width], data[51:100, :sepal_length]) # 0.5259107172828241
cor(data[101:150, :sepal_width], data[101:150, :sepal_length]) # 0.4572278163941129

### linear regression:
x = convert(Array, data[1:50, :sepal_width])
y = convert(Array, data[1:50, :sepal_length])
a, b = linreg(x, y)
# 2-element Array{Float64,1}:
#  2.64466
#  0.690854
# sepal_length = 2.64466 + 0.690854 * sepal_width

# adding a linear regression fit to the plot:
using Winston
pl = plot(data[1:50, :sepal_width], data[1:50, :sepal_length], "g^") # use the symbol for green triangles
s = Slope(0.690854, (0, 2.64466), colorant="blue", linekind="dashed") # this is the linear fit
add(pl, s)
display(pl) # not necessary in the REPL
savefig(pl, "Winston_Linreg.png")

using PyPlot
x = convert(Array, data[1:50, :petal_width])
y = convert(Array, data[1:50, :petal_length])
a, b = linreg(x, y)
# 2-element Array{Float64,1}:
#  1.34304
#  0.495739
cor(x, y) # correlation = 0.30630821115803575 
plot(x, y, "o")
plot(x, [a+b*i for i in x])

### histogram:
Gadfly.plot(data, x="petal_width", Geom.histogram(bincount=30))

### boxplot with Gadfly:
Gadfly.plot(data, x = "species", y = "sepal_length", Geom.boxplot)