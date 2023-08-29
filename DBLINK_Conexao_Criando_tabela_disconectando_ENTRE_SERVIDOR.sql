SELECT dblink_connect(
'projeto','dbname=NS_Remedios hostaddr=10.0.0.91 user=postgres password=geo port=5432');


CREATE TABLE nossa_senhora_dos_remedios AS (
	SELECT * 
	FROM dblink(
		'projeto','SELECT *
			   FROM nossa_senhora_dos_remedios;')AS resultado(
							gid integer,
							geom geometry(MultiPolygon, 4674),
							class_name character varying(254),
							area_tt numeric,
							area_km2 numeric,
							area_km22 numeric(10,6),
							area_porc numeric(5,2)));

SELECT dblink_disconnect('projeto');

ALTER TABLE nossa_senhora_dos_remedios ADD PRIMARY KEY (gid);