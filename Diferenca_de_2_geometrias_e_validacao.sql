--Diferenca entre geometria
CREATE TABLE dif_vegacaguaac AS
	SELECT
		gid,
		class_name,
		COALESCE(ST_Difference(geom, 
			(SELECT ST_Collect(b.geom)
			 FROM ac_pol b
			 WHERE ST_Intersects(a.geom, b.geom))),a.geom) AS geom
	FROM pol_vegacagua a;

ALTER TABLE dif_vegacaguaac DROP COLUMN gid;
ALTER TABLE dif_vegacaguaac ADD COLUMN gid SERIAL PRIMARY KEY;

-- Transformar MultiPolygon para Polygon
CREATE TABLE pol_vegacaguaac AS 
    SELECT
	gid,
	class_name,
	(ST_DUMP(geom)).geom::geometry(Polygon,4674)AS geom
    FROM dif_vegacaguaac;

ALTER TABLE pol_vegacaguaac DROP COLUMN  gid;
ALTER TABLE pol_vegacaguaac ADD COLUMN gid SERIAL;
ALTER TABLE pol_vegacaguaac ADD PRIMARY KEY (gid);

--Correção de validade de geometria
CREATE TABLE valid_geoms_dif_corrigida
	AS WITH make_valid(id, class_name, geom)
		AS (
			SELECT
				ROW_NUMBER() OVER() AS id,
				class_name,
				(ST_Dump(ST_MakeValid(geom))).geom AS geom
			FROM valid_geoms_dif)
		SELECT id, class_name, geom 
		FROM make_valid
		WHERE ST_GeometryType(geom)='ST_Polygon';
