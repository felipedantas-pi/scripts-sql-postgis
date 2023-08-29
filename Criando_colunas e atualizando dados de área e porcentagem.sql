ALTER TABLE altos_agreg ADD COLUMN area_tt numeric;
ALTER TABLE altos_agreg ADD COLUMN area_km2 numeric;
ALTER TABLE altos_agreg ADD COLUMN area_km22 numeric(10,6);
ALTER TABLE altos_agreg ADD COLUMN area_porc numeric (5,2);

UPDATE altos_agreg SET area_tt = 957.655;
UPDATE altos_agreg SET area_km2 = ST_Area(GEOGRAPHY(geom)) / 1000000;
UPDATE altos_agreg SET area_porc = (area_km2 / area_tt) * 100;
UPDATE altos_agreg SET area_km22 = area_km2

SELECT SUM(area_porc) FROM altos_agreg;
