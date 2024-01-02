USE EdmontonHousing
--to see the full table
SELECT *
FROM EdmontonHousing

--How many bedroom types are there in Edmonton?
SELECT DISTINCT(Bedrooms)
FROM EdmontonHousing
ORDER BY Bedrooms ASC

--What's the average price of a house in the Glenwood area?
SELECT AVG(Price) AS 'Average Price in Glenwood'
FROM EdmontonHousing
WHERE Community = 'Glenwood'

--Count the number of houses in each community in Edmonton.
SELECT Community, COUNT(Description) as 'Number of Houses'
FROM EdmontonHousing
GROUP BY Community
ORDER BY Community ASC

--What is the average square footage of houses in the Allendale community?
SELECT AVG([Square Footage]) AS 'Average Square Footage in Allendale'
FROM EdmontonHousing
WHERE Community = 'Allendale'
--we can use CTE as well if we want two columns where the first column holds the name of the community and the second column holds the average value
WITH CTE_AVGSqFootage AS(
SELECT Community, AVG([Square Footage]) AS 'Average Square Footage'
FROM EdmontonHousing
GROUP BY Community)
SELECT c.Community, c.[Average Square Footage]
FROM CTE_AVGSqFootage c
INNER JOIN (
	SELECT [Average Square Footage] AS 'Average Sq Footage in Allendale'
	FROM CTE_AVGSqFootage
	WHERE Community = 'Allendale'
)	subq
ON c.[Average Square Footage] = subq.[Average Sq Footage in Allendale]

--How many houses have more than 2 bathrooms in the Woodcroft area?
SELECT COUNT(Description) as 'Number of Houses with more than 2 Bathrooms in Woodcroft'
FROM EdmontonHousing
WHERE Community = 'Woodcroft'AND Bathrooms > 2

--What is the most common type of house style in Edmonton?
WITH CTE_HousingStyleCount AS (
    SELECT Style, COUNT(Style) AS 'Count'
    FROM EdmontonHousing
    GROUP BY Style)
SELECT c.Style, c.Count AS 'Max'
FROM CTE_HousingStyleCount c
INNER JOIN (
    SELECT MAX(Count) AS 'MaxCount'
    FROM CTE_HousingStyleCount
) subq
ON c.Count = subq.MaxCount;
--Therefore, most common style is '2 Storey' and there are 505 '2 Storey' housing in Edmonton

--Calculate the average price of houses built after the year 2000.
SELECT AVG(Price) AS 'Average Price of Houses built after 2000'
FROM EdmontonHousing
WHERE [Year Built] > 2000

--Find the minimum and maximum acre size of properties in Edmonton.
SELECT MIN(Acres) AS 'Minimum Acres', MAX(Acres) AS 'Maximum Acres'
FROM EdmontonHousing

--How many houses have more than 4 parking spaces?
SELECT COUNT(Description) as 'Number of houses with more than 4 parking spaces'
FROM EdmontonHousing
WHERE [Parking Spaces] > 4

--What is the distribution of the year built for houses in the Caernarvon community?
SELECT MIN([Year Built]) AS 'Oldest House in Caernarvon', MAX([Year Built]) AS 'Newest House in Caernarvon'
FROM EdmontonHousing
WHERE Community = 'Caernarvon'

--Identify the top 5 communities with the highest average house prices
SELECT TOP 5 Community, AVG(Price) AS 'Average house prices'
FROM EdmontonHousing
GROUP BY Community
ORDER BY AVG(Price) DESC

--What percentage of houses in Edmonton have a square footage greater than 1000?
SELECT CONCAT((SUM(CASE WHEN [Square Footage] > 1000 THEN 1.0 ELSE 0 END) / COUNT(*)) * 100,' %') AS 'Percentage Over 1000 SqFt'
FROM EdmontonHousing

--List the sub-types of houses available in Edmonton along with their average prices.
SELECT [Sub Type], AVG(Price) AS 'Average Price'
FROM EdmontonHousing
GROUP BY [Sub Type]