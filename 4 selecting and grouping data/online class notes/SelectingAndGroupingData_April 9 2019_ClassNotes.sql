/*

Date: 04/13/2019
Section: Selecting and Grouping Data
Class: March30Online2019

*/


/*
Using Adventureworks:
 
1.       Production.Product table:  find all gloves in the table. 
2.       Sales.CreditCard table: get all Credit cards that expire October 2006.
3.       Sales.Customer table: get all customers that have a Territory ID between 5-10.
4.       Purchasing.ShipMethod: all ship methods where the ship rate is 1.99 or 2.99.
5.       Find the Adventureworks table where you can execute a statement to show the
		 Canadian Sales rates with the tax type of 2 or 3.
6.       Find the Adventureworks table containing Sales contacts.( to do as homework)
7.       table: show info on all bikes that are not blue or red. 
 
*/

--1.       Production.Product table:  Find all gloves in the table. 

SELECT		*
FROM		AdventureWorks2016.Production.Product
WHERE		[Name] LIKE '%Gloves%'

--2.       Sales.CreditCard table: get all Credit cards that expire October 2006.

SELECT		*
FROM		AdventureWorks2016.Sales.CreditCard
WHERE		ExpMonth LIKE 10
AND			ExpYear LIKE 2006

--or

SELECT		*
FROM		AdventureWorks2016.Sales.CreditCard
WHERE		ExpMonth = 10
AND			ExpYear = 2006

--or

SELECT		*
FROM		AdventureWorks2016.Sales.CreditCard
WHERE		ExpYear= 2006
AND			ExpMonth = 10


--3.       Sales.Customer table: get all customers that have a Territory ID between 5-10.

SELECT		*
FROM		AdventureWorks2016.Sales.Customer
WHERE		TerritoryID IN (5,10)  --> wrong
--or
SELECT		*
FROM		AdventureWorks2016.Sales.Customer
WHERE		TerritoryID IN (5,6,7,8,9,10)  --> correct
--or
SELECT		*
FROM		AdventureWorks2016.Sales.Customer
WHERE		TerritoryID BETWEEN 5 AND 10  --> correct
--or
SELECT		*
FROM		AdventureWorks2016.Sales.Customer
WHERE		TerritoryID >= 5 
AND			TerritoryID <= 10  --> correct

--> Need to know the available values in the column TerritoryID

SELECT		DISTINCT TerritoryID
FROM		AdventureWorks2016.Sales.Customer

--or
SELECT		*
FROM		AdventureWorks2016.Sales.Customer
WHERE		TerritoryID NOT IN (1,2,3,4)

--4.       Purchasing.ShipMethod: all ship methods where the ship rate is 1.99 or 2.99.

SELECT		*
FROM		AdventureWorks2016.Purchasing.ShipMethod
WHERE		ShipRate = 1.99
OR			ShipRate = 2.99

SELECT		*
FROM		AdventureWorks2016.Purchasing.ShipMethod
WHERE		ShipRate LIKE 1.99  --> With LIKE
OR			ShipRate LIKE 2.99



--> ORDER BY 

SELECT		*
FROM		AdventureWorks2016.Sales.Customer
WHERE		TerritoryID BETWEEN 5 AND 10  
ORDER BY	TerritoryID DESC --> Descending Order from the highest number to the lowest number for TerritoryID

SELECT		*
FROM		AdventureWorks2016.Sales.Customer
WHERE		TerritoryID BETWEEN 5 AND 10  
ORDER BY	TerritoryID ASC --> Ascending is from the lowest number to the highest number for TerritoryID

SELECT		*
FROM		AdventureWorks2016.Sales.Customer
WHERE		TerritoryID BETWEEN 5 AND 10  
ORDER BY	TerritoryID  --> Not writing anything after the column name will be ASC as ASC is the default order for ORDER BY


SELECT		*
FROM		AdventureWorks2016.Sales.Customer
WHERE		TerritoryID BETWEEN 5 AND 10  
ORDER BY	CustomerID DESC, TerritoryID DESC

SELECT		*
FROM		AdventureWorks2016.Sales.Customer
WHERE		StoreID IS NOT NULL  --> i do not want to see the missing values
ORDER BY	TerritoryID DESC, StoreID DESC



SELECT		*
FROM		AdventureWorks2016.Sales.Customer
WHERE		StoreID IS NOT NULL  --> i do not want to see the missing values
ORDER BY	TerritoryID DESC, StoreID 

--> Find Customers that do not have a storeID

SELECT		*
FROM		AdventureWorks2016.Sales.Customer
WHERE		StoreID IS NULL --> Missing records

--5.       Find the Adventureworks table where you can execute a statement to show the
--		   Canadian Sales rates with the tax type of 2 or 3.

SELECT		*
FROM		[AdventureWorks2016].[Sales].[SalesTaxRate]
WHERE		[Name] LIKE 'Canadian%'
AND			(TaxType = 2 OR TaxType = 3)  

--or
SELECT		*
FROM		[AdventureWorks2016].[Sales].[SalesTaxRate]
WHERE		[Name] LIKE 'Canadian%'
AND			TaxType IN (2,3) --> same as (TaxType = 2 OR TaxType = 3)  

-- 6.       Find the Adventureworks table containing Sales contacts.(Do as homework for next class)

--7.       table: show info on all bikes that are not blue or red. 

SELECT		*
FROM		AdventureWorks2016.Production.Product
WHERE		Color NOT IN ('blue', 'red')
AND			Name LIKE '%bike%'


SELECT		*
FROM		AdventureWorks2016.Production.Product
WHERE		Color NOT IN ('blue', 'red')
AND			Name LIKE '%bike%'

/*
Using your database
         Add 5 records to the employee table. 
         Add 3 rows to the table using the Script to new query window.
         Now add an additional row, but do not enter data into the DeptID column.
         Manually write the script (Insert statement) to Insert 3 records to the Dept table
         Create a table using the Select Into statement.
         Insert into table using the select statement. 
*/

USE			MarchOnline2019

SELECT		*
FROM		Employee

INSERT INTO dbo.Employee (EmployeeName, DepartmentID)
SELECT		'Chris', 10

--> The above will not execute because the table Employee does not allow NULL values
	-- in the column EmployeeID



-->  Create a table EmployeeBackUp using the Select Into statement.

SELECT		*
INTO		EmployeeBackUp  --> Create a new table and insert records at the same time
FROM		Employee

SELECT		*
FROM		EmployeeBackUp

--> Delete the record for EmployeeID 15 from the table EmployeeBackUp

DELETE FROM EmployeeBackUp
WHERE		EmployeeID = 15

SELECT		*
FROM		EmployeeBackUp

--> Delete all records in the EmployeeBackUp table

DELETE FROM EmployeeBackUp

SELECT		*
FROM		EmployeeBackUp

--> To insert records back into the EmployeeBackUp table 

INSERT INTO EmployeeBackUp
SELECT		*
FROM		Employee

SELECT		*
FROM		EmployeeBackUp

--> TRUNCATE TABLE --> Deletes all the records at once

SELECT		*
INTO		EmployeeBackUp2
FROM		Employee



TRUNCATE TABLE EmployeeBackUp2

SELECT		*
FROM		EmployeeBackUp2

USE AdventureWorks2016

CREATE SCHEMA Colaberry --> This is how you create a schema
 --> What is a schema? Logical Grouping of data in a database


SELECT		*
INTO		 AdventureWorks2016.Colaberry.Customer_BackUp--> creating a table in Adventureworks2016
			-- using the schema Colaberry
FROM		AdventureWorks2016.Sales.Customer

SELECT		*
FROM		Colaberry.Customer_BackUp

--You can use the SELECT INTO to create a table and copy records from one database
	-- to another database

SELECT		*
INTO		MarchOnline2019.dbo.CustomerBackUp --MarchOnline2019 database
FROM		AdventureWorks2016.Sales.Customer -- Adventureworks database


USE AdventureWorks2016

CREATE TABLE AdventureWorks2016.Colaberry.ClassTest (TestID INT,
													 TestName NVARCHAR(25),
													 TestDate Date
													 )

SELECT		*
FROM		Colaberry.ClassTest

USE MarchOnline2019

DROP TABLE Student

CREATE TABLE Student 
(
StudentID INT,
StudentName VARCHAR(50),
StudentClass VARCHAR(50),
StudentAge INT,
StudentRank INT,
TestScore INT
)
SELECT			*
FROM			Student

INSERT INTO dbo.Student
SELECT 1,'Jack','Freshman',18,1,100
Union
SELECT 2,'Mike','Sophomore',19,3,85
Union
SELECT 3,'Ralph','Junior',20,2,95
Union
SELECT 4,'Kishan','Freshman',19,1,93
Union
SELECT 5,'Ali','Sophomore',19,2,91
Union
SELECT 6,'Terrel','Junior',20,3,87
Union
SELECT 7,'Anand','Freshman',20,3,86
Union
SELECT 8,'Sai','Sophomore',21,1,99
Union
SELECT 9,'Larry','Junior',22,1,98
Union
SELECT 10,'Deion','Freshman',18,4,82
Union
SELECT 11,'Sammy','Senior',21,4,81
Union
SELECT 12,'Ralph','Senior',22,3,87
Union
SELECT 13,'Simon','Senior',21,2,90
Union
SELECT 14,'Lebron','Senior',20,1,97

SELECT			*
FROM			Student

/*

Types of Aggregation functions are:

--> COUNT Returns the number of records in a table
--> SUM Returns sum of the values in a table
--> MIN Returns the minimum value in a column
--> MAX Returns the maximum value in a column
--> AVG Returns the average of values in a table 


ASK YOURSELF TWO QUESTIONS

 --> What are you grouping by?
 --> What are you aggregating?

*/

--> We would like to know the average scores of each Student Class.

SELECT			*
FROM			Student
ORDER BY		StudentClass

SELECT DISTINCT StudentClass
FROM			Student



 --> What are you grouping by? StudentClass
 --> What are you aggregating? TestScore

SELECT			StudentClass,
				AVG(TestScore) AS AvgTestScore
FROM			Student
GROUP BY		StudentClass

--> Nbr of records per studentclass

SELECT			StudentClass,
				COUNT(*)
FROM			Student
GROUP BY		StudentClass


--> Sum of All TestScores per StudentClass

SELECT			StudentClass,
				SUM(TestScore) AS SumOfTestScores
FROM			Student
GROUP BY		StudentClass

--> Calculated Avg Test Scores Per StudentClass


SELECT			StudentClass,
				AVG(TestScore) AS AvgTestScore
FROM			Student
GROUP BY		StudentClass

SELECT			StudentClass,			
				SUM(TestScore) AS SumOfTestScores,
				COUNT(*) AS NbrOfStudents,
				(SUM(TestScore) / COUNT(*)) AS CalculatedAvgTestScores
FROM			Student
GROUP BY		StudentClass

--> Retrieve the TOTAL of the Total due for each territory

 --> What are you grouping by? Territory --> GROUP BY 
 --> What are you aggregating? TotalDue --> SUM 

SELECT			*
FROM			AdventureWorks2016.Sales.SalesOrderHeader
ORDER BY		TerritoryID

SELECT			TerritoryID,
				SUM(TotalDue) AS TotalSales
FROM			AdventureWorks2016.Sales.SalesOrderHeader
GROUP BY		TerritoryID

--> MIN and MAX

--> Find out the min age and the max age for each student class

 --> What are you grouping by? StudentClass
 --> What are you aggregating? StudentAge --> MIN and MAX

SELECT			*
FROM			Student

SELECT			StudentClass,
				MIN(StudentAge) AS MinAge,
				MAX(StudentAge) AS MaxAge
FROM			Student
GROUP BY		StudentClass


--> Find out the age difference between the oldest student and the youngest in each student class

SELECT			StudentClass,
				MIN(StudentAge) AS MinAge,
				MAX(StudentAge) AS MaxAge,
				(MAX(StudentAge) - MIN(StudentAge)) AS AgeDifference
FROM			Student
GROUP BY		StudentClass


SELECT			StudentClass,
				MIN(StudentAge) AS MinAge,
				MAX(StudentAge) AS MaxAge,
				(MaxAge - MinAge) AS AgeDifference --> wont work as SSMS does not know these new columns names
FROM			Student
GROUP BY		StudentClass


--> Use the AdventureWorks table Sales.SalesOrderHeader 
		--to find out the totalsales by territoryID
	-- and the salespersonID and due date for the online Order Flag 0

SELECT			*
FROM			AdventureWorks2016.Sales.SalesOrderHeader

SELECT	DISTINCT OnlineOrderFlag
FROM			AdventureWorks2016.Sales.SalesOrderHeader


 --> What are you grouping by? territoryID salespersonID due date 
 --> What are you aggregating? totaldue

SELECT			TerritoryID,
				SalesPersonID,
				DueDate ,
				TotalDue,
				SUM(TotalDue) AS TotalSales
FROM			AdventureWorks2016.Sales.SalesOrderHeader
WHERE			OnlineOrderFlag = 0
GROUP BY		TerritoryID ,
				SalesPersonID ,
				DueDate

