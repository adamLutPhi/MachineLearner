#=
src\DataStructures\heap.jl:

=#

@btime begin 
    m= n=10;
for i = 1:m, j = 1:n
    arr[j, i] = tuple[j, i][1] #no method matching getindex (typeof(tuple), Int64, Int64)
end
end 

typeof(tuple[j, i])

#correction 

@btime begin 
    m= n=10;
@inbounds for i = 1:m, j = 1:n
    #convert tuple to array
    arr[j, i] = tuple[j, i][1]

    end
end 

typeof(tuple[j, i])