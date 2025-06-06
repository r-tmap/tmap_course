library(stars)
library(terra)
library(sf)
library(tmap)
library(tidyverse)
# exporting

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

# shiny

slo_regions_ts = st_read("data/slovenia/slo_regions_ts.gpkg") |> 
	mutate(time = as.factor(time),
		   id = paste(NUTS_ID, time, sep = "_"))

# side topic: animations outside shiny
tmap_mode("plot")
tm_shape(slo_regions_ts) +
	tm_polygons("gdppercap") +
	tm_facets("time")

tm_shape(slo_regions_ts) +
	tm_polygons("gdppercap") +
	#tm_facets("time") +
	tm_animate("time", fps = 1)

tm = tm_shape(slo_regions_ts) +
	tm_polygons("gdppercap") +
	#tm_facets("time") +
	tm_animate("time", fps = 1)

tmap_animation(tm, filename = "output/slo_gdp.gif")


# shiny app
years <- as.numeric(levels(slo_regions_ts$time))
year_init = 2010



tmap_mode("view")
shinyApp(
	ui = fluidPage(
		tmapOutput("map", height = "600px"), 
		sliderInput("year", "Year", min = min(years), max = max(years), value = year_init)),
	server <- function(input, output, session) {
		output$map <- renderTmap({
			tm_shape(slo_regions_ts |> filter(time == as.character(year_init))) + 
				tm_polygons(fill = "gdppercap", zindex = 401)
		})
		get_data = reactive({
			slo_regions_ts |> filter(time == as.character(input$year))
		})
		observe({
			slo_sel = get_data()
			print(slo_sel)
			tmapProxy("map", session, {
				tm_remove_layer(402) +
					tm_shape(slo_sel) + 
					tm_polygons(fill = "gdppercap", zindex = 402)
			})
		})
	}, options = list(launch.browser=TRUE)
)


shinyApp(
	ui = fluidPage(
		tmapOutput("map", height = "600px"), selectInput("var", "Variable", region.vars)),
	server <- function(input, output, session) {
		output$map <- renderTmap({
			tm_shape(slo_regions, id = "NUTS_ID") + tm_polygons(fill = region.vars[1], zindex = 401)
		})
		observe({
			var <- input$var
			tmapProxy("map", session, {
				tm_remove_layer(401)+
					tm_shape(slo_regions, id = "NUTS_ID") +
					tm_polygons(fill = var, zindex = 401)
			})
		})
	}, options = list(launch.browser=TRUE)
)


slo_regions = st_read("data/slovenia/slo_regions.gpkg") |> 
	st_transform(4326)
region.vars <- setdiff(names(slo_regions), c("NUTS_ID", "NUTS_NAME", "URBN_TYPE" ,  "time",
											 "region_group","geom"))

tmap_mode("view")
shinyApp(
	ui = fluidPage(
		tmapOutput("map", height = "600px"), selectInput("var", "Variable", region.vars)),
	server <- function(input, output, session) {
		output$map <- renderTmap({
			tm_shape(slo_regions) + tm_polygons(fill = region.vars[1], zindex = 401)
		})
		observe({
			var <- input$var
			tmapProxy("map", session, {
				tm_remove_layer(401) +
					tm_shape(slo_regions) +
					tm_polygons(fill = var, zindex = 401)
			})
		})
	}, options = list(launch.browser=TRUE)
)

