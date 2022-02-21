#= Requires enough llvm 

while i <= L makes function >5x slower the while i < (L+1) #31416
ndinsmore opened this issue on Mar 20, 2019 · 27 comments
https://github.com/JuliaLang/julia/issues/31416
=#
#=vchuravy commented on Mar 21, 2019 • 

While I do not recommend this, "there is always a way."
=#

    function unsafe_inc(i::Int64)
        Base.llvmcall("""
        %i = add nsw i64 %0, 1
        ret i64 %i
        """, Int64, Tuple{Int64}, i)
    end

function slow_entitlement_test_func(f,iter::Union{Base.KeySet{<:Any, <:Dict}, Base.ValueIterator{<:Dict}},N=1)
    ret=0
    @inbounds for n in 1:N
        ret=0
        d=iter.dict
        slots=d.slots
        L=length(slots)
        vals=d.vals
        i=d.idxfloor
        while i <= L
         #for i = d.idxfloor:L
            @inbounds if slots[i] === 0x1
                @inbounds v=vals[i]
                ret+=f(v)
            end
            i = unsafe_inc(i)
        end
    end
    return ret
end
#=
Since this is not a bug in Julia, but due to the defined semantics I am going to close this issue.
Please continue discussion on discourse.julialang.org
=# 