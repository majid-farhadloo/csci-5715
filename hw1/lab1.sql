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


