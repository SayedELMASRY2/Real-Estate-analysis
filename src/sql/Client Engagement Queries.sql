--🙋 Client Engagement
--● Number of properties visited per client
SELECT
    c.ClientID,
    CONCAT(c.FirstName, ' ', c.LastName) AS ClientName,
    COUNT(DISTINCT v.PropertyID) AS NumberOfPropertiesVisited
FROM
    Clients AS c
LEFT JOIN
    Visits AS v 
	ON c.ClientID = v.ClientID
GROUP BY
    c.ClientID, c.FirstName, c.LastName
ORDER BY
    NumberOfPropertiesVisited DESC;

--● Top clients by sale value
SELECT TOP 10
    c.ClientID,
    CONCAT(c.FirstName, ' ', c.LastName) AS ClientName,
    CAST(SUM(s.SalePrice) AS FLOAT) AS SaleValue
FROM
    Clients c
Inner JOIN
    Sales s ON c.ClientID = s.ClientID
GROUP BY
    c.ClientID, c.FirstName, c.LastName
ORDER BY
    SaleValue DESC;

--● First-time vs repeat buyers
WITH ClientSaleCounts AS (
    SELECT
        ClientID,
        COUNT(SaleID) AS NumberOfSales
    FROM
        Sales
    GROUP BY
        ClientID
)
SELECT
    c.ClientID,
    CONCAT(c.FirstName, ' ', c.LastName) AS ClientName,
	ISNULL(csc.NumberOfSales, 0) AS TotalSalesMade,
    CASE WHEN
        csc.NumberOfSales = 1 THEN 'First-Time Buyer'
        WHEN csc.NumberOfSales > 1 THEN 'Repeat Buyer'
        ELSE 'Not a Buyer' 
    END AS BuyerType
FROM
    Clients AS c
LEFT JOIN
    ClientSaleCounts AS csc 
	ON c.ClientID = csc.ClientID
ORDER BY
    c.LastName, c.FirstName;

--● Region-based client interest (visits by city)
SELECT
    c.ClientID,
    CONCAT(c.FirstName, ' ', c.LastName) AS ClientName,
    p.Location AS City,
    COUNT(v.VisitID) AS NumberOfVisitsInCity
FROM
    Clients AS c
Inner JOIN
    Visits AS v ON 
	c.ClientID = v.ClientID
Inner JOIN
    Properties AS p 
	ON v.PropertyID = p.PropertyID
GROUP BY
    c.ClientID, c.FirstName, c.LastName, p.Location
ORDER BY
    NumberOfVisitsInCity DESC;