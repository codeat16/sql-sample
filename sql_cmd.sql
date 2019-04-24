SELECT p, c, ratio, name p/c AS R
FROM pcv
WHERE ratio > 0.70, name = 'John'
ORDER BY ratio, p DESC, c
LIMIT 10

# option for WHERE
# %: any
LIKE '%abc%'

# --- not tested ---
# SQL is case insensitive
# To do case sensitive search using LIKE, use COLLATE Latin1_General_BIN
SELECT name
FROM Person
WHERE name LIKE '%A'
COLLATE Latin1_General_BIN;
# or COLLATE Latin1_General_CS_AS

# in a set
IN ('A', 'B', 'C')

# BETWEEN is inclusive
date_ BETWEEN '2016-01-01' AND '2017-01-01'

(a>3 OR b<2) AND c>5

IS NULL
IS NOT NULL



## JOIN
JOIN table2 ON table1.id2 = table2.id2

# JOIN with inequity operation (e.g, comparision)
JOIN table2 ON table1.id2 = table2.id2 AND a>b

LEFT JOIN  # same as LEFT OUTER JOIN
RIGHT JOIN # same as RIGHT OUTER JOIN
OUTER JOIN # same as FULL OUTER JOIN
FULL OUTER JOIN = FULL JOIN

#
FROM table t1
LEFT JOIN table t2 ON t1.id=t2.id
AND t1.occurred_at > t2.occurred_at
AND t1.occurred_at >= t2.occurred_at + INTERVAL '28 days'

# OUTER Join that exclude inner
FULL OUTER JOIN with WHERE A.Key IS NULL OR B.Key IS NULL

# table name alias
FROM table t
JOIN table table



SELECT DISTINCT


# aggregate functions
SELECT COUNT(), SUM(), AVG(), MIN(), MAX()


#
GROUP BY var
GROUP BY 1 (column number)

#
SELECT DISTINCT


# to use conditional on aggregate function
HAVING SUM(a)>100

## DATE FUNCTIONS
# DATE_TRUNC understands the keyword and look for the specific and reset other elements into 'zero', result is still in date format 
# and can be worked on.
# DATE_PART cut them into substring and is no longer in date format
SELECT DATE_TRUNC('day', datetimedata)
SELECT DATE_TRUNC('month', datetimedata)
SELECT DATE_TRUNC('year', datetimedata)
SELECT DATE_PART('second', datetimedata)
# dow: Day of Week
SELECT DATE_PART('dow', datetimedata)

#
SELECT abc
	CASE WHEN a<100 THEN 'less than 100' ELSE 'more than 100' END as hundred
	
SELECT abc
	CASE WHEN a<25 THEN 'less than 25%'
	 WHEN a<50 THEN 'less than 50%'
	 WHEN a<75 THEN 'less than 75%'
	 WHEN a<100 THEN 'less than 100'
	END as quartile
	
# subquery, most can select portion and run to test (like spss)
# xxx is alias of inner query
SELECT *
FROM 
(
another query 
) xxx


# Common Table Expression
WITH _alias1_ AS (sub query1 here),
	 _alias2_ AS (sub query2 here)
SELECT *
FROM _alias1_

# String fuctions
LEFT(string, n) AS l
RIGHT(string, n) AS r
LENGTH(string)
UPPER(string)
LOWER(string)
POSITION('x' IN string) = STRPOS(string, 'x')   # case sensitive

CONCAT(firstname, ' ', lastname) = firstname || ' ' || lastname
SUBSTR(string, from, count)

# CAST - like C++ type cast
CAST(string AS date) as _datename_  =   (string)::date as _datename_


# COALESCE
COALESCE(expr1, expr2, ..., exprn)
return the 1st non-null expression


# Window function
#
# after OVER can use PARTITION BY, ORDER BY, or no statement 
# *** Without ORDER BY, there won't be effect of running totals.

SELECT depname, empno, salary, avg(salary) OVER (PARTITION BY depname) FROM empsalary;
ROW_NUMBER() OVER win
RANK() OVER win   # 1, 2, 2, 4
DENSE_RANK() OVER win # 1, 2, 2, 3

# Window alias
SELECT depname, empno, salary, avg(salary) OVER win FROM empsalary;
WINDOW win AS (PARTITION BY depname)

# row selection
LAG(row) OVER win # previous row
LEAD(row) OVER win # next row

# percentile
NTILE(4) OVER win # quartile
NTILE(5) OVER win # quintile
NTILE(100) OVER win # percentile

# UNION
SELECT
FROM
UNION ALL
SELECT
FROM


# perormance tuning
EXPLAIN