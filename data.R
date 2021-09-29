library(sf)
library(osmdata)
library(osmplotr)
library(dplyr)
bbox_select <- getbb(
  'recoleta, buenos aires, argentina',
  format_out = "matrix"
) 
bbox_select[,] <- c(-58.44503,  -34.60884, -58.36032, -34.57019)
bbox_map <- matrix(c(-58.40096, -34.59838, -58.35749, -34.58277), nrow = 2) 
# muenster: 7.56, 51.90, 7.7, 52.00
# salzburg: 12.9, 47.73, 13.10, 47.85
# sbg_map: 12.9, 47.7, 13.2, 47.9
# lisbon: -9.21, 38.65, -9.03, 38.81
# milano: 9.09, 45.44, 9.27, 45.50 | 9.095, 45.445, 9.275, 45.505
# buenos_aires: -58.53145, -34.70564, -58.33514, -34.52655

# dat_B <- extract_osm_objects (key = 'building', bbox = bbox_select)
dat_H <- extract_osm_objects (key = 'highway', bbox = bbox_select)
dat_R <- extract_osm_objects (key = 'water', bbox = bbox_select)
dat_C <- extract_osm_objects(key = 'natural', value = 'coast', bbox = bbox_select, return_type = 'line')
# "bridleway","construction","corridor","cycleway","footway",      
# "living_street","motorway","motorway_link","path","pedestrian",    
# "platform","primary","primary_link","private_footway","proposed",
# "residential","road","secondary","secondary_link","service",       
# "steps","tertiary","tertiary_link","track","trunk",     
# "trunk_link","unclassified"

dat_H_1 <- dat_H %>% 
  filter(highway %in% c("motorway","motorway_link","primary","primary_link",
                        "secondary","secondary_link","tertiary","tertiary_link", 
                        "trunk","trunk_link"))
dat_H_2 <- dat_H %>% 
  filter(highway %in% c(#"bridleway","cycleway","footway",      
                        "living_street",#"path","pedestrian",
                        "residential", "unclassified"))#,"road","track","unclassified"))
map <- osm_basemap (bbox = bbox_select, bg = 'white')

map <- add_osm_objects (map, dat_H_1, col = 'gray60', border = NA, size = 0.5)
map <- add_osm_objects (map, dat_H_2, col = 'gray60',  border = NA, size = 0.2)
map <- add_osm_objects (map, dat_C, col = 'gray70', border = NA)
map <- add_osm_objects (map, dat_R, col = 'gray80', border = NA)

print_osm_map (map)
print_osm_map (
  map,
  dpi = 1800,
  filename = 'out/buenos_aires.png'
)

knitr::plot_crop('out/buenos_aires.png')
