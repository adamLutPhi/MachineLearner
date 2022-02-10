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

z = g(x, y)

"""
when you run code under instunmenting profiler 

it will actually modify that code (effectively)

& run a code looks like this :
"""

push!(timebuffer, ProfileInfo("somefile.jl", 17, time()))
y = f(x)
push!(timebuffer, ProfileInfo("somefile.jl", 18, time()))

z = g(x, y)

push!(timebuffer, ProfileInfo("somefile.jl", 19, time()))

"""basucally it has some buffer that keeps track of timing data
 Right before it runs(first line), it might basically
 Record some information about 
1 .where it is (in your source code)
2. what the current time is 

then it will make that work 
 """

"""
first it knows what time it is 
queries the system 

(me:simulates time advancesment : by passing i as an argument )
time would have advanced by the function call 
(On) every execution, it gets called 
that's a very nice way of measuring time 

there are a Quite a few profilers, work this way 

however,
Insturment profiles come with hurdles:

1.instrumentation slows your code: having to store data at every single function call #TODO: that implements as well in metatrader 
2.instumentation can block compiler optimizations: the compiled code of the real version may be quire different from that of the instrumented code "minus instrumentation"
**3.recursion is a bit tricky**: if you also instrument `f`, the added instrumentation inside `f` distorts your measurement of the runtime of `f` itself

so, running code with instrumentation is a very different code, than the code that runs without the instrumentation  
you're actually getting a misleading picture of the cirumstances  

anytime you do instrumentation inside a function call 
has a little instrumentation around it -gets complicated to subtract out ]
costs of insturmentation 
world has moved on to a different stle of profiler
"""
i = 17
push!(timebuffer, ProfileInfo("somefile.jl", i, time()))
y = f(x)
push!(timebuffer, ProfileInfo("somefile.jl", i = i + 1, time()))

z = g(x, y)
push!(timebuffer, ProfileInfo("somefile.jl", i = i + 1, time()))


"""Sampling profilers 

a sampling profiler ,periodically, 
1.interrupts your code and 
2. collects program-location data (where you are)

Analogy: 

8 hours a day at work 
1 hour a day at the gym 

real word 
waka-time collecting time intervals  of user code activity plus langauge programmed in 
 shortcoming: does this 100s times over a month
 
 aggregates all responses the
 
 """

using GLMakie
location = [rand(1:9) <= 8 ? "work" : "gym" for i = 1:1000]

bins = rand(5:16)
hist(values = location, bins = bins, normalization = :none)
ylabels("Counts")


using PyPlot

location = [rand]
location = [rand(1:9) <= 8 ? "work" : "gym" for i = 1:1000]

bins = rand(5:16)
hist(values = location; bins = bins, normalization = :none)
ylabels("Counts")

"""
Disadvantages of sampling profilers
1. you don't collect exhuastive information 
spending 5 minutses at bank will only be captured at all 

2. it's subject to sampling noise (given `n` counts, you have uncertainty
 of approx. `sqrt(n)` counts)

you'll get different number 

Advantages of sampling profiler
you're running unmodified code 

Code has all the real world optimizations (the compiler can do)

"""

#--deno of profiling 


function busywait(t)

        x = 0
        for i = 1:round(Int, 2.1e10 * t)
                x += i % 2
        end
        return x # return `x` to prevent the compiler from noticing that this doesn't do real work & eliminating it 
end

@time busywait(0.8) # 8400000000

function mydays(n)
        x = 0
        for i = 1:n
                x += work()
                x += gym()
        end
        return x
end

@noinline work() = busywait(0.08)
@noinline gym() = busywait(0.01)

mydays(1) # run once to compile it #945000000 

"""NEW
good rule of thumb:
takeaway: clear the buffer of the library before use 

bullet note: the overhead, when the function itself actually is doiing the work

Count  Overhead File                   Line Function
 =====  ======== ====                   ==== ========
  1877         0 @Base\boot.jl           360 eval
  1877         0 @Base\essentials.jl     708 invokelatest(::Any, ::Any, ::...  1877         0 @Base\essentials.jl     708 #invokelatest#2
  1877         0 @Base\essentials.jl     706 invokelatest(::Any, ::Any, ::...  1580      1580 @Base\int.jl             87 +
  1877         0 @Base\loading.jl       1116 include_string(mapexpr::typeo...  1877         0 @Base\logging.jl        603 with_logger
  1877         0 @Base\logging.jl        491 with_logstate(f::Function, lo...  1877         0 @Base\task.jl           411 (::VSCodeServer.var"#53#54")()  
     1         1 ...ile\src\Profile.jl   352 stop_timer()
  1580         0 ...torial\profiler.jl   157 busywait
   190        29 ...torial\profiler.jl   174 gym()
  1686         0 ...torial\profiler.jl   167 mydays(n::Int64)
   190         0 ...torial\profiler.jl   168 mydays(n::Int64)
  1686       267 ...torial\profiler.jl   173 work()

me:  count/overhead ratio : for gym : 

 190/29 =  6.551724137931034
 1686/267 =  6.314606741573034

work()/gym() ratio:
 267/29 = 9.206896551724138 (over 8 , overworking (seemingly, undergyming)  )
 1686/267 = 6.314606741573034 (under 8, underworking (seemingly over gyming))
  
from looping at the sampling profiler data 


"""

using Profile
Profile.clear() # clear old results (not really needed on the first usuage)
@profile mydays(30)

Profile.print(format = :flat) # represents number of snapshots that it's calling


"""another default way prented in t
 Count  Overhead File                   Line Function
 =====  ======== ====                   ==== ========
  1877         0 @Base\boot.jl           360 eval
  1877         0 @Base\essentials.jl     708 invokelatest(::Any, ::Any, ::...  1877         0 @Base\essentials.jl     708 #invokelatest#2
  1877         0 @Base\essentials.jl     706 invokelatest(::Any, ::Any, ::...  1580      1580 @Base\int.jl             87 +
  1877         0 @Base\loading.jl       1116 include_string(mapexpr::typeo...  1877         0 @Base\logging.jl        603 with_logger
  1877         0 @Base\logging.jl        491 with_logstate(f::Function, lo...  1877         0 @Base\task.jl           411 (::VSCodeServer.var"#53#54")()  
     1         1 ...ile\src\Profile.jl   352 stop_timer()
  1580         0 ...torial\profiler.jl   157 busywait
   190        29 ...torial\profiler.jl   174 gym()
  1686         0 ...torial\profiler.jl   167 mydays(n::Int64)
   190         0 ...torial\profiler.jl   168 mydays(n::Int64)
  1686       267 ...torial\profiler.jl   173 work()
  1877         0 ...Server\src\eval.jl   201 (::VSCodeServer.var"#55#59"{V...  1877         0 ...Server\src\eval.jl   124 (::VSCodeServer.var"#56#60"{B...  1877         0 ...Server\src\eval.jl   153 (::VSCodeServer.var"#57#61"{B...  1877         0 ...Server\src\eval.jl   155 (::VSCodeServer.var"#58#62"{B...  1877         0 ...Server\src\eval.jl   211 inlineeval(m::Module, code::S...  1877         0 ...Server\src\eval.jl   209 inlineeval##kw
  1877         0 ...Server\src\eval.jl    34 macro expansion
  1877         0 ...Server\src\repl.jl    36 hideprompt(f::VSCodeServer.va...  1877         0 ...Server\src\repl.jl   185 withpath(f::VSCodeServer.var"...Total snapshots: 1877

Overhead ╎ [+additional indent] Count File:Line; Function
=========================================================
    ╎1877 @Base\task.jl:411; (::VSCodeServer.var"#53#54")()
    ╎ 1877 ...Server\src\eval.jl:34; macro expansion
    ╎  1877 @Base\essentials.jl:706; invokelatest(::Any)
    ╎   1877 @Base\essentials.jl:708; #invokelatest#2
    ╎    1877 ...erver\src\eval.jl:201; (::VSCodeServer.var"#55#59"...       
    ╎     1877 @Base\logging.jl:603; with_logger
    ╎    ╎ 1877 @Base\logging.jl:491; with_logstate(f::Function...
    ╎    ╎  1877 ...ver\src\eval.jl:124; (::VSCodeServer.var"#56#6...        
    ╎    ╎   1877 ...ver\src\repl.jl:36; hideprompt(f::VSCodeServe...
    ╎    ╎    1877 ...ver\src\eval.jl:153; (::VSCodeServer.var"#57#...       
    ╎    ╎     1877 ...er\src\repl.jl:185; withpath(f::VSCodeServe...        
    ╎    ╎    ╎ 1877 ...er\src\eval.jl:155; (::VSCodeServer.var"#5...        
    ╎    ╎    ╎  1877 ...r\src\eval.jl:209; inlineeval##kw
    ╎    ╎    ╎   1877 ...r\src\eval.jl:211; inlineeval(m::Module,...        
    ╎    ╎    ╎    1877 ...essentials.jl:706; invokelatest(::Any, :...
    ╎    ╎    ╎     1877 ...ssentials.jl:708; invokelatest(::Any, ...        
    ╎    ╎    ╎    ╎ 1877 ...\loading.jl:1116; include_string(mape...        
    ╎    ╎    ╎    ╎  1877 @Base\boot.jl:360; eval
   1╎    ╎    ╎    ╎   1    ...\Profile.jl:352; stop_timer()
    ╎    ╎    ╎    ╎   1686 ...profiler.jl:167; mydays(n::Int64)
 267╎    ╎    ╎    ╎    1686 ...profiler.jl:173; work()
    ╎    ╎    ╎    ╎     1419 ...rofiler.jl:157; busywait
1418╎    ╎    ╎    ╎    ╎ 1419 @Base\int.jl:87; +
    ╎    ╎    ╎    ╎   190  ...profiler.jl:168; mydays(n::Int64)
  29╎    ╎    ╎    ╎    190  ...profiler.jl:174; gym()
    ╎    ╎    ╎    ╎     161  ...rofiler.jl:157; busywait
 161╎    ╎    ╎    ╎    ╎ 161  @Base\int.jl:87; +
Total snapshots: 1877

1686/ 1877 = 0.89824

Takeaway: in profiler tree: the indentation indicates who called `whom` 

Information is attributed to the entire call sequence 
(aggregated in al time spent in that particular line of code )
TODO: 
Q. what is an overhead, & overcount #Research 
"""


Profile.print(format = :tree)