

# clear everything
rm(list = ls())

library(sf)
library(leaflet)
library(dplyr)
library(ggplot2)

# Import our processed data in Cache

xxxxxxxxxx

# if you cant use the df created earlier,  run the codes below to create it
#Data_A <- read.csv('Build/Data/Data_A.csv')
#Data_B <- read.csv('Build/Data/Data_B.csv') 
#My_df <- merge(Data_A, Data_B) 


# Convert to sf file
data_sf <- My_df %>%
  st_as_sf(
  coords = c("Longitude", "Latitude"),
  crs = 4326 # Coordinate Reference System
)


# Simple plot
ggplot(data_sf) +
  geom_sf() +
  theme_minimal()



# Detailed plot

# Read Other Maps
# CO Counties in study area
Counties <- read_sf("Build/Data/Counties/Counties.shp")

# find central points to use for labeling
County_Labels <- st_point_on_surface(Counties)


ggplot() +
  geom_sf(
    data = Counties,  fill = "grey90", color = "grey40", linewidth = 0.5) +
  geom_sf_text(data = County_Labels, aes(label = NAME), size = 3.5, color = "black") + # state names
  geom_sf(data = data_sf,  aes(color = Status),  size = 2.5,  alpha = 0.8) +
  labs(color = "Status" ) +
  theme_minimal()



# Use leaflet package to zoom in and out

Leflet_map <- leaflet() %>%
  addTiles() %>% # Add OpenStreetMap background
  # Add county boundaries
  addPolygons(
    data = Counties, fillOpacity = 0.3,
    color = "black",    weight = 1,  label = ~NAME) %>%
  # Add your observations
  addCircleMarkers(
    data = data_sf,  radius = 5,
    color = ~ifelse(Status == "Active", "blue", "red"),
    fillOpacity = 0.8,stroke = FALSE,
    label = ~paste("Status:", Status))

Leflet_map


# Identify field in each county
# Create a variable indicating county for each field

