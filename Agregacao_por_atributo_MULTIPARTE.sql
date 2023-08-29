CREATE TABLE altos_agreg AS
(WITH r as (SELECT
               class_name,
               ST_Union(t.geom) AS geom
           FROM
               altos as t
           GROUP BY
		class_name
           ORDER BY
		class_name)
SELECT
    ROW_NUMBER() OVER() as gid,
    r.*
FROM r);

--ADIÇÃO DE UMA CHAVE PRIMARIA
ALTER TABLE altos_agreg ADD PRIMARY KEY (gid);

-- ALTERANDO O TIPO DE GEOMETRIA PARA MULTI
ALTER TABLE altos_agreg ALTER COLUMN geom 
    SET DATA TYPE geometry(MultiPolygon) USING ST_Multi(geom);

--TRASNFORMAÇÃO DE SRID
ALTER TABLE altos_agreg
ALTER COLUMN geom TYPE geometry(MultiPolygon, 4674)
USING ST_Transform(geom, 4674);


--CRIANDO UM INDEX GIST
CREATE INDEX altosagreg ON altos_agreg USING GIST(geom);