
using BenchmarkTools
Base.@propagate_inbounds function bLookup!(a = 1, b = 4; h = 1)  #optimal #rapid: median 71.5 ns 

    α = 1
    β = 1 #Whatever _b could be picked-up, inside loop it 'll get overwritten 
    q = [] #DataStructures.Deque{Tuple{Int64,Int64}}()
    n = 1

    while α != b && β <= b # adding inbounds slightly fastens the total process  
        #   2 + (2) = 4 = _b 
        β = α + (n * h)  # = 3  
        push!(q, (α, β)) #1 (1,2) #infer: sub-range [1,2]  #Deque (b=4 !isa b[1]=2  (now a[2] = b[1]=2 for next op ) a starts at 2 
        α = β # Swap a = 2
        n += 1 # 2 
    end

    return q
end
tup = bLookup!()
@benchmark isMod(;tup=tup) = @async size(tup) % 2 === 0 ? true : false;
@benchmark isMod(tup)
isMod(tup) = @async size(tup) % 2 === 0 ? true : false;

#@benchmark isMod2(tup) = @inline mod(length(tup), 2) == 0 ? true : false; 
