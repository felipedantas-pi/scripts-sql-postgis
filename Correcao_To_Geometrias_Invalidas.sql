SELECT a.gid, a.class_name, ST_IsValid(ST_Buffer(a.geom, 0.0))
FROM teresina_orig_test a
WHERE NOT ST_IsValid(a.geom)