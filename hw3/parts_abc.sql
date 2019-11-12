---- Part A

-- question 1
SELECT SDO_NET.GET_NO_OF_LINKS('airport') FROM DUAL;
-- result: 4093 links

-- question 2
SELECT SDO_NET.GET_NO_OF_NODES('airport') FROM DUAL;
-- result: 293 nodes

-- question 3
SELECT SDO_NET.GET_NODE_DEGREE('airport', (SELECT AIRPORT_ID
  FROM airport_list
  WHERE airport_list.AIRPORT_NAME = 'Philadelphia, PA')
) FROM DUAL;
-- result: degree is 91

-- question 4: not sure how to do this without iterating through the airport_list table
SELECT AVG(deg)
FROM ( SELECT SDO_NET.GET_NODE_OUT_DEGREE('airport', )

)


CREATE TABLE temp_out_degree (
  ID NUMBER NOT NULL,
  deg NUMBER NOT NULL,
  PRIMARY KEY(ID)
);

BEGIN
  FOR rec IN (SELECT AIRPORT_ID FROM airport_list) LOOP
    INSERT INTO temp_out_degree (ID, deg)
    VALUES (AIRPORT_ID, SELECT SDO_NET.GET_NODE_OUT_DEGREE('airport', rec) FROM DUAL);
  END LOOP;
END;

SELECT AVG(deg)
FROM temp_out_degree

DROP TABLE temp_out_degree;
-- todo

---- Part B
-- question 1
WITH
  connects_from_gustavus (linkid, node_end_id, STOPS) AS
  (
    SELECT LINK_ID, a.END_NODE_ID, 0 STOPS
    FROM airport_link$ a
    WHERE a.START_NODE_ID = 11997
  UNION ALL
    SELECT a_l_two.LINK_ID, a_l_two.END_NODE_ID, STOPS+1
    FROM airport_link$ a_l_one, airport_link$ a_l_two, connects_from_gustavus c_g
    WHERE c_g.linkid = a_l_one.LINK_ID
    AND a_l_two.START_NODE_ID = a_l_one.END_NODE_ID
    AND c_g.STOPS < 2
  )
SELECT AIRPORT_ID, AIRPORT_NAME
FROM airport_node$ a_n, airport_list, connects_from_gustavus c_g
WHERE c_g.STOPS < 2
AND a_n.NODE_ID = c_g.node_end_id
AND a_n.NODE_ID = airport_list.AIRPORT_ID;

-- result: AIRPORT_ID AIRPORT_NAME
--         ---------- --------------------------------------------------
--              12523 Juneau, AK
--              14256 Petersburg, AK
--              15991 Yakutat, AK
--              14828 Sitka, AK
--              10299 Anchorage, AK
--              11997 Gustavus, AK
--              14747 Seattle, WA
--              12819 Ketchikan, AK

-- question 2

WITH
  flying_from_portland (linkid, node_end_id, STOPS) AS
  (
    SELECT LINK_ID, a.END_NODE_ID, 0 STOPS
    FROM airport_link$ a
    WHERE a.START_NODE_ID = 14057
  UNION ALL
    SELECT a_l_two.LINK_ID, a_l_two.END_NODE_ID, STOPS+1
    FROM airport_link$ a_l_one, airport_link$ a_l_two, flying_from_portland f_p
    WHERE f_p.linkid = a_l_one.LINK_ID
    AND a_l_two.START_NODE_ID = a_l_one.END_NODE_ID
    AND STOPS < 2
  )
  CYCLE linkid SET is_cycle TO 'Y' DEFAULT 'N'
SELECT AIRPORT_ID, AIRPORT_NAME, f_p.STOPS, is_cycle
FROM airport_node$ a_n, airport_list, flying_from_portland f_p
WHERE f_p.STOPS < 2
AND a_n.NODE_ID = f_p.node_end_id
AND a_n.NODE_ID = airport_list.AIRPORT_ID
AND airport_list.AIRPORT_ID = 14006;
-- result: 1 stop is needed



---- PART C

-- question 1
SELECT c.NAME
FROM COUNTRY2018 c
WHERE SDO_NN( c.GEOM, (SELECT GEOM FROM COUNTRY2018 c2 WHERE c2.NAME = 'Norway'), 'sdo_num_res=4') = 'TRUE';
-- result:
-- NAME
-- --------------------------------------------------
-- Finland
-- Norway
-- Russia
-- Sweden

-- question 2
SELECT c.NAME
FROM COUNTRY2018 c
WHERE SDO_OVERLAPS( c.GEOM, (SELECT r.GEOM FROM RIVER2018 r WHERE r.NAME = 'Nile')) = 'TRUE';


-- question 3
SELECT c.NAME
FROM COUNTRY2018 c
WHERE SDO_TOUCH(c.GEOM, (SELECT c2.GEOM FROM COUNTRY2018 c2 WHERE c2.NAME = 'Norway')) = 'TRUE';
-- result:
-- NAME
-- --------------------------------------------------
-- Russia
-- Sweden
-- Finland


-- question 4
SELECT c1.NAME, c2.NAME
FROM COUNTRY2018 c1, COUNTRY2018 c2, user_sdo_geom_metadata m
WHERE m.TABLE_NAME = 'COUNTRIES'
AND m.COLUMN_NAME = 'GEOM'
AND c1.NAME <> c2.NAME
AND SDO_GEOM.WITHIN_DISTANCE(c1.GEOM, m.DIMINFO, 1, c2.GEOM, m.DIMINFO) = 'TRUE';


-- question 5
SELECT c1.NAME, c2.NAME
FROM COUNTRY2018 c1, COUNTRY2018 c2
WHERE SDO_WITHIN_DISTANCE(c1.GEOM, c2.GEOM, 'distance=1') = 'TRUE';
-- executed in 9.86 seconds

-- The second query is much faster, because it utilizes the spatial index defined on the geometry parameter.
-- The "within_distance" function from the SDO_GEOM package does not use this index and so has to
-- filter distance later on in the execution hierarchy.
