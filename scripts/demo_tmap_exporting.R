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

tm_shape(World) +
	tm_polygons("press") +
	tm_crs("auto") +
	tm_layout(asp = 2)

tmap_save(tm, filename = "output/world_square.pdf", width = 7, height = 7, asp = 2)
tmap_save(tm, filename = "output/world_square2.pdf", width = 7, height = 7)
tmap_save(tm, filename = "output/world_square3.pdf", width = 7, height = 7, asp = 0)

tm = tm_shape(World) +
	tm_polygons("press", fill.scale = tm_scale_intervals(n = 9, values = "brewer.set2")) +
	tm_crs("auto")

tmap_save(tm, filename = "output/world_srgb.pdf", width = 9, height = 6, colormodel = "srgb")
tmap_save(tm, filename = "output/world_cmyk.pdf", width = 9, height = 6, colormodel = "cmyk")

tmap_save(tm, filename = "output/press_freedom.html")
tmap_save(tm, filename = "output/press_freedom2.html", selfcontained = FALSE)

tm2 = tm_shape(World) +
	tm_polygons(c("press", "economy"))

tmap_save(tm2, filename = "output/press_economy.html")
