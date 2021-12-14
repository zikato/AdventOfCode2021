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

;WITH sldWindow
AS
(
SELECT 
	i.depth
	, i.Id
	, i.depth 
		+ LEAD(i.depth,1) OVER (ORDER BY i.Id)
		+ LEAD(i.depth,2) OVER (ORDER BY i.Id) AS slidingWindow
FROM #Inputs AS i
)
, LeadWindow
AS
(
	SELECT 
		sldWindow.depth
	  , sldWindow.Id
	  , sldWindow.slidingWindow
	  , CASE 
			WHEN LEAD(sldWindow.slidingWindow) OVER (ORDER BY Id) > sldWindow.slidingWindow
			THEN 1
		ELSE 0
	END AS ld	
	FROM sldWindow 
)
SELECT 
	*
FROM LeadWindow
WHERE ld = 1
ORDER BY Id

/* 1805 */