using Test,  BenchmarkTools, DataStructures
module heap
    
#=
```inputs

n: whole positive natural number > 1 -autoincremented 

|---| --- |
b    b      b
```
 #queue - Datastructures.Deque{Int}()
#=
   i=4 = b ;a=[]; ; n = 1;

if (i < 2 || i > b) # stop
    #crunch in numbers 
    return
else
    #modify then call 
    i = i - (n * h) # 4 -(1*1) = 3 <--- new b /a 
    pt = (i, b) # (3,4); push!()  
    bLookup!(a, b; h = 1)
    #push!()  ∘ ⚇ 


    n += 1

    setindex!(a, 1, i)

end
a=rand(10,1) ; size(a)
@test 
bLookup!()

(1,2)
=#
=#
function extractall!(tuple::Tuple{Any,Any})
    count = 1 
    m = size(collect(minimum(tuple)))
    n = length(len)

    for i = 1:m, j = 1:n
    arr[j, i] = tuple[j, i][1]
    tuple[j, i] = tuple[j, i][2]
    # 
    dt1[count] = zip(tuple[j, i][1], tuple[j, i][2])
    dt2[count] = (tuple[j, i][1], tuple[j, i][2])

    count += 1 #auto-Increment 

end
    return dt1, dt2 #debugging, still 
end 

function bLookup!(a = 1, b = 4; h = 1)

    _a = 1
    _b = 1 #Whatever _b could be picked-up, inside loop it 'll get overwritten 

    q = DataStructures.Deque{Tuple{Int64,Int64}}()
    n = 1

    while _a != b && _b <= b
        #   2 + (2) = 4 = _b 
        _b = _a + (n * h)  # = 3  
        push!(q, (_a, _b)) #1 (1,2) #infer: sub-range [1,2]  (b=4 !isa b[1]=2  (now a[2] = b[1]=2 for next op ) a starts at 2 
        _a = _b # a = 2
        n += 1 # 2 
    end

    return q
end
  
heap =bLookup!()
copiedHeap = deepcopy(heap)
typeof(heap) 
length(heap)

#popfirst!(heap)
#typeof(pop!(heap))
#N = [] #UncommentMe
#collect(pop!(heap)) #UncommentMe
#collect(pop!(heap))[1, 1] #collect creates an Array
#orderedArray = extract_all!(heap) #
dims= deepcopy(size(collect(minimum(heap)))) ;    #= (2,) ; =# #heap = update(heap,1,popped) #<-----Tuple Dimensions 
_length = length(len) #Tamas_Papp Tamas_Papp Oct 2017 (2,) is simply syntax for a tuple of 1 element #needed to avoid confusion with (2) == 2.
typeof(popfirst!(heap)) #(1,2)#Tuple{{Int64, Int64}}

#for i k in enumerate(length) 
#accessing tuple :  2 loops f_vp= 
dt1 = nothing 
dt2 = nothing
#funtion iterTuple(tuple=heap, m,n)
m = size(collect(minimum(copiedHeap))) 
m[1] m[1][1]
typeof(m) # m is a tuple lol 
n = length(m)
count = 1
for i = 1:m, j = 1:n
   dt1[count] =  zip(copiedHeap[j, i][1], copiedHeap[j, i][2])
   dt2[count] =  (copiedHeap[j, i][1], copiedHeap[j, i][2]) 
  #  f_value1[j, i] = copiedHeap[j, i][1]
   # f_value2[j, i] = copiedHeap[j, i][2]
 #  arr1 = dt1
#collect(dt2)
count += 1 #auto-Increment 
end  

typeof(dt1)
typeof(dt2)

for i in enumerate(len)
    res2 =(collect(popfirst!(heap))[1, 1])

 
size(A[1:1, 1]) 
        
 
#N[[1],:] =typeof(collect(pop!(heap)))# boundsError #UncommentMe
N[[:],] = typeof(collect(pop!(heap))) #possible :Deque must me non-empty # invalid index Colon #LoadError: ArgumentError: invalid index: [Colon()] of type Vector{Colon}
N[:] =typeof(collect(pop!(heap))) # returns a 0-element vector 
resultsize(idxs...) = tuple(Iterators.flatten(size.(idxs))...)

#0element vector{Any} at index [[1]]

# typeof(collect(pop!(heap)))

#typeof( collect(pop!(map(x->x, heap))))

containr = nothing
arr = nothing
for i in enumerate(length(heap))
    containr += [arr collect(pop!(map(x[i]->x, heap)) ) ]
end 
#= how you define behavior is how 
julia will react =#
 
    ranges = []
a = 1; b= 4
#ret = nothing
A=[];B=[];I=[];
#q =(,)::Tuple{UnitRange{Int64}, Tuple{Int64, Int64}}, ::Type{Any} # Any #DataStructures.Deque{UnitRange{Int64}}()

#insert!()
A = collect( popfirst!(heap))
    
@inbounds for (n,i) in enumerate(tmp)
        b[n] = i+1
    end 

a,b = popfirst!(heap)

function extractfromHeap(heap)
    for p in enumerate(length(heap))
        a, b = popfirst!(heap)
        #ret = [ret, a:b]
        #push!(A, a)                                                                                                                                                                                                                                                                                                                                                        
        #push!(B, b)
        @inbounds insert!(A, a, p)
        @inbounds insert!(B, b, p)
        @inbounds insert!(I, p, p)
    end
        # A = [a] #1
        # B = [b]
        # I = [p]
        #   (A,B)[i]  = (a,b)
        #i += 1
        #(A[i],B[i]) = (a,b)
        #   (A[i],B[i],I[i]) = a,b,i
        # B[i] = b ;
        #  I[i] = i
        #   a[i],B[i],I[i] = a,b,i            #push!((a:b,i),q)
    return A, B,I
 
end


#ret[1]
#ret[2]
    #ranges  = [ ranges ,a:b] 
    #range1 = ret1:ret2 
    #ret3, ret3 = popfirst!(heap)

#range2 =   
# ret2
#ret1:ret2

function getIndex!(Q::Deque{UnitRange{Int64}}, idx::Int64)
    ret = getQueue(Q, idx)
end 

function getindex!(Q::Deque{Tuple{Int64, Int64}},idx::Int64)
    ret = nothing
    for i in enumerate(size(Q))
        if i isa idx 
        ret = pop!(Q)
        end
    end 
    return ret 
end 
#=--- testing Area
getindex!(heap,1)
i = 4  #... i = 1 ; b[1] =4 
a[1]= b[1] - (n[1]*h) = 

b[2]

b[1]  # setindex!(b,1,)
b[1] =  1 + (1 * 1 )  = 2  #infer: sub-range [1,2]  (b=4 !isa b[1]=2  (now a[2] = b[1]=2 for next op ) a starts at 2 
b[2] = a[2] + (n[2] * h) = 2 + (2 * 1) 

b[2] = a[2] - (n[2] * h) = 2 -  (2 * 1) 
#=
Base.setindex!
=# #Function
setindex!(collection, value, key...)
Store the given value at the given key or index within a collection. The syntax a[i,j,...] = x is converted by the compiler to (setindex!(a, x, i, j, ...); x).
=#

function  findSubrange(a,b=4;n= 1)
i=n;
#a=[]; _b=[]; 
#_n = 1;
 _b =1; _a =1;  

if _b isa b #reached the end 
    _a = a  #
    return 

if !(_b isa b) #
    _a + (n[1] * h)
    i += 1

    while !(_b isa b)
        _b = _a + (_n * h)
 #update _a, _b
        i = 1:_b = _a + (i * h) # = 1 + (1 * 1) = 2  #infer: sub-range [1,2]  (b=4 !isa b[1]=2  (now a[2] = b[1]=2 for next op ) a starts at 2 
        i += 1 
        findSubrange(_a,  _b,n= i)
    end

end 

end
