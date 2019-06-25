/*

Parameters 
March 30th Online Class

*/


--> Reports Dataset

SELECT			 YEAR(OrderDate) AS OrderYear 
				,MONTH(OrderDate) AS OrderMonth
				,TotalDue 
				,[Group] AS TerritoryGroup
				,ST.Name AS TerritoryName
				,ISNULL(FirstName +' '+LastName , 'No Rep') AS SalesRep
				,ISNULL(JobTitle,'None') AS JobTitle -- this is not required
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

--> Order Year Filter 

SELECT	DISTINCT	YEAR(OrderDate) AS OrderYear 
FROM				Sales.SalesOrderHeader SOH
LEFT JOIN			Sales.SalesTerritory ST
ON					SOH.TerritoryID = ST.TerritoryID
LEFT JOIN			Sales.vSalesPerson VSP
ON					SalesPersonID = BusinessEntityID
LEFT JOIN			Person.Address PA
ON					ShipToAddressID = AddressID
LEFT JOIN			Person.StateProvince SP
ON					SP.StateProvinceID = PA.StateProvinceID

--> OR 

SELECT	DISTINCT	YEAR(OrderDate) AS OrderYear 
FROM				Sales.SalesOrderHeader SOH

--> TerritoryGroup Filter

SELECT	DISTINCT   [Group] AS TerritoryGroup
FROM				Sales.SalesTerritory 

--> TerritoryName Filter --> Cascading Parameter

DECLARE @TerritoryGroup VARCHAR(50) = 'North America'

SELECT	DISTINCT    [Name] AS TerritoryName, [Group] AS TerritoryGroup
FROM				Sales.SalesTerritory 
WHERE				[Group] = @TerritoryGroup

--> SSRS 

SELECT	DISTINCT   [Name] AS TerritoryName --, [Group] AS TerritoryGroup
FROM				Sales.SalesTerritory 
WHERE				[Group] IN (@TerritoryGroup)



--> SalesRep Filter 

SELECT DISTINCT ISNULL(FirstName +' '+LastName , 'No Rep') AS SalesRep
FROM			Sales.SalesOrderHeader SOH
LEFT JOIN		Sales.SalesTerritory ST
ON				SOH.TerritoryID = ST.TerritoryID
LEFT JOIN		Sales.vSalesPerson VSP
ON				SalesPersonID = BusinessEntityID
LEFT JOIN		Person.Address PA
ON				ShipToAddressID = AddressID
LEFT JOIN		Person.StateProvince SP
ON				SP.StateProvinceID = PA.StateProvinceID

--We can not use the below query for the salesRep Filter because we need to show the No Rep records

SELECT DISTINCT		ISNULL(FirstName +' '+LastName , 'No Rep') AS SalesRep
FROM				Sales.vSalesPerson

--> JobTitle Filter

SELECT	DISTINCT	ISNULL(JobTitle,'None') AS JobTitle  --> you should use None
FROM				Sales.SalesOrderHeader SOH
LEFT JOIN			Sales.SalesTerritory ST
ON					SOH.TerritoryID = ST.TerritoryID
LEFT JOIN			Sales.vSalesPerson VSP
ON					SalesPersonID = BusinessEntityID
LEFT JOIN			Person.Address PA
ON					ShipToAddressID = AddressID
LEFT JOIN			Person.StateProvince SP
ON					SP.StateProvinceID = PA.StateProvinceID

--> ShipState Filter


SELECT DISTINCT	SP.Name AS ShipState
FROM			Person.Address PA
LEFT JOIN		Person.StateProvince SP
ON				SP.StateProvinceID = PA.StateProvinceID

--> Let's build our parameters in SSRS

   --> Step 1 Add the parameters in your main report dataset 


SELECT			 YEAR(OrderDate) AS OrderYear 
				,MONTH(OrderDate) AS OrderMonth
				,TotalDue 
				,[Group] AS TerritoryGroup
				,ST.Name AS TerritoryName
				,ISNULL(FirstName +' '+LastName , 'No Rep') AS SalesRep
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
WHERE			YEAR(OrderDate) IN (@Year)
AND				[Group] IN (@TerritoryGroup)
AND				ST.Name IN (@TerritoryName)
AND				ISNULL(FirstName +' '+LastName , 'No Rep') IN (@SalesRep)
AND				ISNULL(JobTitle,'No Job Title') IN (@JobTitle)
AND				SP.Name IN (@ShipState)


--> Step 2 Add the dataset for the parameter 

SELECT	DISTINCT	YEAR(OrderDate) AS OrderYear
FROM				Sales.SalesOrderHeader SOH
ORDER BY			YEAR(OrderDate) DESC

--> Step 3 Make changes to the parameter properties 

--> General 
--> Available Values
--> Default Values


---------> SalesRep Name for the Sales By Rep Matrix

--> Use a textbox
--> Drag the parameter @SalesRep
--> Right Click on the parameter and click on Expression
--> =Parameters!SalesRep.Value

--> Make sure you change the properties of the parameter  @SalesRep
 --> uncheck the allow multiple values
 --> do not allow default values