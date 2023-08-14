import numpy
from numpy import array
# def 
Q = [[9,3,4], [2,5,3]]
q = [1,2,3]
Q = array(Q)
def getWeightedInput(capitalQ=Q.T , minQ=q): #, n=2):
    for i in range(len(n)): # [0,1] #[0, 5]
        capitalQ[i]
        for j in range (len( minQ ) ):
           capitalQ[i] * minQ(j)
            
    return capitalQ* minQ
    


def getGramSchmidt( y, capitalQ=Q.T , minQ=q ):
    """
    input:
    =----

    processing 
    v: input vector, to fill in  
    """
    #prepare input vector 
    tmp = GramSchmidtInit(capitalQ=Q.T , minQ=q) #[]
    v = tmp[0]
    varNorm = 0.0
    variance = 0.0
    _sum = 0.0
    
    for i in range(n): # [0,1] #[0, 5]

        #calculate variance 
        varNorm =(i[i] - y[i])**2
        
        variance += varNorm

        # v * varNorm
        #calculate sum
        
        _sum += varNorm  
    return [_sum, variance ]



def combineLinearly(x , A, C , PHI):
    """ linearly combine elements
            
    input:
    -----
    A:

    C: coefficients 
    """
    y= []
    _sum = 0.0
    ratio = 0.0
    ratioCoeffs= []
    terms = []
    for i in range(len(x)):
        for j in range (len(PHI)):

            #1. set the Coefficient ratio
            if C[i]==0:
                #if so, do not continue any further
                return
            elif C[i] != 0:
                #2. otherwise
                ## find Coefficient raatio (of matricies (vectors A[i] , C[i] )
                
                ratioCoeff = (A[i]/C[i]) # condition Discovered: C[i] != 0 
                ratioCoeffs.append(ratioCoeff) 

                # calculate the resultant term, by multiplying the inner product
                ## the  Characteristic function ( Activation function) at i , j  = 1,2, ... , evaluated at value x[i]
                
                term = ratioCoeff * PHI[j](x[i])
                terms.append(term)
                # y.append( (A[i]/C[i]) * PHI[j](x[i]) )

                y.append( term) #(A[i]/C[i]) * PHI[j](x[i]) )
        
                _sum += term
            


    return [_sum , ratioCoeffs , terms]

def delta(q):

    pass

def CorrelationR(a,b):
    """gets the correlation matrix of both inputs: a, b """

def covariance(a,b):
    pass

def equation4(delta, q, R ):
    """returns equation 4 """ 
    return delta(q) * R.T * q

#TODO:
##    equation4(delta, q, R) = 0
def solve(delta, q, R, eps):
    """solve the (non)linear equation, using numpy's `hyperopt` comes in ,along with  perturbation eps"""
    
from numpy import cos, sin

# transform : coordinates: cartesian to polar (cylindrical 

#
def getdistancetoOrigin(x1,y1, x2, y2):
    return ((x2 - x1)**2 + (y2- y1)**2 )**(1/2)


def getx(r, theta):
    return r * cos(theta)

def getY(r,  theta):
    return r * sin(theta)

"""from r , theta
r_hat
theta_hat
"""

def getCylindicalPatameters(theta, x_hat, y_hat):
    r_hat = cos(theta) * x_hat + sin(theta) * y_hat

    theta_hat = - sin(theta) * x_hat + cos(theta) * y_hat

    return r_hat, theta_hat

def getCartesian( r, theta, r_hat, theta_hat  ):

    x_hat = cos(theta) *r_hat - sin(theta) * theta_hat
    y_hat = sin(theta) * r_hat + cos(theta) * theta_hat 

    return x_hat, y_hat

    # how to converet it to a cylindrical system



#def del(x_hat , y_hat, var = r_hat, wrt = r ):
"""
    1. What is d / dx (x_hat) : the change of x, along the x-direction w.r.t x
                        d / dx (x_hat) = 0

    2. What is d / dx (x_hat): the change of x, along the y-direction w.r.t y
                            d / dx (x_hat) =0

    3. What is d / dz (x_hat) : the change of x along the z-diretionde w.r.t z

    Example for the equation:
    cos(theta) * x_hat + sin(theta) * y_hat

    change (innovation) for r:
    d / d r = (r_hat) = d/dr cos(theta) * x_hat + sin(theta) * y_hat)

    change (innovation) for  theta:

    d/ d theta (r_hat)  = d/d theta * (cos(theta) * x_hat + sin(theta) * y_hat


"""
#    pass

def getCylindricalFunction( x_hat , y_hat):

    """
   r_hat =  (cos(theta) x_hat + sin(theta) * y-hat
    """
    return cos(theta) * x_hat + sin(theta) * y_hat

def equation(Lhs, Rhs, LhsValue, RhsValue):
    pass

from math import pi, log10, sqrt
def altCosInverse(theta) :
    return pi/2 + j * log10( sqrt(1 - theta**2 ) + j * theta )


def getIV():
    """ d d/z (r_hat) = 0
        d/d r( theta_hat) = 0
        d / d (theta_hat) =  - r_hat
        d / f z ( theta_hat) = 0
    [0, -r_hat , 0 ] 
        d / dr (z_hat )  = 0
        d/d theta(z_hat) = 0
        d/ d zeta( z_hat) = 0
    [0,0,0]
        
       d/dz (z_hat) = 0

    2. non-trivial quantities
    
    """


"""
Gradient operator in cylindrical coordinates

Grad =

(r_hat * cos(theta) - theta_hat * sin(theta)) , (  r_hat * sin(theta) + theta_hat * cos(theta) )


# for odd numbers: op = *
# for even numbers: op = +

derivs = [drdx  ,  dthetadr ] op [ ddr , ddtheta]

theta = tan^-1( y/x)

"""
def getWeight(w, i):
    n = len(w)
    for j in range(n): #1,n,1):
        #If there is a match
        if i !=j:
            continue
        elif i == j:
            return w[j]#-1]

        else:
            raise Exception(exceptionMsg)

def getInnovation(innovation, i):
    n = len(innovation)
        
    for j in range(n): #1,n,1):
        #If there is a match
        if i !=j:
            continue
        elif i == j:
            return innovation[j]  #-1]

        else:
            raise Exception(exceptionMsg)

from numpy import ones
x_hat = 0.25 ; x_hat2 = 0.30
y_hat = 0.45 ; y_hat2 = 0.55
z_hat = 0.10 ; z_hat2 = 0.00
T = ones(3)
denominator = (T[-1] - T[-2])

#note derivatives still need normalization 
ddx = (x_hat2 - x_hat)/ denominator

ddy = (y_hat2 - y_hat) / denominator
ddz = (z_hat2 - z_hat) / denominator

weight = [ x_hat , y_hat , z_hat]
innovation = [ddx , ddy , ddz ]
_sum = 0.0
print(weight )

for i in range(len(weight)):
    weight[i] = getWeight(weight , i)
    print("weight[i] =", weight[i])
    innovation[i] = getInnovation(innovation, i)
    print("innovation[i] =", innovation[i])
    _sum = weight[i] * innovation[i]
    print("inner prodct (sum) = ", _sum) # non=convergent


    

