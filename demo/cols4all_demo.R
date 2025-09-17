library(cols4all)

c4a_gui()

tm_shape(World) +
	tm_polygons(
		fill = "economy", 
		col = NULL, 
		fill.scale = tm_scale_categorical(values = "brewer.set2"))

.P$brewer$div$pu_or

tm_shape(World) +
	tm_polygons("press",
				fill.scale = tm_scale_intervals(values = "-brewer.pu_or"))


library(ggplot2)
data("diamonds")
diam_exp = diamonds[diamonds$price >= 15000, ]
diam_exp$clarity[1:500] = NA

# continuous diverging scale
ggplot(diam_exp, aes(x = carat, y = depth, color = price)) +
	geom_point(size = 2) +
	scale_color_continuous_c4a_div("cols4all.pu_gn_div", mid = mean(diam_exp$price)) +
	theme_light()

ggplot(diam_exp, aes(x = carat, y = depth, color = price)) +
	geom_point(size = 2) +
	scale_color_binned_c4a_seq(.P$matplotlib$seq$plasma) +
	theme_light()


paletteer = readRDS(gzcon(url("https://cols4all.github.io/paletteer.rds")))
# from paletteer version 1.6.0

c4a_sysdata_import(paletteer)
