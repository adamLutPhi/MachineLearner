
# EucledianDistance

## EucledianDistance(a,b)

""" Returns the distance is the maximum  - minimum between two points """
function EucledianDistance(a,b)

    d =  max(a , b) - min(a, b)

    d

end

# findNearestNieghbor

# findNearestNieghborClassic

function findnearestNieghborClassic(x_test, X, kernel=min)

    count = 0
    d = 0.0
    minimums = []

    # for each point in vector `X`
    for x_i in X

       #1. Calculate the distance , to our `x_test`
       d = EucledianDistance(x_test, x_i)   # max(x_test , x_i) - min(x_test, x_i)

       #2. add it to the minimums `vector`
       
       append!(minimums, d)

       #3. Filter the min (or a la min kernel):

       #3.1 if there is at least 2 items
       if count != 0

           #3.1.1 Get the  kernel (`min` by default) out of `minimums` vector and the point in question `x_test`
           _min = kernel(minimums)
           #3.1.2 Place it in the current  vector pointer (whatever min is )
           minimums[count] = _min
       end
    end
    prevD = 0
    currentD = 0
    _min = 0

    for d in minimums

        # if currentD has a valid distance
        if currentD !=0
            # assign it to the previousDistance
            prev = currentD
        end
        # Assign the new distance `d` to `currentD`
        currentD = d
        #prevD = 0

        #if there is at least 2 items
        if count !=0
            # compare the 2
            _min = min(prevD, currentD)

            #change
            prev = currentD
        end

    #4 finally increment the counter
    count = count + 1


    #4. the Final Minimum Distance would actually be the last distance
    minimums[-1]
end

# findNearestNieghbor

"""
    Finds the nearest neighbor using a kernel,
    which is the minimal or a la minimal value (i.e. least upper bound l.u.b if minimum does not exsit)
    !!!Note: The default is min.
"""
function findNearestNieghbor(x_test, X,kernel=min)


    count = 0
    d = 0.0
    minimums = []

    # for each point in vector `X`
    for x_i in X

       #1. Calculate the distance , to our `x_test`
       d = EucledianDistance(x_test, x_i)  #max(x_test , x_i) - min(x_test, x_i)

       #2. add it to the minimums `vector`
       
       append!(minimums, d)
       #3. Filter the min (or a la min kernel):

       #3.1 if there is at least 2 items
       if count != 0

           #3.1.1 Get the  kernel (`min` by default) out of `minimums` vector and the point in question `x_test`
           _min = kernel(minimums)
           #3.1.2 Place it in the current  vector pointer (whatever min is )
           minimums[count] = _min
       end

       #4 finally increment the counter
       count = count + 1
    end

    #4. the Final Minimum Distance would actually be the last distance
    minimums[-1]


end

    """
    the 2nd derivative
    of the 'sigmoid'
    vanistion at x =0

    f the sigmoid function
    """
function sigmoid(x)

    f = 1 / (1+ exp( - x) )

    f
end

# findNearestNieghbors
function findNearestNieghbors(x_test, X)

    #count = 0
    d = 0.0
    distances = []
    
    for x_i in X

       #1. Calculate the distance , to our `x_test`
       d = EucledianDistance(x_test, x_i)  #max(x_test , x_i) - min(x_test, x_i)

       #2. Add the new distance to the list
       
       append!(distances, d)


       #3. finally increment the counter
       #count = count + 1

    #3. finally return distances vector
    distances

end
