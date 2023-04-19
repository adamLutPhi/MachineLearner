# -*- coding: utf-8 -*-
"""
Created on Wed Apr 19 14:38:27 2023

@author: Ahmad Lutfi
"""

# main source: for further reading: https://www.sciencedirect.com/topics/engineering/jacobian-matrix
# Jacobian matrix or simply Jacobian is a matrix which is required for the conversion of surface and volume integrals from one coordinate system to another
# in a `cartesian` space: mapping  the velocities

# Cross-reference:  Mean Squared Error, Deconstructed
#    https://agupubs.onlinelibrary.wiley.com/doi/epdf/10.1029/2021MS002681

import math
from math import exp
import numpy as np

"""
weight update:

w( n+1) = ( XT(n). X(n))^-1. XT(n) . d(n)
	w( n+1) = X+. d(n)
X+ = [ XT(n). X(n) ]^-1.  XT(n)

class

----
# Eta (Hykin's)

0 < Eta < 2/ lambda_max

0 < Eta < 2 / MSE #( Mean-Square values)

"""


def initMat(X):
    return np.array(X)


def matmul(A, B):
    """if  it's just the dotProduct,  """

    return A @ B

# Derivation


def deltaGeneral(x, h=0.1, n=1):  # h=1,n=0 ):
    """Get the generalized delta for a given location `x`, stepsize `h`, and Iteration `n`
    Input:
    - x: current location
    - n: Iteration
    - h: (next) step size

    Output:
    Returns x1,x0 (no inner computation)
    """
    # n=0: delta =  x1 - x0

    # x * [ (n+h ) + n ]
    # x*n [ (1+h/n) + 1  ] #[pssible : divide by zero
    #  3 * ( (0+1) + 0 )

    # (x + (h+n))_ x*n
    # ret= x *( (n+h ) + n ) #note :  use small parenthesis

    # ret= ( (x+(n*h )) + x*n )#try this

    # idea: return x1,x0 (no inner computation)

    return x+(n*h), x*n


def deriveForwardDividedDifference(f, delta, x):

    x1, x0 = deltaGeneral(x, delta)

    return (f(x1) - f(x0)) / delta  # x + delta ) - f(x) ) / delta

# Integration
# helper function


def fac(n):
    return n * fac(n-1) if n > 1 else 1


# demo:
factList = fac(10)
print("factorial =", factList)


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


def Jsolution():
    """TODO:"""
    # return newtonRaphson() #TODO  integrate each value poinr of function


def getJacobian(x, y):
    """TODO:
1. forward divided difference
calculus
lim f(x +deltax) - f(x) / delta(x)

taking same definitiong
f' = f(x + delta(x) - define

choose delta (x) as finite number
FDD formula [derivative(function)]
f(x+delta(x) - f(x) / delta(x)

"""
    pass

# Unsure about function implementation


def MSE(n,  lst, f):
    """ N: Number of data points, i.e. len(Input) 
    source: Mean Squared Error, Deconstructed
    https://agupubs.onlinelibrary.wiley.com/doi/epdf/10.1029/2021MS002681
    """
    N = len(lst)
    factor = 1/N
    # assume
    lst = []
    total = 0
    for yi, fi in zip(lst, lst[1:]):
        # pass-it in
        # where e (eps) = fi  - yi error (between expected and calculated)
        tmp = factor * (fi - yi)**2
        total += tmp
        lst.append(tmp)  # TODO: recheck equation

    return lst, total

# NMSE


def getNMSE(es, x):
    """ normalized MSE (NMSE)  = MSE(e)/ var_x"""

    varx = np.var(x)
    #sd = np.std(a)
    normalized = []
    for e in es:
        normalized = MSE(e) / varx
    return normalized

    # yield  factor * (fi(n) - yi(n))**2 #nope (for each input: square it


def isHykinCondition(MSE, Eta, lambda_max):
    condition = 0 < Eta < 2/lambda_max and 0 < Eta < 2 / \
        MSE  # ( Mean-Square values)

    return condition
    raise ValueError


print("Hykin condition = ", )
# if:
#    return True
# elif 0 < Eta < 2/lambda_max and 0 < Eta > 2/MSE:
#    return False

# TODO
# lambda_max =


0.01
mse = 0.001

print("bool: isHykinCondition = ", isHykinCondition(
    0.001, 0.01, 1))  # ok (recheck values)

# f( w_vector ) = x_vectorT . w_vector
# Assume we already have dont that step

a = np.array([[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]])

b = np.array([[1, 2, 3]]).T

c1 = a.dot(b)  # function
c = a @  b  # a.dot(b)
# they're equal
# ValueError: The truth value of an array with more than one element is ambiguous
# assert c1.all() == c.all()


def dot(A, B):
    return A @ B
# dot(A,B)
#print(f"dot(A,B) = {A,b}")


def _call(f, n):
    """a repeatable call """
    for _ in range(n):
        f(n)


print(f"c1 = {c1}")
print(f"c = {c}")
print(f"c1 = {c1}")
# type(c)
print(f"c = {type(c)}")
print(f"c1 = {type(c1)}")


# let x, y be random variable vectors, each of length '2'
# r.v. generation
x = np.random.random(2)
y = np.random.random(2)


def cost(x, n, m):
    """ 
    
    assuming `np.log(x[1])` is the error 
    return ratio of xn / x[m] 
Q. should np.log(x[1]))  be negligible (or iterate convergently to 0 at infinity) sothat ratio converges towards 1 
"""
    return x[n]**2 / (x[m] - np.log(x[1]))


"""
def getJacobianfromGrad(X=[5, 3]):  # TODO:
    '''Calculates the jacobian , from the gradient '''
    x = np.array(X, dtype=float)

    pass
"""
a = [5, 7, 11, 4, 5]
for m, n in zip(a, a[1:]):
    print(m, n)


def grad(x):  # 0 was
    """finds the gradient """
    _sum = 0

#TODO: UNCOMMENT ME
#for m, n in zip(a, a[1:]):
#    print( m,n)
#    _sum = x[n] - x[m]

#print( _sum)


gradient_cost = grad(cost)

print(f"gradient_cost = {gradient_cost}")


# jacobian_cost = jacobian(cost) #TODO: apply differentiation on jacobian matirx: for function f
"""#uncommentMe
#gradCost = gradient_cost(x) # Nonetype #UncommentMe

print(f"gradCost = {gradCost}")
"""

# jacobian_cost(np.array([x,x,x]))

#DEMO : Differentiation


# DEMO:
w = initMat([1.3, 2.3])   # weights, m = 5 items
e = initMat([1.4, 1.5])
wI = initMat([2.5, 3.25])  # weights, n = 5, across time steps

# Note: it's not far fetched that: each w(n), wI(n) functions, returning w[n],WI[n] each


def wwI(w, wI, n): return (w[n] - wI[n])  # w, wI , n


def getwWI(w, wI, n):  # abstract function
    _maxN = 2
    _lst = []
    val = 0

    for n in range(0, _maxN):
        print(f"maxN = {_maxN}")
        val = wwI(w, wI, n)
        _lst.append(val)
        print(f"wwI = {_lst}")  # in each iteration, show list
    return _lst


def getwWI2(w, wI, n):  # abstract function
    _maxN = 2
    _lst = []
    val = 0

    for n, m in zip(range(0, _maxN), range(0, _maxN)[1:]):

        print(f"maxN = {_maxN}")
        val = wwI(n, m, n)
        _lst.append(val)
        print(f"wwI = {_lst}")  # in each iteration, show list

    return _lst


# experimental:
def z(r, phi): return r * math.cos(phi)  # z: complex component


def jacob2(r, phi):  # z = r . cos(phi)
    return - r**2 * math.sin(phi)  # rotation


"""
_maxN = 2
_lst = []
val=0
for n in range(_maxN):
    print(f"maxN = {_maxN}" )
    val = wwI(w,wI,n)
    _lst.append(val)
    print(f"wwI = {_lst}") # so each iteration it spills out 
"""

A = np.asarray([w, e.T])
# whatif scenario:
A = np.asarray([w, e])
B = np.asarray([e.T, wI])

B = np.transpose(B)  # row to col # w, e.T  e, wI.T
AB = matmul(A, B)
AB2 = A * B
kronecker = np.kron(A, B)
_mul = np.multiply(A, B)


print(f"AB = {AB}")
Grad_e = initMat(AB)
print(f"Grad_e = AB = {Grad_e}")
print(f"AB2 = {AB2}")
print(f"kronecker, {kronecker} ")

Jacobian = Grad_e.T  # is it inverse or transpose ?


print(f"J = {Jacobian}")

# To check: apply the rule: J . J^-1 = 1

# DEMO:

# Indicator functions


def getIndicator(lst):
    indicator = [1 if x > 0 else 0 for x in lst]
    return indicator


lst = np.ones(11)


# [ 1 if x > 0 else 0 for x in getInidcator(lst) ] # lambda n:   exp(n)
o_j = [int(x >= 0) for x in lst]
d_j = not o_j


print("indicator function = ", o_j)
print("indicator function = ", d_j)

#n = 10

# extra
# delta


def delta_j(a, n): return a * (d_j(n) - o_j(n)) * (o_j(n) * (1 - o_j(n)))


# demo
#print("delta = ", delta_j(a, n))

# or named function :


def delta_j(a, n):
    return a * diffFun(n) * o_j(n) * logicalComplement(o_j, n) #TODO: check


def logicalComplement(f, n):
    """ only iff f(n) in  [0,1] , then compliment = 1-f(n) """
    return 1 - f(n)

# demo


# print("complement of (o_j) = ", logicalComplement(o_j, n))  # 1-  o_j(n)


def o_j(n):  # TODO:
    """ TODO: """
    pass


def diffFun(n, d_j, o_j):
    return [d_j(n) - o_j(n)]

# demo:
