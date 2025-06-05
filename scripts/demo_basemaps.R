library(tmap)
library(sf)

tmap_mode("view")

tm_shape(NLD_muni) +
	tm_polygons() +
	tm_basemap()

tmap_providers()


tm_shape(NLD_muni) +
	tm_polygons(fill_alpha = 0.5) +
	tm_basemap("OpenTopoMap")

tm_shape(NLD_muni) +
	tm_polygons(fill = "dwelling_value",
				fill_alpha = 1) +
	tm_basemap(.tmap_providers$Esri.WorldGrayCanvas)

tm_shape(NLD_muni) +
	tm_polygons(fill = "dwelling_value") +
	tm_basemap(NULL)

st_crs(NLD_muni)

tm_shape(World) +
	tm_polygons(fill = "economy") +
	tm_basemap(NULL) +
tm_crs("auto")

tm_shape(World) +
	tm_polygons(fill = "economy") +
	tm_basemap("OpenTopoMap")

tm_shape(NLD_muni) +
	tm_polygons(fill = "dwelling_value",
				fill_alpha = 0.8) +
	tm_basemap(.tmap_providers$Stadia.StamenWatercolor) +
	tm_tiles(.tmap_providers$Stadia.StamenTerrainLabels)


tm_shape(NLD_muni) +
	tm_polygons(fill = "dwelling_value",
				fill_alpha = 0.8) +
	tm_basemap(.tmap_providers$Stadia.StamenWatercolor) +
	tm_tiles(.tmap_providers$Stadia.StamenTerrainLabels) +
	tm_borders(lwd = 5, col = "red")


tm_shape(World) +
	tm_polygons(fill = "economy") +
	tm_basemap(c("OpenTopoMap", "OpenStreetMap"))

tm_shape(World) +
	tm_polygons(fill = "economy") +
	tm_basemap(c("OpenTopoMap", "OpenStreetMap")) +
	tm_tiles(c("Stadia.StamenTerrainLabels", "Stadia.StamenTerrainLines"))


tm_shape(World) +
	tm_polygons(fill = "economy", group.control = "radio") +
	tm_basemap(c("OpenTopoMap", "OpenStreetMap"))



tm_shape(World) +
	tm_polygons(fill = "economy") +
	tm_basemap("http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png")


tmap_mode("plot")

tm_shape(NLD_muni) +
	tm_polygons(fill = "dwelling_value",
				fill_alpha = 0.8) +
	tm_basemap(.tmap_providers$CartoDB.PositronNoLabels) +
	tm_tiles(.tmap_providers$CartoDB.PositronOnlyLabels)

tmap_providers()

library(tmap.mapgl)

tmap_mode("maplibre")

tm_shape(NLD_muni) +
	tm_polygons(fill = "dwelling_value")

tmap_providers()

tmap_mode("mapbox")

tm_shape(NLD_muni) +
	tm_polygons(fill = "dwelling_value")


tm_shape(NLD_muni) +
	tm_polygons(fill = "dwelling_value") +
	tm_basemap("satellite-streets")

