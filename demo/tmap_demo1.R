library(tmap)
library(tmap.mapgl)


tm_shape(World) +
	tm_polygons("HPI") +
	tm_crs("auto")

tmap_mode("view")

tm_shape(World) +
	tm_polygons("HPI") 

tmap_mode("maplibre")

tm_shape(World) +
	tm_polygons_3d(height = "HPI", fill = "HPI") 

library(terra)

s5 = rast("../tmap/sandbox/Africa_Sen5P_CO_NO2_2024/sentinel5P.nc")

tmap_mode("plot")
qtm(s5)

tm_shape(s5) +
	tm_raster("sentinel5P_Z1=1")

ct = rast("~/Downloads/ct5km_climatology_v3.1.nc")
names(ct)

tm_shape(ct) +
	tm_raster("sst_clim_september", col.scale = tm_scale_continuous(values = "matplotlib.rainbow"))


tmap_mode("maplibre")

tmap_mode("plot")

tm_shape(NLD_muni) +
	tm_polygons("employment_rate") +
	tm_minimap()

tmap_mode("maplibre")

tm_shape(NLD_muni) +
	tm_polygons("employment_rate") +
	tm_minimap()


tmap_mode("plot")

tm_shape(NLD_muni) +
	tm_polygons("employment_rate")

library(tmap)
library(tmap.cartogram)
tm_shape(NLD_muni) +
	tm_cartogram_ncont(size = "*population")

tm_shape(NLD_muni) +
	tm_cartogram(size = "population", fill = "employment_rate")

Africa = World[World$continent == "Africa", ]

qtm(Africa)

Africa$name

Egypt = Africa[Africa$name == "Egypt", ]
Zambia = Africa[Africa$name == "Zambia", ]

tm1 = tm_shape(Egypt) +
	tm_polygons("green")

tm2 = tm_shape(Zambia) +
	tm_polygons("green")

tmap_arrange(tm1, tm2)

