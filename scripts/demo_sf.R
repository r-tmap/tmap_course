library(sf)
library(dplyr)
library(tibble)
library(terra)
library(tmap)
library(spDataLarge)

# Load vector data
zion <- read_sf(system.file("vector/zion.gpkg", package = "spDataLarge"))
zion_points <- spDataLarge::zion_points

tmap_mode("view")
qtm(zion_points)


# Raster (only used to sample data from)
srtm <- rast(system.file("raster/srtm.tif", package = "spDataLarge"))

# Add elevation to points
data("zion_points", package = "spDataLarge")
elevation = terra::extract(srtm, zion_points)
zion_points = cbind(zion_points, elevation)

zion_points = st_transform(zion_points, st_crs(zion))


# Simulate non-spatial data
point_data <- tibble(
	ID = zion_points$ID,
	category = sample(c("A", "B", "C"), size = nrow(zion_points), replace = TRUE)
)

points_joined = zion_points |> 
	left_join(point_data, by = "ID")

tm_shape(zion) +
	tm_polygons() +
	tm_shape(points_joined) +
	tm_dots(fill = "category", fill.scale = tm_scale_categorical(values = "brewer.set1"))

st_intersects(zion_points, zion)


zion_buffered_points = st_buffer(zion_points, dist = 200)

qtm(zion) + qtm(zion_buffered_points)

zd = st_difference(zion, 
	 st_union(zion_buffered_points))



qtm(zd)

France = World |> 
	filter(name == "France")

France_centroid = st_centroid(France)

qtm(France) + qtm(France_centroid)

France_centroid2 = st_centroid(France, of_largest_polygon = TRUE)

qtm(France) + qtm(France_centroid2)

France_split = France |> 
	st_cast("POLYGON") |> 
	mutate(area = units::set_units(st_area(France_split), km^2))

France_split_centroid = st_centroid(France_split)

qtm(France_split) + qtm(France_split_centroid)

# bug?
tm_shape(World) +
  tm_dots(size = 1, options = opt_tm_dots(point_per = "segment"))

tm_shape(World) +
	tm_dots(size = 1, options = opt_tm_dots(point_per = "largest"))
