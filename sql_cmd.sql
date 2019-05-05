SELECT p, c, ratio, name p/c AS R
FROM pcv
WHERE ratio > 0.70, name = 'John'
ORDER BY ratio, p DESC, c
LIMIT 10 OFFSET 5

-- not equal
a <> 100


-- option for WHERE
-- %: any
LIKE '%abc%'

-- show data type
SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
     TABLE_NAME = 'yourTableName' AND 
-- optional
     COLUMN_NAME = 'yourColumnName'
	 
	 

-- --- not tested ---
-- SQL is case insensitive
-- To do case sensitive search using LIKE, use COLLATE Latin1_General_BIN
SELECT name
FROM Person
WHERE name LIKE '%A'
COLLATE Latin1_General_BIN;
-- or COLLATE Latin1_General_CS_AS

-- in a set
IN ('A', 'B', 'C')

-- BETWEEN is inclusive
date_ BETWEEN '2016-01-01' AND '2017-01-01'

(a>3 OR b<2) AND c>5

IS NULL
IS NOT NULL



-- JOIN
JOIN table2 ON table1.id2 = table2.id2

-- JOIN with inequity operation (e.g, comparision)
JOIN table2 ON table1.id2 = table2.id2 AND a>b

LEFT JOIN  # same as LEFT OUTER JOIN
RIGHT JOIN # same as RIGHT OUTER JOIN
OUTER JOIN # same as FULL OUTER JOIN
FULL OUTER JOIN = FULL JOIN

--
FROM table t1
LEFT JOIN table t2 ON t1.id=t2.id
AND t1.occurred_at > t2.occurred_at
AND t1.occurred_at >= t2.occurred_at + INTERVAL '28 days'

-- OUTER Join that exclude inner
FULL OUTER JOIN with WHERE A.Key IS NULL OR B.Key IS NULL

-- table name alias
FROM table t
JOIN table table


--
SELECT DISTINCT


-- aggregate functions
SELECT COUNT(), SUM(), AVG(), MIN(), MAX()
-- can use wildcard
COUNT(*)

-- When using group by, cannot select the individual field anymore. Only aggregate functions of those individual fields are allowed.
-- to add on them is needed 
GROUP BY var
GROUP BY 1 (column number)


-- The HAVING clause was added to SQL because the WHERE keyword could not be used
-- with aggregate functions.
-- to use conditional on aggregate function
GROUP BY ...
HAVING SUM(a)>100
...


-- DATE_TRUNC reduces precision but still gives a datetime type
-- DATE_TRUNC understands the keyword and look for the specific and reset other elements into 'zero', result is still in date format 
--   and can be worked on.
-- DATE_PART extract datetime into substring and is no longer in date format
SELECT DATE_TRUNC('day', datetimedata)
SELECT DATE_TRUNC('month', datetimedata)
SELECT DATE_TRUNC('year', datetimedata)
SELECT DATE_PART('second', datetimedata)
-- dow: Day of Week
SELECT DATE_PART('dow', datetimedata)

-- CASE is used to create a new variable.
-- Example below use CASE to create a categorical value
SELECT abc
	CASE WHEN a<100 THEN 'less than 100' ELSE 'more than 100' END as hundred
	
SELECT abc
	CASE WHEN a<25 THEN 'less than 25%'
	 WHEN a<50 THEN 'less than 50%'
	 WHEN a<75 THEN 'less than 75%'
	 WHEN a<100 THEN 'less than 100'
	END as quartile
	
-- subquery, most can select portion and run to test (like spss)
-- xxx is alias of inner query
-- To use it, place the whole "(....) sub_name" to where the table name is.
-- The field names namespace are now 1st level.
SELECT *
FROM 
(
another query 
) sub_name

-- Using subquery
-- Common Table Expression
WITH _alias1_ AS (sub query1 here),
	 _alias2_ AS (sub query2 here)
SELECT *
FROM _alias1_

-- VIEW
CREATE VIEW view_name AS
-- full query following
-- SELECT ...



-- String functions, case insensitive
LEFT(string, n) AS l
RIGHT(string, n) AS r
LENGTH(string)
UPPER(string)
LOWER(string)
POSITION('x' IN string)

-- CONCAT
CONCAT(firstname, ' ', lastname) 
-- Use literal to concat, same result as above
firstname || ' ' || lastname

-- SUBSTR index starting from 1
SUBSTR(string, from, count)

-- CAST type cast
-- cast a field named 'string' into date format
CAST(string AS date) as _datename_

-- CAST using :: in PostgreSQL
(string)::date as _datename_


# COALESCE 合并
COALESCE(expr1, expr2, ..., exprn)
return the 1st non-null expression


-- Window function
--
-- after OVER can use PARTITION BY, ORDER BY, or no statement 
-- *** Without ORDER BY, there won't be effect of running totals.
SELECT empno, salary, AVG(salary) OVER (PARTITION BY depname) FROM empsalary;

-- Calcualte running sum of salary of all employees up to this row
SELECT empno, salary, SUM(salary) OVER (ORDER BY empno) FROM empsalary;



-- Window
OVER ()  -- this will calucalte for all

ROW_NUMBER() OVER ()
RANK() OVER ()   		-- 1, 2, 2, 4
DENSE_RANK() OVER () 	-- 1, 2, 2, 3

-- row selections 
LAG(row) OVER win 		-- previous row
LEAD(row) OVER win 		-- next row

-- percentile
NTILE(4) OVER win 		-- quartile
NTILE(5) OVER win 		-- quartile
NTILE(100) OVER win 	-- quartile

-- Window alias
SELECT ...
	SUM(xx) OVER win1,
	AVG(yy) OVER win1,
	COUNT(zz) OVER win2
FROM ...
WINDOW win1 AS (...)
WINDOW win2 AS (...)



-- append rows instead of by columns as in JOIN
-- UNION
SELECT
FROM
UNION ALL
SELECT
FROM


-- perormance tuning
-- EXPLAIN will print out a query plan
EXPLAIN



-- Populate table 
-- COPY
CREATE TABLE country (
    name TEXT NOT NULL,
    two_letter TEXT PRIMARY KEY,
    country_id integer NOT NULL
);

COPY country FROM STDIN (DELIMITER '|');
United States|US|1
China|CN|86
\.

--
--

CREATE TABLE spy (
    date DATE NOT NULL PRIMARY KEY,
    Open FLOAT NOT NULL,
    High FLOAT NOT NULL,
    Low FLOAT NOT NULL,
    Close FLOAT NOT NULL,
    Adj_Close FLOAT NOT NULL,
	Volume INT NOT NULL
);

COPY spy FROM '/vagrant/sql-sample/SPY.csv' (DELIMITER ',');
-- ERROR:  must be superuser to COPY to or from a file
-- Try the following, still no go
-- ALTER ROLE vagrant WITH SUPERUSER;

To enter psql as super user you need to: (has to use postgres user which is PostgreSQL admin)
sudo -u postgres psql

If there is no user called postgres you need to create it on system first, with:
sudo adduser newuser

-- This makes copy works.


-- INSERT
-- all values for a row have to be supplied
--
-- use different columns order
INSERT INTO table (col1, col2) VALUES (val1, val2)
-- for regular column order
INSERT INTO table VALUES (val1, val2)


-- FOREIGN KEY
CREATE TABLE students (
	id serial PRIMARY KEY,
	name text);
	
CREATE TABLE courses (
	id text PRIMARY KEY,
	name text);
	
CREATE TABLE grades (
	student integer REFERENCES students(id),
	course text REFERENCES courses(id),
	grade text);
	

