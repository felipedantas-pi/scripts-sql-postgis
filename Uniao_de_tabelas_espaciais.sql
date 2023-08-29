CREATE TABLE munAgreg AS 
	(SELECT * FROM altos
Union all 
	(SELECT * FROM barras
Union all
	(SELECT * FROM batalha
Union all
	(SELECT * FROM cabeceiras_do_piaui
Union all
	(SELECT * FROM campo_largo_do_piaui
Union all
	(SELECT * FROM campo_maior
Union all
	(SELECT * FROM cocal
Union all
	(SELECT * FROM cocal_de_telha
Union all
	(SELECT * FROM cocal_dos_alves
Union all
	(SELECT * FROM esperantina
Union all
	(SELECT * FROM joca_marques
Union all
	(SELECT * FROM jose_de_freitas
Union all
	(SELECT * FROM lagoa_alegre
Union all
	(SELECT * FROM luzilandia
Union all
	(SELECT * FROM madeiro
Union all
	(SELECT * FROM matias_olimpio
Union all
	(SELECT * FROM miguel_alves
Union all
	(SELECT * FROM morro_do_chapeu_do_piaui
Union all
	(SELECT * FROM nazaria
Union all
	(SELECT * FROM nossa_senhora_dos_remedios
Union all
	(SELECT * FROM porto
Union all
	(SELECT * FROM sao_joao_do_arraial
Union all
	(SELECT * FROM teresina
Union all
	(SELECT * FROM uniao))))))))))))))))))))))));

ALTER TABLE munAgreg ADD COLUMN gid SERIAL;
ALTER TABLE munAgreg ADD PRIMARY KEY (gid);


CREATE INDEX munAgreg_gist
  ON munAgreg
  USING GIST (geom);