SELECT gid, class_name, ST_Astext(Filter_Rings(geom,1::FLOAT)) FROM nazaria_clean_agreg;




---------------------------------------------------------------------------------------------------------------
-- DROP FUNCTION Filter_Rings(geometry,FLOAT);
CREATE OR REPLACE FUNCTION filter_rings(geometry, FLOAT)
  RETURNS geometry AS
$BODY$
SELECT ST_MakePolygon(c.outer_ring, d.inner_rings) AS final_geom
  FROM (/* Get outer ring of polygon */
        SELECT ST_ExteriorRing(b.geom) AS outer_ring
          FROM (SELECT (ST_DumpRings($1)).*) b
          WHERE b.path[1] = 0 /* ie the outer ring */
        ) c,
       (/* Get all inner rings > a particular area */
        SELECT ST_Accum(ST_ExteriorRing(b.geom)) AS inner_rings
          FROM (SELECT (ST_DumpRings($1)).*) b
          WHERE b.path[1] > 0 /* ie not the outer ring */
            AND ST_Area(b.geom) > $2
        ) d
$BODY$
  LANGUAGE 'sql' IMMUTABLE;



 -------------------------------------------------------------------------------------------------------------
 CREATE OR REPLACE FUNCTION upgis_filter_rings(geometry,FLOAT) RETURNS geometry AS
$$ SELECT ST_BuildArea(ST_Collect(a.geom)) AS final_geom
        FROM ST_DumpRings($1) AS a
          WHERE a.path[1] = 0 OR
                (a.path[1] > 0 AND ST_Area(a.geom) > $2)
$$
  LANGUAGE 'sql' IMMUTABLE;