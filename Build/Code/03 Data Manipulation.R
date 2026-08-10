

# clear everything

rm(list = ls())


# load addirtional packages
library(dplyr)
library(ggplot2)
library(raster)


# import data
Data_A <- read.csv('Build/Data/Data_A.csv')



# inspect
head(Data_A)
glimpse(Data_A)


# select cols  Farmer_ID, County, Latitude, Longitude
ID_cols <- select(Data_A, Farmer_ID, County, Latitude, Longitude)





# filter retired fields only (Status == "Retired")





# Remove col X from Data_A
Data_New <- select(Data_A, -X)






# Rename cols






# use case_when function
New_Col <- mutate(Data_A, 
                  Sand_Soil = case_when(Soil_Texture %in% c('Sand', 'Loamy Sand')  ~ 'Yes',  
                                        TRUE ~ 'No'))


# use ifelse function
New_Col1 <- mutate(Data_A,
                   Sandy_Soil = ifelse(Soil_Texture %in% c('Sand', 'Loamy Sand'), 'Yes', 'No'))



# The pipe operator %>%
# Takes the output of an expression on its left and passes it as the first argument to the function on its right.
# Allows you to chain multiple functions together sequentially, making your code cleaner and easier to read.

# Example

# Rewrite using the pipe operator:
# Get location details of retired fields only
# Import Data_A, Filter retired fields and select cols
Data_A <- read.csv('Build/Data/Data_A.csv') %>%
  filter(Status == 'Retired') %>%
  select(Farmer_ID, County, Latitude, Longitude)


#------------------------------------------------------------------------

# Clear everything
rm(list = ls())


# Import Data
Data_A <- read.csv('Build/Data/Data_A.csv')
Data_B <- read.csv('Build/Data/Data_B.csv') 


# Use the pipe operator 

# merge Data_A and Data_B into one dataframe
# remove col X
# create new variable and identify sandy soils (ie Sandy,Loamy_Sand)
# Create a col with 1 for Yes and 0 for No
# rename col "elevation" to "Elevation"
# Rename col "Tot_CREP_Rate" to Payment_per_acre
# Create the following Variables 
## Age_Squared = Age^2, 
## Total_Payment = Field_Size * Payment_per_acre
## Log_Total_Payment = log(Total_Payment) 

My_df <- 

# Save, Export 

# Export to csv and save in Cache folder as My_df
write.csv(My_df, file = 'xxxxx/xxxxxxx/xxxxx/My_df.rds')

# Save as  an r object .rds file. 
saveRDS(My_df, file = 'xxxxx/xxxxxxx/xxxxx/My_df.rds')




