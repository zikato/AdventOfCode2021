/* regex replace
find	\B
replace	 ' ' <-- space

*/

DROP TABLE IF EXISTS #Stage_backup
DROP TABLE IF EXISTS #Stage
CREATE TABLE #Stage
(
	  Bit01 tinyint NOT NULL
	, Bit02 tinyint NOT NULL
	, Bit03 tinyint NOT NULL
	, Bit04 tinyint NOT NULL
	, Bit05 tinyint NOT NULL
	, Bit06 tinyint NOT NULL
	, Bit07 tinyint NOT NULL
	, Bit08 tinyint NOT NULL
	, Bit09 tinyint NOT NULL
	, Bit10 tinyint NOT NULL
	, Bit11 tinyint NOT NULL
	, Bit12 tinyint NOT NULL

)
DECLARE @rowCount int

BULK INSERT #Stage
FROM 'D:\AdventOfCode2021\Day3\Input.csv'
WITH
(
	FIRSTROW = 1,
	FIELDTERMINATOR = ' ',
	ROWTERMINATOR = '\n', 
	TABLOCK
)

SET @rowCount = @@ROWCOUNT

SELECT * INTO #stage_backup
FROM #Stage AS s

DECLARE 
	@oxygen char(12),
	@co2 char(12)

/*
###############################################################################
	Stupid manual solution first
###############################################################################
*/

/* Loop for Oxygen here */


DELETE s
FROM #Stage AS s
WHERE s.Bit01 = (SELECT IIF(SUM(Bit01) >= @rowCount/2., 1, 0)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT

DELETE s
FROM #Stage AS s
WHERE s.Bit02 = (SELECT IIF(SUM(Bit02) >= @rowCount/2., 1, 0)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT

DELETE s
FROM #Stage AS s
WHERE s.Bit03 = (SELECT IIF(SUM(Bit03) >= @rowCount/2., 1, 0)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT


DELETE s
FROM #Stage AS s
WHERE s.Bit04 = (SELECT IIF(SUM(Bit04) >= @rowCount/2., 1, 0)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT


DELETE s
FROM #Stage AS s
WHERE s.Bit05 = (SELECT IIF(SUM(Bit05) >= @rowCount/2., 1, 0)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT

DELETE s
FROM #Stage AS s
WHERE s.Bit06 = (SELECT IIF(SUM(Bit06) >= @rowCount/2., 1, 0)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT

DELETE s
FROM #Stage AS s
WHERE s.Bit07 = (SELECT IIF(SUM(Bit07) >= @rowCount/2., 1, 0)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT

DELETE s
FROM #Stage AS s
WHERE s.Bit08 = (SELECT IIF(SUM(Bit08) >= @rowCount/2., 1, 0)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT

DELETE s
FROM #Stage AS s
WHERE s.Bit09 = (SELECT IIF(SUM(Bit09) >= @rowCount/2., 1, 0)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT

SELECT * FROM #Stage AS s

SELECT @oxygen = CONCAT
(
	s.Bit01
  , s.Bit02
  , s.Bit03
  , s.Bit04
  , s.Bit05
  , s.Bit06
  , s.Bit07
  , s.Bit08
  , s.Bit09
  , s.Bit10
  , s.Bit11
  , s.Bit12
) 
FROM #Stage AS s 

/* End Oxygen */

/* Restore Stage table */
TRUNCATE TABLE #Stage
INSERT INTO #Stage SELECT * FROM #stage_backup
SET @rowCount = @@ROWCOUNT

/* Loop for CO2 here */

DELETE s
FROM #Stage AS s
WHERE s.Bit01 = (SELECT IIF(SUM(Bit01) >= @rowCount/2., 0, 1)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT


DELETE s
FROM #Stage AS s
WHERE s.Bit02 = (SELECT IIF(SUM(Bit02) >= @rowCount/2., 0, 1)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT


DELETE s
FROM #Stage AS s
WHERE s.Bit03 = (SELECT IIF(SUM(Bit03) >= @rowCount/2., 0, 1)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT


DELETE s
FROM #Stage AS s
WHERE s.Bit04 = (SELECT IIF(SUM(Bit04) >= @rowCount/2., 0, 1)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT


DELETE s
FROM #Stage AS s
WHERE s.Bit05 = (SELECT IIF(SUM(Bit05) >= @rowCount/2., 0, 1)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT



DELETE s
FROM #Stage AS s
WHERE s.Bit06 = (SELECT IIF(SUM(Bit06) >= @rowCount/2., 0, 1)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT

DELETE s
FROM #Stage AS s
WHERE s.Bit07 = (SELECT IIF(SUM(Bit07) >= @rowCount/2., 0, 1)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT


DELETE s
FROM #Stage AS s
WHERE s.Bit08 = (SELECT IIF(SUM(Bit08) >= @rowCount/2., 0, 1)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT

DELETE s
FROM #Stage AS s
WHERE s.Bit09 = (SELECT IIF(SUM(Bit09) >= @rowCount/2., 0, 1)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT

DELETE s
FROM #Stage AS s
WHERE s.Bit10 = (SELECT IIF(SUM(Bit10) >= @rowCount/2., 0, 1)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT

DELETE s
FROM #Stage AS s
WHERE s.Bit11 = (SELECT IIF(SUM(Bit11) >= @rowCount/2., 0, 1)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT


DELETE s
FROM #Stage AS s
WHERE s.Bit12 = (SELECT IIF(SUM(Bit12) >= @rowCount/2., 0, 1)  FROM #Stage AS s)
SET @rowCount -=  @@ROWCOUNT

SELECT * FROM #Stage AS s

SELECT @co2 = CONCAT
(
	s.Bit01
  , s.Bit02
  , s.Bit03
  , s.Bit04
  , s.Bit05
  , s.Bit06
  , s.Bit07
  , s.Bit08
  , s.Bit09
  , s.Bit10
  , s.Bit11
  , s.Bit12
) 
FROM #Stage AS s 


;WITH
	L0   AS(SELECT 1 AS c UNION ALL SELECT 1),
	L1   AS(SELECT 1 AS c FROM L0 CROSS JOIN L0 AS B),
	L2   AS(SELECT 1 AS c FROM L1 CROSS JOIN L1 AS B),
	L3   AS(SELECT 1 AS c FROM L2 CROSS JOIN L2 AS B),
	L4   AS(SELECT 1 AS c FROM L3 CROSS JOIN L3 AS B),
	L5   AS(SELECT 1 AS c FROM L4 CROSS JOIN L4 AS B),
	Nums AS(SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS n FROM L5)
, tally AS (SELECT TOP (LEN(@oxygen)) n FROM Nums ORDER BY n)
, convertBinary
AS
(
	SELECT 
		n
		, POWER(2, n-1) AS powerOfTwo
		, SUBSTRING(REVERSE(@oxygen),n,1) AS oxygen
		, SUBSTRING(REVERSE(@co2),n,1) AS co2
	FROM tally 
)
SELECT 
	@oxygen AS oxygenBinary
	, @co2 AS co2Binary
	, SUM(cb.powerOfTwo * cb.oxygen) AS oxygenDecimal
	, SUM(cb.powerOfTwo * cb.co2) AS co2Decimal
	, SUM(cb.powerOfTwo * cb.oxygen) * SUM(cb.powerOfTwo * cb.co2) AS result
FROM convertBinary AS cb
