"""P.1.Tricks & Tips in Numerical Computing  
JuliaCon 2018 - M\cr|NA
Credits: Professor Mr. Nick Higham @nhigham 
# today the lecturing Professor @nhigham of Numerical Computing 
University of Manchesterh

http://maths.manchester.ac.uk/~higham

nickhigham.wordpress.com 



"""

"""P.2.Introduction 

1. Exploiting complex Artihmetic 
2. Understanding multivalued functions 
3. Exploiting associativity of matrix products 
4. Randomization to avoid pathological cases 
5. Making the most of Low precision arithmetic 

http://bit.ly/tricks18  
#redirects to a seemingly empty site 

A trick used threetimes becomes a standard technique  -George Polya -Hungarian mathematician [ETH Zürich] (Palo Alto), CA, U.S.
#--- 


"""
f'(x)=(f(x+h)- f(x)) / h


"""Differentiation With(out) a Difference 

≈ abs(f(x))

"""

function h(u,f(x),f''(x))
    #pythagorean theorem 

    return h ≈ sqrt(u* abs(f(x)/f''(x)))

end


sqrt(x); x_minus_one(x) = x^-1
sqrt(x) isa x_minus_one(x)

