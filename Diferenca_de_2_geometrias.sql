--Diferenca entre geometria
CREATE TABLE dif_veso AS
	SELECT
		class_name,
		COALESCE(ST_Difference(geom, 
			(SELECT ST_Collect(b.geom)
			 FROM so_toca_veg b
			 WHERE ST_Intersects(a.geom, b.geom))),a.geom) AS geom
	FROM vegetacao a;

ALTER TABLE dif_veso ADD COLUMN gid SERIAL PRIMARY KEY;

-- Transformar MultiPolygon para Polygon
CREATE TABLE dif_veso_pol AS 
    SELECT
	class_name,
	(ST_DUMP(geom)).geom::geometry(Polygon,4674)AS geom
    FROM dif_veso;

ALTER TABLE dif_veso_pol ADD COLUMN gid SERIAL;
ALTER TABLE dif_veso_pol ADD PRIMARY KEY (gid);