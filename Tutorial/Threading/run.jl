using Threads
using BenchmarkTools
#--- with @threads macro 

function nonThreading1(n = 10)
    a = rand(n)

    for i = 1:n
        a[i] = Threads.threadid()
    end
end

"""
- The iteration space is split among the threads, after which each thread writes its thread ID to its assigned locations:
- Note that Threads.@threads does not have an optional reduction parameter like @distributed.

"""
function threading1(n = 10)
    a = rand(n)

    Threads.@threads for i = 1:n
        a[i] = Threads.threadid()
    end

end


#--- 
@time threading1()
# 2.267 μs (7 allocations: 768 bytes) , 0.000032 seconds (8 allocations: 784 bytes)
@btime threading1() #   0.000004 seconds (1 allocation: 160 bytes) , 2.289 μs (7 allocations: 768 bytes)
@benchmark threading1() # memory:  768 bytes # allocs: 7 # minimum: 2.278 μs (0.00% GC) median: 2.689 μs (0.00% GC), mean: 3.183 μs (1.51% GC), maximum: 487.933 μs (98.80% GC)

@time nonThreading1() #  0.000004 seconds (1 allocation: 160 bytes)
@btime nonThreading1() # 2.289 μs (7 allocations: 768 bytes) , 75.410 ns (1 allocation: 160 bytes)
@benchmark nonThreading1() # memory estimate:  160 bytes, allocs: 1, minimum: 77.222 ns (0.00% GC), median: 82.329 ns (0.00% GC),mean: 106.361 ns (2.37% GC),maximum: 1.776 μs (0.00% GC)

 