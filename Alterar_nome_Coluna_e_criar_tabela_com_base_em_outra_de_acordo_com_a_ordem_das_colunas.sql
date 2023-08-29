CREATE TABLE jose_de_freitas (
gid serial primary key,
class_name varchar(40),
geom geometry(Multipolygon,4674));

INSERT INTO jose_de_freitas (
	class_name, geom)
		SELECT class_name, geom 
		FROM jdf_multiparte;

CREATE INDEX jdf_mp_gix ON jose_de_freitas USING GIST(geom);