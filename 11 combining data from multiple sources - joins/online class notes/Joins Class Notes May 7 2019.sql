/*
Date: 05/07/2019
Section 11: Combining data from multiple Sources - Joins
Class: March Online 2019 
-----------------------------------------------------------------------
-----------------------------------------------------------------------

*Class Work*
-------------

1.	Create a temporary table and insert AddressID, AddressLine1 , City, stateprovinceId postal code From
	AdventureWorks2016.Person.Address

2.	Create a CTE to show number of employees who are Married and has more than 60 vacation hours
		Table - AdventureWorks2016.HumanResources.Employee

*/

/*
2.	Create a CTE to show number of employees who are Married and has more than 60 vacation hours
		Table - AdventureWorks2016.HumanResources.Employee
*/


SELECT		BusinessEntityID,
			NationalIDNumber,
			JobTitle,
			BirthDate,
			MaritalStatus,
			VacationHours
FROM		AdventureWorks2016.HumanResources.Employee
WHERE		MaritalStatus = 'M'
AND			VacationHours > 60



;
WITH CTE_NbrOfMarriedEmplWith60VacationHours
AS
(
SELECT		COUNT(*) AS NbrofEmployees
FROM		AdventureWorks2016.HumanResources.Employee
WHERE		MaritalStatus = 'M'
AND			VacationHours > 60
)

SELECT		*
FROM		CTE_NbrOfMarriedEmplWith60VacationHours

--> CASE STATEMENT 

--> create three levels for vacation hours in a new column
			--> vacation hours > 70 --> mark as Most Regular
			--> vacation hours in ( 61 - 70) --> Regular
			--> vacation hours in (0-60) --> Part Time

SELECT		BusinessEntityID,
			NationalIDNumber,
			JobTitle,
			BirthDate,
			MaritalStatus,
			VacationHours,
			CASE WHEN VacationHours > 70 THEN 'Most Regular'
				 WHEN VacationHours > 60 AND VacationHours <= 70 THEN 'Regular'
				 ELSE 'Part Time'
			END AS EmployeeGroup
FROM		AdventureWorks2016.HumanResources.Employee

SELECT		BusinessEntityID,
			NationalIDNumber,
			JobTitle,
			BirthDate,
			MaritalStatus,
			VacationHours,
			CASE WHEN VacationHours > 70 THEN 'Most Regular'
				 WHEN VacationHours > 60 AND VacationHours <= 70 THEN 'Regular'
				 WHEN VacationHours >= 0 AND VacationHours <= 60 THEN  'Part Time'
				-- ELSE 'Part Time'
			END AS EmployeeGroup
FROM		AdventureWorks2016.HumanResources.Employee

--> Syntax 
/*

CASE WHEN --Condition --THEN ---Something
	 WHEN --condition -- THEN --Something else
	 ELSE 

*/

-------------------------------------JOIN------------------------------------------------


--> Joins allow us developers to combine results from 2 or more different tables based on a key column

-->3 types of joins
		--> Inner Join 
		--> Outer Join (Left Outer Join , Right Outer Join, Full Outer Join)
		--> Cross Join / Cross Apply


--> Before you can actually join tables
		--> check on referential integrity 
		--> you have to know the key column you are using to join the tables
		--> you have to understand the relationship between the tables 

--INNER JOIN  <--> JOIN

USE MarchOnline2019
GO

CREATE TABLE  Section 
			         (
					 SectionID INT PRIMARY KEY IDENTITY(100, 1),
					 SectionName NVARCHAR(255),
					 SectionDescription NVARCHAR(255),
					 EstimatedHrsToComplete INT
					 )

CREATE TABLE Student
					(
					StudentID INT PRIMARY KEY IDENTITY(1 ,1),
					SectionID INT FOREIGN KEY REFERENCES Section(SectionID),
					StudentName NVARCHAR(255),
					SectionCompletionDate DATETIME,
					ClassName NVARCHAR(255),
					ClassType NVARCHAR(255)
					)

INSERT INTO		Section (SectionName,SectionDescription,EstimatedHrsToComplete)
SELECT			'Working with Tables', 'Learn how to create tables and use tables in SQL', 4
UNION 
SELECT			'System Functions', 'Learn how to use SQL Server System Functions', 6
UNION 
SELECT			'Temporary Data Structure', 'Learn how to use Temp table and CTEs', 5

SELECT			*
FROM			dbo.Section

INSERT INTO		Student(SectionID, StudentName, SectionCompletionDate,ClassName,ClassType)

SELECT			100, 'Chantal', '01/25/2019', 'January 2019', 'Online'
UNION 
SELECT			102, 'Mika', '01/30/2019', 'January 2019', 'Onsite'

SELECT			*
FROM			dbo.Section

SELECT			*
FROM			dbo.Student

--> INNER JOIN: it will only give you the matching records 

		--Key column ==> SECTIONID

SELECT			*
FROM			dbo.Section

SELECT			*
FROM			dbo.Student

--> get all the columns from the student table and the section table

SELECT			Se.SectionID,
				Se.SectionName,
				Se.SectionDescription,
				Se.EstimatedHrsToComplete,
				St.StudentID,
				St.SectionID,
				St.StudentName,
				St.SectionCompletiondate,
				St.ClassName,
				St.ClassType
FROM			dbo.Section AS Se  --> left table
INNER JOIN		dbo.Student AS St  --> right table
ON				Se.SectionID = St.SectionID   --> Key Column


SELECT			SectionID,
				Se.SectionName,
				Se.SectionDescription,
				Se.EstimatedHrsToComplete,
				St.StudentID,
				SectionID,
				St.StudentName,
				St.SectionCompletiondate,
				St.ClassName,
				St.ClassType
FROM			dbo.Section AS Se  --> left table
INNER JOIN		dbo.Student AS St  --> right table
ON				Se.SectionID = St.SectionID   --> Key Column

/* if you do get the below error message 

Msg 209, Level 16, State 1, Line 177
Ambiguous column name 'SectionID'.
Msg 209, Level 16, State 1, Line 182
Ambiguous column name 'SectionID'.


it means that you need to provide an alias name to before the column name

*/

SELECT			*
FROM			AdventureWorks2016.Sales.SalesOrderDetail

SELECT			*
FROM			AdventureWorks2016.Production.Product

--> Let's retrieve all products that were sold ( LineTotal, ProductID, ProductName, OrderQty)

SELECT			SOD.ProductID,
				P.Name as ProductName,
				SOD.LineTotal,
				SOD.OrderQty
FROM			AdventureWorks2016.Sales.SalesOrderDetail SOD
INNER JOIN		AdventureWorks2016.Production.Product P
ON				SOD.ProductID = P.ProductID


SELECT			SOD.ProductID,
				P.Name as ProductName,
				SUM(SOD.LineTotal) AS SumOfLineTotal --,
				--SOD.OrderQty
FROM			AdventureWorks2016.Sales.SalesOrderDetail SOD
INNER JOIN		AdventureWorks2016.Production.Product P
ON				SOD.ProductID = P.ProductID
GROUP BY		P.Name, 
				SOD.ProductID


-------->OUTER JOIN  

--> LEFT OUTER JOIN   <--> LEFT JOIN 
	--> all the records in the left table ( table before the left join) and only the matching records from the right tables
	 --> anything that does not match in the left table will have NULL values.

SELECT			Se.SectionID,
				Se.SectionName,
				Se.SectionDescription,
				Se.EstimatedHrsToComplete,
				St.StudentID,
				St.SectionID,
				St.StudentName,
				St.SectionCompletiondate,
				St.ClassName,
				St.ClassType
FROM			dbo.Section AS Se  --> left table
LEFT JOIN		dbo.Student AS St  --> right table
ON				Se.SectionID = St.SectionID 

SELECT			*
FROM			dbo.Section

SELECT			*
FROM			dbo.Student

SELECT			Se.SectionID,
				Se.SectionName,
				Se.SectionDescription,
				Se.EstimatedHrsToComplete,
				St.StudentID,
				St.SectionID,
				St.StudentName,
				St.SectionCompletiondate,
				St.ClassName,
				St.ClassType
FROM			dbo.Student AS St --> left table
LEFT JOIN		dbo.Section AS Se  --> right table
ON				Se.SectionID = St.SectionID 


--> 121317 rows

SELECT			SOD.ProductID,
				P.Name as ProductName,
				SOD.LineTotal,
				SOD.OrderQty
FROM			AdventureWorks2016.Sales.SalesOrderDetail SOD
INNER JOIN		AdventureWorks2016.Production.Product P
ON				SOD.ProductID = P.ProductID

--> 121317 rows

SELECT			SOD.ProductID,
				P.Name as ProductName,
				SOD.LineTotal,
				SOD.OrderQty
FROM			AdventureWorks2016.Sales.SalesOrderDetail SOD
LEFT JOIN		AdventureWorks2016.Production.Product P
ON				SOD.ProductID = P.ProductID

--> 121555 rows
SELECT			SOD.ProductID,
				P.Name as ProductName,
				SOD.LineTotal,
				p.ProductID,
				SOD.OrderQty
FROM			AdventureWorks2016.Production.Product P  --> all the products available 
LEFT JOIN		AdventureWorks2016.Sales.SalesOrderDetail SOD --> products sold
ON				SOD.ProductID = P.ProductID


SELECT			COUNT(*)AS ProductTable  
				--,
				--P.Name as ProductName,
				--SOD.LineTotal,
				--p.ProductID,
				--SOD.OrderQty
FROM			AdventureWorks2016.Production.Product P  --> all the products available 
LEFT JOIN		AdventureWorks2016.Sales.SalesOrderDetail SOD --> products sold
ON				SOD.ProductID = P.ProductID


SELECT			SOD.ProductID,
				P.Name as ProductName,
				SOD.LineTotal,
				P.ProductID,
				SOD.OrderQty
FROM			AdventureWorks2016.Production.Product P  --> all the products available 
INNER JOIN		AdventureWorks2016.Sales.SalesOrderDetail SOD --> products sold
ON				SOD.ProductID = P.ProductID

--SELECT			SOD.ProductID,
--				P.Name as ProductName,
--				SOD.LineTotal,
SELECT			COUNT(*) AS ProductSoldTable --,
				--SOD.OrderQty) 
FROM			AdventureWorks2016.Production.Product P  --> all the products available 
INNER JOIN		AdventureWorks2016.Sales.SalesOrderDetail SOD --> products sold
ON				SOD.ProductID = P.ProductID

--> RIGHT JOIN  -->ALL THE records in the right table and only matching values from the left table

SELECT			Se.SectionID,
				Se.SectionName,
				Se.SectionDescription,
				Se.EstimatedHrsToComplete,
				St.StudentID,
				St.SectionID,
				St.StudentName,
				St.SectionCompletiondate,
				St.ClassName,
				St.ClassType
FROM			dbo.Section AS Se  --> left table
RIGHT JOIN		dbo.Student AS St  --> right table
ON				Se.SectionID = St.SectionID 

SELECT			*
FROM			dbo.Section

SELECT			*
FROM			dbo.Student

SELECT			Se.SectionID,
				Se.SectionName,
				Se.SectionDescription,
				Se.EstimatedHrsToComplete,
				St.StudentID,
				St.SectionID,
				St.StudentName,
				St.SectionCompletiondate,
				St.ClassName,
				St.ClassType
FROM			dbo.Student AS St  --> left table
LEFT JOIN		dbo.Section AS Se  --> right table
ON				Se.SectionID = St.SectionID 

--> FULL OUTER JOIN  <--> FULL JOIN 
				--> Returns all the values from both tables and it will diplay NULL values 
				 --> from both table

SELECT			Se.SectionID,
				Se.SectionName,
				Se.SectionDescription,
				Se.EstimatedHrsToComplete,
				St.StudentID,
				St.SectionID,
				St.StudentName,
				St.SectionCompletiondate,
				St.ClassName,
				St.ClassType
FROM			dbo.Student AS St  --> left table
FULL OUTER JOIN	dbo.Section AS Se  --> right table
ON				Se.SectionID = St.SectionID 


--> CROSS JOIN Returns a result set which is the number of rows in the first table multiplied by the 
  --> number of rows in the second table. This is also a cartesian join.

SELECT			Se.SectionID,
				Se.SectionName,
				Se.SectionDescription,
				Se.EstimatedHrsToComplete,
				St.StudentID,
				St.SectionID,
				St.StudentName,
				St.SectionCompletiondate,
				St.ClassName,
				St.ClassType
FROM			dbo.Student AS St  --> left table
CROSS JOIN		dbo.Section AS Se  --> right table


--> 3 types of relationships

/* -- One to One relationship between two tables
 For a value in the first table, there is one a matching a value in the second table
 --> you can join both tables
 dbo.Student  and dbo.Section

*/
	

/* One to Many relationshiop between two tables

For one value in the first table you have multiple matching values in the second table
--> you can join both tables

*/

SELECT			*
FROM		    AdventureWorks2016.Production.Product
WHERE			ProductID =  776

SELECT			*
FROM			AdventureWorks2016.Sales.SalesOrderDetail
WHERE			ProductID = 776


/* Many to Many relationships between two tables

both tables are pulling multiple rows for a specific value ( Do not join those two tables)

*/


SELECT			*
FROM		    AdventureWorks2016.Production.Product

SELECT			*
FROM			AdventureWorks2016.Sales.SalesOrderDetail

SELECT			*--> SalesPersonID, OrderDate, SalesOrderID, ShipDate, TotalDue, TerritoryID
FROM			AdventureWorks2016.Sales.SalesOrderHeader AS SOH

SELECT			* --> TerritoryID, Name, Group, SalesYTD, SalesLastYear
FROM			AdventureWorks2016.Sales.SalesTerritory AS ST

SELECT			* --> TerritoryID , StartDate, EndDate
FROM			AdventureWorks2016.Sales.SalesTerritoryHistory AS STH

SELECT			SOH.SalesPersonID,SOH.OrderDate,SOH.SalesOrderID,SOH.ShipDate, SOH.TotalDue, SOH.TerritoryID,
				ST.TerritoryID, ST.Name AS TerritoryName, ST.[Group] AS TerritoryGroup, ST.SalesYTD, ST.SalesLastYear,
				STH.TerritoryID, STH.StartDate, STH.EndDate
FROM			AdventureWorks2016.Sales.SalesOrderHeader SOH
LEFT JOIN		AdventureWorks2016.Sales.SalesTerritory ST 
ON				SOH.TerritoryID = ST.TerritoryID
LEFT JOIN		AdventureWorks2016.Sales.SalesTerritoryHistory AS STH
ON				SOH.TerritoryID = STH.TerritoryID


--> include the territoryName and TerritoryGroup

SELECT		emp.BusinessEntityID,
			NationalIDNumber,
			JobTitle,
			BirthDate,
			MaritalStatus,
			VacationHours,
			ISNULL(CAST(STH.TerritoryID AS VARCHAR(15)),'No TerritoryID') AS TerritoryID
FROM		AdventureWorks2016.HumanResources.Employee emp
LEFT JOIN	AdventureWorks2016.Sales.SalesTerritoryHistory AS STH
ON			Emp.BusinessEntityID = STH.BusinessEntityID
WHERE		MaritalStatus = 'M'
--AND			VacationHours > 60

--> OR

SELECT		emp.BusinessEntityID,
			NationalIDNumber,
			JobTitle,
			BirthDate,
			MaritalStatus,
			VacationHours,
			CASE WHEN CAST(STH.TerritoryID AS VARCHAR(15)) IS NULL THEN 'No TerritoryID'
			     ELSE CAST(STH.TerritoryID AS VARCHAR(15)) 
		    END AS TerritoryID
FROM		AdventureWorks2016.HumanResources.Employee emp
LEFT JOIN	AdventureWorks2016.Sales.SalesTerritoryHistory AS STH
ON			Emp.BusinessEntityID = STH.BusinessEntityID
WHERE		MaritalStatus = 'M'