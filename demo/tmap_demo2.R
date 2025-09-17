library(tmap)
library(tmap.mapgl)
library(sf)

World

st_crs(World)

tm_shape(World) +
	tm_polygons(fill = "orange", col = "black") +
	tm_crs(3857)


tm_shape(World) +
	tm_polygons(fill = "orange", col = "black") +
	tm_crs("+proj=eqearth")

Africa = World[World$continent == "Africa", ]

qtm(Africa)

metro

rtm()
tm_shape(metro) +
	tm_symbols(size = "pop2020") +
	tm_scalebar()

tm_shape(land) +
	tm_raster() +
	tm_facets(nrow = 2)

tm_shape(World) +
	tm_polygons(fill = "orange", col = "black")

tm_shape(World) +
	tm_polygons(fill = "orange", col = "orange", lwd = 2)

tmap_mode("plot")

tm_shape(World) +
	tm_polygons(fill = "HPI",
				fill.scale = tm_scale_intervals(breaks = seq(10,60, by = 5)))

tm_shape(World) +
	tm_polygons(fill = "HPI",
				fill.scale = tm_scale_intervals(breaks = seq(10,60, by = 5), label.style = "continuous"))

tm_shape(World) +
	tm_polygons(fill = "economy",
				fill.scale = tm_scale_categorical())

tm_shape(NLD_muni) +
	tm_polygons("employment_rate") +
	tm_facets("province")

tm_shape(NLD_muni) +
	tm_polygons("employment_rate") +
	tm_facets("province", free.coords = FALSE, drop.units = FALSE)
