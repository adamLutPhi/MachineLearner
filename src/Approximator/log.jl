



function log10(z::Complex)
    a = log(z)
    a / log(oftype(real(a), 10))
end
function log2(z::Complex)
    a = log(z)
    a / log(oftype(real(a), 2))
end

function exp(z::Complex)
    zr, zi = reim(z)
    if isnan(zr)
        Complex(zr, zi == 0 ? zi : zr)
    elseif !isfinite(zi)
        if zr == Inf
            Complex(-zr, oftype(zr, NaN))
        elseif zr == -Inf
            Complex(-zero(zr), copysign(zero(zi), zi))
        else
            Complex(oftype(zr, NaN), oftype(zi, NaN))
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

function expm1(z::Complex{T}) where {T<:Real}
    Tf = float(T)
    zr, zi = reim(z)
    if isnan(zr)
        Complex(zr, zi == 0 ? zi : zr)
    elseif !isfinite(zi)
        if zr == Inf
            Complex(-zr, oftype(zr, NaN))
        elseif zr == -Inf
            Complex(-one(zr), copysign(zero(zi), zi))
        else
            Complex(oftype(zr, NaN), oftype(zi, NaN))
        end
    else
        erm1 = expm1(zr)
        if zi == 0
            Complex(erm1, zi)
        else
            er = erm1 + one(erm1)
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

function log1p(z::Complex{T}) where {T}
    zr, zi = reim(z)
    if isfinite(zr)
        isinf(zi) && return log(z)
        # This is based on a well-known trick for log1p of real z,
        # allegedly due to Kahan, only modified to handle real(u) <= 0
        # differently to avoid inaccuracy near z==-2 and for correct branch cut
        u = one(float(T)) + z
        u == 1 ? convert(typeof(u), z) : real(u) <= 0 ? log(u) : log(u) * z / (u - 1)
    elseif isnan(zr)
        Complex(zr, zr)
    elseif isfinite(zi)
        Complex(T(Inf), copysign(zr > 0 ? zero(T) : convert(T, pi), zi))
    else
        Complex(T(Inf), T(NaN))
    end
end

function exp2(z::Complex{T}) where {T}
    z = float(z)
    er = exp2(real(z))
    theta = imag(z) * log(convert(float(T), 2))
    s, c = sincos(theta)
    Complex(er * c, er * s)
end

function exp10(z::Complex{T}) where {T}
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
# λ1, λ2 = #rand(im,1)# no rand for complex 
#unwinding number 
U(z) = (z - log(exp(z))) / 2 * pi * im # takeaway:the use of generic functon promotes lazy processing - easy on memory, fast in response 

λ1 = 0.75;
λ2 = 0.25;
lhs = log(λ2) - log(λ1)

z = (λ2 - λ1) / (λ2 + λ1)

z = log(exp(z)) + 2 * pi * im * U(z)
#=
log(λ2) - log(λ1) 
someway, i can rewrite the expression , for more accurate Evaluation 
by introducing the z:
#TODO: check error1 = abs(lhs - rhs1) 
=#

rhs1 = log(λ2 / λ1) + 2 * pi * im * U(log(λ2) - log(λ1))# my bad: U(z) * (log(λ2) - log(λ1) # now, it's corrrect #checked

rhs1_5 = log((1 + z) / (1 - z)) + 2 * pi * im * U(log(λ2)-log(λ1)) #this value is also sound 
#result clustering rhs1, rhs1_5 
error_initial = rhs1 -  rhs1_5 # error is the same  (same values ) # logical error: comparing 2 RHSs # TODO: compare each RHS with its respective LHS

error1 = abs(rhs1) -abs(lhs) # 2.220446049250313e-16 < \epsilon≈ 0

#= "The Difference of Logs as a log Ratio
problem: need a correction term 
solution: that's where the unwinding number steps in  "
=log((1+z)/(1-z) + 2*π*i*u(log(λ2)-log(λ1))


=assuming we have a good atanh function 
=#
rhs2 = atanh(z) + 2 * pi * im * U(log(λ2) - log(λ1)) #used in state of art matrix log codes 

#=you can be sure that won't give you an accurate estimation 
(even if lambdas are close )
used in state of the art matrix log codes 

emphasize: z still has λ2 - λ1 (in it)
(but they're subtracting original numbers, that was given)

=#

error  = abs(z - rhs2)
#--- the Significance (& the Plateau)
#= one value isn't & won't be enough for correctly identifying the Significance of values
    Thus, it is in my pure interest to develop a 'Gray Area' around 0.05 
    My prine concern is to build a more valuable plateau around the Significant value (rather than relying on an arbitrary line in sand)
    This would render results as one of three: Significant, insignificant, indeterminant 
    The hardest thing is failing to admit our indeterminance 
    Our determenance is defined by the thickness of the indeterminance, the plateau must always be smaller than the Significance itself
    Let's say we have a line of Significance at 0.05 , then there must be a free-zone revolving around it, that is equal to each other- as above, so below 
    0.05 ± 0.01 : 0.01 thus, absolute thickness would make up 0.02 
    
    =# 
isSignificatant = error< 0.05 == true ||  error >=0.05 == false
