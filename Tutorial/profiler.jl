#---profiling 
"""NEW - Profiling
once code is writting, running 
we hat to profile it ens then you

1.Start tuning: the performance of code 

why: once working, figure out where it spends its time
-Timing the execution is very informative 

Takeaway: but as code gets more complicated, 

        "Measuring time become Less & Less Useful"

2.start guessing: which part of my code is  
 eating up all time (optimize:if you can somehow lower that down)

for that: encourage you to use a set of Profilers 


Profiling: what parts of code are Taking part of the time 


(in very rough terms) there are two types of profilers:
# instrumenting profiles
an instrument profiler adds measurement 'instrumentation' to your source code 

say call f(of x) store results in y: y = f(x) #me: calling f(x) a single variable function 


"""

y = f(x) # this is line

z = g(x , y)

"""
when you run code under instunmenting profiler 

it will actually modify that code (effectively)

& run a code looks like this :
"""

push!(timebuffer, ProfileInfo("somefile.jl", 17, time()))
y= f(x)
push!(timebuffer, ProfileInfo("somefile.jl",18, time()))

z = g(x, y)

push!(timebuffer, ProfileInfo("somefile.jl", 19,time()))

 """basucally it has some buffer that keeps track of timing data
 Right before it runs(first line), it might basically
 Record some information about 
1 .where it is (in your source code)
2. what the current time is 

then it will maje tgat cakk 

 """
