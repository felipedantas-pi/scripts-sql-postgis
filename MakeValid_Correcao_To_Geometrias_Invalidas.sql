SELECT gid, class_name, ST_AsText(geom), ST_IsValidReason(geom)
FROM nazaria_clean
WHERE NOT ST_IsValid(geom);



SELECT ST_Union(v.geom)
FROM
(SELECT ST_MakeValid(St_Snap(t.geom, 
        (SELECT ST_SnapToGrid(st_collect(f.geom), 1) AS geom
         FROM (SELECT (ST_DumpPoints(g.geom)).geom AS geom
               FROM table1 as g) as f),
        0.001)) as geom
FROM
    table1 as t) as v;