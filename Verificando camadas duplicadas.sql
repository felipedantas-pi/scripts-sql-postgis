SELECT a.gid, a.class_name , b.gid, b.class_name
FROM teresina_seg a, teresina_seg b
WHERE st_equals(a.geom, b.geom) AND a.gid <> b.gid