#= 
1. get 1st value 
undex0f() returns int 


#=cheatsheet
nofindfirst - no problem 
findfirst() extension function 
    A custom remapping from the julia functions 
    first()
    findfirst()
    firstIndex(v::Vector)
    firstIndex(v::Vector, i::Int)
    elementat(v::Vector, i)
    indexof(v::Vector, i)

=#
=#
#function last(index) #returns fallback / extension we're making! 
#function indexin()
#firstIndex(v)
#first(v) # first : returns the contents of the first index 
#Q.need for firstIndex() 

#------------
#---Index 

export firstIndex, indexOf, elementat

@propagate_inbounds function firstIndex(v::Vector) #
    #using first()
    return elementat(v, 1)#[1] #content 
end

#checked 
"""
returns index of value i   
"""
@propagate_inbounds function indexOf(i, v::Vector) #where {T<:Union{Float64,Int64}}
    try
        res = findfirst(isequal(i), v)
        
    catch
        return -1
    end

end

#fixed 
@propagate_inbounds function indexOf(i, v::Vector)
    try
        res = findfirst(isequal(i), v)
        if res isa Number
            return res
        else
            throw(error("Unexpected Error")) # 2. throw(error(ExceptionError)) 
        end
    catch UnexpectedError
        @error UnexpMsg exception = (UnexpectedError, catch_backtrace())
    end
    # return res
end

@propagate_inbounds function indexOf(i, v::Vector)
    try
        res = findfirst(isequal(i), v) #warning it's never used 
        #typeof(res) == Nothing ? res = -1 : return Int(res) #res[1] #
    catch
        return -1
    end
    return res 
end
#---    elementat ---- 

#checked 
function elementat(v::Vector, i)
    return elementat(i, v) #findall(x -> x == i, v)[1]
end

@propagate_inbounds function elementat(i, v::Vector)
    try
        res = findall(x -> x == i, v)[1]
        length(res) == 0 ? res = -1 : res = res
    catch
        return -1
    end

    # return res
end


@propagate_inbounds function elementat(v::Vector)
    # return findall(x -> x == 1, v)[1]
    return elementat(1, v::Vector)

end


#---elements ----

#--------------------------------

#--- Indicies ----
"""
returns an array
"""
@propagate_inbounds function firstIndicies(v::Vector, i) #::AbstractArray{T,N}
    return findall(v)
    return findall(x -> x == i, v)
end

#= the rest is for the test part 
#i.e. solution for these 
v = [0, 1, 2, 3]
v = [1, 2, 3, 4] # alg: first(index) + last(index) 


#--- testing 
#benchmarking 
using BenchmarkTools
v = [1, 2, 3, 4]
#a =
firstIndex(v)
=#