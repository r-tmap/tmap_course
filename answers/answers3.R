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
