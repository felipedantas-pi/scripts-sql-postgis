SELECT gid
FROM nazaria_clean l,
	(SELECT ST_Difference(
		(SELECT ST_MakePolygon(ST_Boundary(ST_Union(geom))) FROM nazaria_clean),
		(SELECT ST_Union(geom) FROM nazaria_clean) 
	) AS geom) AS holes
WHERE ST_Touches(holes.geom, l.geom);
/* */
CREATE TABLE naz_diff AS (
SELECT ST_Difference(
   (SELECT ST_MakePolygon(ST_Boundary(ST_Union(geom))) from nazaria_clean),
   (SELECT ST_Union(geom) from nazaria_clean) 
) as diff);


