using Distributions
import Statistics, Plots #Warning: unrecommened - to the personal standard- Reason: has a huge set of other packages- once initial deguggin finished -Remove 
import AbstractPlotting.MakieLayout
#--- Bernoulli

"""  
Returns a Bernoulli Probability Density Function (PDF) that is;

1. Discrete process  
2. I.I.D

"""
function pdf(ntimes)

  return Bernoulli(ntimes)
end

function cdf(pdf, x)
  return sum(pdf(x)) #discrete sum 
end
#function #later

function sign(value = 0.5, comparisonFunction = rand(), trueValue = -1, falseValue = 1)

  multiplier += ifelse(comparisonFunction < value, trueValue, falseValue)
  return multiplier
end


"""
A function useful for benchmarking julia's statistical functions 

  tested 
"""
function _globalRandomWalker()
  @time begin
    pos = 0
    count = 0
    _mean = 0
    Mean = 0
    data = []
    numsteps = 10^4
    numwalkers = 10^4
    final_square_positions = Int[]

    for i in 1:numwalkers
      for j in 1:numsteps
        pos += ifelse(rand() < 0.5, -1, +1)
        count += 1
      end
      push!(final_square_positions, pos^2)
      push!(data, pos)
    end
    println("Total Displacement " * string(pos))
    _mean = pos / count #adding  a naive arithmetic mean
    Mean = Statistics.mean(final_square_positions)
    println("Mean Displacement " * string(_mean))
    println("Mean Squared Displacement " * string(Mean))


    return pos, _mean, Mean, data
  end
end


pos, _mean, Mean, data = _globalRandomWalker()
#root-squared mean 
trueMean = Statistics.mean(data)
n = size(data)[1]
rsMean = sqrt(Mean)
#=Q. is mean ≈ rsMean? if not , is it dispered by how much
ended up with 3 means: 
1.trueMean (based on Statistics.jl)
2.rsMean (square root of squared values) [hugely large , Disqualified] - say, what if this is the only one that truely expresses the mean?
3._mean (non-weighted, naive mean )
=#
error2 = max(_mean, rsMean) - min(_mean, rsMean) # rsMean did not work  here very smoothly 
error = max(_mean, trueMean) - min(_mean, trueMean) 
#=by only comparing the 2 results above, only a correct Mean would be close to the true one i.e. calculated naive  _mean =#
#then we can visualize error  with y     

x = 1:n; #preferable to use linspace 
y = data; # These are the plotting data
Plots.plot(x, y)



