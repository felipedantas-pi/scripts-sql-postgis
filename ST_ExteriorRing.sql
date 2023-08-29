-- A função St_ExteriorRing() vai levar em consideração
-- apenas os vértices exteriores, descartando os vértices
-- que se encontram no interior do polígono.

CREATE TABLE ve_pol_er AS
(SELECT
	class_name,
	st_makepolygon(st_exteriorring(geom)) AS geom
FROM ve_pol);

ALTER TABLE ve_pol_er ADD COLUMN gid SERIAL;
ALTER TABLE ve_pol_er ADD PRIMARY KEY (gid);
ALTER TABLE ve_pol_er ALTER COLUMN geom TYPE geometry(Polygon, 4674) USING st_transform(st_force2d(geom), 4674);


SELECT DISTINCT st_astext(geom) FROM ve_pol_er;