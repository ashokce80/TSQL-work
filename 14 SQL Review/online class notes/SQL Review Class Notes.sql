/*
Date: 05/28/2019
Section: SQL Review 
Class: March Online 2019

*/

/* Class work 

Find out sum of Total due for each salesPerson, 
					Tax + Freight amount,
					if Tax + Freight > 10000 Then 'High Tax Group'
					if Tax + Freight > 8000 and < 10000 Then 'Medium Tax Group'
					if Tax + Freight < 8000  Then 'Low Tax Group'
					--column name will be 'Tax group'

Use the table AdventureWorks2016.sales.SalesOrderHeader
					
*/

SELECT		SUM(TotalDue) AS TotalOfTotalDue
			,SUM(TaxAmt + Freight) AS TaxAndFreight
			,CASE WHEN SUM(TaxAmt + Freight) > 10000 THEN 'High Tax Group'
				  WHEN SUM(TaxAmt + Freight) > 8000 AND 
					   SUM(TaxAmt + Freight) < 10000 THEN 'Medium Tax Group'
				 WHEN   SUM(TaxAmt + Freight) < 8000 THEN  'Low Tax Group'
				ELSE 'No Tax Group'
			END AS 	TaxGroup	
			,SalesPersonID	
FROM		AdventureWorks2016.sales.SalesOrderHeader
GROUP BY	SalesPersonID

--> the above query is the same as the query below

SELECT		 SUM(TotalDue) AS TotalOfTotalDue
			,SUM(TaxAmt + Freight) AS TaxAndFreight
			,TaxGroup = CASE WHEN SUM(TaxAmt + Freight) > 10000 THEN 'High Tax Group'
				  WHEN SUM(TaxAmt + Freight) > 8000 AND 
					   SUM(TaxAmt + Freight) < 10000 THEN 'Medium Tax Group'
				 WHEN   SUM(TaxAmt + Freight) < 8000 THEN  'Low Tax Group'
				ELSE 'No Tax Group'
				END
			--END AS 	TaxGroup	
			,SalesPersonID	
FROM		AdventureWorks2016.sales.SalesOrderHeader
GROUP BY	SalesPersonID

/*
Take the above query and create a stored procedure and add the following 
columns SalesPersonFirstName, SalesPersonLastName, JobTitle, TerritoryName
TotalOfTotalDue,TaxAndFreight,TaxGroup
Input parameter will be the Territory Name
*/
--> when you are in the field, you will be provided a data dictionary
	--which will help you find the tables you need to use 
--> you want to use the filter option for the database and look for 
 --tables with the information you need

--> Find a stored procedure using a table

/*
FROM blog.sqlauthority.com

SELECT DISTINCT o.name, o.xtype
FROM syscomments c
INNER JOIN sysobjects o ON c.id=o.id
WHERE c.TEXT LIKE '%SalesOrderHeader%'

*/

--> find tables with a specific column names

/*
SELECT      c.name  AS 'ColumnName'
            ,t.name AS 'TableName'
FROM        sys.columns c
JOIN        sys.tables  t   
ON			c.object_id = t.object_id
WHERE       c.name LIKE '%FirstName%'
ORDER BY    TableName
            ,ColumnName;
*/

IF OBJECT_ID('Tempdb..#BasePop') IS NOT NULL DROP TABLE #BasePop

SELECT		 SUM(TotalDue) AS TotalOfTotalDue
			,SUM(TaxAmt + Freight) AS TaxAndFreight
			,CASE WHEN SUM(TaxAmt + Freight) > 10000 THEN 'High Tax Group'
				  WHEN SUM(TaxAmt + Freight) > 8000 AND 
					   SUM(TaxAmt + Freight) < 10000 THEN 'Medium Tax Group'
				 WHEN   SUM(TaxAmt + Freight) < 8000 THEN  'Low Tax Group'
				ELSE 'No Tax Group'
			END AS 	TaxGroup	
			,SalesPersonID	
			,TerritoryID
INTO		#BasePop
FROM		AdventureWorks2016.sales.SalesOrderHeader
GROUP BY	SalesPersonID,TerritoryID

--> THE QUERY BELOW WILL MAKE YOU USE THE LEFT JOIN TO GRAB ANY NULL RECORDS FROM 
 --> THE AdventureWorks2016.Person.Person TABLE
--SELECT		*
--FROM		AdventureWorks2016.sales.SalesOrderHeader
--WHERE		SalesPersonID IS NULL 

SELECT		*
FROM		AdventureWorks2016.HumanResources.Employee
SELECT		*
FROM	    AdventureWorks2016.Person.Person
SELECT		*
FROM		AdventureWorks2016.Sales.SalesTerritory

SELECT		FirstName,
			LastName,
			E.JobTitle,
			ST.Name AS TerritoryName,
			TotalOfTotalDue,
			TaxAndFreight,
			TaxGroup
FROM		#BasePop B
LEFT JOIN	AdventureWorks2016.HumanResources.Employee E
ON			BusinessEntityID = SalesPersonID
LEFT JOIN	AdventureWorks2016.Person.Person P
ON			p.BusinessEntityID = E.BusinessEntityID
LEFT JOIN   AdventureWorks2016.Sales.SalesTerritory ST
ON			ST.TerritoryID = B.TerritoryID


--> Let's create the stored procedure now that we have the query

-- =============================================
-- Author:		Chantal Togbey
-- Create date: May 28 2019
-- Description:	This stored procedure will determine the tax group based on the
--				total of the tax amount and the freight as well as 
--				provide the salespersonname, job title and territoryname 
--Input Parameter: TerritoryName

------------------------------------------
------------------------------------------
--Change Log:

--Ticket Number 12345 --05/29/2019 --> added a new column 
-- =============================================

GO
CREATE PROCEDURE USP_SalesPersonInfo
@TerritoryName NVARCHAR(20)
AS 
BEGIN
SET NOCOUNT ON;

IF OBJECT_ID('Tempdb..#BasePop') IS NOT NULL DROP TABLE #BasePop

SELECT		 SUM(TotalDue) AS TotalOfTotalDue --CT 05/29/2019
			,SUM(TaxAmt + Freight) AS TaxAndFreight --CT 05/29/2019
			,CASE WHEN SUM(TaxAmt + Freight) > 10000 THEN 'High Tax Group'
				  WHEN SUM(TaxAmt + Freight) > 8000 AND 
					   SUM(TaxAmt + Freight) < 10000 THEN 'Medium Tax Group'
				 WHEN   SUM(TaxAmt + Freight) < 8000 THEN  'Low Tax Group'
				ELSE 'No Tax Group'
			END AS 	TaxGroup	
			,SalesPersonID	
			,TerritoryID
INTO		#BasePop
FROM		AdventureWorks2016.sales.SalesOrderHeader
GROUP BY	SalesPersonID,TerritoryID

SELECT		FirstName,
			LastName,
			E.JobTitle,
			ST.Name AS TerritoryName,
			TotalOfTotalDue,
			TaxAndFreight,
			TaxGroup
FROM		#BasePop B
LEFT JOIN	AdventureWorks2016.HumanResources.Employee E
ON			BusinessEntityID = SalesPersonID
LEFT JOIN	AdventureWorks2016.Person.Person P
ON			p.BusinessEntityID = E.BusinessEntityID
LEFT JOIN   AdventureWorks2016.Sales.SalesTerritory ST
ON			ST.TerritoryID = B.TerritoryID
WHERE		ST.Name = @TerritoryName

END

EXEC USP_SalesPersonInfo 'Canada'

--> Let's alter the stored procedure to handle errors such as someone not putting
--> a parameter for the stored procedure

SELECT	distinct		Name
FROM AdventureWorks2016.Sales.SalesTerritory

EXEC USP_SalesPersonInfo ''

GO
ALTER  PROCEDURE USP_SalesPersonInfo
@TerritoryName NVARCHAR(20)
AS 
BEGIN
SET NOCOUNT ON;

IF OBJECT_ID('Tempdb..#BasePop') IS NOT NULL DROP TABLE #BasePop

SELECT		 SUM(TotalDue) AS TotalOfTotalDue --CT 05/29/2019
			,SUM(TaxAmt + Freight) AS TaxAndFreight --CT 05/29/2019
			,CASE WHEN SUM(TaxAmt + Freight) > 10000 THEN 'High Tax Group'
				  WHEN SUM(TaxAmt + Freight) > 8000 AND 
					   SUM(TaxAmt + Freight) < 10000 THEN 'Medium Tax Group'
				 WHEN   SUM(TaxAmt + Freight) < 8000 THEN  'Low Tax Group'
				ELSE 'No Tax Group'
			END AS 	TaxGroup	
			,SalesPersonID	
			,TerritoryID
INTO		#BasePop
FROM		AdventureWorks2016.sales.SalesOrderHeader
GROUP BY	SalesPersonID,TerritoryID

IF @TerritoryName IS NULL OR @TerritoryName = ''

BEGIN 
			SELECT 'Please enter one of the following Territory name:
					Australia,
					Canada	 ,
					Central	 ,
					France	 ,
					Germany	 ,
					Northeast,
					Northwest,
					Southeast,
					Southwest,
					United Kingdom'
			END 

ELSE 		

SELECT		FirstName,
			LastName,
			E.JobTitle,
			ST.Name AS TerritoryName,
			TotalOfTotalDue,
			TaxAndFreight,
			TaxGroup
FROM		#BasePop B
LEFT JOIN	AdventureWorks2016.HumanResources.Employee E
ON			BusinessEntityID = SalesPersonID
LEFT JOIN	AdventureWorks2016.Person.Person P
ON			p.BusinessEntityID = E.BusinessEntityID
LEFT JOIN   AdventureWorks2016.Sales.SalesTerritory ST
ON			ST.TerritoryID = B.TerritoryID
WHERE		ST.Name = @TerritoryName

END


EXEC		USP_SalesPersonInfo ''

EXEC		USP_SalesPersonInfo 'Southwest'

/*

Retrieve products that were not sold

*/
--121316 rows

SELECT			P.*
FROM			AdventureWorks2016.Production.Product P
INNER JOIN		AdventureWorks2016.Sales.SalesOrderDetail SOD
ON				SOD.ProductID = p.ProductID

--> 121554 rows

SELECT			P.*
FROM			AdventureWorks2016.Production.Product P
LEFT JOIN		AdventureWorks2016.Sales.SalesOrderDetail SOD
ON				SOD.ProductID = p.ProductID

--> 237 rows 

SELECT			P.*
FROM			AdventureWorks2016.Production.Product P
LEFT JOIN		AdventureWorks2016.Sales.SalesOrderDetail SOD
ON				SOD.ProductID = p.ProductID
WHERE			SOD.ProductID IS NULL 

--237 rows

SELECT			P.*
FROM			AdventureWorks2016.Production.Product P
WHERE			NOT EXISTS 
				(SELECT				ProductID
				FROM				AdventureWorks2016.Sales.SalesOrderDetail SOD
				WHERE				SOD.ProductID = p.ProductID
				)			
				
--> retrieve products that were sold

--121316 rows

SELECT			P.*
FROM			AdventureWorks2016.Production.Product P
LEFT JOIN		AdventureWorks2016.Sales.SalesOrderDetail SOD
ON				SOD.ProductID = p.ProductID
WHERE			SOD.ProductID IS NOT NULL 

--121316 rows
			
SELECT			SOD.*
FROM			AdventureWorks2016.Sales.SalesOrderDetail SOD
WHERE			EXISTS 
				(SELECT				ProductID
				FROM				AdventureWorks2016.Production.Product P
				WHERE				SOD.ProductID = p.ProductID
				)	

-----------------------------------------------------------------------------------------
/*

1. Understand different Constraints 
		-- PK 
		-- FK
		-- Default
		-- Check constraints
		-- NOT NULL
		-- Identity

2. System Functions
		--> Strings Functions
			-- substring
			-- Charindex
		--> Date functions
			-- Datediff
			-- DatePart
			-- DateAdd 
			-- DateName

		-- Cast 
		-- Convert -- it has flexibility to use with Different date format
		-- Isnull / Coalesce

3. Temporary Data Structure

		-- Temporary table
				-- Local temp table #
				-- Global temp table ##
		-- Variables
				-- Scalar -- to store single record  
				-- Table  -- to store multiple records/ rows / columns

4. User Defined Functions -- the functions that you create
		 -- Table valued function
		 -- scalar valued function
		 -- joining table udf with a regular table 

5. JOINS
		-- Left join
		-- Right join
		-- Inner join
		-- cross apply 
		-- full outer join
		-- Self join



6. Stored Procedures
		-- while loop inside the stored  proc
		-- Case statement inside the sp
		-- temp table inside sp
		-- udf inside the sp
		-- sp with output param
		-- executing sp within a sp 

7. View

8. Triggers -- to keep track of the changes in specific tables
		1. After Trigger (FOR trigger)
				a. After insert
				b. After Update
				c. After Delete

		2. Instead of										