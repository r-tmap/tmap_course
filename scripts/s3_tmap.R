library(tmap)


tm_shape(World) + tm_polygons("purple")

tmap_mode("view")

tm_shape(World) + tm_polygons("purple")

ttm()



tm_shape(World) + tm_polygons("press")

tm_shape(World) + tm_polygons(c("inequality", "gender"))

tm_shape(World) + 
  tm_polygons(
  	fill = c("inequality", "gender"),
  	col = "red",
  	lwd = 2,
  	lty = "dashed")

tm_shape(World) + 
	tm_polygons(
		fill = "yellow",
		col = "red",
		lwd = "inequality") +
	tm_dots(fill = "purple",
			size = "pop_est")


tm_shape(World) + 
	tm_polygons(
		fill = "HPI",
		col = "red",
		lwd = "inequality") +
	tm_dots(fill = "purple",
			size = "pop_est")

tmap_mode("view")

tm_shape(World) + 
	tm_polygons(
		fill = "HPI",
		col = "red",
		lwd = "inequality") +
	tm_dots(fill = "purple",
			size = "pop_est")

tm_shape(World) + 
	tm_polygons(
		fill = "HPI")

tm_shape(World) + 
	tm_polygons(
		fill = "HPI",
		fill.scale = tm_scale_continuous(limits = c(25, 55), outliers.trunc = c(TRUE, TRUE)))

tm_shape(World) + 
	tm_polygons(
		fill = "HPI",
		fill.scale = tm_scale_intervals(n = 7, style = "kmeans"))

tmap_mode("plot")
tm_shape(World) + 
	tm_polygons(
		fill = "HPI",
		fill.scale = tm_scale_intervals(n = 7, style = "kmeans", values = "purples"),
		fill.legend = tm_legend(title = "Happy Planex Index", orientation = "portrait"))


