CREATE TABLE so_pol AS 
    SELECT
	class_name,
	(ST_DUMP(geom)).geom::geometry(Polygon,4674)AS geom
    FROM so;

ALTER TABLE so_pol ADD COLUMN gid SERIAL;
ALTER TABLE so_pol ADD PRIMARY KEY (gid);