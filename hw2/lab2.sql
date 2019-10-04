
-- task1
select c1.name, SDO_GEOM.SDO_CENTROID(c1.GEOM) as Centroid 
from csci5715.COUNTRIES c1
where c1.name = 'France';


-- task 2

select distinct c1.name, c1.region from csci5715.COUNTRIES c1 
order by region asc;



-- task3

select c1.name, c1.ISO2 ISO2, c1.ISO3 ISO3, 
c1.region region, SDO_GEOM.SDO_CENTROID(c1.GEOM, 0.5)
from csci5715.COUNTRIES c1 where c1.pop2005>200000000;



-- task 4

select c1.name, SDO_GEOM.SDO_MBR(c1.GEOM) 
from csci5715.COUNTRIES c1 where name='France';


--task 5

select r1.name, SDO_GEOM.SDO_LENGTH(r1.GEOM, 0.5) as length 
from csci5715.RIVERS r1 order by length desc;


-- task 6


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


describe csci5715.RIVERS;