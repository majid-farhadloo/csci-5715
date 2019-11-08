
-- task1
select c1.name, SDO_GEOM.SDO_CENTROID(c1.GEOM) as Centroid 
from csci5715.COUNTRIES c1
where c1.name = 'France';


-- task 2

select distinct c1.region from csci5715.COUNTRIES c1 
order by region asc;



-- task3

select c1.name, c1.ISO2 ISO2, c1.ISO3 ISO3, 
c1.region region, SDO_GEOM.SDO_CENTROID(c1.GEOM, 0.5)
from csci5715.COUNTRIES c1 where c1.pop2005>200000000;



-- task 4

select c1.name, SDO_GEOM.SDO_MBR(c1.GEOM) 
from csci5715.COUNTRIES c1 where c1.name='France';


--task 5

select r1.name, SDO_GEOM.SDO_LENGTH(r1.GEOM, 0.5) as length 
from csci5715.RIVERS r1 order by length desc;


-- task 6

select c1.name as city, co1.name as country
from csci5715.CITIES c1,
csci5715.COUNTRIES co1,
csci5715.RIVERS r1
where r1.name = 'Nile'
and SDO_CONTAINS(co1.GEOM, c1.GEOM) = 'TRUE'
and SDO_GEOM.SDO_DISTANCE(c1.GEOM, r1.GEOM, 0.5) < 1000000;

-- task 7

SELECT c.name city, r.name river, SDO_GEOM.SDO_DISTANCE(r.GEOM, c.GEOM, 0.5) as distance 
FROM csci5715.RIVERS r, csci5715.CITIES c 
WHERE r.name = 'Mississippi'
AND c.name = 'Chicago';

-- task 8

select name, length from (
select r1.name, SDO_GEOM.SDO_LENGTH(r1.GEOM, 0.5) as length 
from csci5715.RIVERS r1 order by length desc) where rownum<=1;


-- task9

select name, area from (
select c1.name, SDO_GEOM.SDO_AREA(c1.GEOM, 0.5) as area 
from csci5715.COUNTRIES c1 order by area desc) where rownum<=1;






-- EXTRA WORK:


CREATE TABLE FALLS_INTO(SRC VARCHAR(30), DEST VARCHAR(30));
Insert into FALLS_INTO (SRC, DEST) 
VALUES
('P1', 'PLATTE'),
('P2', 'PLATTE'),
('Y1', 'YELLOWSTONE'),
('Y2', 'YELLOSTONE'),
('PLATTE', 'MISSOURI'),
('YELLOWSTONE','MISSOURI'),
('MISSOURI','MISSIP'),
('OHIO','MISSIP'),
('RED','MISSIP'),('ARKANSAS','MISSIP');




CREATE TABLE PRIOR (SRC VARCHAR(30), DEST VARCHAR(30));
Insert into PRIOR (SRC, DEST) VALUES
('PLATTE', 'MISSOURI'), ('YELLOWSTONE', 'MISSOURI');



SELECT SRC FROM FALLS_INTO CONNECT BY PRIOR SOURCE = DEST START WITH DEST='MISSOURI';




SELECT DISTINCT NAME FROM CSCI5715.RIVERS;

SELECT R.ORIGIN, MIN(R.LENGHT) FROM CSCI5715.RIVERS R GROUP BY ORIGIN HACING COUNT(*)>1;


SELECT R.Origin, MIN (R.length) AS Min-length FROM 
CSCI5715.River GROUP BY R.Origin HAVING COUNT(*) > 1;





SELECT distinct Co.Name
FROM Country Co
WHERE Co.GDP > ANY (
			     SELECT Co1.GDP
			     FROM Country Co1
			    WHERE Co1.Name = 'Canada') ORDER BY NAME;










