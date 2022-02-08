
#struct approximator end

mutable struct accumulator #<: approximator

    # enum op +, -,*,/

    @enum op begin
        Add = 1
        Sub = 2
        Mul = 3
        Div = 4
    end

    function consume(op,a,b)
    if op isa Add

    elseif op isa Sub 
    elseif op isa Mul 
    elseif op isa Div 
    end
end

end
