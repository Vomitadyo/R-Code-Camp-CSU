



rm(list = ls())



# This is the preamble script for the project. 
# It should be run once each time a user begins a new R session to work on the project.

# Install pacman package if not already installed
if (!require("pacman")) {
  install.packages("pacman")
}

# Load required packages
pacman::p_load("raster", "lubridate", "dplyr", "sf", 'ggplot2', 'conflicted', 'exactextractr', 
               'elevatr', 'cdlTools', 'CropScapeR', 'leaflet',  'soilDB', 
               'nnet', "terra", 'ggspatial', 'patchwork', 'VGAM', 'tidyverse')


# Declare preference when there are conflicts
conflicts_prefer(dplyr::filter)
conflicts_prefer(dplyr::select)

