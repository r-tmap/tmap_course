library(sf)
library(tmap)
library(tidyverse)

slo_regions = st_read("data/slovenia/slo_regions.gpkg")

qtm(slo_regions)

names(slo_regions)

tm_shape(slo_regions) +
	tm_polygons(fill = tm_vars())

st_geometry_type(slo_regions)

st_crs(slo_regions)

slo_railroads = st_read("data/slovenia/slo_railroads.gpkg")
slo_border = st_read("data/slovenia/slo_border.gpkg")

qtm(slo_railroads)

slo_railnetwork = slo_railroads |> 
	st_buffer(dist = 500) |> 
	st_union() |> 
	st_transform(st_crs(slo_border))
slo_railnetwork = slo_railnetwork[2]

st_geometry_type(slo_railnetwork)

qtm(slo_railnetwork)

tm_shape(slo_railnetwork) +
	tm_lines()


qtm(slo_border)




slo_diff = st_difference(slo_border, slo_railnetwork)

qtm(slo_diff)


slo_cities = st_read("data/slovenia/slo_cities.gpkg")

tm_shape(slo_regions) +
	tm_polygons("pop_dens") +
	
library(cols4all)

c4a("brewer.blues", 5, range = c(.1, .6)) |> 
	c4a_plot(hex = TRUE)

tm_shape(slo_regions) +
	tm_polygons(fill = "pop_dens",
				fill.scale = tm_scale_intervals(values = c4a("brewer.blues", 5, range = c(.1, .6)))) +
tm_shape(slo_cities) +
	tm_bubbles(size = "population", 
			   fill = "place",
			   fill.scale = tm_scale_categorical(values = c("orange", "yellow")),
			   size.scale = tm_scale_continuous(values.scale = 4, ticks = c(50, 100, 200, 300) * 1e3),
			   size.legend = tm_legend(title = "Population"),
			   fill.legend = tm_legend(title = "Place")
			   ) +
	tm_labels(text = "name", options = opt_tm_labels(point.label = TRUE)) +
tm_compass() +
tm_scalebar() +
tm_title(text = "Slovenia", position = c("left", "top"))


slo_regions_ts = st_read("data/slovenia/slo_regions_ts.gpkg")

tm_shape(slo_regions_ts) +
	tm_polygons(fill = "gdppercap") +
	tm_facets(by = "time")


tm_shape(slo_regions_ts) +
	tm_cartogram(size = "population", fill = "gdppercap") +
	tm_facets(by = "time")

tm_shape(slo_regions) +
	tm_cartogram(size = "population", fill = "gdppercap")

tm_shape(slo_regions) +
	tm_cartogram_ncont(size = "population", fill = "gdppercap")

tm_shape(slo_regions) +
	tm_cartogram_dorling(size = "population", fill = "gdppercap", options = opt_tm_cartogram_dorling(share = 20))
