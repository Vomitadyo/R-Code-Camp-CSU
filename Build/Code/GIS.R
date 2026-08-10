

# clear everything
rm(list = ls())

library(sf)
library(leaflet)
library(dplyr)

# Import our processed data in Cache
Data_A <- read.csv('Build/Data/Data_A.csv')
Data_B <- read.csv('Build/Data/Data_B.csv') 

My_df <- merge(Data_A, Data_B) 

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
Counties <- read_sf("Build/Data/counties_shapefiles/USA_Counties.shp") %>%
  filter(STATE_NAME == 'Colorado')%>%
  filter(NAME %in% c('Cheyenne', 'Kit Carson', 'Lincoln', 'Logan', 'Phillips', 'Sedgwick', 'Washington', 'Yuma')) %>%
  st_transform(4326)

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

