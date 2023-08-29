SELECT 
	DISTINCT ON (ST_Intersection(a.geom,b.geom))
		a.gid,b.gid,
		st_astext(ST_Intersection(a.geom,b.geom))
FROM
	esperantina_orig AS a,
	esperantina_orig AS b
WHERE
	ST_Intersects(a.geom,b.geom) AND NOT ST_touches(a.geom,b.geom) AND a.gid != b.gid