ALTER TABLE nsremedios
ALTER COLUMN geom TYPE geometry(MultiPolygon, 4674)
USING st_transform(st_force2d(geom), 4674);
