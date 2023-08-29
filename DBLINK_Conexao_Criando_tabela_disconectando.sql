SELECT dblink_connect(
'projeto','dbname=Arquivos_Projeto hostaddr=10.0.0.91 user=postgres password=geo port=5432');


CREATE TABLE lim_cocal AS (
	SELECT * 
	FROM dblink(
		'projeto','SELECT *
			   FROM area_projeto
			   WHERE gid = 40;')AS resultado(
						gid integer,
						objectid integer,
						id_objeto numeric,
						nome character varying(100),
						geocodigo character varying(15),
						qtd_prod double precision,
						valor_prod double precision,
						ar_tt_prod double precision,
						perimetro double precision,
						geom geometry(MultiPolygon, 4674)));

SELECT dblink_disconnect('projeto');

ALTER TABLE lim_cocal ADD PRIMARY KEY (gid);