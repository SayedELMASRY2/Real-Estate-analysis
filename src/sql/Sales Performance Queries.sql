--💵 Sales Performance
--● Total sales value over time (monthly, quarterly, yearly)
--Monthly
SELECT
    MONTH(SaleDate) AS MonthNum,
    CAST(SUM(SalePrice) AS INT) AS TotalSales
FROM
    Sales
GROUP BY
    MONTH(SaleDate)
ORDER BY
    MonthNum;

--Quarterly
SELECT 
    DATEPART(QUARTER, SaleDate) AS QrtNum,
    CAST(SUM(SalePrice) AS INT) AS TotalSales
FROM 
    Sales
GROUP BY 
     DATEPART(QUARTER, SaleDate)
ORDER BY 
     QrtNum;

--Yearly
SELECT 
    YEAR(SaleDate) AS Year,
    CAST(SUM(SalePrice) AS INT) AS TotalSales
FROM 
    Sales
GROUP BY 
    YEAR(SaleDate)
ORDER BY 
    Year;

--● Average sale value per property type
SELECT 
    p.PropertyType,
    CAST(ROUND(AVG(s.SalePrice), 2) AS DECIMAL(18,2)) AS AvgSaleValue
FROM 
    Sales s
Inner JOIN 
    Properties p 
	ON s.PropertyID = p.PropertyID
GROUP BY 
    p.PropertyType
ORDER BY 
    AvgSaleValue DESC;

--● Conversion rate = (sales / visits) per property or agent

--per property
-- Step 1: Get visit count and sale status per property
WITH PropertyStats AS (
    SELECT
        p.PropertyID,
        p.PropertyType,
        COUNT(DISTINCT v.VisitID) AS VisitCount,
        CASE WHEN 
		        COUNT(DISTINCT s.SaleID) > 0 THEN 1 
		        ELSE 0 
		END AS WasSold
    FROM
        Properties AS p
        LEFT JOIN Visits AS v 
		ON p.PropertyID = v.PropertyID
        LEFT JOIN Sales AS s 
		ON p.PropertyID = s.PropertyID
    GROUP BY
        p.PropertyID, p.PropertyType
)
-- Step 2: Compute conversion rate as 1 sale per number of visits
SELECT
    PropertyID,
    PropertyType,
    VisitCount,
    WasSold,
    CASE WHEN
             VisitCount = 0 THEN 0
             WHEN WasSold = 1 THEN CAST(ROUND(100.0 / VisitCount, 2) AS DECIMAL(5,2))
             ELSE 0
    END AS ConversionRatePercent
FROM
    PropertyStats
ORDER BY
    ConversionRatePercent DESC;

--Per Agent
SELECT
    a.AgentID,
    CONCAT(a.FirstName, ' ', a.LastName) AS AgentName,
    COUNT(DISTINCT s.SaleID) AS NumberOfSales,
    COUNT(DISTINCT v.VisitID) AS NumberOfVisits,
    CAST(ROUND((COUNT(DISTINCT s.SaleID) * 100.0) / NULLIF(COUNT(DISTINCT v.VisitID), 0),2) AS DECIMAL(5,2)) AS ConversionRatePercentage
	
FROM
    Agents AS a
LEFT JOIN
    Sales AS s 
	ON a.AgentID = s.AgentID
LEFT JOIN
    Visits AS v 
	ON a.AgentID = v.AgentID
GROUP BY
    a.AgentID, a.FirstName, a.LastName
ORDER BY
    ConversionRatePercentage DESC;

--● Time on market before sale
SELECT 
    s.PropertyID,
    p.PropertyType,
    MIN(v.VisitDate) AS FirstVisitDate,
    s.SaleDate,
    DATEDIFF(DAY, MIN(v.VisitDate), s.SaleDate) AS DaysOnMarket
FROM 
    Sales AS s
Inner JOIN 
    Properties AS p 
	ON s.PropertyID = p.PropertyID
Inner JOIN 
    Visits AS v 
	ON s.PropertyID = v.PropertyID
GROUP BY 
    s.PropertyID, p.PropertyType, s.SaleDate
ORDER BY 
    DaysOnMarket DESC;