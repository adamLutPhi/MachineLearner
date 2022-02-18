#=
src\DataStructures\heap.jl:

=#

using BenchmarkTools

@btime begin
    m = n = 10
    for i = 1:m, j = 1:n
        arr[j, i] = tuple[j, i][1] #no method matching getindex (typeof(tuple), Int64, Int64)
    end
end

typeof(tuple[j, i])


#@btime begin
function convertTuple(tuple::Tuple{Int64,Int64})
    m = n = 10
    @inbounds for i = 1:m, j = 1:n
        #convert tuple to array
        arr[j, i] = deepcopy(size(collect(minimum(tuple[j, i]))))
        arr2[j, i] = deepcopy(size(collect(minimum(tuple[i, j]))))
    
    end
    return arr, arr2
    end
   
#end

typeof(tuple[j, i])

@btime begin
    m = n = 10
    @inbounds for i = 1:m, j = 1:n
        #convert tuple to array
        arr[j, i] = tuple[j, i][1]

    end
end

typeof(tuple[j, i])