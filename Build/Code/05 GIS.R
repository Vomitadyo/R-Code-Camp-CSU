

# clear everything
rm(list = ls())



# Import our processed data in Cache

My_df <- readRDS('Build/Cache/My_df.rds')

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

#=============================================================================================================

# Identify field in each county
# Create a variable indicating county for each field

# Make sure CRS matches
Counties <- st_transform(Counties, st_crs(data_sf))


# Identify county for each field
data_sf1 <- st_join(data_sf, Counties, join = st_within) # join all cols
data_sf <- st_join(data_sf, Counties["NAME"], join = st_within) # only the county name



# Create a buffer/circle around the point
field_polygon <- data_sf %>%
  st_buffer(dist = 5000) # change dist and visualize on the plot


ggplot() +
  geom_sf(
    data = Counties,  fill = "grey90", color = "grey40", linewidth = 0.5) +
  geom_sf_text(data = County_Labels, aes(label = NAME), size = 3.5, color = "black") + # state names
  geom_sf(data = field_polygon,  aes(color = Status),  size = 2.5,  alpha = 0.8) +
  labs(color = "Status" ) +
  theme_minimal()


###################################################################


# Exctract data from raster files


# read the raster file
# downloaded from; https://databasin.org/datasets/35bed46ed5674db58d3a56fd3423a3f6/
temp <- raster("Build/Data/Temp/temperature.tif")

plot(temp)

print(temp)


# Project the shape file to match the raster file projection
data_sf <- st_transform(data_sf, crs(temp)) %>%
  st_buffer(dist = 100) %>%
  mutate(ID = as.numeric(1:nrow(.)))


# Extract the values of the crop data layer for each field
temp_values <- exact_extract(temp, data_sf)  %>%
  bind_rows(., .id = 'ID') %>%
  mutate(ID = as.numeric(ID)) %>%
  group_by(value, ID) %>%
  summarize(coverage = sum(coverage_fraction))%>% # sum up coverages
  group_by(ID) %>%
  summarise(
    weighted_mean = weighted.mean(value, coverage, na.rm = TRUE) # weighted mean temp
  )
  

# merge
new_data <- merge(data_sf, temp_values)




# save

saveRDS(new_data, file = "build/Cache/new_data.rds")

