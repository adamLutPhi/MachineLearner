abstract type NN end

struct Network <: NN

    id::Inf64
    name::string 
    obj::Any

    Synapse[i] #synapses#  are always between the axon of one neuron and the sum[Op: operation] of another. 
    #Q1. is this the best representation ?
    #Q2.how about a network of meta-conns(you know, with amongst synapses ) ? 
    
    axon #Q3. how does this make the synapse better ? [ isa significant axon asif it hasa `distict features` ]  
    
    
    
end 



