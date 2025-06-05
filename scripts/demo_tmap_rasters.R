library(tmap)
library(terra)
library(stars)
library(sf)
library(spDataLarge)
library(cols4all)

tm_shape(land) + 
	tm_raster(c("trees", "elevation"))






tm_shape(land) + 
	tm_raster(col = c("trees", "elevation"),
			  col.free = TRUE)

# library(ggplot2)
# scales argument of facet_grid()

tm_shape(metro) +
	tm_bubbles(size = c("pop1960", "pop2030"))

tm_shape(metro) +
	tm_bubbles(size = c("pop1960", "pop2030"),
			   size.free = FALSE)


tm_shape(land) + 
	tm_raster(col = c("trees", "elevation"))

tm_shape(land) + 
	tm_raster(col = "trees",
			  col.scale = tm_scale_continuous(values = "matplotlib.viridis")) +
	tm_facets(by = "cover_cls")


tm_shape(World) + 
	tm_polygons(fill = "HPI") +
	tm_facets(by = "continent", free.coords = FALSE)

tm_shape(World) + 
	tm_polygons(fill = "HPI") +
	tm_facets(by = "continent", free.coords = TRUE)

tm_shape(World) + 
	tm_polygons(fill = "HPI") +
	tm_facets_grid(rows = "continent", columns = "economy")


srtm = rast(system.file("raster/srtm.tif", package = "spDataLarge"))
zion = read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))
zion = st_transform(zion, st_crs(srtm))
zion_points <- st_transform(spDataLarge::zion_points, st_crs(srtm))

tmap_mode("view")
qtm(srtm) + qtm(zion) + qtm(zion_points)

library(mapview)
mapview(srtm) + mapview(zion) + mapview(zion_points)


tmap_mode("plot")

tm_shape(srtm) +
	tm_raster(col = "srtm",
			  col.scale = tm_scale_continuous(values = "carto.geyser"))

tm_shape(srtm) +
	tm_raster(col = "srtm",
			  col.scale = tm_scale_continuous(values = "carto.geyser", limits = c(1000, 3000), ticks = c(1000, 2000, 3000)))


tm_shape(srtm) +
	tm_raster(col = "srtm",
			  col.scale = tm_scale_continuous(values = "carto.geyser", limits = c(1000, 3000), ticks = c(1000, 2000, 3000)),
			  col.legend = tm_legend(orientation = "landscape", position = tm_pos_out("center", "bottom"), item.width = 8)) +
	tm_layout(scale = 3)

qtm(World, fill = "HPI") + tm_layout(scale = .5)
qtm(World, fill = "HPI") + tm_layout(scale = 1)
qtm(World, fill = "HPI") + tm_layout(scale = 2)

tm_shape(World) +
	tm_polygons()

tm_shape(l7) +
	tm_rgb(col = tm_vars(dimvalues = 1:3, multivariate = TRUE))

tm_shape(l7) +
	tm_rgb(col = tm_vars(dimvalues = 3:1, multivariate = TRUE))

tm_shape(l7) +
	tm_rgb(col = tm_vars(dimvalues = rep(1,3), multivariate = TRUE))


