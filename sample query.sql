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



