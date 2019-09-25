library(sf)

library(osmdata)
library(osmplotr)
library(dplyr)
bbox_select <- getbb('salzburg, at') 
bbox_select[,] <- c(12.9, 47.7, 13.2, 47.9)
bbox_map <- matrix(c(12.92, 47.71, 13.15, 47.86), nrow = 2)
# muenster: 7.56, 51.90, 7.7, 52.00
# salzburg: 12.9, 47.73, 13.10, 47.85
# sbg_map: 12.9, 47.7, 13.2, 47.9
# lisbon: -9.21, 38.65, -9.03, 38.81

# dat_B <- extract_osm_objects (key = 'building', bbox = bbox_select)
dat_H <- extract_osm_objects (key = 'highway', bbox = bbox_select)
dat_R <- extract_osm_objects (key = 'water', bbox = bbox_select)
# dat_C <- extract_osm_objects(key = 'natural', value = 'coast', bbox = bbox_select, return_type = 'line')
# dat_W <- osm_line2poly(dat_C, bbox = bbox_select)
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
map <- osm_basemap (bbox = bbox_map, bg = 'white')

map <- add_osm_objects (map, dat_H_1, col = 'gray50', border = NA, size = 0.5)
map <- add_osm_objects (map, dat_H_2, col = 'gray50',  border = NA, size = 0.2)
# map <- add_osm_objects (map, dat_C, col = 'gray50', border = NA, size = 0.2)
map <- add_osm_objects (map, dat_R, col = 'gray20', border = NA)

print_osm_map (map)
# print_osm_map (map, dpi = 900, filename = 'salzburg.png')