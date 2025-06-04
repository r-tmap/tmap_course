library(sf)
library(tidyverse)
nc <- st_read(system.file("shape/nc.shp", package = "sf"))


nc$centroid = st_centroid(nc)$geometry

qtm(nc)

nc2 = st_set_geometry(nc, "centroid")

qtm(nc2)

df = as.data.frame(nc2)

nc3 = st_as_sf(df, sf_column_name = "centroid")

sf_use_s2(TRUE)


# part 2

nc <- st_read(system.file("shape/nc.shp", package = "sf"))

st_drop_geometry(nc)
as.data.frame(nc)


st_crs(nc)

nc_robin = st_transform(nc, "+proj=robin")

nc_3857 = st_transform(nc, 3857)

nc_NA = st_set_crs(nc, NA)
st_crs(nc_NA)
nc_rubbish = st_set_crs(nc, 3857)




tmap_mode("view")
qtm(nc_rubbish)

st_crs(nc_robin)

tmap_arrange(
	qtm(nc),
	qtm(nc_robin), 
	qtm(nc_3857),
	ncol = 3
)

tmap_mode("plot")
tm_shape(World) +
	tm_polygons() +
 tm_grid() + 
  tm_crs(3857)

tm_shape(nc_3857) +
	tm_polygons() +
	tm_grid()
