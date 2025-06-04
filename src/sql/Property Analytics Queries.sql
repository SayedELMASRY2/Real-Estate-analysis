--🏠 Property Analytics
--● Number of listed properties by type and location
SELECT 
    PropertyType, 
    Location, 
    COUNT(*) AS NumberOfProperties
From  
      Properties
Group By 
      PropertyType, 
	  Location

ORDER BY 
      PropertyType, 
	  Location;

--● Average price per square meter per city
SELECT 
    Location AS City, 
    Round(AVG(PriceUSD / NULLIF(Size_sqm, 0)),2) AS AvgPricePerSqm
FROM 
    Properties
GROUP BY 
    Location
ORDER BY 
    AvgPricePerSqm DESC;

--● Distribution of property types (Apartment, Villa, etc.)
SELECT 
    PropertyType, 
    COUNT(*) AS NumberOfProperties
FROM 
    Properties
GROUP BY 
    PropertyType
ORDER BY 
    NumberOfProperties DESC;

--● Top 10 most expensive or most visited properties
--Most expensive
SELECT 
    TOP 10
    PropertyID, 
    PropertyType,
	PriceUSD
FROM 
    Properties
ORDER BY 
    PriceUSD DESC;
--Most visited
SELECT 
    TOP 10
    v.PropertyID, 
    p.PropertyType, 
    COUNT(*) AS NumberOfVisits
FROM 
    Visits AS v
Inner JOIN 
    Properties AS p 
	ON v.PropertyID = p.PropertyID
GROUP BY 
    v.PropertyID, p.PropertyType, p.Location
ORDER BY 
    NumberOfVisits DESC;