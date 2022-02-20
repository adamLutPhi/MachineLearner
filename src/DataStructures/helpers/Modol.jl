#=

1. which is faster ?

=#
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
vec = bLookup!()
typeof(vec)
length(vec)  # lenght ; size
l = length(vec)
flag = nothing

isMod(vec) = length(vec) % 2 == 0 ? flag = true : flag = false; #use of global 

#benchmark isMod(vec)
#=using globals freely : flag = true global , l = 
=#
@time begin
    flag = isMod(vec)
    if flag == true
        l = length(vec) / 2
    elseif flag == false
        l = (length(vec) + 1) / 2
    else
        print("something's wrong")
    end
end


# 0.000019 seconds (1 allocation: 16 bytes) #correct! 
#=
what is the max of list ?
=#

#---

r = [1, 2, 3, 4]
maxr = r[4]
number = r[2]
for i in r
    print(i)
end

for i in r
    if number
        if number < r[4]
            1:r
        end
    end
end

#is divisible 




#---
fl = nothing
isMod(vec) = length(vec) % 2 == 0 ? fl = true : fl = false; #use of global 

#benchmark isMod(vec)
#using globals freely 
succeed(v, i) = v[i+1];
transfer(v, m, n) = v[m], v[n] = v[n], v[m]
#v[m] -> v[n]
insertat!(v, m, i) = v[i] = m;
jump(v, ; m, n) = v[n] -> tmp, v[m] -> v[n], tmp->v[m];

v[n] -> tmp

a = zeros(2);

b = ones(2);

c = (a, b)
# ([0.0, 0.0], [1.0, 1.0])

 @swap!(a, b);

# c  # unchanged, because all the `@swap!` macro did was change the bindings "a" and "b"
#([0.0, 0.0], [1.0, 1.0])

#; && v[m] -> v[n] && tmp -> v[m]

#@time begin flag = isMod(vec)
    #=
if fl == true
    l = length(vec) / 2
elseif flag == false
    l = (length(vec) + 1) / 2
end 
=#
