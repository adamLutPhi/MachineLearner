"""Binary Builders 
JuliaCon2018
Video: https://www.youtube.com/watch?v=2e0PBGSaQaI&ab_channel=TheJuliaProgrammingLanguage
Credits: Elliot Saba  (thank you so much!)

Q.How are we gonna do that?

1. Unpack compiled taballs
1.2. No:
1.2.1. package managers 
1.2.2. sudo 
1.2.3. Compilation 
1.2.4. NO STATE! 

2.Build Tarballs
2.1.How: using cross-compilation Environment 
2.1.1 Linux based: with:
2.1.1.1. gcc 
2.1.1.2. gfortran 
2.1.1.3. clang 

2.2 Corss compilers with everybody
Note: built for all targets 
2.2.1. windows 
2.2.2. arm64

2.3 Run inside a Cross Compilation Environment
2.3.1 Buld `all` the things - Anywhere
me: with its own special flavors & Recipies

"""
#=Strategy:
we'll `bake` a little Linux image on any linux or mac machine 
Juliacon2018 - Elliot Saba 
How: prerequisites: activate current directory and add package BinaryBuilder

1. using BinaryBuilder 
2. BinaryBuilder.runshell() 

q.

windows -> admin prevelages 

either findout chmod and try back on win 
    or run in mac 

#waiting to be consumed  on mac ... 

=#
using BinaryBuilder
BinaryBuilder.runshell()   

