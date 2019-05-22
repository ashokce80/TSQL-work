SELECT		*
FROM		[Sales].[CreditCard]
WHERE		CardType = 'Vista' 
AND			ExpMonth = 11;

SELECT		*
FROM		[Purchasing].[ShipMethod]
WHERE		ShipRate = 1.99
OR			ShipRate = 2.99;

SELECT		*
FROM		[Sales].[Customer]
WHERE		TerritoryID >= 5
AND			TerritoryID <= 10;

SELECT		SalesOrderID,TerritoryID,CustomerID, TotalDue
FROM		[Sales].[SalesOrderHeader]
WHERE		TotalDue > 15000;

/* Use the AdventureWorks table AdventureWorks2016.Sales.SalesOrderHeader 		--to find out the totalsales by territoryID	-- and the salespersonID and due date for the online Order Flag 0
*/
USE		AdventureWorks2014;
-- GRP BY  TID SLSPID DUE DATE
-- AGG TOTAL SALES  SUM
SELECT		*
FROM		AdventureWorks2014.Sales.SalesOrderHeader;

SELECT		TerritoryID, SalesPersonID, DueDate,
			SUM(TotalDue) AS TotalSales
FROM		AdventureWorks2014.Sales.SalesOrderHeader
WHERE		OnlineOrderFlag = 0
GROUP BY	TerritoryID, SalesPersonId, DueDate
