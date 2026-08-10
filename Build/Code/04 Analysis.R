
# Packages
library(ggplot2)
library(dplyr)


rm(list = ls())

# read data from previous script saved in Cache
My_df <- readRDS('Build/Cache/My_df.rds')


# Data Analysis: summary statistics, visualizations, regressions etc

# summarise: 
# Summary Stata
summary(My_df)

mean(My_df$Field_Size) # mean
sum(My_df$Field_Size) # Sum
sd(My_df$Field_Size) # Std Dev



# grouped summary
# Summary for retired and active fields
var_summary <- My_df %>%
  group_by(Status) %>%
  summarise(
    Age_Mean = mean(Age, na.rm = TRUE),
    Elevation_Mean = mean(elevation, na.rm = TRUE),
    Field_Size_Mean = mean(Field_Size, na.rm = TRUE),
    Groundwater_Mean = mean(DepthToGroundwater, na.rm = TRUE),
    Precipitation_Mean = mean(Mean_Precipitation, na.rm = TRUE),
    Temperature_Mean = mean(Mean_Temp, na.rm = TRUE),
  ) %>%
  ungroup() 

var_summary




# Visualize with ggplot
# Some Common Plots
ggplot(My_df, aes(x = Field_Size)) +
  geom_histogram(bins = 30) +
  labs(
    title = "Distribution of Field Size",
    x = "Field Size (acres)",
    y = "Number of Fields"
  )


ggplot(My_df, aes(x = Status, y = Field_Size)) +
  geom_boxplot() +
  labs(
    title = "Field Size by Status",
    x = "Status",
    y = "Field Size (acres)"
  )




ggplot(My_df, aes(x = Age, y = Field_Size)) +
  geom_point() +
  #geom_smooth(method = "lm") + #Add trend line
  labs(
    title = "Field Size and Farmer Age",
    x = "Age",
    y = "Field Size (acres)"
  )



ggplot(My_df, aes(x = Soil_Texture, fill = Status)) +
  geom_bar() +
  labs(
    title = "Status by Soil Texture",
    x = "Soil Texture",
    y = "Number of Fields"
  )



ggplot(My_df, aes(x = Age, y = Field_Size, color = Status)) +
  geom_point() +
  labs(
    title = "Field Size and Age by Status",
    x = "Age",
    y = "Field Size (acres)",
    color = "Status"
  )


# Correlation matrix
# select numeric variables only
cor_data <- My_df %>%
  select(Age, Field_Size, elevation,
         DepthToGroundwater,
         Mean_Precipitation,
         Mean_Temp)

cor_matrix <- cor(cor_data)


# Linear Regression
model <- lm(Tot_CREP_Rate ~ Age + Field_Size + DepthToGroundwater, data = My_df)

summary(model)


# Logit 
library(VGAM)


Logit_Model <- vglm(Status ~ Age + Field_Size + elevation +
                      DepthToGroundwater + Mean_Precipitation + Mean_Temp, 
                    family = multinomial(refLevel = 1), 
                    data = My_df)

summary(Logit_Model)
