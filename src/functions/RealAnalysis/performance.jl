"""
Tim Holy 
High performance computing 1

"""

value = add2(rand(5, 5))

matrix = add2([rand(5, 5), rand(5, 5)])
value2=add2(matrix)
add2([1.0, 2.0])
methods(add2)
"""
doing different things when passed different types of input 

"""

m = @which add2(arr = [1.0, 2.0])

m

"""package 

method analysis
there's a function in it  called method instance (using MethodAnalysis)
"""
using MethodAnalysis
#pipe , tim ,Vector{Core.MethodInstance}
methodinstances(@which add2([1, 2]))
"""
 MethodInstance for add2(::Matrix{Float64})
 MethodInstance for add2(::Vector{Matrix{Float64}})
 MethodInstance for add2(::Vector{Int64})
hypothesize: these method instances (of the method)
there's only one method 
but julia itself would generate multiple instances
(of that method) - for handling different argument types
we get two MethodInstances from a single Method
form of specialization 
julia does Automatically 

you can 
can specialize methods 
 can create methods 
 append(me:update) methods 
 specific types 
 have multiple methods  (for a single function)

 automatic specialization
 generatie by the compiler  - compiler specialization 

"""
"""
passing a novel Type

let's make another , indexable type 

    we should generate another method instance

julia when adds an int & Float64 
it will return a Float64
"""

dataType1 = typeof(add2((1, 2, 0)))
dataType2 = typeof(add2((1, 2.0)))

"""
let's call this MethodInstances again 
"""
#Base.method_instances()
methodinstances()

@code