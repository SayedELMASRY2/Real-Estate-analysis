--📍 Location-Based Insights
--● Sales heatmap by city or region
-- Number of Sales per Location (Volume)
SELECT
    p.Location,
    COUNT(s.SaleID) AS SalesNum
FROM
    Properties AS p
INNER JOIN
    Sales AS s 
	ON p.PropertyID = s.PropertyID
GROUP BY
    p.Location
ORDER BY
    SalesNum DESC;

--Total Sales Value per Location (Value)
SELECT
    p.Location,
	CAST(SUM(s.SalePrice) AS FLOAT) AS SaleValue
FROM
    Properties p
Inner JOIN
    Sales AS s 
	ON p.PropertyID = s.PropertyID
GROUP BY
    p.Location
ORDER BY
    SaleValue DESC;

--● High-performing areas (most sold or highest priced)
--Areas with Most Properties Sold
SELECT
    p.Location,
    COUNT(s.SaleID) AS SalesNum
FROM
    Properties AS p
INNER JOIN
    Sales AS s 
	ON p.PropertyID = s.PropertyID
GROUP BY
    p.Location
ORDER BY
    SalesNum DESC;

--● Average visit-to-sale ratio per location

-- 1. For every sold property, calculate its number of visits.
WITH SoldProperties AS (
    SELECT
        p.PropertyID,
        p.Location
    FROM
        Properties p
        INNER JOIN Sales AS s 
		           ON p.PropertyID = s.PropertyID
),
VisitsPerSoldProperty AS (
    SELECT
        sp.PropertyID,
        sp.Location,
        COUNT(v.VisitID) AS VisitsNum
    FROM
        SoldProperties AS sp
        LEFT JOIN Visits AS v 
		ON sp.PropertyID = v.PropertyID
    GROUP BY
        sp.PropertyID, sp.Location
)
-- 2. Now calculate the average number of visits for sold properties by location.
SELECT
    Location,
    AVG(VisitsNum * 1.0) AS AvgVisitToSaleRatio
FROM
    VisitsPerSoldProperty
GROUP BY
    Location
ORDER BY
    AvgVisitToSaleRatio DESC;
