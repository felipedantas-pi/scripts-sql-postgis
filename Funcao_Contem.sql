SELECT DISTINCT a.* 
FROM municipios_visitados a, pontos_gps b
WHERE ST_Contains(a.geom, b.geom);