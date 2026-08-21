

rm(list = ls())


# Read
new_data <- readRDS("build/Cache/new_data.rds")


# Number of bootstrap samples
B <- 1000

# Store bootstrap means
boot_means <- numeric(B)

# Bootstrap loop
for (i in 1:B) {
  
  # Draw a sample with replacement
  sample_age <- sample(new_data$Age, 
                       size = length(new_data$Age), 
                       replace = TRUE)
  
  # Calculate the mean
  boot_means[i] <- mean(sample_age, na.rm = TRUE)
}


mean(boot_means) # Bootstrap estimate of mean age
sd(boot_means) # Bootstrap standard error
quantile(boot_means, c(0.025, 0.975)) # 95% confidence interval







# Functions


calculate_mean <- function(data, variable) {
  
  mean_value <- mean(data[[variable]], na.rm = TRUE)
  
  return(mean_value)
}


calculate_mean(new_data, "Age")
calculate_mean(new_data, "Field_Size")
