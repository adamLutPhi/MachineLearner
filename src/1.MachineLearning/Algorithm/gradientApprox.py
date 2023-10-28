#NPTEL - computation course

#example1
#1. check equal length 
import numpy
import numpy as np

def initMat(x):
    """
    initializes a list x, transforming it into a numpy `array`

    input:
    -----
    x : list vector [Warning: no bounded limit on its dimension is set ]

    
    """
    return numpy.array(x)


#Theory 
def dot1D(a , b):

    """returns the dot product
    Assuming a , b are equal in dimensiom
    """
    
    return np.dot( a[i] * b[i])
    


def dot2D(a,b):

    """returns the dot product
    Assuming a , b are equal in dimensiom

    Input:
    -----
    a: vector, 1-Dimensional [ dim(a) = 1 ]
    b: vector, 1-Dimensional [ dim(b) = 1 ]

    Processing:
    ----------
    Note: assumes inputs: a,b are of the same dimension (size)
    1.  each row in the first is multiplied with each column in the second vector b 
    Output:
    -------
    
    # Example 
 
    >>
    #Input:
    ##1.inputs:
    
    a =  [[1,2,3], [3,4,5]]
    b =  [[1,2,3], [3,4,5]]
    ## 2. Processing:
    >>
    c = dot2D(a,b)

    # 3. Output:
    >> print( c )
    >>[14, 50]
    
    """
    
    l = []
    for i in range( len(a) ):
        l.append( np.dot(a[i] , b[i] ) )
    return l

        
a =  [[1,2,3], [3,4,5]]
b =  [[1,2,3], [3,4,5]]

A = [1,2,3]
B = [3,5,6]
c = dot2D(a,b) # DEbugs
print("c =",c)

def init_vector(x):
    return numpy.array(x)

A = init_vector(A)
B = init_vector(B)
print("A = ", A)
print("B= ",B)
print("type(A) = ", type(A) )
print("type(B)= ", type(B) ) 

A2 = A.T * A
print("A2 = ", A2)
I = numpy.invert(A).T * A
print("I = ", I)

def LU(l,u):
    return L * u

def outerProduct(X,b):
    return X @ b.T # or mat_mul()


class feedForwardNetwork:

    """
    Feed Forward
    by taking linear combination (of non-linearity )
    inputs:
    ------
    w: weights vector
    x : values vector
    """

    def __init__(self, w, x , phi, b):
    
        self.bias = bias

        _len = len(w)
        
        for i in range(_len+1):

            
            #Calc others:
            self.w[i] = w
            self.x[i] = x
            
            
            self.phi_w = [] # list of phi , of w , at

            phi_w_i_j = 0.0 

           #bias
            for j in range(len(bias) ):
                
                #insert scalar bias b into list entry j
                self.bias[j] = b
                #activation (characteristic function) phi
                self.phi[j] = phi

                # calculate the weighted average 
                w_i_j += w * x # wieghted average 

                self.phi_w[ j ] = phi(w_i_j) 

                phi_w_i_j +=   self.phi_w[ j ] + b # dim [bias = N*M + b ]
                print("phi_w_i_j =",phi_w_i_j)
                
                          
                
#outer product 
A @ A.T


L = [1 , 0]
L = init_vector(L)
print(L) # [1 0]
#source : https://math.stackexchange.com/questions/4538838/how-to-prove-this-inverse-matrix-identity?rq=1
a = [1, -1]
a = init_vector(a)

a_prime = numpy.invert(a)
I = a_prime * L * a
print("I= ", I)

#L * u

I = L.T * L
print(L) #the same vector [1 0]
print(I)#  [ -2  -6 -12]
x = numpy.kron(L, L.T)
print("kron(L) = ",x)



#source: https://www.youtube.com/watch?v=kTSKHXWlyl0
dot_prod = 0.0

def isEqualDimension(a,b):
    pass

#example 4:

A4= [ [1 ,- 6], [3,5]] # Rectangular (list)
# step1 transform data type ( list -to-> matrix)

##what if
A4_2= [ [1 - 6], [3,5]] #check output!
print("A4 = ",A4)
print("A4_2 = " , A4_2)
# assert A4 == A4_2
"""
def get nCols(x):
    >>> v = np.array([1,-1,1])
>>> print(v[0:2])
[1, -1]
>>> print(v[:])
[ 1 -1  1]
>>> print(v[0:3:2])
[1 1]
>>> C = np.array([[1,2,3],[4,5,6],[7,8,9]])
>>> print(C)
[[1 2 3]
 [4 5 6]
 [7 8 9]]
>>> print(C[:,0])
[1 4 7]
"""
#ND Matrix

def initMatNd(x):
    """
    The list comprehension method creates a new list of sublists, with each sublist corresponding to the number of rows in the matrix. We sliced sample_list to extract a chunk of “n_cols” elements from the original list, starting at index “i” and ending at index “i+n_cols”.

    The range() function is used to generate a sequence of starting indices for each row, starting at 0 and incrementing by “n_cols”.

    However, it outputs a
    list class.
    That is because, technically, it is still a list, although it has been reshaped as a matrix.
    """
        
    print(type(x))
    #unviersity of Utah 
    n_cols = len(x[:]) # x[:,None,1] # len(x[:]) #, 0] # len( x[:,[0]])
    x = [x[i:i+n_cols] for i in range(0, len(x), n_cols)]
    print(type(x) ) # it is still a list 
 
import numpy as np
    
def dot2D(a,b):

    """returns the dot product, for a 2D matrix
    using numpy's einsum `eigenvalue sum

    -note : transport operator: while it does not make a copy, it is an in fix operator ,  has zero cost

    
    Assuming a , b are equal in dimensiom
    note: a, b has to be on the same size , else it is undefined

    [1 -6
    3 5 ]   . [1 5]T
    """

    return einsum(a, b)


def dotNd(k,m,a ):
    i=0;j=0
    dot(a, b)[i,j,k,m] = sum(k[i,j,:] * b[k,:,m])
    return dot(a, b)[i,j,k,m]

#DEMO
A4 = initMatNd(A4)
#I = dotNd(A4, np.transpose(A4) , 0)
#print("I", I)


#TODO: PEP-465
     
#In-fix operator

#Application

class Card:
    """

    source:https://stackoverflow.com/questions/932328/python-defining-my-own-operators

    """
    
    # other stuff
    @staticmethod
    def fromstring(s):
        value, of, suit = s.split()
        return Card(Value[value], Suit[suit])
    

# for i in range(

#nptel : computation course ( taylor series )
    
def newtonRaphson(nSteps):
    
    """ 1. evaluate f, test its correct
        2. approximate solution L
        F'(x ) nSteps = - F(x)
        3. next x= x_n+1 = x_n + lambda s

        steplength is imortant , so step s should b satisfactory
        so, in a nonlinear solver: # use steph length control


        local convergence: using liphschitz continuity
    J calculation can be v inaccurate (causes problems )
    analytic J require some robostness
    when difference Jacobian is done poorly

    1 quanitgy stagnation (how)
    1. add errrors in function evaluagio, & deruvatuve eval tio theorem 1.1


"""
    return fac(nSteps)

def LevenbergMarquardt(x):
    """an update on the NewtonRaphson Method """
    pass

import sklearn
#uses: threadpoolctl

def getKmeeans(nClusters = 5, maxIterations =500, eps_tolerance= 1.00e-4):
    return  sklearn.cluster.KMeans(n_clusters=nClusters, init='k-means++', n_init='warn', max_iter=maxIterations, tol=eps_tolerance, verbose=0, random_state=None, copy_x=True, algorithm= 'svd') #'lloyd'
                                 
