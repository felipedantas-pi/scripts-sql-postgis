SELECT gid, class_name,st_astext(geom), ST_IsValidReason(geom)
FROM boqueirao_pol
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

CREATE TABLE boqueirao AS
(WITH r as (SELECT
               class_name,
               (ST_Dump(ST_Union(t.geom))).geom as geom
           FROM
               boqueirao_polygon as t
           GROUP BY
               class_name
           ORDER BY
		class_name)
SELECT
    ROW_NUMBER() OVER() as gid,
    r.*
FROM r);

ALTER TABLE multiparte ADD PRIMARY KEY (gid);
ALTER TABLE multiparte ADD COLUMN area_km2 numeric;
ALTER TABLE multiparte ADD COLUMN area_km22 numeric(10,6);
ALTER TABLE multiparte ADD COLUMN area_tt numeric;
ALTER TABLE multiparte ADD COLUMN area_porc numeric(5,2);

UPDATE multiparte SET area_km2 = ST_Area(geom::geography)/1000000 WHERE ST_IsValid(geom);
UPDATE multiparte SET area_km22 = area_km2; 
UPDATE multiparte SET area_tt = 278.297;
UPDATE multiparte SET area_porc = (area_km2/area_tt)*100;

select sum(area_porc) from multiparte
