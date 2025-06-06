library(tmap)
library(tmap.mapgl)

tmap_mode()

rtm()

tm_shape(World) +
	tm_polygons("press",
				fill.scale = tm_scale_intervals(values = "pu_gn_div")) +
	tm_title("Press")

tm_shape(World) +
	tm_polygons(c("press", "inequality"))

tm_shape(NLD_muni) +
	tm_polygons("employment_rate")

tmap_mode("maplibre")
#> ℹ tmap mode set to "maplibre".

NLD_dist$pop_dens = NLD_dist$population / NLD_dist$area

tm_shape(NLD_dist) +
	tm_polygons_3d(height = "pop_dens",
				   fill = "edu_appl_sci",
				   fill.scale = tm_scale_intervals(style = "kmeans", values = "-pu_gn"),
				   fill.legend = tm_legend("Univeristy degree")) +
	tm_maplibre(pitch = 45)


library(tmap.glyphs)

tmap_mode("plot")
tmap_mode("view")
ZH_muni = NLD_muni[NLD_muni$province == "Zuid-Holland", ]

ZH_muni$income_middle = 100 - ZH_muni$income_high - ZH_muni$income_low


tm_shape(ZH_muni) +
	tm_polygons() +
	tm_donuts(parts = tm_vars(c("income_low", "income_middle", "income_high"), multivariate = TRUE),
			  fill.scale = tm_scale_categorical(values = "-pu_gn_div"),             
			  size = "population",
			  lwd = 1,
			  size.scale = tm_scale_continuous(ticks = c(50000, 100000, 250000, 500000), values.scale = 1),
			  options = opt_tm_donuts(fill_hole = FALSE, inner = .5))


tm_shape(ZH_muni) +
	tm_polygons() +
	tm_flowers(parts = tm_vars(c("income_low", "income_middle", "income_high"), multivariate = TRUE),
			  fill.scale = tm_scale_categorical(values = "-pu_gn_div"),             
			  size = "population",
			  size.legend = tm_legend_hide(),
			  lwd = 1,
			  size.scale = tm_scale_continuous(ticks = c(50000, 100000, 250000, 500000), values.scale = 3),
			  options = opt_tm_flowers())

library(sf)
#> Linking to GEOS 3.12.1, GDAL 3.8.4, PROJ 9.4.0; sf_use_s2() is TRUE

q = function(x) {
	r = rank(x)
	r[is.na(x)] = NA
	r = r / max(r, na.rm = TRUE)
	r
}

World$rank_well_being = q((World$well_being / 8))
World$rank_footprint = q(((50 - World$footprint) / 50))
World$rank_inequality = q(((65 - World$inequality) / 65))
World$rank_press = q(1 - ((100 - World$press) / 100))
World$rank_gender = q(1 - World$gender)


tm_shape(World) +
	tm_polygons(c("rank_well_being", "rank_footprint", "rank_inequality","rank_press", "rank_gender"))


tm_shape(World) +
	tm_polygons(fill = "white", popup.vars = FALSE) +
	tm_shape(World) +   
	tm_flowers(parts = tm_vars(c("rank_gender", "rank_press", "rank_footprint", "rank_well_being", "rank_inequality"), multivariate = TRUE),
			   fill.scale = tm_scale(values = "friendly5"),
			   size = 1, popup.vars = c("rank_gender", "rank_press", "rank_footprint", "rank_well_being","rank_inequality"), id = "name") +
	tm_basemap(NULL) +
	tm_layout(bg.color = "grey90")

library(tmap.networks)

library(sfnetworks)

sfn = as_sfnetwork(roxel)

tm_shape(sfn) +
	tm_network()

rtm()

tm_shape(sfn) +
	tm_edges(col = "type", lwd = 3) +
	tm_nodes(fill = "grey40") +
	tm_basemap(server = .tmap_providers$`dark-matter`)



# get vector buildings
library(osmdata)
#> Data (c) OpenStreetMap contributors, ODbL 1.0. https://www.openstreetmap.org/copyright
buildings <- opq(bbox = "Roxel, Germany") |>
	add_osm_feature(key = "building") |>
	osmdata_sf()

library(dplyr, warn.conflicts = FALSE)
# only keep polygons
buildings_poly <- buildings$osm_polygons |>
	# convert height and levels from string to numeric
	mutate(levels = as.numeric(`building:levels`),
		   height = as.numeric(height)) |>
	# assume 2 levels if NA
	mutate(levels = if_else(is.na(levels), 2, levels),
		   # assume height of 3 m per level if no height
		   height = if_else(is.na(height), levels * 3, height))

mx = max(buildings_poly$height)

# plot
tm_shape(buildings_poly) +
	tm_polygons_3d(height = "height", fill = "building", 
				   options = opt_tm_polygons_3d(height.max = mx)) + 
	tm_maplibre(pitch = 60) +
tm_shape(sfn) +
	tm_edges(col = "type", lwd = 5) +
	tm_nodes(fill = "grey40", size = 0.2) +
	tm_basemap(server = .tmap_providers$`dark-matter`)


