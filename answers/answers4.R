library(stars)
library(terra)
library(sf)
library(tmap)

srtm = rast(system.file("raster/srtm.tif", package = "spDataLarge"))
zion = read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))
zion = st_transform(zion, st_crs(srtm))
zion_points <- st_transform(spDataLarge::zion_points, st_crs(srtm))


tmap_mode("plot")

(tm = tm_shape(srtm) +
	tm_raster(col = "srtm",
			  col.scale = tm_scale_continuous(values = "carto.geyser", limits = c(1000, 3000), n = 6),
			  col.legend = tm_legend(title = "Elevation", orientation = "portrait", position = tm_pos_out("right", "center"), reverse = TRUE)) +
tm_shape(zion) +
  tm_borders(lwd = 2) +
tm_shape(zion_points) + 
  tm_dots() +
tm_layout(scale = 1, meta.margins = c(0, 0, 0, .2)) +
tm_compass(position = tm_pos_out("right", "center", pos.v = "bottom")) +
tm_scalebar(position = tm_pos_out("right", "center", pos.v = "bottom")))
	
tmap_save(tm, filename = "output/zion_journal.png", width = 2000, height = 2000)
tmap_save(tm, filename = "output/zion_poster.png", width = 2000, height = 2000, scale = 0.5)

# work-around bug #1117
tmap_save(tm + tm_layout(legend.frame.lwd = 0.5), filename = "output/zion_poster.png", width = 2000, height = 2000, scale = 0.5)

tmap_save(tm + tm_layout(legend.frame.lwd = 0.5), filename = "output/zion_icon.png", width = 500, height = 500, scale = 0.4)

tmap_save(tm, filename = "output/zion.html")
