"""crdits t go
tim ho; on youtuv
"""
add2(x) = x[1] + x[2]
add2([1.0, 2.0])
add2([1, 2])


add2((1, 2.0))

methods(add2)
m = @which add2([1, 2])

using MethodAnalysis

methodinstances(m)

# For DataType ( int or  float) #- its just a 2 ways of "mthod specization "

@code lowered add2([1, 2]) #- represents the method, not a particular mrthodinstance
