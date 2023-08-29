CREATE TABLE quadro_de_areas AS 
(SELECT *
FROM madeiro
WHERE gid IN (5,18,40,110,178,259));

ALTER TABLE quadro_de_areas ADD PRIMARY KEY (gid)