
#how julia builds code

"""

1.text Files read as a string 
2.-julia lets Files gets parsed into Julia `Expr`
`Expr`: a structured representation of the code (you wrote)

3.it organizes structures (for you)- you can manipulate, 
so that you don't do that (as a form of Raw Strings)

e.g. 
Matching the paranthesises

- Expressions get lowered (@code_lowered) to this lowered representation llvm
e.g. you're v. familiar in seeing this message
the `Info: pre-compiling...` message, when you update a package (or install a new one)
Tip: this (llvm) is mosly what gets saved to a file when that happens 


juila is parsing text files into Expressions
2. then lowering them 
3. then julia saves the lowered code to a file 
(on your harddrive)

it can save that work, next time you run julia 

the package is asked for additional information (to be stored )
    
- There is more information into those pre-compile files - only most of what's happening (code also turned to be native )
#--------

when you call `f(args...)` either 

-the native code gets looked up in the in-memory torage & then runs (typo @ 22:42)
OR:

1. f gets type-inferred for the argument types 
2. th type-inferred code gets optimized by Julia (this gets stored in memory)
3. the result gets compiled by LLVM (this also gets stored in memory)
4. Julia runs the compiled code 

when you use a package, it loads that past file - that has lowered code stored in it 
whenever you make a function call, either
    if already compiled, julia has it in memory 
        it will look it up , & run it 
        or 
    if never called it before,  then 
    Julia will Perform type inference for specific types of arguments that 
    you're passing in , 
    that type-inferred code gets optimized (optimize=true stage)
    result gets compiled by an LLVM
    finally, it will run the compile code 
#------Dispatch runtime vs compile-time 

Hoping you'd appreciate the importance of types to Julia's performance


Remember the addTwo 
this leaves a question open 

what is this + here? 

+ is a function call , generic , 200 methods (more if we loaded additional packages)
(as packages can extend functions)

How does julia know which (of the methods)is the right one? 

It chooses the `Most specific method` for the the types of an argument 

types of the argument(here ): x[1] , x[2]
could've been written as:
+(x[1] , x[2]) #then, it'd be more appearant this is a function call , by plus 
which is the applicable one here- 
we can see the decision process using @code_typed (it hates the UndefVars )
give all arguments a value for  addTwo( x[1] , x[2])
    @code_typed: answers which of methods gets called 
"""
addTwo(x) = x[1] + x[2]
"""adding 2 numbers"""
@code_typed optimize = false addTwo(1, 2.0) #Any[] #no problem

#again rewriting in another way:
addTwo(x) = +(x[1], x[2])
"""
CodeInfo(
1 ─ %1 = Base.getindex(x, 1)::Int64
│   %2 = Base.getindex(x, 2)::Float64
│   %3 = (%1 + %2)::Float64
└──      return %3
) => Float64
"""
@code_typed optimize = false addTwo((1, 2.0)) #Any[]
#=
since it's a typed code, it can figure out which method is the one 
(applicable for those 2 types):
while compiling this code, 
    figure out which method is the one applicable 
for those 2 types 
-the point: it didn't have to run the code (to figure it out )

the Magic: type-infernce : when i run this code, what types will %1 & %2 be ?

If know with certainty, then I can figure out which method will 
Be applicable to them  (at the time I'm building the code ) - not at the time I'm running 

here's julia main Performance bit of  magic: 
takeaway: 
instead of running it with optimize=false  , can see having figured out which method is gonna be called, in optimize=true 
=#
@code_typed optimize=true addTwo((1, 2.0)) #optimize=true performing inlining: inline_expansion

 """
 this ability to 'pear-in the future' 
 & look-up the functions ahead of time 
 is again a key component 

 this is called 
 "Compile-time Dispatch"

 meaning choosing hich method 
 will get executed happens when the calling function is being compiled 

alternative is called runtime Dispatch
we're gonna defeat the ability of julia's 


takeaway:type-inference engine (will) work
by creating a Vector that contains "No Information about the types (of objects) stored in it  "

others like: vector int , Float64, nut this line will gonna create a vector of Any 
"""

@code_typed optimize =true addTwo(Any[1,2.0]) ## call irt on a Vector(Any) 

#=
Literally any kind of Object, String , a Dictionary,an image, anything you want  
Might be stored in the slots of this Vector 
takeaway: Julia Cannot Predict the types of the Object that will be gen_call_with_extracted_types_and_kwargs  under any circumstances, 

therefore eventhough we turned on optimize = true , you'd hope julia will do all types of inlining 
-heere thre's nothing to inline - it has no clue what method 
+ will be applicable in this circumstance

the first object of type Any - julia has no Idea what type it is 
2nd tye: inferred to be a type Any , therefore + is also any  
why: if it doesn't know the inputs gonna be , it can't figure out what the 
output is gonna be 

julia knows very very little here  
 & it's not made any sort of progress on optimizing your code 
 for  this particular caes 

this ould have then to be executed by a runtime dispach 
=#

"""
1.It knows this arrayref is gonna be called (that's progress of perform)
2.It Doesn't know what the result will be 
that reason it knows 

vector of any isn't the type 
vector of any isn't the type (that julia understands)
that part is a concrete type can figureout 
what's gonna be called here 

but it doesn't know what the result will be  

takeaway: the key decision has to be made, once called the + operator 

(it depends on the arguments)

Only piece of information, julia has to go on  - It doesn't get very far 

means: this method will be looked up & called when the function is running 

this is called run-time 