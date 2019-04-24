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


SELECT * FROM agents
WHERE AGENT_NAME like 'a%'
LIMIT 2;

SELECT * FROM orders
WHERE ord_date BETWEEN '2008-07-01' AND '2008-07-20'

SELECT customer.CUST_NAME, customer.PAYMENT_AMT, agents.AGENT_NAME FROM customer JOIN agents ON customer.AGENT_CODE = agents.AGENT_CODE
GROUP BY agents.AGENT_NAME

