#stableRNG 
rng = StableRNG(123)
A = randn(rng, 10, 10)
num1 = randn(rng, 1)
num2 = randn(rng, 1) # instead of randn(10, 10)
@test inv(inv(A)) ≈ A
@test inv(randn(A))

struct ratio()
    numerator
    denominator
    return numerator / denominator
end
global maxiterations = 10
@testset genericTest begin

    function half(n)
        enumerate(n)
           x = 1/a /2
        end
    end

    function iterate_sqrt(a, n, x)
        """
        a = numerator 
        x = denominator
        """
        for i = 1:n
            x = (x + a / x) / 2
        end
        return x
    end

    for (i, value) in enumerate(a)
        println("$i $value")
    end

    function fun1(ϵ, maxiterations, x = 2, min = 1, fun = iterate_sqrt(x, iterations, min))
# i doesn't matter 
        for iterations = min:maxiterations
            val = iterate_sqrt(x, iterations, min)
            ϵ = val - sqrt(x) # 1 form of difference (euclidean distance )[the Geodesic ] (optimally. should be absolute)
            @show iterations, val, ϵ

            return iterations, val, ϵ
        end
    end

function fun1(ϵ, maxiterations, x = 2, min = 1, fun = iterate_sqrt(x, iterations, min))
    # i doesn't matter 
    for i in enumerate(maxiterations)
        val = iterate_sqrt(x, i, min)
        ϵ = val - sqrt(x) # 1 form of difference (euclidean distance )[the Geodesic ] (optimally. should be absolute)
        @show i, val, ϵ

        return i, val, ϵ
    end
#end

    """
    in julia, defaults to a Double-precision, floating-point values, or like 15 decimal digits)
    """
function error()
    
end
    function printIterations(BigFloat, maxiterations = 16) # 400 binary digits, about 120 decimal places
        #enumerate(maxiterations)
        for iterations = 1:10
            val = iterate_sqrt(big"2.0", iterations, big"1.0")
            err = Float64(val - sqrt(big"2.0"))
            println("iterations = $iterations:\n    val = $val\n    err = $err")
        end
    end

     err = Float64(iterate_sqrt(big"2.0", n, big"1.0") - sqrt(big"2.0"))
    function setprecision()
        #enumerate(maxiterations)
        n= 10 
       
            enumerate(n)
            val = iterate_sqrt(big"2.0", n, big"1.0")
            err = Float64(val - sqrt(big"2.0"))
            println("iterations = $iterations:\n    val = $val\n    err = $err")
        end
    end

    # output x as HTML, with digits matching x0 printed in bold
    function matchdigits(message, pattern)
        s = string(message)
        pattern = string(pattern)
        buf = IOBuffer()
        matches = true
        i = 0
        print(buf, "<b>")
        while (i += 1) <= length(s)
            i % 70 == 0 && print(buf, "<br>")
            if matches && i <= length(pattern) && isdigit(message[i])
                if message[i] == pattern[i]
                    print(buf, message[i])
                    continue
                end
                print(buf, "</b>")
                matches = false
            end
            print(buf, message[i])
        end
        matches && print(buf, "</b>")
        HTML(String(take!(buf)))
    end
    using Interact
    range = 0:12
    function setprecision(BigFloat, fun = iterate_sqrt(x, range, iterations)) # 4000 binary digits, about 1200 decimal places

        @manipulate for n = 0:12
            print(typeof(n))
            matchdigits(iterate_sqrt(big(2), n, big(1)), sqrt(big(2)))
        end
    end

    #

    setprecision(BigFloat, maxiterations) # =16
    for range = 0:10
        display(matchdigits(iterate_sqrt(big(2), n, big(1)), sqrt(big(2))))
    end
end