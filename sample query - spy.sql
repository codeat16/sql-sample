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


CREATE TABLE totalpc (
    date DATE NOT NULL PRIMARY KEY,
    calls FLOAT NOT NULL,
    puts FLOAT NOT NULL,
    total FLOAT NOT NULL,
    pcratio FLOAT NOT NULL
);

COPY totalpc FROM '/vagrant/sql-sample/totalpc_my.csv' (DELIMITER ',');

INSERT INTO totalpc VALUES ('2020-01-01', 1.1, 2.2, 3.3, 4.4);

-- use different columns order
INSERT INTO totalpc (pcratio, date, calls, puts, total)
VALUES (10.1, '2021-01-01', 10.2, 10.3, 10.4);




SELECT DATE_PART('year', date) as year, AVG(close)
FROM spy
-- WHERE is part of the SELECT query, cannot use alias yet
WHERE DATE_PART('year', date) >2000
-- After query, alias 'year' can be used
GROUP BY year
ORDER BY year
LIMIT 10 OFFSET 5;



SELECT DATE_PART('year', date) as year, AVG(close)
FROM spy
-- WHERE is part of the SELECT query, cannot use alias yet
WHERE DATE_PART('year', date) >2000
-- After query, alias 'year' can be used
GROUP BY year
--
HAVING AVG(close)>150
ORDER BY year
LIMIT 10 OFFSET 5;




-- BETWEEN
SELECT * FROM spy
WHERE date BETWEEN '2008-07-01' AND '2008-07-20'


-- subquery
SELECT * FROM
(
SELECT spy.date, spy.close, totalpc.pcratio
FROM spy JOIN totalpc ON spy.date=totalpc.date
) xxx
LIMIT 3;

-- WITH to cache subquery
WITH xxx AS (
SELECT spy.date, spy.close, totalpc.pcratio
FROM spy JOIN totalpc ON spy.date=totalpc.date
) 
SELECT * FROM xxx
LIMIT 3;


-- VIEW
CREATE VIEW close_and_pc AS
SELECT spy.date, spy.close, totalpc.pcratio
FROM spy JOIN totalpc ON spy.date=totalpc.date;


SELECT * FROM close_and_pc
LIMIT 3;


	 
--  OVER
SELECT date,
	AVG(pcratio) OVER (PARTITION BY DATE_PART('month', date)) as avg_pc
FROM totalpc
ORDER BY date
LIMIT 60;

-- for comparison, this () window will do aggregate function on the whole data set
SELECT date,
	AVG(pcratio) OVER () as avg_pc
FROM totalpc
ORDER BY date
LIMIT 60;


-- OVER using AS syntax

SELECT date,
	AVG(pcratio) OVER win as avg_pc
FROM totalpc
WINDOW win AS (PARTITION BY DATE_PART('month', date))
ORDER BY date
LIMIT 60;



-- EXPLAIN
EXPLAIN
the whole query goes here

