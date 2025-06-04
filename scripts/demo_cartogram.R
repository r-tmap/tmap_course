library(tmap)
library(tmap.cartogram)

Africa = World[World$continent == "Africa", ]

tm_shape(Africa) +
	tm_cartogram(size = "pop_est")

tm_shape(Africa) +
	tm_polygons(fill = "footprint")

tm_shape(Africa) +
	tm_cartogram(size = "pop_est", fill = "footprint")

ttm()
tm_shape(Africa) +
	tm_cartogram_ncont(size = "pop_est", fill = "footprint")

tm_shape(NLD_dist) +
	tm_polygons(fill = "edu_appl_sci", col = NULL) +
	tm_shape(NLD_prov) +
	tm_borders(lwd = 2)

tm_shape(NLD_muni) +
	tm_cartogram_ncont(size = "population", fill = "edu_appl_sci", col = NULL) +
	tm_shape(NLD_prov) +
	tm_borders(lwd = 2)

tm_shape(Africa, crs = "+proj=robin") +
	tm_bubbles(size = "pop_est",
			   size.scale = tm_scale_continuous(values.scale = 8))

tm_shape(Africa, crs = "+proj=robin") +
	tm_cartogram_dorling(size = "pop_est")


tm_shape(Africa) +
	tm_cartogram(fill = "HPI",
				 fill.scale = tm_scale_continuous(values = "pu_gn"),
				 size = "*pop_est") +
	tm_animate_slow(fps = 20, play = "pingpong")
