---- Part A

-- question 1

SELECT SDO_NET.GET_NO_OF_LINKS('airport') FROM DUAL;

-- question 2

SELECT SDO_NET.GET_NO_OF_NODES('airport') FROM DUAL;

-- question 3

SELECT SDO_NET.GET_NODE_DEGREE('airport',
  (SELECT AIRPORT_ID
  FROM airport_list
  WHERE airport_list.AIRPORT_NAME = 'Philadelphia, PA')
) FROM DUAL;

-- question 4: not sure how to do this without iterating through the airport_list table

-- todo

---- Part B
WITH
  connects_to_gustavas (AIRPORT_ID, STOPS) AS
  (
    SELECT AIRPORT_ID, 0 STOPS
    FROM airport_list a_l
    WHERE a_l.AIRPORT_NAME = 'Gustavas, AK'
  UNION ALL
    SELECT SDO_NET.GET_CHILD_NODES('airport', c_g.AIRPORT_ID) child, STOPS+1
    FROM connects_to_gustavas c_g, DUAL
  )
SELECT AIRPORT_ID, STOPS
FROM connects_to_gustavas
WHERE STOPS < 2;
