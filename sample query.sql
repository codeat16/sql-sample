--- browse data
SELECT * FROM agents
LIMIT 2;

SELECT * FROM company
LIMIT 2;
SELECT * FROM customer
LIMIT 2;
SELECT * FROM daysorder
LIMIT 2;

-- no data
SELECT * FROM despatch
LIMIT 2;

SELECT * FROM foods
LIMIT 2;
SELECT * FROM listofitem
LIMIT 2;
SELECT * FROM orders
LIMIT 2;
SELECT * FROM student
LIMIT 2;
SELECT * FROM studentreport
LIMIT 2;

-- LIKE
SELECT * FROM agents
WHERE AGENT_NAME LIKE 'a%'
LIMIT 2;

-- BETWEEN
SELECT * FROM orders
WHERE ord_date BETWEEN '2008-07-01' AND '2008-07-20'

-- GROUP BY, ORDER BY, SUM, CASE
SELECT SUM(customer.PAYMENT_AMT) AS pmt, agents.AGENT_NAME,
	CASE WHEN SUM(customer.PAYMENT_AMT)<10000 THEN 'less than 10000' ELSE 'more than 10000' END as tenk
FROM customer JOIN agents ON customer.AGENT_CODE = agents.AGENT_CODE
GROUP BY agents.AGENT_NAME
HAVING pmt >10000
ORDER BY pmt DESC


-- subquery
SELECT AGENT_NAME, tenk FROM
(
SELECT SUM(customer.PAYMENT_AMT) AS pmt, agents.AGENT_NAME,
	CASE WHEN SUM(customer.PAYMENT_AMT)<10000 THEN 'less than 10000' ELSE 'more than 10000' END as tenk
FROM customer JOIN agents ON customer.AGENT_CODE = agents.AGENT_CODE
GROUP BY agents.AGENT_NAME
ORDER BY pmt DESC
) xxx
LIMIT 3

-- Do not work on www.db-fiddle.com
-- WITH to cache subquery
WITH xxx AS (
SELECT customer.PAYMENT_AMT, agents.AGENT_NAME
FROM customer JOIN agents ON customer.AGENT_CODE = agents.AGENT_CODE
--GROUP BY agents.AGENT_NAME
--ORDER BY pmt DESC
) 
SELECT AGENT_NAME FROM xxx
LIMIT 3


-- String functions
-- Beware of the RIGHT. The string variable usually is fixed in length. So select from right most could give empty character.
SELECT AGENT_NAME,
	LEFT(AGENT_NAME,3) as l,
	LENGTH(AGENT_NAME) as len,
	RIGHT(UPPER(AGENT_NAME),3) as r,
	POSITION('SAN' IN AGENT_NAME) as pos1
FROM agents

--- more Sring functions
SELECT CONCAT(AGENT_NAME, ' ', WORKING_AREA) as field1
FROM agents
-- SUBSTR is 1 indexed
SELECT SUBSTR(AGENT_NAME, 2, 4) as second_to_fourth
FROM agents


-- DATA_TYPE
SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
     TABLE_NAME = 'orders'
	 
--  OVER not working in .db-fiddle.com
SELECT ORD_NUM,
	SUM(ORD_AMOUNT) OVER (PARTITION BY DATE_TRUNC('month', ORD_DATE)) as acc_amount
FROM orders

SELECT ORD_NUM,
	SUM(ORD_AMOUNT) OVER win as acc_amount
FROM orders
WINDOW win AS (PARTITION BY DATE_TRUNC('month', ORD_DATE))


-- UNION
SELECT * 
FROM agents
WHERE WORKING_AREA = 'London'

UNION ALL

SELECT * 
FROM agents
WHERE WORKING_AREA = 'San Jose'


-- EXPLAIN
EXPLAIN
the whole query goes here

