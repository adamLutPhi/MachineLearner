#PS: feels like an  NLP course # be more #creative [hint: meta-Idea (explaining the idea ) ] 

abstract type abstractIdea end 
struct idea <: abstractIdea 
    title::string 

    content::Any 
    Context::Any # ;)
end # what makes an idea=  {Title, content} #Context <--- how about it , too? ;)

struct metaIdea <: idea #TODO:Elaborate ...
"""
an abstract construct(ion)
Rose from an idea 
Could be useful (later...) #Q.what makes a concept, a concept? 
"""
struct concept <: idea  

end 

"""

this is a seed, help us by growing it with your support- thank you!