"""P.1.Tricks & Tips in Numerical Computing  
JuliaCon 2018 - M\cr|NA
Credits: Professor Mr. Nick Higham @nhigham 
# today the lecturing Professor @nhigham of Numerical Computing 
University of Manchesterh

http://maths.manchester.ac.uk/~higham

nickhigham.wordpress.com 



"""

"""P.2.Introduction 

1. Exploiting complex Artihmetic 
2. Understanding multivalued functions 
3. Exploiting associativity of matrix products 
4. Randomization to avoid pathological cases 
5. Making the most of Low precision arithmetic 

http://bit.ly/tricks18  
#redirects to a seemingly empty site 

A trick used threetimes becomes a standard technique  -George Polya -Hungarian mathematician [ETH Zürich] (Palo Alto), CA, U.S.
#--- 


"""
f'(x) = (f(x + h) - f(x)) / h


"""p.3.Differentiation With(out) a Difference 

≈ abs(f(x))

Error O(h) (especialy)

My Note:
this differential function is  #reminder: do a differential repo #TODO
"""
function h(u, f(x), f_double_prime(x))
    #pythagorean theorem 
    return h ≈ sqrt(u * abs(f(x) / f_double_prime(x)))
end

# Q,which order of complexity is this algorithm?

a = sqrt(x);
b = x_minus_one(x) = x^-1; #  Matrix{Float64} <: DenseMatrix{Float64} <: AbstractMatrix{Float64} <: Any
m = 10;
n = 10;
v = rand(m, n) # sqrt only accepted a Squared matrix 
sqrt(v) ≈ x_minus_one(v) #false they are not equal!!!!!!!!! # not even a false # Q.what is ϵ here (I have never framed ϵ) just working with the Maestro for not 
#once matrix is rectangular i.e. 10x10 
sqrt(v) == x_minus_one(v)
#for all item vij
sumError = nothing;
error = zeros(m, n) #nothing ;

rowErrors = nothing;
colErrors = nothing;
tmp = nothing;

k = 1
for i in enumerate(m) #rows 
    #tmp = sum(v, 1) ; #rowErrors[]
    # rowErrors = [rowErrors,tmp]
    #print(tmp)
    for j in enumerate(n) # cols #entering j's context  
        #tmp = sum(v, 2)
        #   colErrors = [colErrors, tmp] # col error Array 
        #  print(tmp)
        error[m, k] = abs(sqrt(v[m, n]) - x_minus_one(v[m, n]))
        k += 1
        #sumError += error #sum error of each time 
        #REVEALED: hidden Issue 
        #DimensionMismatch (matrix is not square dimensions are 10x1 )# either sqrt or x_minus_one requires rectangular dimensions 
    end
end
#mean = ∑
print(error)
#print(colErrors)
#print(rowErrors)
using BenchmarkTools
rowErrors = cumsum(v, dims = 1)
#=10×10 Matrix{Float64}:
 0.755532  0.590352  0.111428  0.887575  0.0507037  0.903207  0.358227  0.186171  0.761759  0.883808
 1.10254   0.596795  0.428979  0.958866  0.156567   1.09377   0.999251  0.762358  1.12141   1.36038
 ⋮                                                  ⋮
 4.3395    3.67298   3.29483   6.04047   3.35655    4.74542   2.36259   4.56519   3.20877   5.0396
 4.87931   4.34269   4.2687    **6.44228**   3.38897    5.0163    *3.0492*    4.72759   4.09149   5.76818
 largest error (column independent) col 4:  6.44228 (>5.76818 last cumuli)
 min error            col(7): *3.0492*
 error range = [*3.0492*, 6.44228]
=#
6.44228 - 3.0492
colErrors = cumsum(v, dims = 2)

_minCol = minimum(colErrors)
_maxCol = maximum(colErrors)
colDispersion = _maxCol - _minCol

minimum(A[:, 4])
#=
 0.755532   1.34588   1.45731   2.34489   2.39559   3.2988   3.65703  3.8432   4.60496  **5.48876**
 0.347007   0.35345   0.671001  0.742292  0.848155  1.03871  1.67974  2.25592  2.61558  3.09215
 ⋮                                                  ⋮
 0.0863792  0.132913  0.530735  1.41574   1.61419   1.62391  2.04341  2.63593  2.69061  3.63327
 0.539811   1.20953   2.18339   2.5852    2.61763   2.88851  3.57511  3.73751  4.62024  5.34882

 Max:largest (row independent) error row(1) 10,1: 5.48876
 Min: (row independent) error 
 min ( 0.0863792) error  0.0863792
 =#

@btime rowErrormat = cumsum(error, dims = 1) 143.349 ns (1allocation:896bytes)
_maxRow = maximum(rowErrormat)
_minRow = minimum(rowErrormat)
rowDispersion = _maxRow - _minRow

colDispersion < rowDispersion # false positive 
colDispersion > rowDispersion  #true positive 
colDispersion > rowDispersion === true #it should be true,the only statement under question# it displays false!
ratio = max(colDispersion, rowDispersion) / min(colDispersion, rowDispersion)
ratio = rowDispersion / colDispersion

xor(colDispersion < rowDispersion, colDispersion > rowDispersion) #always true [true,false] 
and= &
and(colDispersion < rowDispersion, colDispersion > rowDispersion) # hiccup with and # always false 


#=
 0.0       0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
 0.0       0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
 ⋮                             ⋮
 0.0       0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
 0.518967  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0

 only 1 error created  a big problem (of not a Neglegible size)
=#
colErrormat = cumsum(error, dims = 2)
#=
 0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0
 0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0
 ⋮                                                 ⋮
 0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0
 0.518967  0.518967  0.518967  0.518967  0.518967  0.518967  0.518967  0.518967  0.518967  0.518967

 #
=#

