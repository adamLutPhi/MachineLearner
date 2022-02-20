function Base.broadcast!(::typeof(identity), ta::Tuple{A1,A2}, tb::Tuple{B1,B2}) where {A1,A2,B1,B2}
    ta1, ta2 = ta
    tb1, tb2 = tb
    @assert indices(ta1) == indices(ta2) == indices(tb1) == indices(tb2)
    for i in eachindex(ta1)
        @inbounds ta1[i], ta2[i] = tb1[i], tb2[i]
    end
    ta
end