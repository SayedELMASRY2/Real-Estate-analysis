--Milestone
--Sent emails to the potential customers
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
    c.Email,
    ISNULL(csc.NumberOfSales, 0) AS TotalSalesMade
FROM
    Clients AS c
LEFT JOIN 
	ClientSaleCounts AS csc 
	ON c.ClientID = csc.ClientID
WHERE
    csc.NumberOfSales = 1 
	OR 
	csc.NumberOfSales IS NULL
ORDER BY
    c.LastName, c.FirstName;

--Not Visited Properties to Focus On on our campains and offers
SELECT 
    p.PropertyID, 
	p.PropertyType, 
	p.Location
FROM 
    Properties AS p 
LEFT JOIN 
    Visits AS v
    ON p.PropertyID= v.PropertyID
WHERE 
    v.VisitID IS NULL

--MOM% in Sales
SELECT
    YEAR(SaleDate) As Year,
    MONTH(SaleDate) AS Month,
    SUM(SalePrice) AS Total_Sales,
    ROUND( 
	     (SUM(SalePrice) - 
                               LAG(SUM(SalePrice)) OVER (ORDER BY YEAR(SaleDate), MONTH(SaleDate)) ) * 100.0 /               
                               NULLIF(LAG(SUM(SalePrice)) OVER (ORDER BY YEAR(SaleDate), MONTH(SaleDate)), 0)
         , 2) AS MOM_per
FROM 
    Sales

GROUP BY 
    YEAR(SaleDate),
    MONTH(SaleDate)
ORDER BY 
    YEAR(SaleDate),
    MONTH(SaleDate);

--YOY% in Sales
SELECT
    YEAR(SaleDate) AS Year,
    SUM(SalePrice) AS Total_Sales,
    ROUND( 
         (SUM(SalePrice) - 
                             LAG(SUM(SalePrice)) OVER (ORDER BY YEAR(SaleDate))) * 100.0 /
                             NULLIF(LAG(SUM(SalePrice)) OVER (ORDER BY YEAR(SaleDate)), 0)
        , 2) AS YOY_per 
FROM
    Sales   
GROUP BY
    YEAR(SaleDate)
ORDER BY
    YEAR(SaleDate)