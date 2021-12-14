DROP TABLE IF EXISTS #Stage
CREATE TABLE #Stage
(
	Input int NOT NULL
)

DROP TABLE IF EXISTS #Inputs
CREATE TABLE #Inputs
(
	Id int IDENTITY NOT NULL
	, depth int NOT NULL
)


BULK INSERT #Stage
FROM 'D:\AdventOfCode2021\Day1\Input.csv'
WITH
(
	FIRSTROW = 1,
	FIELDTERMINATOR = ',',  --CSV field delimiter
	ROWTERMINATOR = '\n',   --Use to shift the control to next row
	TABLOCK
)

INSERT INTO #Inputs WITH (TABLOCKX)
(depth)
SELECT s.Input
FROM #Stage AS s

;WITH leadInput
AS
(
SELECT 
	depth
	, Id
	, LAG(depth) OVER(ORDER BY Id) AS lg
	, CASE WHEN 
		depth > LAG(depth) OVER(ORDER BY Id) 
		THEN 1
	ELSE 0
	END AS inc
FROM #Inputs
)
SELECT 
	*
FROM leadInput
WHERE leadInput.inc = 1
ORDER BY Id