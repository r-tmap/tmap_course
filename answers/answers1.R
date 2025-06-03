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

# 11. What color palette can you recommend for the following data variables in the World dataset: "well_being" , "gdp_cap_est" , and "footprint" ?

#12. Make a choropleth (see 3b) of each of these variables using the selected color palettes. (Tip: put a - prefix to reverse the colors)

tmap_mode("plot")

tm_shape(World) +
  tm_polygons(
    fill = "well_being",
    fill.scale = tm_scale_intervals(values = "-greens")) +
tm_crs("auto")

# tm_crs will be covered tomorrow

# question: suppose you would like to add a highlighting color
# how to check for color-blind-friendliness etc?

# get the palette colors and add a highlighting color
pal = c4a("greens", n = 6, reverse = TRUE)
pal[3] = "#FF0000" # for convenience we replace the third color with red

# load that palette into cols4all
c4a_data(list(mypal = pal), types = "seq") |> 
	c4a_load()

# analyse the palette (not color-blind friendly in this case)
c4a_gui()

# create the map again
tm_shape(World) +
  tm_polygons(
  fill = "well_being",
  fill.scale = tm_scale_intervals(values = pal)) +
tm_crs("auto")
