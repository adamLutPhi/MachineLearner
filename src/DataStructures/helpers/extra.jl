
#==#
#Ratios.BisectSort()
@propagate_inbounds function div(n=10,m=6)   #inline's maximum is slower its counterparty by factor of 2.6928 
   k=m
    @inbounds for i ∈ 1:k
    n /= m 
    end
end
@propagate_inbounds function mul(n=10,m=6)
    k = m 
   @inbounds for i ∈ 1:k    
        n *= m  
    end
end 
#inline is not the best  for speed
  @inline function div2(n=10,m=6)    # the fastest 
   k=m
    @inbounds for i ∈ 1:k
    n /= m 
    end
end
#-----------------------
t1 = @benchmark div()
t2 = @benchmark div2()


maxt1 = maximum(t1)
maxt2   = maximum(t2)

maxt1.time/mint1.time # 
mint1.time/maxt1.time

maxratio = maxt1.time / maxt2.time #max time of div1  is larger  than max time of div2 by factor of 2.6928 
minratio = mint1.time/mint2.time  # minimum is equal for div1 & div2 
#Idea: min-max matrix 
#vcat([maxt1/maxt2,maxt1/mint2]) 

#meanDiv2ns = median(t2)
#modeDiv2ns = mode(t2)
#stdDiv2ns = std(t2)

mint1.time = minimum(t1)

#--------------

avg = 0
tmul = @benchmark mul()#10^6 

maxi = 100
count=0
tmul = @benchmark mul()#
#---------------------------------------------------
@inbounds for i ∈ 1:maxi #is 10_000
    tmul = @benchmark mul()#
    tmul
    maxm = maximum(tmul.times)
    count += maxm
end
count #count = 55975
avg = count/maxi #population MostLikelihoodEstimae =  E(x)=avg =55.975
sampleMax=maximum(tmul)
#tmul.median
sampletime = sampleMax.time #143.3 # is it higher or lower of the 'Normal'?
sampletime/avg #2.56 Infer: sample is higher by factor of 2.56 # standard deviant got to be high as well
dispersion = sampletime- avg# 87.32499
dispersion/sampletime/avg #idea 0.01 (pvalue significant)

mint2 = minimum(t2)

mint1.time/mint2.time
mint1.time ≈ mint2.time
mint1.time == mint2.time

#=
BenchmarkTools.Trial: 10000 samples with 1000 evaluations.
 Range (min … max):  1.400 ns … 143.300 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     1.500 ns               ┊ GC (median):    0.00%
 Time  (mean ± σ):   1.637 ns ±   2.125 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ██ ▃  ▂ ▁                                                   ▂
  ██▁█▁██▁█▁▇▁▇▄▁▅▁▄▁▄▃▁▁▁▁▁▃▁▁▁▁▄▄▁▁▁▃▁▅▃▁▄▁▁▁▃▃▁▁▁▃▁▄▃▁▄▁▁▃ █
  1.4 ns       Histogram: log(frequency) by time       4.8 ns <
  
julia> dump(tmul)

  params: BenchmarkTools.Parameters
.....
     seconds: Float64 5.0
    time_tolerance: Float64 0.05
    memory_tolerance: Float64 0.01
....
julia>     gcsample: Bool falseBenchmarkTools.Trial: 10000 samples with 1000 evaluations.
 Range (min … max):  1.400 ns … 143.300 ns  ┊ GC (min … max): 0.00% … 0.00%
 Time  (median):     1.500 ns               ┊ GC (median):    0.00%
 Time  (mean ± σ):   1.637 ns ±   2.125 ns  ┊ GC (mean ± σ):  0.00% ± 0.00%

  ██ ▃  ▂ ▁                                                   ▂
  ██▁█▁██▁█▁▇▁▇▄▁▅▁▄▁▄▃▁▁▁▁▁▃▁▁▁▁▄▄▁▁▁▃▁▅▃▁▄▁▁▁▃▃▁▁▁▃▁▄▃▁▄▁▁▃ █
  1.4 ns       Histogram: log(frequency) by time       4.8 ns <
vial info:
    seconds: Float64 5.0

    time_tolerance: Float64 0.05
    memory_tolerance: Float64 0.01

    -----------
Lesson learned:population (of the poulation) : returned time could be dubious, depending on the distribution of variance (which is nasty indee d) 
#=stil, giving emphasis on just the mean, could mean turning a blind eye on possible meaningful anomalies 
most data is ranged differently according to its interval (interval analysis ?) 
    a fast fourier  would enhance analysis but the best approach would be a "weighted kernel approach"
that too may not possible even explain the existence of such anomalies, in general-  not only in this one
mint2 = minimum(t2)

mint1.time/mint2.time
mint1.time ≈ mint2.time
mint1.time == mint2.time

------------------