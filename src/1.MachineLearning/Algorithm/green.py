import numpy
import scipy
 

def Norm1(x, normOrder= 0):
    return scipy.linalg.norm(numpy.array(x, normOrder))
                      
def Norm2(a,b, normOrder= 0):
    #TODO: dot product: a* b
    x = a*b
    # sp.linalg.LinAlgError
    return scipy.linalg.norm(numpy.array(x, normOrder))

def modifyNonList(x):
    """to solve the first issue (whether it is  something or list`
    works when comparing `int` , and changes it to a list

    Note: only works for 1-D data 

    see also:

    1.related functions: morph(x, _lenOther)
    2. composite functions: `Norm(a,b,normOrder=None)`
"""

    _lenX = 0
    if( type(x) == list):
        _lenX = len(x)
    else:
        pass #no change
        #_lenX = 0
    return _lenX

def morph(x, _lenOther):
    """ changes the small one, to suit the the length of the other""" 
    return numpy.reshape(x, (1,_lenOther) )

# another way for forming a Norm


def Norm(a,b,normOrder=None): #best 
    """for 1D data """
    _lenA = 0; _lenB = 0;
    print(a)
    print(b)

    #if not equal , find which is the longest
    #do: more Type-oriented programming

    #Type-check a & b , then modify

    a = modifyNonList(a) # instead of len(a)
    b = modifyNonList(b) # instead of len(b)
    
    _lenA =  a
    _lenB = b
    masterLength = -1
    #by default: _lenA == _lenB ; if not, do the following (sub-routine):

    #0. modify b to suit a's length
    if _lenA > _lenB:

        masterLength = _lenA
        # change (morph) the small part
        #b = numpy.reshape(b, (1,_lenA) )
        b = morph(b, _lenA)

    #modify a to suit a's length   
    elif _lenB > _lenA: 
        masterLength = _lenB
        #change (morph) the small part 
        a = numpy.reshape( a, (1, _lenB) )
        a = morph(a, _lenA)

        
        
    #1. dot product (of 2 vectors):
    x = a * b 

    #2. calculate the norm (given vector x,  `normOrder` 
    #return numpy.linalg.dot(a, b ) #<---- UnboundLocalError: np
    return scipy.linalg.norm(numpy.array(x, normOrder))
    # sp.linalg.inf

    """
    formsa a 1-D or 2-D
    (unless order `ord = None`
    Note: If both axis and ord are None, the 2-norm of a.ravel will be returned.
    """
    
    answer = -1
    
    #check if equals 
    if len(a) == len(b):
        
        #dimensions must match
        ##In that case, append b to a
        a =  np.dot(a,b) #np.@(a,b) #a.append(b)
        #scipy.linalg.norm(a, ord = order, axis = None, keepdims=True,check_finite = True)
        #keepdims = True : to normalize `axes` over , resulting a dimensions = 1 ( 
        # check_finite = True: checks for non-finite values (i.e. possible nans Nans) 
        #answer = scipy.linalg.norm( a = a , ord = sc.linalg.norm(a, axis=1) , axis = None, keepdims=True,check_finite = True)
        print(a)

        #grand idea: for comple analysis : 
        # answer = scipy.linalg.norm(np.array( [1e-5, 1e-5,1e-5, 1e-5]), None)  #numpy.linalg.norm( numpy.dot(a.real, b.real) + dot(a.imag, b.imag),  axis=None)# , keepdims=False) #<----
        answer = Norm1(a, None) 
    # pass
    return answer


def Green(a,b):
    """ Note: this is only a place holder (of the actual function ) (and not the function itself"""

    return Norm(a,b)
#from math import  abs, max, min # functions are built-in with current language
def distanceMeasure2(a,b):
    """finds the measure, based on the absolute value of the `variational distance`"""
    return abs( max(a,b) - min(a,b) )

def distanceMeasure1(a,b):
    """find nthe distance , based on squaring the `Variational Distance` """
    
    return  ( a - b)**2

def D(Fun):
    """ To Do: differentiate the function, iterativelyh (i.e. as much times as required)
    returns
    teh function itself
    Idea: the implementation of the function
    here:
    For a Green's function, return Dirac's Delta 
    dirac's delta
    
    """
    return Fun

#global dumy placeholder variable
#TODO: add optimization algorithm that searches and returns the `optimal` found solutions, as a vector `t` 
t_j_center = 0

def regularizationTerm(Lambda):
    """WARNING: D: differential operator
    And F_star is a function (or matrix)
    - The Differential Operator is supposed to able to differentiate F_star
    (Whatever it might be)
    [Most likely: a Polynomial]
    """
    
    return lambda D, F_star: Lambda *  Green( D(F_star), t_j_center )  #<----
Lambda = 1
F_star= 1 # TODO: Polynomial (TO Build)
DifferentialOperator = D # int: ERROR: non-callable function (solution: replace witha a function Delegate (name) )

def regularizationTermDemo(DifferentialOperator, Lambda):

    #call regularizationTerm(Lambda) 
    anonfunction = regularizationTerm(Lambda)

    print( "anonfunction (Signature): ", anonfunction )  # a valid lambda function 

    print("D(F*) = ", DifferentialOperator(F_star))#convolution operator 

    #Instantiate ( realize ) the new anonfunction using
    ##1. DifferentialOperator D (a function [Delegate] (i.e. name) )
    
    ##2. F_star (F*) : value (for the (Differential) function, required to instantiate
    result =  anonfunction( DifferentialOperator,  F_star  )   # 0.0 # correct answer

    print ("anonfunction_applied(D, F*) = ",result )
    return result

anonfunction = regularizationTerm(Lambda)
print( "anonfunction (Signature): ", anonfunction )  # a valid lambda function 
print("D(F*) = ", DifferentialOperator(F_star))#convolution operator 
#print("D(F*) = ", DifferentialOperator(F_star))#convolution operator 

print ("anonfunction_applied(D, F*) = ", anonfunction( DifferentialOperator,  F_star  ) )  # 0.0 # correct answer


# Regularization :DEMO
## Assign an anonymous function

anonfunction = regularizationTerm(Lambda)

print( "anonfunction (Signature): ", anonfunction )  # a valid lambda function 



### evaluate lambda
#desired function implementation :

a =  DifferentialOperator(F_star) #convolution operator 
print("Differential Function type = ", type(a) )

##Erroneous: scalar arrays can be conveted to a scalar index

# print ("anonfunction_applied(D, F*) = ", anonfunction( DifferentialOperator,  F_star  ) )  # 0.0 # correct answer

#overview regularization
## a Survival function:
### represents a shock wave : high at first, then it slowly dies out , in a
### <some particular manner> (me: it could be equal to the half-life of some material )
### (or it could be more sophisticated function, as well )


#anonFunction = regularizationTerm(Lambda)
#print(anonfunction( DifferentialOperator, F_star ) ) #<-----



# F* (for 1-D input (a , b)

def F_star(x, N, m1, w,t , d , G = Green ,step_size=1):
    """
    Argument Input:

    #1. input:
    x: data (here: the dot product (a, b) 

    N:  dim1 : dimension of a (the 1st one) : int `Integer`
    m1: dim2 :  dimension of b (the 2nd one): int `Integer`
    d:  distance function
    G:  Green's function ( the Norm)

    #2.Processing:
    Calculates 2 sums:

    1. in the 1st loop: `partialSum`
    2. 2nd loop: global sum: adds up the distance measure (between `d` and the `partialSum`)

    #3. Output:
        returns `globalSum`
    
    """
    # in the best cases :
    ## vanilla assumption: it's best value when : N = m1
    
    a1 = 1
    b1 = N

    a2 = 1
    b2 = m1
    
    partialSum = 0; globalSum =0
    #loop1: depends on loop2: waits it to finish, then value is calculated: d[i] - partialSum
    for i in range(a1, len(a), step_size): #range(a1, b1, step_size):

        #loop2: calculates partial sum (Green function G , weighted with w[i]
        for j in range(a2, len(a), step_size): # range(a2, b2, step_size):
        
            #Issue:  to resolve: give me the gist of data (so , instead of scalar, get the `container, it is contained in
            ##resolution: involves getting the whole set of data (and not just anamolous data like min or max )

            print("w",w)
            print("w[i]",w[i])
            print("x", x) #Scalar 9.0
            print("x[i]",x[i])
            print("t[j]",t[j])#<-----
            partialSum += w[i] * G( Norm(x[i], t[j]) , b) # <--IndexError: invalid index to scalar variable. (python means: unexpected scalar (expecting a list, not a scalar)  
            
            #   d[i] - Sum[j= 1, m1] w[i] * G( Norm(x[i], t[j]) ) )  #||x[i] - t[j] || )
            # Calculate distance Measure, then add it to the globalSum
            # (d[i] - partialSum )^2
            globalSum += distanceMeasure1( d[i] , partialSum  )

        #pass
    return globalSum

def getDifference(a,b):
    """ todo: a higher order of optimization
    - as we are unsure whether we are at a low or height

    Mini-max function would optimize the vectors a, b for us #TODO:

    me: how much difference is required
    Say, how much difference is different?

    should we really throw every out , to get what we want?
    or can we keep them ?
    """ 

    #return  max(a,b) - min(a,b)#  a - b
    #return  a - b

    #Common-wealth mini-max Algorithm
    
    #1. get the min vector , then maximize it
    # Crucial Note : assumes function is continuous , whereas values are reachable
    # But, otherwise,  if they are not reachable, then we have to do some `fix` i.e.:
    ##So to avoid function issues,
    #Apply-Next:

    ##1. Instead of `max`, supremum `sup` [Maximum generalization: a function that approaches the max (from the left, or right hand side ]
    ##2. Instead of `min`: infimum `inf` [Minimum generalization: function that approaches the min (from left , or right hand side) ]
    ## Note: to do the above, an Analysis theory is required (  whether it is real , or complex )

    #Attention: this  line is the root of all evil: it throws the baby with its  bathwater (so no lessons are more to be learned):  we are dispensing  valuable information [which we may later need] about our data
    
    max_a =  max(a) # just get the max (of a min list ) 
    min_b = min(b) # just get the min (of the max list )

    return max_a - min_b
    #return  max(max_a , min_b) - min( max_a , min_b )#  a - b # well, it doesn't error out , it finds values, that we asked it to do ( Greedily)

    
#Demo: say we have the following 2 1-D vectors:

a=[1,2,3]
b=[1,1,1]

#level1: Norm Demo 
print("Norm value:")
print( Norm(a,b) )  # normalize: get the `dot product`

x= Norm(a,b)

#Level2: Green's function Demo:

print("Green's value:") 
Green(a,b) #TODO: calculate the Green's function : for demo purposes only [ calls Norm(a,b) ]

#Level3: demo F_star:


#full equation: f*(x) + regularization(D(F_star(x) ) 
""" F_star(x) #TODO: """

w = [1,1,1]
m1 = 10
N = m1
#centers (from optimization)
t = [0.5, 0.65, 0.51]

#require: difference (between Desired vector `b` & calculate vector(by Optimization  `t` ) - here:it's just a `placeholder`
d = getDifference( b , t) # final output (Desired) b - calculated (from Optimization function) t 
#now, we can calculate F*:

#set data array

#1. check shape
a =  numpy.array(a)
b = numpy.array(b)
#m= b.@.a numpy.@

print("a dims = ",a.shape)
print("b dims = ",b.shape)

# data = numpy.concatenate( a, b ) # couldn't concatenate 
## print("data = ",data)

##I = np.ones( a.shape, dtype= 'int') #(a,),dtype='int64')
I = numpy.eye(3)

#The correct way is to input the two arrays as a tuple:
print("concatenate = ", numpy.concatenate( (a,a)) ) 

data1 = numpy.append( a,a.T)
print("data1 = ", data1)
data = numpy.concatenate( (a,a))

# data = numpy.append( (a, a.T) )

# data = numpy.concatenate( a, a.T )

#data = numpy.concatenate( a, b.T )

# to ease of use : set d to desired output , say `b` (i.e. desired is the second input vector 
d = b #  #  4.0 

"""Uncomment me:
##but, what if:
d = t # F* = 1.3652000000000002
"""
#interpretation:
""""when d = t
F* (me: cumulative variation value of errors ) is smaller to 0 (small)
"""

final_result = F_star(data, N, m1, w, t, d)

print("final result", final_result) #  4.0




