ALTER TABLE cabeceiras1
ALTER COLUMN geom TYPE geometry(Polygon, 4674)
USING ST_Transform(geom, 4674);
