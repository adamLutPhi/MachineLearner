from math import tan, tanh, exp, inf 

"""
 recheck
 Loss function with weights episode : backprop
 
Guide:

To differentiate

We will use a neural network

Having a neural Network, having an:

activation function


activation function :

having 
layer1 = Layer( input ) --> layer2= Layer ( Hidden)

still, need something in between, linking layer1 and layer2

# class map

class map :
     def __init__(nnLayer1, nnLayer2):

          nnlayer1.  

"""

""" all derivatives of u with respect to the input x
Can be found

this is possible if I had 1 single neuron
what if:
I had 10 hidden Neurons(multiple hidden neurons)

Even if multiple layers (of hidden neurons) through backpropagation)

you can find out
d output/ d input 
du / dx



#rank 2 approcimation
d2u / dx2

=
d2 u_hat/dx2 + linear_function

d2 u_hat/dx2 + a* d_u_hat/dx - b ]

this is the optimization algorithm
which we have to minimize
since it is a rank 2 
so

forward propogation

another episode

w1 , w2 -> do forward prop

to get a new cost function
cross : ref Neural Network2: Cost function
credits L 
https://arxiv.org/abs/2301.10581

# straight line fit 
Cscale = 0.3268 ˆσI + 0.0018. 


"""


class map:

     def __init__(self):
          pass
     
class nnLayer:
     Nodes = []
     def __init__(self, vectorNodes):
          """vector of nodes , by

          Inputs:
          -------
          vectorNodes: by default

          """
          
          _len = len(vectorNodes)
          for i in range( _len +1 ):

               self.Nodes.append(vectorNodes[i])
          
          
class Node:

     def __init__(self, name, value):

          self.name = name
          self.value = value
     
          def __init__2(self, name, x, w):
               """ constructor : for scalar arguments
               Fill the corresponding scalars to them
               
               input:

               x: pattern
               w: weight

               """
               self.name = name
               self.x = x
               self.w = w

          def __init__3(self, name, x, w):
               """
               
               If arguments are arrays, then fill a corresponding array with it
               
               """
               self.name = name
               _len = len(x)
               for i in range(_len+1):
                    self.X = x[i]
                    self.W = w[i]


#Gradient approximation

#sum (L_t -= L)

#    w = w- a * dL/dw -> sum a Lt



def funTan(x):
    return tan(x)

def _2Diff(x):
     """source: Corollary 2: """
     
     return tan( tan( x) ) + 1
"""
     assert funTanh(1) == funTanh2(1) #passed

     assert funTanh(1) != funTan(1)
"""

def sigmoid(x):
     """
     Sigmoid function:
     source(wikipedia):
     https://en.wikipedia.org/wiki/Sigmoid_function

     Source: https://math.stackexchange.com/questions/1226089/is-expx-the-same-as-ex
     mathematicians tend to use exp instead of e function for `interesting` calculations

     """
     return 1 / (1+ exp(x))
     
     
# user is free to pick an activation function 
def activationFun(x):

     sigmoid(x)

def getOutput(inputNodes):
     """returns the output of input nodes
     inputs:
     -------
     inputNodes: a list of nodes

     processing:
     ----------
     Algorithm:
     1. get `inputNodes` length:
     
     nodeLength = len(Nodes)
     
     output:
     -------
     The sum of all input nodes (assuming Neural nodes are `fully-connected`

     """


#activationFun(x)
     
def getNode(x, neuralOutput):
     """ me: observe:
     Any node is:
     1. fully-connected: has got to be connected with
     the `Output` of 
     Neural Nodes (From the previous layer)


     """
     return activationFun(x, neuralOutput)
     
def g(x):
     """ the gradient of x

     Reasoning

     Assume :
     1. u is a neural network , where x is an input
     me: with tan(x) as an ectivation function
     _sum = 0
     for i in range ( n +1)
          _sum += Node(i)

     me
     where Node is a weighted
     sigmoid(w1, x) = sigmoid ( w1*x ) 


     universal appproximation theorem

     I can always approxumatge you , arbitrary close
     to the neural network

     I can assume u is a neural network
     how does that help us ?
     A.
     example:
     10 nn input nodes
     with 1 output

     writing
     a full Functional Form  for u

     forget the bias unit

     - say:
     Hidden Layer :

     - 1 hidden neuron node (a)

     where
     a1 = sigmoid ( w , x)
     suppose this layer is linear 
     u = w2 * sigmoid( w1 * x )
     analytical ingestigation:

     du / d sigmoid = w2 . sigmoid' * (w1 * x) * w

     """
     
     return tan(x)

def H(x):
    return g (g(x))

def G(x,n):
    """A generalized Gradient """
    if n==1:
        return g(x)
    else:
        n = n-1
        return G(x,n)

#Norm
def norm(x):

     #placeholder : TODO: replace with the actual norm function
     #if x is scalar: return its absolute value
     
     return abs(x)

#Global (TODO)
Lambda = 2 # The Regularization parameter - 


def h(t=1):
    """TODO: plug in an actual characteristic function """
    return t * 1

def checkLambda(Lambda):

    if Lambda  > 1:
        pass
    pass

#needs testing to pass 
def taylor(x): 
     """ gets taylor series, 2nd order """
     return ( f(x) + (x - x0) * g(x) ) + 1/2 * ((x-x0) * H(x))

def getH( n, t=1, Lambda=2):
    """solves next h_t+n """

    return norm(h(t)) * Lambda **n


print("h(1) = ", getH( n = 1) )

print("h(2) = ", getH( n = 2 ) )


