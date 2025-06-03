# 1. Load the library tmap

library(tmap)

# 2. Take a look at the dataset World (included in tmap). Also open the documentation page ?World .

World
summary(World)
View(World)

?World

# 3. Make the following World maps using tm_shape() and tm_polygons() :
# 	a. Fill all country areas with orange. See vignette about visual variables for some examples


tm_shape(World) + 
	tm_polygons("orange")

# or use a hex RBG color code:

tm_shape(World) + 
  tm_polygons("#FFCC00")

# b. Fill all country areas with colors that show a data variable (a variable from World )

tm_shape(World) +
  tm_polygons(fill = "press")

# c. Change the color palette to a rainbow palette. See vignette about scales.

# run cols4all::c4a_gui() to explore color palettes

(tm3c = tm_shape(World) +
  tm_polygons(
    fill = "press",
	fill.scale = tm_scale_intervals(
	  style = "fisher",      # a method to specify the classes
	  n = 7,                 # number of classes
	  midpoint = 50,         # data value mapped to the middle palette color
	  values = "-rainbow_bgyr_35_85_c73"   # color palette; 
  ))
)

# 4. Take a look at the dataset metro , also contained in tmap

metro

# 5. Make a bubble map with tm_shape() and tm_symbols() where the size of each bubble is proportional to the number of inhabitants in 2020.

(tm5 = tm_shape(metro) +
	tm_symbols(size = "pop2020",
			   size.scale = tm_scale_continuous(values.scale = 2)))

# 6. Combine the map created at step 3a with the last map.

tm3c + tm5

# 7. Make an interactive version of this map. See vignette about modes

tmap_mode("view")

tm3c + tm5
