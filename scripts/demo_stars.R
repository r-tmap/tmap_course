library(stars)
tif_file <- system.file("tif/L7_ETMs.tif", package = "stars")
l7 <- read_stars(tif_file)



l7[1 , 1:10, 30:40, 3]

qtm(l7)

names(l7)

land

qtm(land) + tm_facets(nrow = 2)

names(land)

tm_shape(World) +
	tm_polygons(fill = tm_vars(x = 1:3))

tm_shape(l7) +
	tm_raster(col = tm_vars(dimvalues = 1:3))

tm_shape(l7) +
	tm_raster(col = tm_vars(dimvalues = 1:3, multivariate = TRUE))

tm_shape(l7) +
	tm_rgb(col = tm_vars(dimvalues = 1:3, multivariate = TRUE)) 

(l7_splitted = split(l7, "band"))

l7[1,1:10,1:10,3:4]
l7_splitted[3:4,1:10,1:10]


l7_mean <- st_apply(l7, c("x", "y"), mean)
tm_shape(l7_mean) +
	tm_raster()


arr = array(runif(100), dim = c(10, 10))
s = st_as_stars(arr, xlim = c(0,1), ylim = c(0,1))
st_bbox(s) = st_bbox(c(xmin = 0, xmax = 1, ymin = 0, ymax = 1), crs = 4326)

qtm(s)


s <- read_stars(system.file("ex/elev.tif", package = "terra"))
qtm(s)

lowres <- st_as_stars(st_bbox(s), nx = 8, ny = 8)
#st_crs(lowres) <- st_crs(s)

s_lowres <- st_warp(s, lowres)
qtm(s_lowres)

s_reproj <- st_transform(s, crs = 32612)
qtm(s_reproj)


tmap_mode("view")


srtm_terra = rast(system.file("raster/srtm.tif", package = "spDataLarge"))
srtm_stars = read_stars(system.file("raster/srtm.tif", package = "spDataLarge"))

dim(srtm_stars)
dim(srtm_terra)

nrow(srtm_stars)
nrow(srtm_terra)

ncol(srtm_stars)
ncol(srtm_terra)
