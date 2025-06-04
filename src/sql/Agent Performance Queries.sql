--󰞴 Agent Performance
--● Number of sales per agent
SELECT
    a.AgentID,
    CONCAT(a.FirstName, ' ', a.LastName) AS AgentName,
    COUNT(s.SaleID) AS NumberOfSales
FROM
    Agents AS a
LEFT JOIN
    Sales AS s 
	ON a.AgentID = s.AgentID
GROUP BY
    a.AgentID, a.FirstName, a.LastName
ORDER BY
    NumberOfSales DESC;

--● Number of client visits per agent
SELECT
    a.AgentID,
    CONCAT(a.FirstName, ' ', a.LastName) AS AgentName,
    COUNT(v.VisitID) AS NumberOfClientVisits
FROM
    Agents AS a
LEFT JOIN
    Visits AS v 
	ON a.AgentID = v.AgentID
GROUP BY
    a.AgentID, a.FirstName, a.LastName
ORDER BY
    NumberOfClientVisits DESC;

--● Conversion rate per agent (visits → sales)
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

--● Avg sale value handled by each agent
SELECT
    a.AgentID,
    CONCAT(a.FirstName, ' ', a.LastName) AS AgentName,
    CAST(ROUND(AVG(s.SalePrice), 2) AS DECIMAL(15,2)) AS AverageSaleValue
FROM
    Agents AS a
LEFT JOIN
    Sales AS s 
	ON a.AgentID = s.AgentID
GROUP BY
    a.AgentID, a.FirstName, a.LastName
ORDER BY
    AverageSaleValue DESC;