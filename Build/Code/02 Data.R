

# 1. Types of Data 

# a. Doubles
# Doubles are real numbers with a decimal value.

# b. Intergers: 
# Integers are real whole numbers. 1,  3,  4

# c. Characters:
# Doubles are real numbers with a decimal value. 3.4

# d. Dates:
# In R, dates are internally stored as doubles, but with a date object class. 
# Dates can be entered or converted using as.Date() function.
#--------------------------------------------------------------------------

## 2. Data Structures

# a. Vector
vector <- c(11:14)

# b. Data Frame (df)
# Has equal length vectors with unique attributes for each vector, making it a rectangular 2-dimensional (rows and columns). 
# In other words, a data frame is a matrix with column names.
my_df <- data.frame(numbers = 1:4, 
                          letters = c("a", "b", "c", "d"), 
                          logicals = c(TRUE, FALSE, FALSE, TRUE),
                          # Woah you can make sequences with dates?!
                          dates = seq(as.Date("01/01/99", "%m/%d/%y"), 
                                      as.Date("01/01/02", "%m/%d/%y"), 
                                      "years")
)


my_df


# c. Matrix
A <- matrix(c(10, 8,
              5, 12), ncol = 2, byrow = TRUE)


# d Arrays

# Store data in more than two dimensions
multiarray <- array(c(1:27), dim = c(row_Size = 3, 
                                     column_Size = 3, 
                                     matrices = 3))
multiarray

# e Factors
# Store categorical information
likert_levels <- c("strongly disagree", "strongly agree", "disagree", "agree",
                   "somewhat disagree", "somewhat agree", "neutral")


# f. Raster
# Represent gridded spatial data
# Imagine a map divided into thousands of square cells, where each cell contains a value. 
# That value could represent elevation, temperature, rainfall, land cover, soil type, or satellite imagery.
# we will deal with this one later. 


# g List

# lists act as storage bins
# Store different data types and structures
# create lists using the list() function

my_list <- list(my_df, multiarray, likert_levels)


#########################################################################################

# IMPORTING DATA

# Import CSV files in the Data folder named Data_A and Data_B

Data_A <- read.csv('Build/Data/Data_A.csv')

Data_B <- read.csv('Build/Data/Data_B.csv')

