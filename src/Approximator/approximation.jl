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

P.4 Complex step Method 

for analytic t i = sqrt(-i)

    f'(x) ≈ Im f(x + i*h)/h 

Error O(h^2)
h not restricted by rounding errors 
can take h = 10^100 

- Approximate automatic Differntiation 
- Alg for f must not emply complex arithmetic

Paper: 
-Lyness & Moler (1967)
- Squire & Trapp (1998)


f(x) = atan(x) / (1+ exp(-x^2)) at x=2:

Prof Higham: "derivative is correct to 15 figures"

Accurate derivative
0.274623728154858 gets all digits correct 

Complex step with h = le-100. #gets all digits correct
0.274623728154858

Forward difference with h = 8*u.
0.250000000000000  

Forward difference with h = sqrt(8*u). 
0.274623729288578

#takeaway: with optimal choice, you get only Half of the digits correct 


"The shortest and best way between two
truths of the real domain often passes
through the imaginary one."
Jacques Hadamard (1945)
log(z) is the Alogorithm for which Im log z E (-1r, 1r]


log(z1 + log(z2)    (9.1)

log z1 * z2 = log(abs(z1*z2)) + i*arg(z1*z2)
            = Log(abs(z1) + Log(z2) + i*arg(z1)+ i*arg(z2)
            = log(z1) + log(z2)

Difference between Log vs log:


book: an introduction to complex analysis R.P Agarwal 2011
turning the page, 9.1 holds if you 
take the appropriate  
"Branch of the log (in each of those occurences of the log )
(not an actual identity to the principal Log)
So, the formula is not , in general, true 
Q.1how can we understand this?
Q2. how can we compute this in practice ?
Goes on say it must take appropriate Brach for 
    each occurence of "log"

Book: NIST Handbook (Olver et al. 2010)
a very widely-used mathematical functions
arcsin, Arccos are "general values" of inverse sine, inverse cosine 
9
4.24(iii) Addition Formulas 

Arcsin(u)  ± Arcsin(v)
= - Arcsin(u*(l - v^2)^1/2 ± v(l - 1t2 )^1/2) 4.24.13
Arccos(u) = Arcos(v) 
= Arccos(u*wi ∓ ((1-u^2))*(1 - u^2)*(1-v^2))^1/2) 4.24.14

Arcsin, Arccos are "general values" of inverse sine, inverse
cosine

Each occuruce of the "Multi-valued function" could be from Different Branch 
Q. if I have a particular u & v 
for my principal branch, I want to know : what can i say
 the Author's Understanding (topic)v.s. Reader Understanding(topic )

 #---P.12. unwinding Number 

 U(z) = z- log(exp(x)^z)/2*pi*i

 Note: log(exp(x)^z)+ 2*pi*i*U(z)
 papers:
 -Corless,Hare & Jeffery (1996)
 -Apostol (1974):special case 

 #---P.13.
 unwinding number is an integer (an alternative formula)

 U(z) = z-log(exp(x)^z)/2*pi*i = ceil(Im(z)-pi/2*pi)

 when is log exp^z = z  #NOT A USUAL ^ 
 U(z) = 0 iff Im(z) ∈ (i*pi,pi} #semi-open interval 
me: reimann surface of logarithm forms a helix variable color(whose value vary)

comment: turns out
1.unwinding number is an integer 
2.reimann Surface: counts which branch of Reimann Surface (you are on)

 when log(e^z)=z  [me: no errors!] #NOT USUAL ^
 it will be as long as imaginary part (Im(z))
 is in a VErtical strip (horizontal strip) - i digress 
 between [-pi,pi]

 #--- Roundtrip Relations 
another identity:
cos(acos(z)) = z [minimal error ]

WARNING: AVOID AMBIGUITY WITH ^ 
SEE:https://github.com/JuliaLang/julia/blob/master/base/complex.jl
there are 2 imaginary number specifications : 
im , imag
 =#

z1= imag #generic function with 19 methods 
z2=im::Complex
 z1 != z2
z=z2  
cos(acos(z)) == z #false 
cos(acos(z)) ≈ z  #true! [already an identity]
# acos(cos(z)) = z # Syntax Error cos(z) is not a valid function 


function log10(z::Complex)
    a = log(z)
    a/log(oftype(real(a),10))
end
function log2(z::Complex)
    a = log(z)
    a/log(oftype(real(a),2))
end

function exp(z::Complex)
    zr, zi = reim(z)
    if isnan(zr)
        Complex(zr, zi==0 ? zi : zr)
    elseif !isfinite(zi)
        if zr == Inf
            Complex(-zr, oftype(zr,NaN))
        elseif zr == -Inf
            Complex(-zero(zr), copysign(zero(zi), zi))
        else
            Complex(oftype(zr,NaN), oftype(zi,NaN))
        end
    else
        er = exp(zr)
        if iszero(zi)
            Complex(er, zi)
        else
            s, c = sincos(zi)
            Complex(er * c, er * s)
        end
    end
end

function expm1(z::Complex{T}) where T<:Real
    Tf = float(T)
    zr,zi = reim(z)
    if isnan(zr)
        Complex(zr, zi==0 ? zi : zr)
    elseif !isfinite(zi)
        if zr == Inf
            Complex(-zr, oftype(zr,NaN))
        elseif zr == -Inf
            Complex(-one(zr), copysign(zero(zi), zi))
        else
            Complex(oftype(zr,NaN), oftype(zi,NaN))
        end
    else
        erm1 = expm1(zr)
        if zi == 0
            Complex(erm1, zi)
        else
            er = erm1+one(erm1)
            if isfinite(er)
                wr = erm1 - 2 * er * (sin(convert(Tf, 0.5) * zi))^2
                return Complex(wr, er * sin(zi))
            else
                s, c = sincos(zi)
                return Complex(er * c, er * s)
            end
        end
    end
end

function log1p(z::Complex{T}) where T
    zr,zi = reim(z)
    if isfinite(zr)
        isinf(zi) && return log(z)
        # This is based on a well-known trick for log1p of real z,
        # allegedly due to Kahan, only modified to handle real(u) <= 0
        # differently to avoid inaccuracy near z==-2 and for correct branch cut
        u = one(float(T)) + z
        u == 1 ? convert(typeof(u), z) : real(u) <= 0 ? log(u) : log(u)*z/(u-1)
    elseif isnan(zr)
        Complex(zr, zr)
    elseif isfinite(zi)
        Complex(T(Inf), copysign(zr > 0 ? zero(T) : convert(T, pi), zi))
    else
        Complex(T(Inf), T(NaN))
    end
end

function exp2(z::Complex{T}) where T
    z = float(z)
    er = exp2(real(z))
    theta = imag(z) * log(convert(float(T), 2))
    s, c = sincos(theta)
    Complex(er * c, er * s)
end

function exp10(z::Complex{T}) where T
    z = float(z)
    er = exp10(real(z))
    theta = imag(z) * log(convert(float(T), 10))
    s, c = sincos(theta)
    Complex(er * c, er * s)
end

# _cpow helper function to avoid method ambiguity with ^(::Complex,::Real)
function _cpow(z::Union{T,Complex{T}}, p::Union{T,Complex{T}}) where {T}
    z = float(z)
    p = float(p)
    Tf = float(T)
    if isreal(p)
        pᵣ = real(p)
        if isinteger(pᵣ) && abs(pᵣ) < typemax(Int32)
            # |p| < typemax(Int32) serves two purposes: it prevents overflow
            # when converting p to Int, and it also turns out to be roughly
            # the crossover point for exp(p*log(z)) or similar to be faster.
            if iszero(pᵣ) # fix signs of imaginary part for z^0
                zer = flipsign(copysign(zero(Tf), pᵣ), imag(z))
                return Complex(one(Tf), zer)
            end
            ip = convert(Int, pᵣ)
            if isreal(z)
                zᵣ = real(z)
                if ip < 0
                    iszero(z) && return Complex(Tf(NaN), Tf(NaN))
                    re = power_by_squaring(inv(zᵣ), -ip)
                    im = -imag(z)
                else
                    re = power_by_squaring(zᵣ, ip)
                    im = imag(z)
                end
                # slightly tricky to get the correct sign of zero imag. part
                return Complex(re, ifelse(iseven(ip) & signbit(zᵣ), -im, im))
            else
                return ip < 0 ? power_by_squaring(inv(z), -ip) : power_by_squaring(z, ip)
            end
        elseif isreal(z)
            # (note: if both z and p are complex with ±0.0 imaginary parts,
            #  the sign of the ±0.0 imaginary part of the result is ambiguous)
            if iszero(real(z))
                return pᵣ > 0 ? complex(z) : Complex(Tf(NaN), Tf(NaN)) # 0 or NaN+NaN*im
            elseif real(z) > 0
                return Complex(real(z)^pᵣ, z isa Real ? ifelse(real(z) < 1, -imag(p), imag(p)) : flipsign(imag(z), pᵣ))
            else
                zᵣ = real(z)
                rᵖ = (-zᵣ)^pᵣ
                if isfinite(pᵣ)
                    # figuring out the sign of 0.0 when p is a complex number
                    # with zero imaginary part and integer/2 real part could be
                    # improved here, but it's not clear if it's worth it…
                    return rᵖ * complex(cospi(pᵣ), flipsign(sinpi(pᵣ), imag(z)))
                else
                    iszero(rᵖ) && return zero(Complex{Tf}) # no way to get correct signs of 0.0
                    return Complex(Tf(NaN), Tf(NaN)) # non-finite phase angle or NaN input
                end
            end
        else
            rᵖ = abs(z)^pᵣ
            ϕ = pᵣ * angle(z)
        end
    elseif isreal(z)
        iszero(z) && return real(p) > 0 ? complex(z) : Complex(Tf(NaN), Tf(NaN)) # 0 or NaN+NaN*im
        zᵣ = real(z)
        pᵣ, pᵢ = reim(p)
        if zᵣ > 0
            rᵖ = zᵣ^pᵣ
            ϕ = pᵢ * log(zᵣ)
        else
            r = -zᵣ
            θ = copysign(Tf(π), imag(z))
            rᵖ = r^pᵣ * exp(-pᵢ * θ)
            ϕ = pᵣ * θ + pᵢ * log(r)
        end
    else
        pᵣ, pᵢ = reim(p)
        r = abs(z)
        θ = angle(z)
        rᵖ = r^pᵣ * exp(-pᵢ * θ)
        ϕ = pᵣ * θ + pᵢ * log(r)
    end

    if isfinite(ϕ)
        return rᵖ * cis(ϕ)
    else
        iszero(rᵖ) && return zero(Complex{Tf}) # no way to get correct signs of 0.0
        return Complex(Tf(NaN), Tf(NaN)) # non-finite phase angle or NaN input
    end
end

#=Roundtrip Relations 
Theorem 

if Re z != k*pi ; k \in Z then 
    
    
    acos(cos(z)) #not existant per se 
    = z - 2*pi*U(i*z)*sign(z-2*pi*U(i*z)))
Corollary 
acos(cos(z)) = z iff Re z z∈(0,pi)

=#
#=Accurate Difference

how to compute Accurate Value of 
log \lambda , λ1,λ2 ∈ C
=#
log(λ2) - log(λ1) ; 

z = (λ2-λ1)/(λ2+λ1)

log(λ2) - log(λ1) = log(λ2/λ1)+2*pi*i*u*(log(λ2)-log(λ1))
=log((1+z)/(1-z) + 2*π*i*u(log(λ2)-log(λ1))

#=
used in state of the art matrix log codes 
=#
