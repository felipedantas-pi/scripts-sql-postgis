SELECT b.*
FROM teresina_orig_test a, teresina_orig_test b
WHERE ST_Equals(a.geom, b.geom)