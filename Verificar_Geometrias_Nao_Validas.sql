SELECT gid, class_name, geom 
FROM teresina_orig_test 
WHERE NOT ST_IsValid(geom)