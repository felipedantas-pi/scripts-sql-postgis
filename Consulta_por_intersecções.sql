SELECT
	a.gid AS gid_a,
	a.class_name AS classe_a,
	b.gid AS gid_b,
	b.class_name AS classe_b
FROM
	altos_pol a INNER JOIN altos_pol b ON ST_Intersects(a.geom, b.geom) 
WHERE
	b.gid <> a.gid;