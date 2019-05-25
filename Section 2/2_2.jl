# Code for Video 2.2: 

fac(n) = (n <= 1)? 1 : n * fac(n - 1)

n = 20
@printf("The %d-th Factorial number is %d", n, fac(n))
println("")
print("The calculation took")
@time fac(n)

# The 20-th Factorial number is 2432902008176640000
# The calculation took  0.000006 seconds (149 allocations: 10.167 KB)

# C:\Users\CVO>julia --lisp
# ;  _
# ; |_ _ _ |_ _ |  . _ _
# ; | (-||||_(_)|__|_)|_)
# ;-------------------|------

# > (* 3 45)
# 135

# >

 n = 108 # 108
 n # 108
 :n # :n

 typeof(:n) # Symbol

 e = :(a + b) # :(a + b)

 typeof(e) # Expr

 a = 2 # 2
 b = 3 # 3
 eval(e) # 5

 fieldnames(e)
# 3-element Array{Symbol,1}:
#  :head
#  :args
#  :typ

 e.args
# 3-element Array{Any,1}:
#  :+
#  :a
#  :b

 c = quote
           a = 2
           b = 3
           a + b
       end
# quote  # none, line 2:
#     a = 2 # none, line 3:
#     b = 3 # none, line 4:
#     a + b
# end

 eval(c) # 5

 typeof(c) # Expr

 c = quote
           a = 2
           b = 3
           $a + $b
       end
# quote  # none, line 2:
#     a = 2 # none, line 3:
#     b = 3 # none, line 4:
#     2 + 3
# end

macro timeit(ex)
    quote
        local t0 = time()
        local val = $(esc(ex))
        local t1 = time()
        println("elapsed time in seconds: ")
        @printf "%.3f\n" t1 - t0
        val
    end
end

@timeit fac(20) 
# elapsed time in seconds:
# 0.002
# 2432902008176640000

macro repeat(n, body)
    quote
        for i = 1:$(esc(n))
            $(esc(body))
        end
    end
end

@repeat(7, println("Hi Julia"))
# Hi Julia
# Hi Julia
# Hi Julia
# Hi Julia
# Hi Julia
# Hi Julia
# Hi Julia

macroexpand(:@repeat(7, println("Hi Julia")))
# quote  # none, line 3:
#     for #57#i = 1:7 # none, line 4:
#         println("Hi Julia")
#     end
# end

@repeat(3, for i in 1:5 println(i*i) end)
# 1
# 4
# 9
# 16
# 25
# 1
# 4
# 9
# 16
# 25
# 1
# 4
# 9
# 16
# 25

macroexpand(:@repeat(3, for i in 1:5 println(i*i) end))
# quote  # none, line 3:
#     for #29#i = 1:3 # none, line 4:
#         for i = 1:5 # none, line 1:
#             println(i * i)
#         end
#     end
# end

# @assert  108 = (2 + 105)
# ERROR: syntax: invalid assignment location "108"

# @assert  108 == (2 + 105)
# ERROR: AssertionError: 108 == 2 + 105

 using Base.Test

# @test_approx_eq 2 2.1
# ERROR: assertion failed: |2 - 2.1| <= 4.440892098500626e-12
#   2 = 2
#   2.1 = 2.1
#   difference = 0.10000000000000009 > 4.440892098500626e-12
#  in error at error.jl:22

# @test_approx_eq_eps 2 2.1 0.1
# ERROR: assertion failed: |2 - 2.1| <= 0.1
#   2 = 2
#   2.1 = 2.1
#   difference = 0.10000000000000009 > 0.1
#  in error at error.jl:22

@test_approx_eq_eps 2 2.1 0.15

@windows ? println("I am on Windows") : println("No Windows here")
# I am on Windows

@which (1 +2im) * (2 - 8im)
# *(z::Complex{T<:Real}, w::Complex{T<:Real}) at complex.jl:113




