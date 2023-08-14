from numpy import matrix, zeros, ones # , divmod #, nultiply

"""Takeaways

Do not divide a numpy vector by: `/`
but divide it by numpy.divmod
instead of divmod, use //
// : vector division :without remainder
/ : vector division 
"""

def initMatrix(x):
    return matrix(x)

def matAdd(a,b):
    for i, bi in enumerate(b): a[i] += bi
    return a[i]

def matMul(a,b):
    c = map(float.__mul__, a, b)
    return c

def initvariables(x, basis=[1 , 1, 1] ):
    """initialize variables, by transforming x-datatype from list into a matrix
        seemingly the operation is done for the basis vector
        
    """
    x = initMatrix(x)
    basis = initMatrix(basis)
    
    return x, basis

#As easy as 1,2,3
def getXbasis( x , basis=[1 , 1, 1] ):
    """ Returns input vector x after multiplying with the basis vector,
        applying the proper projection and scale

    input:
    -----
    x: input vector
    basis : basis vector [default = [1 , 1  , 1] ]

    output:
    ------
    outerProduct13: the x vector, multiplied by the basis, and  rescaled



    """
    
    _len = len(basis)
    _ones = ones(3) #_len )#1,3) #ones(3,1) #initMatrix(ones(3,1))
    print("_ones = ", _ones)


    #1. outer product : @ (x.T, basis)
    outerProduct1 = x.T @ basis  #x.T @ basis #x.T @ basis # dim( outerProduct1) = 3 x 3 # <------- weakness 

    #2. display outerProduct1
    print("outerProduct1 =\n", outerProduct1) #dim( outerProduct1) = 3 x 3

    #========================
    #3. get `outerProduct13` :
    #What if: multiply thee outer product:  outerProduct1 by  ones ( @(outerProduct1, _ones)  ? 

    outerProduct12 =  outerProduct1 @ _ones # <------- weakness (transpose ) 

    ##outerProduct12 = _ones @ outerProduct1 # outerProduct12 =  [[12.  6. 15.]]
    print("outerProduct12 = " ,outerProduct12)
    #outerProduct12 =  [[12.  6. 15.]] #good (still, values are Scaled by 3 (number of elements) (divide by 3 [scalar])

    #re-scale the output vector ( by number of dimensions i.e. 3 ) 
    outerProduct13 = divmod(outerProduct12, _len) #  outerProduct12 // _len # divmod(outerProduct12, _len) # outerProduct12 / _len # 3 #<---
    outerProduct13 = outerProduct13[0]
    
    #display the projected vector
    print("outerProduct13 = " , outerProduct13 ) # outerProduct13 =  [[4. 2. 5.]]

    return outerProduct13


#basis vectors [they could take any value]

i = [ 1, 0, 0]
j = [0, 1, 0]
k = [0, 0, 1]

#1. Transform lists: i, j, k to matricies (via `initMat`)
i = initMatrix(i)
j = initMatrix(j)
k = initMatrix(k)

#2. Build the basis vector `getBasis`
#TODO: add basis vector (with length of current dimension ) 
##2.1 initialize vector to zeros(dimension)
basis = zeros(len(i)) #i.e. zeros(3) = [[0. 0. 0. ]] 
#2.2. Initialize the basis vector is a matrix
basis = initMatrix(basis)
#add components : i , j , k into `basis`
basis = i + j + k # note adding k

print("basis = ", basis)

x = [1 , 1, 1 ] #[4, 2, 5 ]
# 4 2 5 * [ 1 1 1 ]
w = [1 , 1, 1] #[0.2 , 1.4, 1.0]

#3. initialize

##3.1 initialize input matrix 
x = initMatrix(x)
##3.2 initialize weight matrix 
w = initMatrix(w)

#matMul
##
x2 = matMul( x.T , basis) # dead end 
print("matrix, after applying basis vector\n", x2.__repr__)


#outer product
"""result
As in Mirror land, the vector's output can be seen
as the same, from each axes (x, y, z)

had to flip `outerProduct`, first to make it
outerProduct1 =
 [[4 2 5]
 [4 2 5]
 [4 2 5]]
 note: size is (3x3)
 but our goal: to make of dimensions ( rows= 1 x columns= 3) 
"""
_ones = ones(3)#1,3) #ones(3,1) #initMatrix(ones(3,1))
print("_ones = ", _ones)
#1. outer product : @ (x.T, basis)
outerProduct1 = x.T @basis # dim( outerProduct1) = 3 x 3

#2. Transpose:  @ (x.T, basis).T
#flip outerProduct1 by transposing it
outerProduct1 = outerProduct1.T #  dim( outerProduct1) = 3 x 3
print("outerProduct1 =\n", outerProduct1)

"""
#3.outerProduct11 = @( outerProduct1 , _ones   #innerProduct * ( outerProduct1 * _ones)
outerProduct11 = outerProduct1 @ _ones
print("outerProduct11 = " , outerProduct11 )# dim( innerProduct1) = 3 x 1
# outerProduct11 =  [[11. 11. 11.]] [dead end]
"""
#retry...
#4. get `outerProduct13` :
#What if: multiply outer product, ones by outerProduct1 ? 

outerProduct12 = _ones @ outerProduct1 # outerProduct12 =  [[12.  6. 15.]]
print("outerProduct12 = " ,outerProduct12)
#outerProduct12 =  [[12.  6. 15.]] #good (still, values are Scaled by 3 (number of elements) (divide by 3 [scalar])

#outerProduct13 =  outerProduct12 / 3 #<---

outerProduct13 =  divmod(  outerProduct12, 3) # outerProduct12 // 3    #divmod(outerProduct12 , 3)
outerProduct13 =outerProduct13[0]

#display the projected vector
print("outerProduct13 = " ,outerProduct13) # outerProduct13 =  [[4. 2. 5.]]

xBasis = outerProduct13

print("cols = ", xBasis.shape[1] ) 

print( "rows ", xBasis.shape[0] ) 




#...
#print("innerProduct1" , innerProduct1) # dim( innerProduct1) = 1 x 3
"""
outerProduct2 =  x @basis.T
print("outerProduct2 =\n", outerProduct2)

outerProductProjection = outerProduct1#[]
"""
#Demo :
#1. original list 
x = [4, 2, 5 ]

#initmat : transform dataType (list -> matrix ) 

##x = initMatrix(x)
##basis = initMatrix(basis)
x = initMatrix(x)
basis = initMatrix(basis)
#x, basis = initvariables(x, basis)


#get x

x = getXbasis( x , basis= basis ) #[1 , 1, 1] )
print("x with basis: ", x)
#Rule: transpose the column vector
outerProduct = x.T @ w
print("outerProduct =\n", outerProduct)

#hadamard's innner product of vectors x, w: < x, w>
#matMul = multiply( x,  basis.T) 
#print("matMul  = x, basis.T =\n",innerProduct) 
innerProduct = x.T * w 
print("innerproduct<x, w>=\n",innerProduct) 
#@innerProduct = 
#print("innerproduct<x, w>=\n",innerProduct) 
 
_lenx = len(x)
_sum = 0
partial = 1
idx = 0
#for n in enumerate( x, start = 1):  #range(x):
#chi squared
partialWeights = 0.0
for i in range(3):
    
    for idx, n in enumerate(x): 
    
    #1, matrix([[4, 2, 5]]))
        print("idx", idx)
        print("n", n) # good to be the index 
        print("shape=", n.shape)
        print("shape[1]=", n.shape[1])
        col= n.shape[1] # len(n) # 3 
        row= n.shape[0] #len(n[0]) #1

        #expected: R = 1, C  = 3
        print("row R = ", row) # 1 # 1  
        print("col C = ", col) # 3 # 1
 
          
    #nIdx, nMatrix = n
    #_len = len(nMatrix)
        print("n = ", col -1 ) #_len -1) #nMatrix-1) #nIdx) # nMatrix [4, 2, 5 ] 
        print("initial x = ", x) #<----initial x =  [[11.]] :S
        _len = x.shape[1] # 3 
        print("_len", _len)
        #x : axis 0, size 1

        #get Matrix
        #  xMat =  x [ r], [c]
        print("x = ", x)
        xMat = x [0][-1]
        print("xMat", xMat)
        col = xMat.shape[1]
        row = xMat.shape[0]
        print("col =", col)
        print("row1 =", row)

        #get Input x
        xInput = xMat[-1]# [col]  #x [0][-1] # [0]  #col - 1] #_len -1] #nMatrix-1] #nIdx - 1  ]
        wWeight = w [ 0 ][-1]#len-1] #col - 1]  # _len -1]  #nMatrix - 1]  #nIdx - 1]
        print("x = ", xInput)
    
        newX = divmod(x[0][-1],3)
        newX = newX[0]
    
    
        # print("x[0][-1] = ", x[0][-1])

        print("newX", newX)
        print("w =", wWeight)
        _len = len(xInput)
        print("last col index = ", col)  #1) #_len -1) 
        #multiply first column with i
    #2nd column with j
    #3rd column with k
    ####partial = xInput  * wWeight
        partial = [ 0 , 0 , 0]
    #error
    #try: outer product
    #[1, 1, 1] * [1 , 1 , 1] = [1, 1, 10]
        #do an outer product 
        partialWeights = x[ col-1] @ w[ col -1 ]   #* w[ _len -1 ] #_len -1] * w[ _len -1 ] #nIdx-1 ].T * w[nIdx-1]
        print("partialWeights x*w = ", partialWeights)

    _sum=0.0

    # add first basis component i
    if col % 1 ==0: #nIdx % 1 ==0:
        print("col % 1 ")
        #x[ nIdx ] * w[nIdx] * i[nIdx]

        partial *=  i[ col - 1].T #_len -1] #nIdx -1] #<-----
        #me: rescale by 2
        #FUNCTIONAL
        
        #partial = partial  / 2.0  #maybe we need to multiply by 2 (in the outer-scope
        _sum += partial #uncomentMe
        #print("partial", partial)
        print("first partial", partial)

    # add second basis component j
    if col % 2 ==0: #<---- unsure
        print("2nd col % 2 ")
        #indifference detected 
        #x[ nIdx ] * w[nIdx] * j[nIdx]
        #partial *= j[ _len -1] #nIdx - 1]
        
        partial *= j[ col -1].T #
        #partial = partial  #/ 2.0
        _sum += partial  #uncomentMe
    
        print("2nd partial", partial)

    # add third basis component k
    if col % 3 == 0: #nIdx % 3 ==0:
        #indifference detected 
        #x[ nIdx ] * w[nIdx] * k[nIdx]
         partial *= k[ col - 1] #_len -1] #nIdx - 1]
         #partial = partial  #/ 2.0 

         _sum += partial
         
         print("3rd partial", partial)
    #_sum += partial 
    print("cumulative sum = ", _sum)
    

print("sum = ", _sum )

"""
_sum = _sum *(3/4) # correction 

print("sum = ", _sum )
"""
