/* regex replace
find	\B
replace	 ' ' <-- space

*/

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

DROP TABLE IF EXISTS #Inputs
CREATE TABLE #Inputs
(
	Id int IDENTITY NOT NULL
	, Bit01 tinyint NOT NULL
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


BULK INSERT #Stage
FROM 'D:\AdventOfCode2021\Day3\Input.csv'
WITH
(
	FIRSTROW = 1,
	FIELDTERMINATOR = ' ',  --CSV field delimiter
	ROWTERMINATOR = '\n',   --Use to shift the control to next row
	TABLOCK
)

INSERT INTO #Inputs WITH (TABLOCKX)
SELECT 
	s.*
FROM #Stage AS s

DECLARE @gamma char(12)

SELECT 
	@gamma = CONCAT
	(
			IIF(SUM(i.Bit01) > 500, '1', '0')	
		, IIF(SUM(i.Bit02) > 500, '1', '0')	
		, IIF(SUM(i.Bit03) > 500, '1', '0')	
		, IIF(SUM(i.Bit04) > 500, '1', '0')	
		, IIF(SUM(i.Bit05) > 500, '1', '0')	
		, IIF(SUM(i.Bit06) > 500, '1', '0')	
		, IIF(SUM(i.Bit07) > 500, '1', '0')	
		, IIF(SUM(i.Bit08) > 500, '1', '0')	
		, IIF(SUM(i.Bit09) > 500, '1', '0')	
		, IIF(SUM(i.Bit10) > 500, '1', '0')	
		, IIF(SUM(i.Bit11) > 500, '1', '0')	
		, IIF(SUM(i.Bit12) > 500, '1', '0')	
	) 
FROM #Inputs AS i 


;WITH
	L0   AS(SELECT 1 AS c UNION ALL SELECT 1),
	L1   AS(SELECT 1 AS c FROM L0 CROSS JOIN L0 AS B),
	L2   AS(SELECT 1 AS c FROM L1 CROSS JOIN L1 AS B),
	L3   AS(SELECT 1 AS c FROM L2 CROSS JOIN L2 AS B),
	L4   AS(SELECT 1 AS c FROM L3 CROSS JOIN L3 AS B),
	L5   AS(SELECT 1 AS c FROM L4 CROSS JOIN L4 AS B),
	Nums AS(SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS n FROM L5)
, tally AS (SELECT TOP (LEN(@gamma)) n FROM Nums ORDER BY n)
, convertBinary
AS
(
	SELECT 
		n
		, POWER(2, n-1) AS powerOfTwo
		, SUBSTRING(REVERSE('011100101100'),n,1) AS gamma
	FROM tally 
)
SELECT 
	SUM(cb.powerOfTwo * cb.gamma) AS gamma
	, SUM(cb.powerOfTwo * ((cb.gamma + 1) % 2)) AS epsilon /* flip the bits */
	, SUM(cb.powerOfTwo * cb.gamma) * SUM(cb.powerOfTwo * ((cb.gamma + 1) %2)) AS result
FROM convertBinary AS cb
