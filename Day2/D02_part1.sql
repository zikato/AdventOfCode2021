DROP TABLE IF EXISTS #Stage
CREATE TABLE #Stage
(
	Direction varchar(7) NOT NULL
	, Val int NOT NULL
)

DROP TABLE IF EXISTS #Inputs
CREATE TABLE #Inputs
(
	Id int IDENTITY NOT NULL
	, Direction varchar(7) NOT NULL
	, Val int NOT NULL
)


BULK INSERT #Stage
FROM 'D:\AdventOfCode2021\Day2\Input.csv'
WITH
(
	FIRSTROW = 1,
	FIELDTERMINATOR = ' ',  --CSV field delimiter
	ROWTERMINATOR = '\n',   --Use to shift the control to next row
	TABLOCK
)

INSERT INTO #Inputs WITH (TABLOCKX)
(Direction, Val)
SELECT 
	s.Direction, s.Val
FROM #Stage AS s



SELECT 
	SUM(i.Val)
FROM #Inputs AS i 
WHERE i.Direction = 'Forward'
/* 1832 */

SELECT 
	SUM(CASE WHEN i.Direction = 'down' THEN i.Val ELSE i.Val * -1 end) AS depth
FROM #Inputs AS i 
WHERE i.Direction <> 'Forward'
/* 1172*/

SELECT 1832 * 1172 