"""Name:
topic (or subject) -whicever fits best 
A debate is an overkill (context: this stage of development )
#temp-solution: remove (for now , only )
    - Elaborate on topic 
    - Elaborate on concept
    - Elaborate on issue 

    debate : displays an NLP applied ... sth
    we are elaborating on abstract domain 
    debate does not belong here ...

"""
struct topic <: idea 

    function topic() end #guess this is redundant# julia already develops an empty function for it 

    """topic 


    """
    function topic(id,name,meta )
        id = id 
        name = name
        meta = meta # Q1.do you mean metaIdea? #Q2.how about Idea (has alread a body ) 
    end 
    function debate(Set{concept} ) #, Set{topic}, Set{issue})
end