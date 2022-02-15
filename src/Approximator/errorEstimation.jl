#=P.1.Tricks & Tips in Numerical Computing  
JuliaCon 2018 - M\cr|NA
Credits: Professor Mr. Nick Higham @nhigham 
# today the lecturing Professor @nhigham of Numerical Computing 
University of Manchesterh

http://maths.manchester.ac.uk/~higham

nickhigham.wordpress.com 



=#

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
x = 10^5

#f(x) =
#f = f(x)

#to view only (secant method )
# f'(x) = (f(x + h) - f(x)) / h


#=p.3.Differentiation With(out) a Difference 

≈ abs(f(x))

Error O(h) (especialy)

Note:
this is a differential function
=#
range = 1:10
size(range)[1]

#=
calculates b on different subset of ranges (for each n)
```inputs:

a: initial position 
n: steps required (see: nLookup)
h: stepsize 
```

Example |--- |...|--- |
        a1  b1   bn-1  bn
say a = 1, b3 =4 , & h 1 (pre-defined constant) , let ni be n1, n2,...ni =s.t.= 1,2,3,...  for i = 1,2,3,.. , i∈ N+ Positive Natural numbers,
then: # for i =1,2,3,..
b[i] = a*(n[i]*h)
e.g. 

b[1] = a[1] + (n[1] * h) = 1 + (1 * 1 )  = 2  #infer: sub-range [1,2]  (b=4 !isa b[1]=2  (now a[2] = b[1]=2 for next op ) a starts at 2 
b[2] = a[2] + (n[2] * h) = 2 + (2 * 1)  =  4  #infer: sub-rage [2,4]   (b4=4 isa b[2]=4 HALT!)
b is reached , with 2 steps 
Recursing back from  b[i]= b = 4 : if a[1] !=1 yet (2 steps )   
if b 
b[4]

=#  
using Test,  BenchmarkTools, DataStructures



"""
Returns the number of steps 

    Example:   
  
    for range [a= 1 , b=3]
    size of range = b - a = 3 - 1 = 2  range length 
    if h is 1 then stepsrequired = size(range) * h = 2 * 1 = 2 steps  
"""
function nLookup(a, b, h) 

    _size = nothing  # b -a    
    _size = b - a # range length   
    stepsrequired = ceil( _size * h )  #steps #whatever h is , it returns ceiled whole number 
    return stepsrequired
end 
    """
    f_prime 
  
    ```inputs
    f: the function operator 
    x: the single variable
    a: lower range bound 
    b: upper range bound 
    h: the stepsize : initialized to 1
    ```
    
    example: 
  
   for range [a= 1 , b=3]
    size of range = b - a = 3 - 1 = 2  range length 
    if h is 1 then stepsrequired = size(range) * h = 2 * 1 = 2 steps  
    a , a+h, a+2h, ...,b
    a=1 , 1+1, 1+1+1 = b
    """
function f_prime!(f,x,a,b,;h=1)

    result =nothing
    n = nLookup(a,b,h) #returns `number of steps` required to do  n  :: # is it always a whole number #expectation : whole number 
    sum = 0
    if i > n  && i < 1 #Upon fallback 
        #return result 

    else #otherwise # do the work 
        #which variables are changing 
        #nth  step: 

        
      #  f_prime!()

    end

    if b >= a 
        result = f(x=b) - f(x=a) / (b - a) 
        

    elseif b <= a 
        result = f(x = a) - f(x=b) / (a - b)
    
    return result

end 

function f_double_prime(f, x, a = 1, b = 10)
    
    for i in enumerate(2)

    f = f_prime!(f, x, a, b) #f(b) - f(a) 
    δfδx = deepcopy(f)
end 

function h(u, x, f, f_double_prime) # f(x) is not a valid function Argument #Solution: remove arguments 
    #pythagorean theorem 
    return h ≈ sqrt(u * abs(f(x) / f_double_prime(x)))
end

# Q,which order of complexity is this algorithm?
#=
function (model=sqrt(v[m, n]), approx=x_minus_one(v[m, n])
    for i in enumerate(m) #rows 
        #tmp = sum(v, 1) ; #rowErrors[]
        # rowErrors = [rowErrors,tmp]
        #print(tmp)
        for j in enumerate(n) # cols #entering j's context  

            error[m, k] = abs(sqrt(v[m, n]) - x_minus_one(v[m, n]))
            k += 1

            #REVEALED: Sqare Array is a must
            #DimensionMismatch (matrix is not square dimensions are 10x1 )# either sqrt or x_minus_one requires rectangular dimensions 
        end
    end
end
=#

#Example: the square-root sqrt: most irrational rational 

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
function dispersion()
colDispersion = _maxCol - _minCol

end 

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
size(v)
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
#---below is an overkill
xor(colDispersion < rowDispersion, colDispersion > rowDispersion) #always true [true,false] 
and = &
and(colDispersion < rowDispersion, colDispersion > rowDispersion) # hiccup with and # always false 


#= there is an error in estimating the sqrt function, perturbuted into 
 0.0       0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
 0.0       0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
 ⋮                             ⋮
 0.0       0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
 0.518967  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0

 only 1 error created  a big problem (of not a Neglegible size)
=#
colErrormat = cumsum(error, dims = 2)
end
end 
#=
 0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0
 0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0
 ⋮                                                 ⋮
 0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0       0.0
 0.518967  0.518967  0.518967  0.518967  0.518967  0.518967  0.518967  0.518967  0.518967  0.518967
  
 #
=#

#=
for f(x) = exp(x) with x = 1
Optimal 

h≈ (u*abs(f(x)/f''(x)))^1/2
Prof. Higham:
and you could see the error 

"error touches the red line then error stars to blow up"
me: approx. at (10^8) - 10^7 
this is a well known phenomenon - v-shaped curve 

the errors in the evaluation starting to 
Dominate the truncation errors 
mathematically going to zero 

what is the point where moment is reached 
approx. the value shown here
-unit round-off: 16 *mod f(x) / mod (f''(x))

you're limited to how much accuracy you're going to get 

Q.can we do better? 
=#
