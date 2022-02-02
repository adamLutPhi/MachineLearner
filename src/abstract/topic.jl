"""Name:
topic (or subject) -whicever fits best 
"""
struct topic <: idea 

    function topic() end 
    function topic(id,name,meta )
        id = id 
        name = name
        meta = meta
    end 
    function debate(Set{concept} ) #, Set{topic}, Set{issue})
end