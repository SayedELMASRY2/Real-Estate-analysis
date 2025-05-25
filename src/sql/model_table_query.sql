SELECT 
    p.*,
    COALESCE(v.VisitCount, 0) AS VisitCount,
    CASE 
        WHEN s.PropertyID IS NOT NULL THEN 1
        ELSE 0
    END AS Sold,
    CASE 
        WHEN COALESCE(v.VisitCount, 0) BETWEEN 0 AND 1 THEN '0-1'
        WHEN COALESCE(v.VisitCount, 0) BETWEEN 2 AND 3 THEN '2-3'
        WHEN COALESCE(v.VisitCount, 0) BETWEEN 4 AND 5 THEN '4-5'
        WHEN COALESCE(v.VisitCount, 0) BETWEEN 6 AND 10 THEN '6-10'
        ELSE '11+'
    END AS VisitCountBin,
    p.PriceUSD / p.Size_sqm AS Price_per_sqm,
    CASE 
        WHEN p.PriceUSD <= 250000 THEN 'Low'
        WHEN p.PriceUSD <= 500000 THEN 'Medium'
        WHEN p.PriceUSD <= 750000 THEN 'High'
        ELSE 'Premium'
    END AS PriceCategory,
    CASE 
        WHEN p.Size_sqm <= 150 THEN 'Small'
        WHEN p.Size_sqm <= 300 THEN 'Medium'
        WHEN p.Size_sqm <= 450 THEN 'Large'
        ELSE 'Extra Large'
    END AS SizeCategory
INTO Model_table
FROM 
    Properties p
LEFT JOIN 
    (SELECT PropertyID, COUNT(*) AS VisitCount FROM Visits GROUP BY PropertyID) v
    ON p.PropertyID = v.PropertyID
LEFT JOIN 
    (SELECT DISTINCT PropertyID FROM Sales) s
    ON p.PropertyID = s.PropertyID;
