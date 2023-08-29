CREATE TABLE nazaria_agreg AS
(WITH r as (SELECT
               class_name,
               (ST_Dump(ST_Union(t.geom))).geom as geom
           FROM
               nazaria_clean as t
           GROUP BY
		class_name
           ORDER BY
		class_name)
SELECT
    ROW_NUMBER() OVER() as gid,
    r.*
FROM r);

ALTER TABLE nazaria_agreg
ALTER COLUMN geom TYPE geometry(Polygon, 32723)
USING ST_Transform(geom, 32723);

ALTER TABLE nazaria_agreg ADD PRIMARY KEY (gid);

CREATE INDEX naz_agreg ON nazaria_agreg USING GIST(geom);