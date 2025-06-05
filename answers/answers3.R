library(terra)
library(sf)
library(tmap)
library(tidyverse)

slo_elev = rast("data/slovenia/slo_elev.tif")
slo_gm = rast("data/slovenia/slo_gm.tif")

qtm(slo_elev)
qtm(slo_gm)

slo_regions = st_read("data/slovenia/slo_regions.gpkg")

# slo_regions_vect = vect("data/slovenia/slo_regions.gpkg")

slo_region_SI041 = slo_regions |> 
	filter(NUTS_ID == "SI041")

tmap_mode("view")
qtm(slo_region_SI041)

qtm(slo_regions, fill = "gold") + qtm(slo_region_SI041, fill = "orange")

# alternative method

slo_regions = slo_regions |> 
	mutate(nuts_color = ifelse(slo_regions$NUTS_ID == "SI041", "orange", "gold"))
tm_shape(slo_regions) +
	tm_polygons(fill = "nuts_color", fill.scale = tm_scale_asis())

slo_elev_mask = mask(slo_elev, slo_region_SI041)
qtm(slo_elev_mask)

slo_cities = st_read("data/slovenia/slo_cities.gpkg")

slo_cities_elev = terra::extract(slo_elev, slo_cities)
slo_cities2 = slo_cities |> 
	mutate(elev = slo_cities_elev$elevation)

slo_cities_gm = terra::extract(slo_gm, slo_cities)
slo_cities3 = slo_cities2 |> 
	mutate(gm = slo_cities_gm$geomorphons)

qtm(slo_elev) +
qtm(slo_cities2, fill = "elev")

slo_tavg = read_stars("data/slovenia/slo_tavg.tif")
qtm(slo_tavg)

slo_tavg_splitted = split(slo_tavg)

qtm(slo_tavg_splitted)

tm_shape(slo_tavg_splitted) +
	tm_raster(col = tm_vars(),
			  col.free = FALSE)

slo_tmean = st_apply(slo_tavg, c("x", "y"), FUN = mean)
qtm(slo_tmean)


slo_border = st_read("data/slovenia/slo_border.gpkg")

range(slo_elev)

c4a_gui()

tm_shape(slo_elev) +
	tm_raster(col.scale = tm_scale_continuous(values = "matplotlib.terrain", values.range = c(0.3, 1))) +
tm_shape(slo_border) + 
	tm_borders(lwd = 1.5) +
tm_shape(slo_cities) +
	tm_dots() +
	tm_labels("name") +
tm_basemap("Esri.WorldImagery")

tmap_mode("view")

tm_shape(slo_gm) + 
	tm_raster()


tm_shape(slo_gm) + 
	tm_raster(col.scale = tm_scale_categorical(values = "cols4all.friendly13"))

c4a_gui()

slo_cities3

tm_shape(slo_cities3) +
	tm_bubbles(size = "population", 
			   fill = "gm",
			   size.scale = tm_scale_continuous(values.scale = 3))

tmap_mode("plot")
tm_shape(slo_tavg) +
	tm_raster(col.scale = tm_scale_intervals(values = "tol.sunset", midpoint = NA))

tm_shape(slo_tavg) +
	tm_raster(col.scale = tm_scale_intervals(values = "tol.sunset", midpoint = 0, breaks = c(-15, -5, 5, 15, 25)))


tm_shape(slo_tavg) +
	tm_raster(col.scale = tm_scale_intervals(values = "tol.sunset", midpoint = NA, style = "kmeans"))


