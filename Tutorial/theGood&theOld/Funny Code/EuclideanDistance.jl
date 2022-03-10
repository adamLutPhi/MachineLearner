#https://www.sciencedirect.com/topics/mathematics/euclidean-distance#:~:text=The%20weighted%20Euclidean%20distance%20measure,element%20of%20the%20average%20profile.

dispersion = abs(a + b)
@propagate_inbounds function EuclidDist(a, b) #sumInterval subtracts 1 (complies with julia logic)
    cond = dispersion - 1
    @inbounds if cond >= 1
        return cond
    end
end

@benchmark sumInterval(1, 10)