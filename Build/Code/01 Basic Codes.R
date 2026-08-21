
# Installing R and RStudio
#------------------------------------------------------------

# the 4 panes; Script, Console, Environment,  Output
# Change background, font etc
#------------------------------------------------------------


# Basic Functions

1 + 1

4 - 2 

2 * 3 

12 / 4

2^2

20 - 2*(3 + 1)^2

# R will return an error message if you type a command it doesn’t recognize.
3 % 5
3 + x

x <- 4
x=4

3 + x
#------------------------------------------------------------------


#  Comment your work!
## Commenting your code is important for two main reasons. 
## First, as a scientist, you should strive to make your work reproducible. 
## Annotating your code makes it easier to understand for other people to interpret your process. 
## Second, you will inevitably write a lot of code, get busy, move on to other things, and reopen your code months later with little to no memory of what you did. 
## Spending the extra 5 minutes to annotate your work will save you a headache down the line.

# To comment your code, simply put a hashtag character, #, in front of your annotations. 
# R treats # in a special way, and it will not run anything that follows # on a line.

#------------------------------------------------------------------
# 4. Creating Objects
my_first_object <- 2
my_first_object

a <- 10
b <- 30
c <- 12
x <- 25

# use objects 
a+b
3 + x
a+b+c-x


num <- 3.14       # numeric
int <- 42        # integer
char <- "Hello"   # character
logic <- TRUE     # logical
gender <- factor("male", "female") # factor

#------------------------------------------------------------

# Vector
my_vector <- c(1,2,3, -4, 3.24)
gender <- factor(c("male", "female", "female", "male"))

# What is the 2nd element in my vector?
my_vector[5]

## The c() function is flexible in what you can include, but what if you want to create a really long vector? 
## The : operator lets you create a sequence of integers, 
## The seq() function lets you create a sequence with a defined increment.

7:20
seq(from  = 2, to = 10, by = 0.5)
seq(2, 10, by = 0.5)

#------------------------------------------------------------------------

# Matrix Operations

# A nice list of operators and functions relating to matrices can be found here: 
# https://www.statmethods.net/advstats/matrix.html

# You can create matrices using the matrix() function.

# Two simple 2x2 matrices

A <-matrix(c(10, 8, 5, 12), ncol = 2, byrow = TRUE)
A
A[2,2]

B <-matrix(c( 5, 3, 15, 6), ncol = 2, byrow = TRUE)
B

A+B
A-B
A %*% B 

dim(A) # dimensions
t(A) # Transpose
det(A) # determinant


# Packages
# R is open source; anyone can make their own functions and packages. 
# One of the most commonly used and versatile package is tidyverse. 
# Note that you only need to install packages once.
# You load packages once everytime you start the project.

install.packages("tidyverse") #run this in console or install from the output pane
install.packages('dplyr')

# load package
library(tidyverse) 
library(dplyr)
