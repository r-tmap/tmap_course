library(cols4all)

c4a_gui()

library(ggplot2)

ggplot(mtcars, aes(wt, mpg, fill = disp)) +
	geom_point(shape = 21, colour = "black", size = 5, stroke = 1)

ggplot(mtcars, aes(wt, mpg, fill = disp)) +
	geom_point(shape = 21, colour = "black", size = 5, stroke = 1) +
	scale_fill_continuous_c4a_seq("-matplotlib.plasma")


tm_shape(World) +
  tm_polygons("HPI",
  			fill.scale = tm_scale_continuous(values = "tableau.classic_orange_blue"))

tm_shape(World) +
	tm_polygons("HPI",
				fill.scale = tm_scale_intervals(values = "tableau.classic_orange_blue"))
