SELECT *
FROM COUNTRY
WHERE REGION IN ('Asia', 'Europe')
AND YEAR = '2004'
ORDER BY POPULATION DESC;


SELECT DISTINCT NAME
FROM COUNTRY
WHERE REGION = 'Europe'
AND POPULATION > 1000000
AND YEAR = '2003';

SELECT DISTINCT REGION
FROM COUNTRY
WHERE NAME LIKE '%p%'
OR NAME LIKE '%g%';

#########

SELECT COUNT(NAME) AS NUM_COUNTRIES, AVG(GDP) AS AVG_GDP
FROM COUNTRY
WHERE REGION = 'Europe'
AND YEAR = '2003'
GROUP BY REGION;

SELECT DISTINCT REGION
FROM COUNTRY
WHERE POPULATION > 1000000
AND YEAR = '2003'
GROUP BY REGION
HAVING COUNT(*) >= 4;

################

INSERT INTO COUNTRY (NAME, POPULATION, AREA, YEAR, REGION)
VALUES ('New_Country', 1000, 5, '3001', 'Majidland');

DELETE FROM COUNTRY
WHERE GDP IS NULL;

UPDATE COUNTRY
SET AREA = 80
WHERE AREA < 80;
