CREATE TABLE quadro_de_areas AS 
(SELECT *
FROM porto_polygon
WHERE gid IN (17,117,148,151,183,340));

ALTER TABLE quadro_de_areas ADD PRIMARY KEY (gid);
