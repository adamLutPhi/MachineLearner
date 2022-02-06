
"""Base.reindex is a Function.

  # 6 methods for generic function "reindex":      
  [1] reindex(::Tuple{}, ::Tuple{}) in Base at subarray.jl:242
  [2] reindex(idxs::Tuple{Real, Vararg{Any, N} where N}, subidxs::Tuple) in Base at subarray.jl:245   
  [3] reindex(idxs::Tuple{Base.Slice, Vararg{Any, N} where N}, subidxs::Tuple{Any, Vararg{Any, N} where N}) in Base at subarray.jl:249
  [4] reindex(idxs::Tuple{AbstractVector{T} where T, Vararg{Any, N} where N}, subidxs::Tuple{Any, Vararg{Any, N} where N}) in Base at subarray.jl:253    
  [5] reindex(idxs::Tuple{AbstractMatrix{T} where T, Vararg{Any, N} where N}, subidxs::Tuple{Any, Any, Vararg{Any, N} where N}) in Base at subarray.jl:257
  [6] reindex(idxs::Tuple{AbstractArray{T, N}, Vararg{Any, N} where N}, subidxs::Tuple) where {T, N} in Base at subarray.jl:261

  """

"""Tuple

Static Type systems,where every program 
Expression must have a Type Computable 
Before the Execution of the Program, and 

Dynamic type systems, where nothing is known 
about types - until Run-Time, 

(when the actual values Manipulated by the program are available)

Object orientation:
Allows (some) Flexibility in Statically-typed Languages 

How:
By letting code be written 
Without the Precise Types of values  being known 
At Compile Time. 

polymorphism:
The ability to write code that can Operate 
On different Types- is called polymorphism.

All code in classic dynamically-typed Languages is Polymorphic: 
Only by explicitly checking types, or(on fallback():
When objects fail to support operations at run-time), are the types of any values ever restricted

"""

"""

The default behavior in Julia when types 
are omitted is to allow values to be of any type. 
Thus, one can write many useful Julia functions
 without ever explicitly using types. 
 When additional expressiveness is needed, however,
it is easy to gradually introduce explicit 
type annotations into previously "untyped" code. 

Adding annotations Serves 3 primary purposes:
1. to take advantage of Julia's Powerful multiple-dispatch mechanism,
2. to improve human readability, and 
3. to catch programmer errors

"""

"""
Describing Julia in the lingo of type systems, 
it is: Dynamic, Nominative and Parametric. 
Generic types can be parameterized, and 
the hierarchical relationships between types '
are explicitly declared, 
rather than implied by compatible structure.
"""