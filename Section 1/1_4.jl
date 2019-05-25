# Code for Video 1.4: Controlling the flow

a = b = c = 4
n, m = 1, 2

area = (r = 3; π*r^2) # 28.274333882308138

x = begin
           a = 2
           b = 3
           a + b
    end

body_temp = 38.5 # 38.5
if body_temp > 38
  println("this person has fever")
elseif 35 < body_temp <= 37
  println("this person has normal temperature")
else
  println("this person has hypothermia")
end
# this person has fever

n = 10; m = 15
max = if n > m   n
      else       m
      end
# max == 15
max = n > m ? n : m  # 15

year = 2016
while year <= 2050
    println("increase year")
    year += 1
end

while year <= 2050
    println("increase year")
    year += 1
    if year == 2047
        println("reached 2047")
        break
    end
end

# while true
#     println("I do not stop!")
# end

blood_groups = ["A", "B", "AB", "O"]
# 4-element Array{ASCIIString,1}:
#  "A"
#  "B"
#  "AB"
#  "O"
for blg in blood_groups
    print("$blg / ")
end
# A / B / AB / O /
for (ix, blg) in enumerate(blood_groups)
    println("Blood-group no. $ix is $blg")
end
# Blood-group no. 1 is A
# Blood-group no. 2 is B
# Blood-group no. 3 is AB
# Blood-group no. 4 is O

for i in 1:5
    print("$i -")
end
# 1 - 2 - 3 - 4 - 5 -

# open("test.txt")
# ERROR: SystemError: opening file test.txt: No such file or directory
#  in open at iostream.jl:90
#  in open at iostream.jl:99
println("")

try
    open("test.txt")
catch ex
    showerror(STDOUT, ex)
    println("")
end
println("I recovered from the exception")

blood_groups = ["A", "B", "AB", "O"]
code = "X"
if code in blood_groups
   println("we have a supply of this blood")
else
#   throw(DomainError())
end
print("After error: not reached")
# ERROR: DomainError:
println("")

if code in blood_groups
   println("we have a supply of this blood")
else
#   error("blood group unknown!")
end
print("After error: not reached")
# ERROR: blood group unknown!
#  in error at error.jl:21
println("")

if code in blood_groups
   println("we have a supply of this blood")
else
   warn("blood group unknown!")
end
print("After error: reached!")

z = @async 26 * 78
println("In the meantime, I calculate other things!")
println(consume(z)) # 2028  