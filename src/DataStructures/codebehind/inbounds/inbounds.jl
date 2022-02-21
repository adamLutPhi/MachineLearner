@inbounds usage within string code #35842 #Open @KristofferC opened this issue on May 11, 2020 · 0 comments
#https://github.com/JuliaLang/julia/issues/35842
#=
Is there a True Significance for @inbounds? Really?
=#
#=
Comments
@KristofferC

Sponsor Member KristofferC commented on May 11, 2020 • 

The string code is filled with @inbounds, @propagate_inbounds, @checkbounds etc but it isn't (at least to me) completely clear what these really mean and it doesn't really feel documented.

Let's take string indexing, here @inbounds is only used to turn off checking that you are not outside the bounds of the string but you still need to index on a valid index:
=#

f(a, i) = @inbounds a[i]
f(0, 1)
f(1, 10)
#f (generic function with 1 method)

f("aα", 2) # if string, it checks it , at a valid index 
f("aα", 3)
# ERROR: StringIndexError("aα", 3) #erronr annotations been update meaningfully # `valid nearby index` [2]=> `a` 
#useful in 
s = "aα"
@time begin
    try
        @inbounds for i in size(f(s, size(f(s, 1))))
        end
    catch
        if (!OutOfMemoryError)
            println("caught ;)")
        end
    end
end


#=
However, you can also add an @inbounds to the SubString constructor (how would you even know that) which then turns off checking for a valid index:
=#
SubString("fα", 1, 3)  #same problem index 3 higher than max size of string , if you add 

SubString("fα", 1, 2) #successfully returns fa

#=
ERROR: StringIndexError("fα", 3) =#

g(a, i, j) = @inbounds SubString(a, i, j) #works 
# g (generic function with 1 method)

g("fα", 1, 2) #valid around max length (string)
# no error #it doesn't works
# "fα"
#=
So to me, 
`it feels a bit inconsistent``. 
Many string functions that take some kind of string index use @checkbounds but 
what do you actually promise when you use @inbounds and 
How do you find out which functions 
`that are useful to pass it to`.


I can only comment on changes right 
I guess there are more things yet to be uncovered 
#

=#

#---testing 

#-- speed  
using BenchmarkTools
 
#=ensures value stays withing bounds  =#
f(a, i) = @inbounds a[i]
@benchmark f(1, 8^2) # rand(1,1) is unpredictable 
f(a, i) = a[i] #redo without 
@benchmark f(1, 8^2) #ERROR bounds error! 
#=
 Memory estimate: 0 bytes, allocs estimate: 0.

BenchmarkTools.Trial: 10000 samples with 1000 evaluations.
 Range (min … max):  1.300 ns … 21.300 ns  ┊ GC (min … max): 0.00% … 0.00%     
 Time  (median):     1.400 ns              ┊ GC (median):    0.00%
 Time  (mean ± σ):   1.505 ns ±  1.169 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%     

                              █                            ▁  
  ▅▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ ▂
  1.3 ns         Histogram: frequency by time         1.5 ns <

 Memory estimate: 0 bytes, allocs estimate: 0.

 =#
f(1, 10)

#without @inbounds 

