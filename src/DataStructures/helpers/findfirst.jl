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
#function last(index) #returns fallback / extension we're making! 
#function indexin()
#firstIndex(v)
#first(v) # first : returns the contents of the first index 
#Q.need for firstIndex() 


function firstIndex(v::Vector) #
    #using first()
    return findall(first(v)) #content 
end


function firstIndex(v::Vector, i::Int)
    return findnext(v, i)  #findfirst(v,i)    #v>=  i 
end


function elementat(v::Vector, i)
    return findnext(v, i)
end


function indexof(v::Vector) #, i)
    #findIndex(v::Vector) #Note Takes 1 argument(parameter)- v::Vector -only
    return findIndex(v) #, i) 
end

"""
returns an array
"""

function firstIndicies(v::Vector)::AbstractArray{T,N}
    return findall(v)

end

#i.e. solution for these 
v = [0, 1, 2, 3]
v = [1, 2, 3, 4] # alg: first(index) + last(index) 


#--- testing 
#benchmarking 
using BenchmarkTools
v = [1, 2, 3, 4]
#a =
firstIndex(v)
#= 
1. get 1st value 
undex0f() returns int 