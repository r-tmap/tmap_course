library(tmap)


# crs is set in the transformation stage
tm_shape(World, crs = "auto") +
	tm_polygons("press")


# crs is set in the plotting stage
tm_shape(World) +
	tm_polygons("press") +
	tm_crs("auto")


tm = tm_shape(World) +
	tm_polygons("press") +
	tm_crs("auto")


dir.create("output")
tmap_save(tm, filename = "output/world.png", width = 2000, height = 1200)
tmap_save(tm, filename = "output/world_small.png", width = 2000, height = 1200, scale = 0.5)
tmap_save(tm, filename = "output/world_large.png", width = 2000, height = 1200, scale = 2)

tmap_save(tm, filename = "output/world_icon.png", width = 400, height = 400, scale = 0.5)

tmap_save(tm, filename = "output/world.pdf", width = 1.5, height = 1.5)
