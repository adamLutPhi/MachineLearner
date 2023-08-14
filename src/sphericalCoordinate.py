"""
for variance to workout as expected in theory

1. Independent variables: are  uncorreated

presupposes (1) mean to revolve around : 
142.4


ref: Vector calculus in spherical coordinate system
@NPTEL-NOC-IITM
source:https://www.youtube.com/watch?v=kNpjrvn-A10&t=631s

"""
from math import sin, cos, pi
from numpy import matrix

#def getZ():
    
getZ = lambda x,y :   x + 1j * y

def cartesianToPolar(x,y, alpha=0.01):
    """using euler's formula
 z = x + i*y = |z|*(cos(alpha) + i *sin(alpha)):

ref:https://essentia.upf.edu/reference/streaming_CartesianToPolar.html
 input:
 -------

 x = Real part,
 y = Imaginary part,
 |z| = modulus, magnitude,

 α = phase, in (-pi,pi]
 
"""
    z =  get(x, y) #lambda x,y :   x + 1j * y
    return abs(z) *( cos(alpha) + 1j *sin(alpha) )
    

def polarToCartesian(theta,r, phi):

    x = r* sin(theta) * cos(phi)

    y = r* sin(theta) * sin(phi)
    z = r* cos(theta) 
    return x, y, z



def getA(r_hat, theta_hat, ):

    return getAr(r_hat) , getATheta(theta_hat), getAPhi(phi_hat)

def getRadiusProjection( theta ):
    return sin(theta)    

def getD(r, r_hat, theta, theta_hat, phi, phi_hat):
    return d(r,r_hat) + r*d(theta, theta_hat) + r * sin( theta) * d( phi, phi_hat)
#def d(r, r_hat, theta, theta_hat, phi, phi_hat): #l):
    """returns dl
    TODO:
    """
#   getD(r, r_hat, theta, theta_hat, phi, phi_hat)


def d(x):
    return x


def initMat(x):
    return matrix(x)


# line Element

def getDlr(r):
    return d(r)


def getDlTheta(r, theta):
    return r* d(theta)


def dlPhi(r, theta, phi):
    return r* sin(theta) * phi


def getD2(r, theta, phi):
    """returns d( Tao)
    """
    return r**2 * sin(theta) * d(r) * d(theta) * d(phi)\


def getlTheta( r, theta, phi):
    return r * sin(theta) * d( phi)


def getVolume(r, theta, phi):
    return getD2(r, theta, phi)
    #pass 


def getSurfaceElements(r, theta, theta_hat, phi, phi_hat):
    """returns the surface, as an inner product """
    return initMat( r* d(theta * theta_hat)) @  initMat( r* sin(theta) * d(phi * phi_hat) ) # * p # * d(theta_hat)


def getdQ(r, r_hat, theta, phi):
    return r**2 * sin(theta) * d(theta) * (phi * r_hat)


#xy plANE , theta= CONSTANT = PI/2
def getDQ1( r_hat, phi_hat):

    return initMat( getDlr( r_hat)) @ initMat( dlPhi( phi_hat ) ) #getDlPhi(phi_hat)


def getDQ2( r_hat, phi_hat, theta_hat ):

    return initMat(  r* d(r)) @ initMat(d(phi * theta_hat )) #*
 # * theta_hat #getDlr( r_hat)) @ initMat( dlPhi( phi_hat ) ) #getDlPhi(phi_hat)

# r in [ 0, inf]
# theta in [ 0, pi ]
# phi in [ 0 , 2 * pi ]


def getV(R):

    # 4/3 * pi* R**3 
    return (2*pi) * 2 *   R**(3) /3



def intR(y, low = 0, up = R,dr = 10^-6):
    #dr = 10^-6
    _sum = 0.0
    for i in range (up-low):
        _sum += r**2 * dr

    return _sum 
    #pass

def V(phi):
    return phi
def intTheta(y, low = 0, up = pi, dTheta = 10^-6) :
    """integration of angles
    """
    #dr = 10^-6
    _sum = 0.0
    for i in range (up-low):
        _sum += sin(theta) *dTheta  #r**2 * dr
    return _sum
    #pass


def intTheta(y, low = phi0, up = 2*pi, dPhi = 10^-6) :
    _sum = 0.0
    for i in range (up-low):
        _sum += d(theta) #Esin(theta) *dTheta  #r**2 * dr
    return _sum



def getRatio(numerator, denominator):
    return numerator / denominator 
    pass


def getDivergence(r, r_hat, theta, theta_hat, phi, phi_hat ):

    return
    (1/r**2) * ddr(Vr* r**2)  + (1/(r*sin(theta)) * ddTheta(sin(theta)* VTheta) )
    + (1/r* sin(theta) ) * dVPhidPhi


def getCurl(r, r_hat, theta, theta_hat, phi, phi_hat  ):

    return(1/r*sin(theta))* ( ddTheta( sin(theta)* V(Phi) ) -dVThetadPhi ) * r_hat

+ (1/r) * ( ( 1/sin(theta)* getRatio( d(Vr), d(Phi))) - getRatio(d(r *  V(Phi)) , d(r) )) * theta_hat

+ (1/r) *( getRatio(d(r*V(theta)) , d(r) ) - getRatio( d(Vr), d(theta)  ) ) * phi_hat


pre= [1/r*sin(theta), 1/r , 1/r ]
post = [r_hat , theta_hat, phi_hat]


def gradient(r, r_hat, theta, theta_hat, phi, phi_hat ):
    """returns gradient of Time """

    return getDivergence(r, r_hat, theta, theta_hat, phi, phi_hat )


def gradient2(r, theta, T ):

    return 
    getRatio(1, r**2) * getRatio(d(( r**2) * getRatio(d(T), d(r) ) ) )
    + getRatio(1, (r**2)*sin(theta)) * getRatio( sin(theta)* getRatio(d(T), d(theta) ) , d(theta) )
    
    + getRatio(1, (r**2)*sin(theta)) *  getRatio(d(T)*d(T), d(phi) * d(phi) )
    

#DEMO
"""Example

V = int d( Tao)
V =  int(r) int(theta int(phi) r**2 * sin(theta) d(r) * d(theta) * d(phi)
"""
r = 0.5 # [[0.5]]
theta  = 50
theta_hat = theta + 5
Vr = r
r_hat = Vr + 1

phi0  = 0.0
Phi = phi0 + 1
phi_hat = Phi +0.5
R = 10
