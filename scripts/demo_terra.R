library(tmap)
library(terra)

library(sf)

tmap_mode("plot")

srtm = rast(system.file("raster/srtm.tif", package = "spDataLarge"))

qtm(srtm)

tmap_mode("view")

qtm(srtm)

crs(srtm)
st_crs(srtm)


zion = read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))

zion = st_transform(zion, st_crs(srtm))

qtm(srtm) + qtm(zion, fill = NULL, lwd = 3)


srtm_masked = mask(srtm, zion)

qtm(srtm_masked)

plot(zion)
plot(srtm_masked)

srtm_masked

st_bbox(zion)
st_bbox(srtm)
terra::ext(srtm)

m <- matrix(1:100, 10, 10)
rst <- rast(m)
ext(rst) <- ext(0, 10, 0, 10)
crs(rst) <- "EPSG:4326"

qtm(rst) + tm_graticules()

tm_shape(rst) +
	tm_raster(col = "lyr.1",
			  col.scale = tm_scale_continuous())


r <- rast(system.file("ex/elev.tif", package = "terra"))
qtm(r)

r
qtm(r)

r_lowres <- aggregate(r, fact = 2, fun = mean)
qtm(r_lowres)

r_lowres2 <- aggregate(r, fact = 4, fun = mean)
qtm(r_lowres2)


r_lowres3 <- aggregate(r, fact = 16, fun = mean)
qtm(r_lowres3)

