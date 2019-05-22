/*

Date: 05/04/2019
Section: Implementating best practices for Temporary Data Structure
Class: March Online 2019 

*/
---------------DON'T FORGET TO MARK YOURSELF AS PRESENT-----------------------
/*
Class work:

1. Use AdventureWorks2016.Person.Address Table.
   Create an UDF to return AddressID, AddressLine1, City, StateProvinceID and PostalCode.
	**Parameter to be passed CITY**

2. Use Sales.SalesOrderDetail table.
   Create an UDF to find out most expensive product for each salesOrderID. Return a table with columns
    "SalesOrderID, MaxUnitPrice
	- parameter to be passed SalesOrderID

3. Use Sales.CreditCard table
   Create an UDF to retun all the Credit card which are expiring next month
	- Parameter to be passed Card Type

4. Use Sales.SalesOrderHeader
   Create an UDF to return TotalSales/TotalDue for each Year (use DueDate column for the calculation)
   - Paramerter To be passed Year.

*/

/*
2. Use Sales.SalesOrderDetail table.
   Create an UDF to find out most expensive product for each salesOrderID. Return a table with columns
   "SalesOrderID, MaxUnitPrice
  - parameter to be passed SalesOrderID
*/

GO
CREATE FUNCTION UDF_GetExpensiveProduct
(@SalesOrderID INT)
RETURNS TABLE 
AS 
RETURN 
 (
		SELECT SalesOrderId, MAX(UnitPrice) as MaxUnitPrice
		FROM	AdventureWorks2016.Sales.SalesOrderDetail
		WHERE	SalesOrderId = @SalesOrderID
		GROUP BY SalesOrderId
	)
GO

SELECT		SalesOrderId, UnitPrice
FROM		AdventureWorks2016.Sales.SalesOrderDetail
WHERE		SalesOrderID = 43664 

SELECT			*
FROM			UDF_GetExpensiveProduct(43664)

/*
3. Use Sales.CreditCard table
   Create an UDF to retun all the Credit card which are expiring next month
	- Parameter to be passed Card Type
*/

--to retun all the Credit card which are expiring next month

SELECT			*
FROM			AdventureWorks2016.Sales.CreditCard
WHERE			ExpMonth = DATEPART(MM, GETDATE()) + 1 
AND				CardType = 'Distinguish'

SELECT			DATEPART(MM, GETDATE()) + 1 AS NextMonth --This month that we are currently in 

GO
CREATE FUNCTION UDF_GetCardExpNextMonth
(@CardType VARCHAR(25))
RETURNS TABLE
AS 
RETURN
(
SELECT			*
FROM			AdventureWorks2016.Sales.CreditCard
WHERE			ExpMonth = DATEPART(MM, GETDATE()) + 1 
AND				CardType = @CardType
)
GO

SELECT			*
FROM			UDF_GetCardExpNextMonth('Vista')

--------------------------TEMPORARY DATA STRUCTURE-------------------------

/* Temporary Table --> Temp Table

--> 2 types of temporary tables --> Temporary tables are stored in the tempdb database

		--> 1. Local Temp Table - #
		--> Scope of the local temp table
							--Limited to current session 
							--current user 
							--The local temp table automatically drop when closing current connection
		--> 2. Global Temp Table - ##
			--Scope of the global temp table:
			 --They are available to any connection once created, and they are dropped 
			   --when the last connection using it is closed
*/


--Local Temp Table

CREATE TABLE #FirstTempTable (
								ID INT,
								[Name] VARCHAR(250),
								Amount MONEY,
								TransactionDate DATE
							 )

SELECT			*
FROM			#FirstTempTable

INSERT INTO		#FirstTempTable
SELECT			1,'John', 250, '2019-05-04'


SELECT		*
FROM		#FirstTempTable


SELECT		*
INTO		#TempEmployee  --> create the temp table and insert records at the same time
FROM		AdventureWorks2016.HumanResources.Employee

SELECT		*
FROM		#TempEmployee

--Best practice is always check if the temp table exists or not

IF OBJECT_ID('Tempdb..#TempEmployee') IS NOT NULL DROP TABLE #TempEmployee

 /*
 
 'Tempdb..#TempEmployee' -->DatabaseName --> SchemaName --> TableName

 */

SELECT		*
INTO		#TempEmployee  --> create the temp table and insert records at the same time
FROM		AdventureWorks2016.HumanResources.Employee
WHERE		Jobtitle LIKE 'Research and Development%'

SELECT		*
FROM		#TempEmployee 

DELETE FROM #TempEmployee 
WHERE		BusinessEntityID = 10

SELECT		*
FROM		#TempEmployee 

UPDATE		#TempEmployee
SET			JobTitle = 'Research and Development Manager'
WHERE		BusinessEntityID = 8

SELECT		*
FROM		#TempEmployee


TRUNCATE TABLE #TempEmployee

SELECT		*
FROM		#TempEmployee


--> What are the differences between a temp table and a physical table?
/*

1-Storage: Tempdb VS Database specified
2-Usage: Temp tables get dropped automatically when you close the session 
and Physical do not get dropped when you close the session (unless you drop it yourself)
3-Temp tables are only available to the current session and user 
while physical tables are available to anyone that has access to the database where the table is
4- Temp tables start with a # and Physical table do not

*/

/*
 Create a local Temporary table and store all the data for the group North America
 from the table Sales.SalesTerritory table

 */

 SELECT				*
 FROM			   AdventureWorks2016.Sales.SalesTerritory
 WHERE				[Group] = 'North America'

 --INTO Method

 IF OBJECT_ID('Tempdb..#NorthAmericaGroup') IS NOT NULL DROP TABLE #NorthAmericaGroup

 SELECT				*
 INTO				#NorthAmericaGroup
 FROM			    AdventureWorks2016.Sales.SalesTerritory
 WHERE				[Group] = 'North America'

 SELECT				*
 FROM				#NorthAmericaGroup

 --INSERT INTO Method

 IF OBJECT_ID('Tempdb..#NorthAmericaGroup') IS NOT NULL DROP TABLE #NorthAmericaGroup


 CREATE TABLE	#NorthAmericaGroup(	   TerritoryID INT,
									   TerritoryName NVARCHAR(25),
									   TerritoryGroup NVARCHAR(25),
									   SalesYTD FLOAT,
									   SalesLastYEar FLOAT
									)

INSERT INTO #NorthAmericaGroup(TerritoryID, TerritoryName, TerritoryGroup,SalesYTD, SalesLastYEar)

SELECT		 TerritoryID,
			 [Name],
			 [Group],
			 SalesYTD,
			 SalesLastYEar
FROM		 AdventureWorks2016.Sales.SalesTerritory
WHERE		 [Group] = 'North America'

SELECT		 *
FROM		 #NorthAmericaGroup

--> To find the information about a table for example [Sales].[SalesTerritory]
 --Make sure you change the database to the one where the table is in

EXEC		SP_HELP'[Sales].[SalesTerritory]' --> Table information 

-->To find the code used in the function [dbo].[UDF_GetCardExpNextMonth]
  --use the below query
   --Make sure you change the database to the one where the function is in

SELECT		OBJECT_DEFINITION(OBJECT_ID('[dbo].[UDF_GetCardExpNextMonth]')) AS FunctionDefinition 



/*
CREATE FUNCTION UDF_GetCardExpNextMonth  (@CardType VARCHAR(25)) 
 RETURNS TABLE  
 AS   RETURN  
   (  SELECT   *  
       FROM   AdventureWorks2016.Sales.CreditCard  
      WHERE   ExpMonth = DATEPART(MM, GETDATE()) + 1   
	  AND    CardType = @CardType  )
 */



/*

Create a local temp table that has the territory group, average cost year to date 
and the sum of the total sales YTD.
Use the INTO method

*/


SELECT			*
FROM			AdventureWorks2016.Sales.SalesTerritory

IF OBJECT_ID('tempdb..#TerritorySales') IS NOT NULL DROP TABLE #TerritorySales


SELECT			[Group] AS TerritoryGroup,
				AVG(CostYTD) AS AverageCostYTD,
				SUM(SalesYTD) AS YearlySalesYTD
INTO			#TerritorySales
FROM			AdventureWorks2016.Sales.SalesTerritory
GROUP BY		[Group]

SELECT			*
FROM			#TerritorySales


--> Global Temporary Tables

IF OBJECT_ID('Tempdb..##NorthAmericaGroup') IS NOT NULL DROP TABLE ##NorthAmericaGroup

 CREATE TABLE	##NorthAmericaGroup(   TerritoryID INT,
									   TerritoryName NVARCHAR(25),
									   TerritoryGroup NVARCHAR(25),
									   SalesYTD FLOAT,
									   SalesLastYEar FLOAT
									)

INSERT INTO ##NorthAmericaGroup(TerritoryID, TerritoryName, TerritoryGroup,SalesYTD, SalesLastYEar)

SELECT		 TerritoryID,
			 [Name],
			 [Group],
			 SalesYTD,
			 SalesLastYEar
FROM		 AdventureWorks2016.Sales.SalesTerritory
WHERE		 [Group] = 'North America'

SELECT		 *
FROM		 ##NorthAmericaGroup


------------------------CTE-------------------------------------------
/* CTE (Common Table Expression)

--> Everytime you create a CTE, it has to be followed by 
		SELECT , DELETE, UPDATE, INSERT

--> Syntax 

WITH CTE_Name
AS 

(

 Your code goes here


)

SELECT			*
FROM			CTE_Name

*/


--Create a CTE to get the female employees from HumanResources.Employee

SELECT			*
FROM			AdventureWorks2016.HumanResources.Employee


GO
WITH   CTE_MyFirstCTE
AS 

	(SELECT  BusinessEntityID,
			 LoginID,
			 JobTitle,
			 Birthdate,
			 MaritalStatus,
			 Gender,
			 HireDate
	FROM	 AdventureWorks2016.HumanResources.Employee
	)  


SELECT		*
FROM		CTE_MyFirstCTE
WHERE		Gender = 'F'

--Same thing as below query difference 

IF OBJECT_ID('Tempdb..#TempStoreResultsfromCTE') IS NOT NULL DROP TABLE #TempStoreResultsfromCTE

CREATE TABLE  #TempStoreResultsfromCTE( BusinessEntityID INT,
										LoginID NVARCHAR(255),
										JobTitle NVARCHAR(255),
										BirthDate DATE,
										MaritalStatus NVARCHAR(5),
										Gender NVARCHAR(5),
										HireDate DATE
										)

;
WITH  

CTE_MyFirstCTE
AS 

	(SELECT  BusinessEntityID,
			 LoginID,
			 JobTitle,
			 Birthdate,
			 MaritalStatus,
			 Gender,
			 HireDate
	FROM	 AdventureWorks2016.HumanResources.Employee
	)  

INSERT INTO		#TempStoreResultsfromCTE
SELECT			*
FROM			CTE_MyFirstCTE
WHERE			Gender = 'F'

SELECT			*
FROM			#TempStoreResultsfromCTE

--> How to remove duplicates using CTE

IF OBJECT_ID('dbo.Sports', 'U') IS NOT NULL DROP TABLE dbo.Sports

--> U is for User Defined Table (as opposed to system tables)

CREATE TABLE    dbo.Sports( SportID INT IDENTITY(1,1),
							SportName VARCHAR(50),
							PlayerName VARCHAR(50)
							)
SELECT			*
FROM			dbo.Sports

INSERT INTO     dbo.Sports(SportName, PlayerName)
VALUES			('BasketBall', 'Kobe Bryant'),
				('FootBall','Barry Sanders'),
				('BasketBall','Michael Jordan'),
				('BasketBall','Michael Jordan'),
				('FootBall','Peyton Manning')

SELECT			*
FROM			dbo.Sports

SELECT			*
INTO			Sports_BackUp
FROM			dbo.Sports

SELECT			*
FROM			Sports_BackUp

--> Remove Duplications

;
WITH CTE_Sports  --(SportID, Sport, Player, Duplicate)
AS
(
		SELECT	SportID, 
				SportName, 
				PlayerName,
				ROW_NUMBER() OVER ( PARTITION BY SportName, PlayerName  ORDER BY SportName) AS Duplicate
		FROM	dbo.Sports
)

DELETE FROM  CTE_Sports
WHERE	     Duplicate > 1	

SELECT		*
FROM		CTE_Sports

--OR

--SELECT			*
--FROM			CTE_Sports
--WHERE			Duplicate = 1

SELECT				*
FROM				Sports

/* please go over the page 

https://docs.microsoft.com/en-us/sql/t-sql/functions/row-number-transact-sql?view=sql-server-2017

*/

--This is how you use a temp table to see the results before deleting the duplicate records from the physical table Sports

IF OBJECT_ID('Tempdb..#Temp') IS NOT NULL DROP TABLE #Temp

SELECT	SportID, 
		SportName, 
		PlayerName,
		ROW_NUMBER() OVER ( PARTITION BY SportName, PlayerName  ORDER BY SportName) AS Duplicate
INTO	#Temp
FROM	Sports_BackUp


SELECT		*
FROM		#Temp
WHERE		Duplicate = 1


SELECT		*,
			ROW_NUMBER() OVER(ORDER BY SportName DESC) AS RN
FROM		Sports_BackUp

SELECT		*,
			ROW_NUMBER() OVER(ORDER BY SportName ) AS RN
FROM		Sports_BackUp


SELECT		*,
			RN = ROW_NUMBER() OVER (PARTITION BY PlayerName ORDER BY PlayerName ) 
INTO		#Dupe
FROM		Sports_BackUp



SELECT		*
FROM		#Dupe
WHERE		RN = 1

DELETE FROM Sports_BackUp
WHERE		SportID = 4 

 --In the query above we are hardcoding to remove the duplicate records
--with millions of records i need to use a CTE to make that happen 

;
WITH CTE_Sports  --(SportID, Sport, Player, Duplicate)
AS
(
		SELECT	SportID, 
				SportName, 
				PlayerName,
				ROW_NUMBER() OVER ( PARTITION BY SportName, PlayerName  ORDER BY SportName) AS Duplicate
		FROM	Sports_BackUp
)

DELETE FROM  CTE_Sports
WHERE	     Duplicate > 1	


SELECT				*
FROM				Sports_BackUp



