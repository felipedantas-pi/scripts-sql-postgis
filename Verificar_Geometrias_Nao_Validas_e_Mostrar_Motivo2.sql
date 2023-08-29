SELECT gid, class_name,st_astext(geom), ST_IsValidReason(geom)
FROM luzilandia_agreg
WHERE NOT ST_IsValid(geom);

CREATE TABLE valid_geoms
	AS WITH make_valid(id, class_name, area_km2, area_munic, area_perc, geom)
		AS (
			SELECT
				ROW_NUMBER() OVER() AS id,
				class_name,
				area_km2,
				area_total,
				area_perc,
				(ST_Dump(ST_MakeValid(geom))).geom AS geom
			FROM boqueiraodopiaui)
		SELECT id, class_name, area_km2, area_munic, area_perc, geom 
		FROM make_valid
		WHERE ST_GeometryType(geom)='ST_Polygon';

ALTER TABLE valid_geoms ADD COLUMN cod SERIAL PRIMARY KEY;
ALTER TABLE valid_geoms ALTER COLUMN geom TYPE geometry(Polygon,32723);
UPDATE valid_geoms SET area_km2 = ST_AREA(geom)/1000000;
UPDATE valid_geoms SET area_perc = (area_km2 / area_munic ) * 100;