
#---test emulating for loop , i, upperbound, lenA +s - 1
a = [2, 3, 4]
total = length(a)
#correct for s = 1 
#------for 0
s = 1
i = s #initial i0 

#-----start loop 
i # <----
#-------- variables 3PICK WHICH ONE Equals s
#_final = copy(i - s + 1) #_len - s + i # ERROR: 4 #issue i + s #the Most  correct! 
_start1 = copy(i + s) #2 (should be 1) #4 (array out of bounds error )
_start2 = copy(i + s - 1) #working well #as a start  #1  #last = 3  #inbounds #accepted 

_final6 = copy(length(a) + s - 1) # works well, for a finish #3 #inbounds #accepted 
_final6_5 = copy(length(a) + s + i - 1)
_final7 = copy(length(a) + s + i - 3) #4 
_final7 = copy(s + i) # only correct   #4 

_final8 = copy(s + i - 1) # works well as an end  #3 #least constraints #adopt this 
#infer formula: s + i -1 if i = 1 : s +1 -1 = s (start init value ): either 0 (0th index) or 1 (1st index)
#-----------------------# seems you plugged in i = s - 1  
i += 1
#-----------------------
lenA = length(a)
lenA + i
lenA + s - 1 + -lenA - 1  # here , if s = i = 1 
lenA + s - 1 + (lenA + 1) - lenA - 1 - (lenA + s - 1) #equivalent (already) #or by composition 
lenA(1 - 1) + s - 2  #experimental # same #equivalent
s - 2 # here, is start at s=i=1 it yeilds -1 # not acceptable in the positive domain 
# mind boggling line abve seems to have no equal (initially )
#-----------adopt this for for every future endevour
#s either 0 or 1 
for i ∈ 1:lenA+s-1  # idea= keep fixating starting i at  i=1 #strict condition: needs s=i=1 to work well 
    println(i) #prints range correctly 1,2,3 (accordingly) 
end

#testing ranges 
s = 1
i = 1 #initial i0 #i is fixed to 1

#-----start loop 
i # <----
#-------- variables 3PICK WHICH ONE Equals s
#_final = copy(i - s + 1) #_len - s + i # ERROR: 4 #issue i + s #the Most  correct! 
_start1 = copy(i + s)
_start2 = copy(i + s - 1)
#_final = copy(i + s - 1) #_len - s + i # ERROR: 4 #issue i + s #(al)most correct 
#_final4 = copy(total - s + 1) # i believe so 
#_final5 = copy(length(a) - 1)
_final6 = copy(length(a) + s - 1)
_final7 = copy(length(a) + s + i - 3)
_final7 = copy(s + i) # only correct 

_final8 = copy(s + i - 1)
#-----------------------
i += 1
#------- fixed values [Desired]
_first = s #s
_len = calcLength(2, 4; s) # 2, 3, 4 #euclidDist + start= 1  # |b - a| + s # always 3 
lenA = copy(length(a)) # always 3 
_endingIndex = _len   # + i - s #value inside array bracket 
_len - lenA #always 0 
_len === lenA

_finalAlt = copy(i + s) #seems ok  #errorneous 
_final2 = copy(total - s) # i believe so 
_final3 = copy(total - s + i) # i believe so 
#----------------

#metric: 
_endingIndex == lenA
_endingIndex - lenA + i #start

a[_len]
#recall i=0 ; length - 1 
#when   i=1 ; length -1 

# endingIndex == _len - s


#infer 

#best start 

#best final

_final = lenA +s +i -1
