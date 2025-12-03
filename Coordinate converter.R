# Coordinate converter as the format for inclusion to QGIS list was wrong ----
rm(list=ls())
## coords to be converted ----
library(sf)
## Create a data frame with the originals ----
coords <- data.frame(
  easting = c(194170.56, 194015.1, 194286.6, 194365.39, 194389.31, 194433.53, 194402.50),
  northing = c(650660.00, 650523.8, 650587.6, 650420.06, 650322.45, 650282.87, 650357.71))
## high 1, low 1, high 2, medium 2, medium 3, medium 4, medium 5
## Convert to sf ----
coords_sf <- st_as_sf(coords, coords = c("easting", "northing"), crs = 27700)
## Transform to WGS 84 ----
coords_wgs84 <- st_transform(coords_sf, crs = 4326)
## converted coordinates ----
coordinates <- st_coordinates(coords_wgs84)
print(coordinates)
