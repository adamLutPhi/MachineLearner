


mutable struct accumulator end
export consume
#struct approximator end
#<: approximator end 

# enum op +, -,*,/

@enum op begin
    Add = 1
    Sub = 2
    Mul = 3
    Div = 4
end

function consume(op, a::Float64, b::Float64)
    if op isa Add
        #addCall(a::Float64, b::Float64)
        +(a::Float64, b::Float64)
        
    elseif op isa Sub
        #subCall()
        -(a::Float64, b::Float64)
        
    elseif op isa Mul #enough- for a banach space operations (covers  rationals  (real )
        *(a::Float64, b::Float64)
        
    elseif op isa Div # unnecessary (for the target context )
        /(a::Float64, b::Float64)       
    end
end
#TODO: Rethink a generalization about the 4 ops:
"""
we can never be sure about the Input Arguments: a  & b 
in this file in particular, we cannot preallocate static types for arguments, then
unless, once we specify one method with particular set of `preallocated` argumnets
then:
      via multi-dispatch, we are constrained by defining each and every possible method there could exist 
between the inputs a & b

returns the Sum ∑ #which sum? 

"""
function addCall(a::Array{Float64,1}, b::Array{Float64,1}) #vectors a, b 
    return Expr(:call, :+, a, b)  # a + b # do vector multiplication  #TODO:
end

function addCall(a::Array{Float64,2}, b::Array{Float64,2}) #matrix  a, b 
    return # do matrix multiplication 
end

#the following does not add any significant value:

function subCall(a, b)
    return a - b
end

function mulCall(a, b)
    return a * b
end

function divCall(a, b) 
return a / b
end

#end

function arrayOp(; op = (:+, :-, :*, :/), a::Array{Float64,1}, b::Array{Float64,1}) #vectors a, b 
    return Expr(:call, op, a, b)  # a + b # do vector multiplication  #TODO:
end  # #TODO: matrix Addition
function addCall(a::Array{Float64,1}, b::Array{Float64,1}) #vectors a, b 
    return Expr(:call, :+, a, b)  # a + b # do vector multiplication  #TODO:
end
a = rand(10, 10);
b = rand(10, 10);

function arrayOp(;op=:+, a::Matrix, b::Matrix)
end 


arrayOp()#:+, a, b)
   # addCall( )
