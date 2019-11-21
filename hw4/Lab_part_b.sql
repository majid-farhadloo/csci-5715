-- Q1
SELECT SDO_NET.GET_NO_OF_NODES('hennepin') FROM DUAL;
-- Result: 839

-- Q2
SELECT SDO_NET.GET_NODE_DEGREE('hennepin', 140776) FROM DUAL;
-- Result: 4

-- Q3
SELECT hn.NODE_ID
FROM hennepin_node$ hn
WHERE (SDO_NET.GET_NODE_OUT_DEGREE('hennepin', hn.NODE_ID) < 2);
-- Result:
-- NODE_ID
-- ----------
--   11358
--   25335
--  100773
--  134381
--    5721
--  103376
--  142527
--  142546
--  139276
--   45312
--  100821
--  127387
--   46652
--  123246
--   41320
--   96866
--   18139
--   94826
--  160616
--   45248
--   39187
--   43058
--  104309
--   47510
--   43020
--  132210
--  103402
--  142597
--  143053
--  143095

-- Q4
SELECT AVG(SDO_NET.GET_NODE_IN_DEGREE('hennepin', hn.NODE_ID))
FROM hennepin_node$ hn;
-- Result: 2.0524438

-- Q5
SELECT htt.TRANSIT_TIME
FROM csci5715.hennepin_transit_time htt, hennepin_link$ hl
WHERE hl.TRANSIT_ID = htt.TRANSIT_ID
AND hl.LINK_ID = 300
AND htt.START_TIME >= 630
AND htt.END_TIME <= 1020;
-- Result:
-- TRANSIT_TIME
-- ------------
--   .356355976
--   .356355976
--   .356355976
--   .370061976
--   .370061976
--   .370061976
--   .384864455
--   .384864455
--   .384864455
--   .384864455
--   .384864455
--   .384864455
--   .384864455
--   .384864455
--   .384864455
--   .384864455
--   .384864455
--   .370061976
--   .370061976
--   .370061976
--   .370061976
--   .356355976
--   .356355976
--   .356355976
--   .356355976
--   .356355976

-- Q6
SELECT htt.TRANSIT_TIME
FROM csci5715.hennepin_transit_time htt, hennepin_link$ hl
WHERE hl.TRANSIT_ID = htt.TRANSIT_ID
AND hl.LINK_ID = 300
AND htt.START_TIME >= 1230
AND htt.END_TIME <= 1440;
-- TRANSIT_TIME
-- ------------
--   .320720379
--   .320720379
--   .320720379
--   .320720379
--   .320720379
--   .320720379
--   .320720379
--   .320720379
--   .320720379
--   .320720379
--   .320720379
--   .320720379
--   .320720379
--   .320720379

-- Q7
SELECT MIN(htt.TRANSIT_TIME) AS "Min Travel Time",
MAX(htt.TRANSIT_TIME) AS "Max Travel Time"
FROM csci5715.hennepin_transit_time htt, hennepin_link$ hl
WHERE hl.TRANSIT_ID = htt.TRANSIT_ID
AND hl.LINK_ID = 1000;
-- Result:
-- Min Travel Time Max Travel Time
-- --------------- ---------------
--       .10151537      .156177492
