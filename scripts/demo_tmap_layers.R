# one group
tm_shape(World) +
	tm_polygons(fill = "yellow") +
	tm_dots(fill = "red")



tm_shape(World) +
	tm_polygons(fill = "yellow") +
tm_shape(metro) +
	tm_dots(fill = "red")

tmap_mode("plot")


tm_shape(World, crs = "+proj=robin") +
	tm_polygons(col = "yellow") +
	tm_dots(fill = "red") +
tm_graticules(n.y = 10) +
	tm_title("World Map") +
	tm_scalebar()

tm_shape(NLD_muni) +
	tm_graticules(n.y = 10, col = "gray80") +
	tm_polygons(fill = "gold") +
	tm_title("Netherlands Map") +
	tm_scalebar(position = c("left", "bottom")) +
	tm_layout(asp = 1, bg.color = "purple")

tm_shape(NLD_muni) +
	tm_grid(col = "gray80") +
	tm_polygons(fill = "gold") +
	tm_title("Netherlands Map") +
	tm_scalebar(position = c("left", "bottom")) +
	tm_layout(asp = 1, bg.color = "purple")


tm_shape(NLD_muni, bbox = "Utrecht") +
	tm_graticules(n.y = 10, col = "gray80") +
	tm_polygons(fill = "gold") +
	tm_title("Netherlands Map") +
	tm_scalebar(position = c("left", "bottom")) +
	tm_layout(asp = 1, bg.color = "purple")


tm_shape(NLD_muni, bbox = st_bbox(c(ymin = 400000, ymax = 450000, xmin = 100000, xmax = 150000), crs = st_crs(NLD_muni))) +
	tm_graticules(n.y = 10, col = "gray80") +
	tm_polygons(fill = "gold") +
	tm_title("Netherlands Map") +
	tm_scalebar(position = c("left", "bottom")) +
	tm_layout(asp = 1, bg.color = "purple")


tm_shape(NLD_muni) +
	tm_lines()

tm_shape(metro) +
	tm_symbols(shape = 17)


World$color = c("pink", "orange", "purple")

tm_shape(World) +
	tm_polygons(fill = "color",
				fill.scale = tm_scale_asis())

tm_shape(World) +
	tm_polygons(fill = "color",
				fill.scale = tm_scale_categorical())

# create grid of 25 points in the Atlantic
atlantic_grid = cbind(expand.grid(x = -51:-47, y = 20:24), id = seq_len(25))
x = sf::st_as_sf(atlantic_grid, coords = c("x", "y"), crs = 4326)

tm_shape(x, bbox = tmaptools::bb(x, ext = 1.2)) +
	tm_symbols(shape = "id",
			   size = 2,
			   lwd = 2,
			   fill = "orange",
			   col = "black",
			   shape.scale = tm_scale_asis()) +
	tm_text("id", ymod = -2)

tm_shape(metro) +
	tm_symbols(shape = 7)

ttm()
tm_shape(NLD_muni) +
	tm_polygons() +
	tm_minimap()

