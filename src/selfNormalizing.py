# self-normalizing nn: via sleu
#from math import exp

"""

paper:
source https://proceedings.neurips.cc/paper_files/paper/2017/file/5d44ee6f2c3f71b73125876103c8f6c4-Paper.pdf

"""

"""Tip1: use euler's number, instead of exp
definition
ref1: https://en.wikipedia.org/wiki/E_(mathematical_constant)
2.71828

Why:
reason1: 
ref2: quantamagazine
source: https://www.quantamagazine.org/why-eulers-number-is-just-the-best-20211124/

reason2:
ref3: Quora
source: https://www.quora.com/Why-are-exponential-functions-often-represented-with-Eulers-number-instead-of-just-numbers

Note: to differentiate between error e and euler,

euler is defined by euler , explicitly
error is defined by e


answer1 <--> answer3 <--> answer2 
"""
euler = 2.71828 # a better alternative (max) exp function : using scalar is faster

exceptionMsg = "Exception: please recheck input, then retry later"


ans1 = lambda x: x
ans2 = lambda alpha, x: alpha * ex
ys = [ ans1 , ans2 ] 


class indicatorfunction(object):

    def __init__(cls, x, bound, answer1= ys[0] , answer2 = ys[1]):

        if x > bound:
            return answer1
        elif x <= bound:
            return answer2
        else: raise Exception(exceptionMsg)


class customIndicatorFunction(indicatorfunction):
    """
           bound1         bound2
    answer1   |   answer2    |     answer3
    """
    
    def __init__(cls, x, bound1, bound2, answer1, answer2, answer3):

       # super().__init__(x, , bound, answer1, answer2)

        if x > bound and x <bound2:
            return answer1
        elif x < bound and x > bound2:
            return answer2
        else:
            raise Exception(exceptionMsg)

