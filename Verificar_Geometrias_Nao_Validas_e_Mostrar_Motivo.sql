SELECT gid, class_name, ST_AsText(geom), ST_IsValidReason(geom)
FROM lagoaalegre_clean 
WHERE NOT ST_IsValid(geom);