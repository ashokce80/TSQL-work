/* 

Class: Intro to SSRS Architecture
Date: June 1 2019
Section: March Online Class

*/

SELECT			--SOD.ProductID
				ISNULL(CAST(SUM(LineTotal) AS VARCHAR(150)), 'Product Not Sold') AS TotalLineTotal
				,Name AS ProductName
FROM			Sales.SalesOrderDetail SOD
RIGHT JOIN		Production.Product P 
ON				P.ProductID = SOD.ProductID
GROUP BY		--SOD.ProductID
				Name


SELECT			
				ISNULL(SUM(LineTotal) ,0) AS TotalLineTotal
				,Name AS ProductName
FROM			Sales.SalesOrderDetail SOD
RIGHT JOIN		Production.Product P 
ON				P.ProductID = SOD.ProductID
GROUP BY		--SOD.ProductID
				Name


SELECT			@@SERVERNAME

SELECT			*
FROM			Production.Product

SELECT			
				ISNULL(LineTotal ,0) AS TotalLineTotal
				,Name AS ProductName
FROM			Sales.SalesOrderDetail SOD
RIGHT JOIN		Production.Product P 
ON				P.ProductID = SOD.ProductID


SELECT			
				ISNULL(SUM(LineTotal) ,0) AS TotalLineTotal
				,Name AS ProductName
FROM			Sales.SalesOrderDetail SOD
RIGHT JOIN		Production.Product P 
ON				P.ProductID = SOD.ProductID
GROUP BY		--SOD.ProductID
				Name

/*
o	Year (Year of the OrderDate) from Sales.SalesOrderHeader
o	Territory Group (defined as Group within SalesTerritory table) from Sales.SalesTerritory
o	Territory (defined as Name within SalesTerritory table)from Sales.SalesTerritory
o	SalesRep (defined as First and Last Name of the SalesRep) from Sales.vSalesPerson 
o	Job Title (defined as Job title of Sales Rep)from  Sales.vSalesPerson 
o	Ship State (defined Ship State of Order) from Person.StateProvince and Person.Address


*/
--> SME ( Subject Matter Expert)
/*

In our SELECT statement we are going to have the following columns

-	TotalDue 
-	Year from OrderDate (use YEAR)
-	Month from OrderDate (use MONTH)
-	Territory Group from Group
-	Territory Name from Name 
-	SalesRep from FirstName LastName  need to use ISNULL to replace Sales with no Reps by 
	'No Rep'
-	Job Title from JobTitle
-	ShipState from Name (Person.StateProvince and  Person.Address)
*/

SELECT			*
FROM			Sales.SalesOrderHeader

SELECT			*
FROM			Sales.SalesTerritory

SELECT			*
FROM			 Sales.vSalesPerson

SELECT			*
FROM			Person.Address

SELECT			*
FROM			Person.StateProvince 


SELECT			 YEAR(SOH.OrderDate) AS OrderYear 
				,MONTH(SOH.OrderDate) AS OrderMonth
				,SOH.TotalDue
				,[Group] AS TerritoryGroup
				,ST.Name AS TerritoryName
				,ISNULL(VSP.FirstName +' '+VSP.LastName , 'No Rep') AS SalesRep
				,ISNULL(VSP.JobTitle,'No Job Title') AS JobTitle -- this is not required
				,SP.Name AS ShipState
FROM			Sales.SalesOrderHeader as SOH
LEFT JOIN		Sales.SalesTerritory as ST
ON				SOH.TerritoryID = ST.TerritoryID
LEFT JOIN		Sales.vSalesPerson as VSP
ON				SalesPersonID = BusinessEntityID
LEFT JOIN		Person.Address as PA
ON				ShipToAddressID = AddressID
LEFT JOIN		Person.StateProvince as SP
ON				SP.StateProvinceID = PA.StateProvinceID

Where			VSP.FirstName is not null 
OR				VSP.JobTitle is not null

--------------------OR-------------------------------------------

SELECT			 YEAR(OrderDate) AS OrderYear 
				,MONTH(OrderDate) AS OrderMonth
				,TotalDue 
				,[Group] AS TerritoryGroup
				,ST.Name AS TerritoryName
				,CASE WHEN LTRIM(RTRIM(CONCAT(FirstName,' ',LastName))) = '' THEN 'No Rep'
						ELSE CONCAT(FirstName,' ',LastName)
				END AS SalesRep
				,ISNULL(JobTitle,'No Job Title') AS JobTitle -- this is not required
				,SP.Name AS ShipState
FROM			Sales.SalesOrderHeader SOH
LEFT JOIN		Sales.SalesTerritory ST
ON				SOH.TerritoryID = ST.TerritoryID
LEFT JOIN		Sales.vSalesPerson VSP
ON				SalesPersonID = BusinessEntityID
LEFT JOIN		Person.Address PA
ON				ShipToAddressID = AddressID
LEFT JOIN		Person.StateProvince SP
ON				SP.StateProvinceID = PA.StateProvinceID

Select		@@SERVERNAME
Select		@@DATEFIRST
-------------------------- test

--Funnel chart related data in sql query to understand it 
SELECT	top 10	 SUM(SOH.TotalDue) as SUMOFTOTAL
				,VSP.FirstName AS SalesRep
FROM			Sales.SalesOrderHeader as SOH
LEFT JOIN		Sales.SalesTerritory as ST
ON				SOH.TerritoryID = ST.TerritoryID
LEFT JOIN		Sales.vSalesPerson as VSP
ON				SalesPersonID = BusinessEntityID
LEFT JOIN		Person.Address as PA
ON				ShipToAddressID = AddressID
LEFT JOIN		Person.StateProvince as SP
ON				SP.StateProvinceID = PA.StateProvinceID
Where			VSP.FirstName is not null
Group by		VSP.FirstName
Order by		SUM(SOH.TotalDue) desc

--- first drill down related

SELECT			 [Group] AS TerritoryGroup
				,ST.Name AS TerritoryName
				,SP.Name AS ShipState
				,ISNULL(VSP.FirstName +' '+VSP.LastName , 'No Rep')  AS SalesRep
				,YEAR(SOH.OrderDate) AS OrderYear 
				,MONTH(SOH.OrderDate) AS OrderMonth
				,SUM(SOH.TotalDue) as TOTALDUE
				--,ISNULL(VSP.JobTitle,'No Job Title') AS JobTitle -- this is not required
				
FROM			Sales.SalesOrderHeader as SOH
LEFT JOIN		Sales.SalesTerritory as ST
ON				SOH.TerritoryID = ST.TerritoryID
LEFT JOIN		Sales.vSalesPerson as VSP
ON				SalesPersonID = BusinessEntityID
LEFT JOIN		Person.Address as PA
ON				ShipToAddressID = AddressID
LEFT JOIN		Person.StateProvince as SP
ON				SP.StateProvinceID = PA.StateProvinceID
Where			 YEAR(SOH.OrderDate) = 2011
Group by		[Group] 
				,ST.Name 
				,SP.Name 
				,ISNULL(VSP.FirstName +' '+VSP.LastName , 'No Rep') 
				,YEAR(SOH.OrderDate) 
				,MONTH(SOH.OrderDate)
				
				--,ISNULL(VSP.JobTitle,'No Job Title') AS JobTitle -- this is not required
				
Order by		[Group] 
				,ST.Name 
				,SP.Name
				,ISNULL(VSP.FirstName +' '+VSP.LastName , 'No Rep')
				  
