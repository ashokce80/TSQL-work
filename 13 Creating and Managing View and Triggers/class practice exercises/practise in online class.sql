/* Online class practise*/ 


/* Sales.SalesOrderHeaderSales.SalesTerritoryCreate a view to display / include the columns from above two tables		1. Order date		2. Due Date		3. Status		4. Online Flag		5. Territory		6. Freight		7. TotalDue
*/

--Create View 

 Select	 top 1	*
From AdventureWorks2014.Sales.SalesOrderHeaderSelect	top 1	*
From AdventureWorks2014.Sales.SalesTerritory

GO
Create View	VW_SaleDetail
As
	Select		SOH.OrderDate,
				SOH.DueDate,
				SOH.Status,
				SOH.OnlineOrderFlag,
				ST.Name as [Territory Name],
				SOH.Freight,
				SOH.TotalDue
	From		AdventureWorks2014.Sales.SalesOrderHeader as SOH
	Inner join	AdventureWorks2014.Sales.SalesTerritory as ST
	ON			ST.TerritoryID = SOH.TerritoryID
GO

Select	*
From	VW_SaleDetail


