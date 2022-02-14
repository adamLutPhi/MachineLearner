#=
∈
Low Rank Updates of A \in R^nxn

Sherman-Morrison formula 

If x, y ∈ R^n & 1+y^T A^-1 x is nonzero then 

TODO: check for  (A+x*y') != 0 , A != 0 
=#

using LinearAlgebra
# as an expression
lhs = :((A + x * y')^-1)

rhs = :((A^-1) - [(A^-1 * (x * y') * A^-1) / (1 + y' * A^-1 * x)])
#Or Generic function 

A = rand(10, 10)
x = rand(10, 10)
y = rand(10, 10)
I = ones(10, 10)
Lhs(A = A, x = x, y = y) = ((A + x * y')^-1)

Rhs(A = A, x = x, y = y) = (A^-1) - [(A^-1 * (x * y') * A^-1) / (I + y' * A^-1 * x')]

Rhs(A, x, y) ≈ Lhs(A, x, y)

y' * A^1 * x' ≈ y' * A^1 * x # beware while using transpose ' is false # false positive

numerator = (A^-1 * (x * y') * A^-1)
denominator = I + y' * A^1 * x'

numeratorSize = size(numerator)
denominatorSize = size(denominator)
Div = numerator / denominator # ok 

Mul = x * y'
(A + Mul)^-1

(A + Mul)^-1 ≈ A^-1 - Div # final answer  #false (negative)
denominatorSize = size(I + y' * A^1 * x') #correct 
numeratorSize = size((A^-1 * (x * y') * A^-1)) # correct 

#--- Sherman-Morrison-Woodbury formula 
#= Sherman-Morrison-Woodbury formula 

if U,V ∈ R^nxp & Ip + V' A-1*U is non singular 
=#
#=  warning U is already Used in another context in another file in different 'context'  <--- TODO a need for a context (logic ) =#

u = rand(10, 10)
v = rand(10, 10)
A + u * v
#=10×10 Matrix{Float64}:
 2.71503  3.87771  2.80252  …  3.10273  3.43842
 2.69587  2.54099  1.62384     1.73684  2.25296
 ⋮                          ⋱
 3.05006  3.93606  2.79434     2.61207  4.02894
 3.50059  3.93851  2.27809     2.68894  2.88773
 =#
A + u * v'
#=
10×10 Matrix{Float64}:
 2.12618  3.19865  2.75244  3.72066  …  2.21105  3.81644  2.81843  3.19734   
 1.96465  1.76703  1.64296  3.0106      1.73512  2.2817   1.92534  2.07472
 ⋮                                   ⋱
 2.69908  3.21591  3.02653  4.24413     2.68673  4.60944  2.40217  3.60195   
 3.35323  3.15063  2.7179   3.24876     1.50348  3.66244  2.49389  2.75832 
 =#


left = v' * A^-1
#=10×10 Matrix{Float64}:
1.4968     7.37556  0.833061  …  0.584169  -1.06658   -2.45121
0.0867906  8.30224  0.652222     0.364652  -0.477872  -4.7667
⋮                             ⋱
1.62219    4.33597  0.576026     0.916961  -0.639694  -1.27006
2.14516    2.79338  0.335954     0.421141  -1.84897   -0.723347
=#

tmpmiddle = u * (I + (v' * A' * u))^-1
#=
10×10 Matrix{Float64}:
 -1.86419  -0.695083  -1.7452     …   2.54644   2.64085    1.49266
 -3.1713   -1.84768    1.1834         2.22572   5.69861    1.40546
  ⋮                               ⋱
  2.29853   6.16219    0.0294727     -5.62846   0.167164  -2.55069
  4.09594  -0.9933    -1.79248        1.63777  -5.71097   -1.05803
 =#
middle = -A^-1 * tmpmiddle
#=
  49.4646  57.4864    -9.72253  …  -53.8581   -68.3594  -32.7693
  27.8203  24.1974    -1.55644     -26.5274   -34.1993  -16.7565
   ⋮                            ⋱
 -13.4486   4.15526   10.7227       -8.40686   18.9022    2.26729
  40.2082  18.4852   -19.0904      -13.7932   -64.1186  -18.4974
  =#
right = A^-1

RHS = right * middle * left
#=
10×10 Matrix{Float64}:
 2.12618    8.08584   0.655802  …  0.719427  -4.17327   -2.74713
 1.52245    2.78087  -0.116915     0.85684   -2.58951   -1.93996
 ⋮                              ⋱
 0.756402  -1.35546   0.561576     0.32922    0.521806   1.98675
-0.663023   6.10921   1.78613      0.112573  -1.47111   -3.54095
  6.74992  2097.73  213.576   -772.089     13.7489   
-513.715  -1168.69
  ⋮                                     ⋱            1762.06   -3871.44     
211.53     2470.34  202.148   -776.942     69.1312   -513.715  -1168.69     
-802.528  -1352.28
 56.3864   4963.32  524.213  -1765.25      58.9692  --802.528  -1352.28     1384.89   -2718.6   
 =#
Lehs = (A + u * v')^-1
#=
 -1.64577     1.22028   …  -0.751388  -0.825928       
 -0.457401    1.00314      -0.378621  -1.72199
  ⋮                     ⋱
  0.357082   -0.770006      1.3016     1.68018        
 -0.0114964  -1.66291      -1.31537    1.18225 
 =#

#---recalled lecture 1 | convex Optimization I (stanford)

#=
47:19 
actually i know ever  know how to solve A 
everyone here has done A/ B -probably only a few know actually what it did ( what it means)

47:45 https://youtu.be/McLq1hEq3UY?t=2865
" Believe it or not, they won't even know what I'm asking !"
     - Professor Stephen Boyd, of the Stanford Electrical Engineering Department
    Lecture 1 | Convex Optimization 1 (Standard)

  =#

Lehs - RHS
""" the Best we can get 
10×10 Matrix{Float64}:
 22.2142     25.6118    -89.3328   -7.21748   -17.99     15.6037   12.0876   77.5545     3.49734  -43.1083
  0.472091  -35.6289   -125.656    17.9696     82.6787  -81.5007   53.3611  152.23       2.13005  -57.7565
  ⋮                                                       ⋮
  2.53801    -9.63932   -31.15      3.34303    18.2504  -20.8493   13.5364   38.1611     4.72605  -15.887
 51.7025    133.216     -80.0547  -47.635    -183.818   208.653   -45.3165   -2.99068  -11.0007   -49.3098
"""


function _span(arr = A, ; diagon = LinearAlgebra.diag(A))
  span = 0
  for i in enumerate(size(diagons))
    span += diagons[i]
  end
  return span
end

diagons = LinearAlgebra.diag(A) = LinearAlgebra.Diagonal(A)
span(A, diagons)

LinearAlgebra.span

#--- identity
A = rand(10, 10)
B = rand(10, 10)
I = ones(10, 10)
C = rand(10,10 )
_0 = zeros(10, 10)
_lhs = (I + A .* B)^-1
#=
 2.51162     1.06328     3.50709   -3.73767   -1.19645   -2.50288  -0.293292   0.961015   2.15519   -2.10134
 -6.03368    -1.3807     -8.14618    9.10683    4.05341    6.37086  -1.45176   -0.658709  -5.30112    2.65344
  ⋮                                                        ⋮
  4.9177      1.4219      6.38853   -7.89654   -1.68593   -5.32977   0.260283   0.159931   4.43551   -2.16398
 -0.0382185   0.0314968   0.316589  -0.994095  -0.307413   1.4129    0.126316  -0.345001   0.232051  -0.182067
=#
#_0 ≈ _lhs

(I + B * A)^-1 * B

#=
10×10 Matrix{Float64}:
  1.92712   -1.52044   …   2.88647    0.899755
  4.59499   -5.75992       6.18216    0.0528266
  ⋮                    ⋱
 -5.99075    6.25609      -9.001     -1.07983
 -0.834267   0.204393     -0.139767  -0.228184

=#

_rhs = I - A * (I + B * A)^-1 * B

_rhs ≈ _lhs  #false(bnot close (enough))
 
#=Key equations 

A*B*A ≈ (B*A) 
=#
A*B * A ≈ A * (B * A)  # true #finally 
#=fundanetbal theory of matrix theory =#

(A*B)*C ≈ A * (B*C) # true

#=Matrix Cain multiplication\
where to put the par anothers
A1,A2,..An
by soliving dynamic programming , in O(k^3)
paper: O(K Log K  Hu, Shing (1984)
why importanT ? 
=# 

#--- Chain Ruler 

g(x)=(f3 *(f2(x)f1(x)) 
#=
where fk: R^nk -> R^nk+1
chain rules give  #TODO: a loop on allJacobians 

for i in enumerate(n)

  if i <2 
    return jf(i,)

=#
Jg(x) =  Jf3(f2*(f1(x)))*Jf2(f1(x))*Jf1(x) ;

#---Todo implement Jacobian too     

#=y Symbolics.substitute
https://discourse.julialang.org/t/how-to-evaluate-substitute-numerical-values-of-params-n-states-a-jacobian-in-modelingtoolkit-using-generate-jacobian-or-calculate-jacobian/71466

Solution 
yewalenikhil65
Nov 2021 
thanks @baggepinnen 
i am doing currently following

states ,parameters
i == 1
x1map = 

warning: ModelingToolkit uses ZygoteRules
plus next line it uses Symbolics too writer seems 
can we do better ? 
=# 
#= Requires ModelingToolkit, Symbolics, Zygote (3 in 1) 
pmap = nothing ;jac=nothing ;x1=0;ps =;
x₀map = states(odesys) .=> x1
pmap  = parameters(odesys) .=> ps
jac = substitute.( ModelingToolkit.calculate_jacobian(odesys), (Dict([x₀map;pmap]),) )
jac = Symbolics.value.(jac);
=#
#=the key
You only need function f(x)

Defining F as zeros(3) restricts its entries to be Float64s, whereas to use ForwardDiff
they need to be Duals.

Change it to F = similar(x) or F = zero.(x)
#https://discourse.julialang.org/t/jacobian-of-a-multivariate-function/21131/10
=#

#=@dpsanders 

to get something of the correct type: =#




#--- chain rule gives 
#=
function _f(x)
  F = similar(x) #zero.(x)#small perturbation

  F[1] = x[1]^2 + x[3] # function here
  F[2] = x[1] + x[2] #another function 
  F[3] = x[2]^2 + x[3]^2 #third one too

  return F
end
=#
g(x) = f3(f2(f1(x)))   # fk R^n => R^nk+1;

Jg(x) = Jf3(f2(f1(x)))*Jf2(f1(x))*Jf1(x);

#=
Q. does Jg as (Jf3*Jf2)*Jf1 or Jf3*(Jf2*(Jf1)) 
me: i.e. is it forward or backward 

https://github.com/JuliaDiff/SparseDiffTools.jl
In addition, the following forms allow you to provide a gradient function g(dy,x) or dy=g(x) respectively:
=#
num_hesvecgrad!(dy,g,x,v,
                     cache2 = similar(v),
                     cache3 = similar(v))

num_hesvecgrad(g,x,v)

auto_hesvecgrad!(dy,g,x,v,
                     cache2 = ForwardDiff.Dual{DeivVecTag}.(x, v),
                     cache3 = ForwardDiff.Dual{DeivVecTag}.(x, v))

auto_hesvecgrad(g,x,v);

#---
#The `numauto`and autonum methods both mix numerical and automatic differentiation, with the former almost always being more efficient and thus being recommended.

# Optionally, if you load Zygote.jl, the following numback and autoback methods are available and allow numerical/ForwardDiff over reverse mode automatic differentiation respectively, where the reverse-mode AD is provided by Zygote.jl. Currently these methods are not competitive against numauto, but as Zygote.jl gets optimized these will likely be the fastest.

#using Zygote # Required #i'm not sure # are there anytthing else?

numback_hesvec!(dy,f,x,v,
                     cache1 = similar(v),
                     cache2 = similar(v))

numback_hesvec(f,x,v)

# Currently errors! See https://github.com/FluxML/Zygote.jl/issues/241
autoback_hesvec!(dy,f,x,v,
                     cache2 = ForwardDiff.Dual{DeivVecTag}.(x, v),
                     cache3 = ForwardDiff.Dual{DeivVecTag}.(x, v))

autoback_hesvec(f,x,v)
#=
Jv and Hv Operators
The following produce matrix-free operators which are used for calculating Jacobian-vector and Hessian-vector products where the differentiation takes place at the vector u:
=#
JacVec(f,x::AbstractArray;autodiff=true)
HesVec(f,x::AbstractArray;autodiff=true)
HesVecGrad(g,x::AbstractArray;autodiff=false)

#These all have the same interface, where J*v utilizes the out-of-place Jacobian-vector or Hessian-vector function, whereas mul!(res,J,v) utilizes the appropriate in-place versions. To update the location of differentiation in the operator, simply mutate the vector u: J.u .= ....

#=Chain Rule Modes of differentiation - Prof. Nick Higham 

 1.Automatic Differentiation (AD) 
 2.Forward (mode)
 3.Reverse mode

Provides references  references 
G.Strang Linear Algebra & Learning from Data 
Wellesley-Cambridge Press 2018 
http://math.mit.edu/~gs/Learningfromdata 

=#