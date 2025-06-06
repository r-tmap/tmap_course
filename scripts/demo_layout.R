library(tmap)

tmap_mode("plot")

tm_shape(World) +
	tm_polygons("gender",
				fill.legend = tm_legend(title = "")) +
	tm_crs("auto") +
	tm_title("Gender Inequality Index") +
	tm_title("- inequality between women and men -", size = 1, fontface = "italic") +
	tm_scalebar()


tm_shape(NLD_muni) +
	tm_polygons("employment_rate",
				fill.legend = tm_legend(title = "")) +
	tm_title("Employment rate") +
	tm_scalebar(position = tm_pos_in("left", "bottom")) +
	tm_compass(type = "8star") +
	tm_credits("Statistics Netherlands 2022\nKadaster", position = tm_pos_out("right", "center", pos.v = "bottom"))

bb_ams = tmaptools::bb("Amsterdam") # Uses OSM geocoding
bb_ams_sf = tmaptools::bb_poly(bb_ams)


tm_shape(NLD_dist) +
	tm_fill("income_high") +
tm_shape(NLD_muni) +
	tm_borders(lwd=1) +
tm_shape(NLD_prov) +
	tm_borders(lwd=3) +
tm_shape(bb_ams_sf) +
	tm_borders(col = "red") +
tm_inset(bb_ams, position = tm_pos_in("left", "top"), height = 4, width = 5)

g = ggplot(mtcars, aes(mpg, wt, shape = factor(cyl))) + geom_point() + theme_bw(base_size = 4)

tm_shape(NLD_dist) +
	tm_fill("income_high") +
	tm_inset(g)

tm_shape(NLD_muni) +
	tm_polygons("income_high", fill.legend = tm_legend(position = tm_pos_out("right", "center"))) 
	
tm_shape(NLD_muni) +
	tm_polygons("income_high", fill.legend = tm_legend(position = tm_pos_out("right", "center", pos.v = "bottom"))) 


## options
tmap_mode("plot")
tm_shape(NLD_muni) +
	tm_polygons("income_high") +
	tm_layout(frame = TRUE,
			  frame.color = "purple",
			  frame.lwd = 3,
			  frame.r = 40)


tm_shape(World, crs = "+proj=robin") + tm_polygons() + tm_graticules() +
	tm_layout(earth_boundary = TRUE, frame = FALSE, bg.color = "steelblue", space.color = "black")


tm_shape(slo_regions_ts) +
	tm_polygons("gdppercap") +
	tm_facets("time") +
	tm_layout(panel.label.bg.color = "pink", panel.label.fontface = "italic")


tm_shape(slo_regions_ts) +
	tm_polygons("gdppercap") +
	tm_facets("time") +
	tm_layout(panel.label.bg.color = "pink", panel.label.fontface = "italic", panel.labels = paste("Year", 2003:2022))

tmap_mode("plot")

tm_shape(World) +
	tm_polygons("HPI") +
	tm_style("cobalt")

tm_shape(World) +
	tm_polygons("HPI") +
	tm_style("classic")


tm_shape(World) +
	tm_polygons("HPI")

tmap_style("classic")

tm_shape(World) +
	tm_polygons("HPI")

tm_shape(slo_regions_ts) +
	tm_polygons("gdppercap") +
	tm_facets("time") +
	tm_layout(panel.label.bg.color = "pink", panel.label.fontface = "italic", panel.labels = paste("Year", 2003:2022))



tm_shape(NLD_muni) +
	tm_polygons("employment_rate", fill.legend = tm_legend(group_id = "lt")) +
	tm_compass(group_id = "lt") +
	tm_credits("Statistics Netherlands", group_id = "lt") +
	tm_comp_group(group_id = "lt", position = c("left", "top"))


tm_shape(NLD_muni) +
	tm_polygons("employment_rate", fill.legend = tm_legend(group_id = "lt")) +
	tm_compass(group_id = "lt") +
	tm_credits("Statistics Netherlands", group_id = "lt") +
	tm_comp_group(group_id = "lt", position = c("left", "top"), frame_combine = FALSE, frame = TRUE)

tm_shape(NLD_muni) +
	tm_polygons("employment_rate", fill.legend = tm_legend(group_id = "lt")) +
	tm_compass(group_id = "lt") +
	tm_credits("Statistics Netherlands", group_id = "lt") +
	tm_comp_group(group_id = "lt", position = c("left", "top"), frame_combine = FALSE, frame = TRUE, equalize = FALSE)

tmap_mode("view")
tmap_options_reset()


tmap_mode("view")
tm_shape(NLD_dist) +
	tm_polygons(
		fill = "dwelling_value",
		fill.scale = tm_scale_intervals(values = "-brewer.rd_yl_bu", breaks = c(75, 150, 250, 500, 750, 1000, 1600)),
		fill.legend = tm_legend("Dwelling value (x 1000)"),
		group = "District") +
	tm_shape(NLD_muni) +
	tm_polygons(
		fill = "dwelling_value",
		fill.scale = tm_scale_intervals(values = "-brewer.rd_yl_bu", breaks = c(75, 150, 250, 500, 750, 1000, 1600)),
		fill.legend = tm_legend_hide(),
		group = "Municipality") +
	tm_borders(group = "District", lwd = 2) +
	tm_title("Zoom in for district level (and out for municipality level)") +
	tm_shape(NLD_prov) +
	tm_borders(lwd = 3, group.control = "none") +
	tm_group("Municipality", zoom_levels = 8:10) +
	tm_group("District", zoom_levels = 11:14) +
	tm_view(set_zoom_limits = c(8,14))
