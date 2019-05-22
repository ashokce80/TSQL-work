/*
Date:04/09/2019
Section 3: Working With Tables
Class: Online March 30 Batch

*/

--> Class Quiz

/*

1- 	Create a database called Colaberry
		--> Do it via the Object Explorer (GUI)
		--> Do it again via the script

CREATE DATABASE Colaberry

*/

/*
2- Create a table called Student in the Colaberry database

 The columns: 
 StudentID --> Int
 StudentName --> VARCHAR(100)
 Location VARCHAR(50)
 ClassType NVARCHAR(10) 
 StartDate DateTime
 EndDate Date

*/

 CREATE TABLE Student
					(
					StudentID INT NOT NULL,
					StudentName VARCHAR(100),
					[Location] VARCHAR(50),
					ClassType NVARCHAR(10),
					StartDate DateTime,
					EndDate Date
					)

SELECT				*
FROM				Student
					
--> Insert 2 records in the table using any data you want

INSERT INTO			dbo.Student(StudentID, StudentName, [Location], ClassType,StartDate, EndDate)
VALUES				( 1, 'Chris', 'Dallas', 'Online', '2019-03-30', '2019-06-30'),
					(2, 'Chantal', 'Frisco', 'Onsite','2019-03-30','2019-06-30')

SELECT				*
FROM				Student

SELECT				*
FROM				Colaberry.dbo.Student --> Database Name.Schema.TableName


/*
--> Data Types:

Check https://docs.microsoft.com/en-us/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-2017

1-  Numeric
	--> Exact Numbers ( INT, BIGINT, TINYINT, SMALLINT, NUMERIC, DECIMAL)
	--> Approximate numeric (FLOAT) --> can hold both numbers and decimal values 
	--> Example of INT 12345...
	--> Example of NUMERIC: 1234.12
	--> Example of a Decimal(5,2) DECIMAL(p,s) --> 345.06

Precision is the number of digits in a number. 
Scale is the number of digits to the right of the decimal point in a number.
For example, the number 123.45 has a precision of 5 and a scale of 2.

2-	String
	--> VARCHAR --> it will only accept strings 
	--> CHAR
3-  Unicode Characters
	--> NVARCHAR --> it will hold both numbers and string 
	--> NCHAR
4-	Date and Time
	--> Datetime 2019-04-09 7:09:10.00 --> YYYY-MM--DD HH:MM:SS:MS
	--> Date  2019-04-09
	--> Time  HH:MM:SS:MS
5-  Binary
	--> Image

BIT DATATYPE only accepts 1 or 0 ( 1 ==> TRUE and 0 ==> FALSE)

*/



--> DATA TYPE MONEY accepts currency values in a format of numbers/decimal 


DROP TABLE Student

SELECT			*
FROM			Student

CREATE TABLE Student
			( StudentID INT,
			StudentName VARCHAR(100),
			[Location] VARCHAR(50),
			StartDate DATETIME,
			EndDate DATE,
			CourseFee MONEY,
			IsActiveStudent BIT,
			InstallmentAmount FLOAT,
			PaymentTime TIME
			)

INSERT INTO		Student(StudentID, StudentName, [Location],StartDate,EndDate, CourseFee,IsActiveStudent,
				InstallmentAmount, PaymentTime)
VALUES			(1, 'Chantal', 'Frisco', '2016-01-01 09:10:00:000','03/20/2016', 1999.99, 'False', 123465, '08:00:01:000')


INSERT INTO		Student(StudentID, StudentName, [Location],StartDate,EndDate, CourseFee,IsActiveStudent,
				InstallmentAmount, PaymentTime)
VALUES			(1, 'Chantal', 'Frisco', '2016-01-01 09:10:00:000','03/20/2016', 1999.99, 1, 123465, '08:00:01:000')



--> Below wont work for the BIT datatype

INSERT INTO		Student(StudentID, StudentName, [Location],StartDate,EndDate, CourseFee,IsActiveStudent,
				InstallmentAmount, PaymentTime)
VALUES			(1, 'Chantal', 'Frisco', '2016-01-01 09:10:00:000','03/20/2016', 1999.99, 'yes', 123465, '08:00:01:000')



SELECT				*
FROM				Student

DELETE FROM			Student

--> UNION ALL VS UNION 
		--> UNION ALL is faster than UNION 
		--> UNION ALL allows duplicate records
		--> Same order of columns and same data types

INSERT INTO		Student(StudentID, StudentName, [Location],StartDate,EndDate, CourseFee,IsActiveStudent,
				InstallmentAmount, PaymentTime)
SELECT			1, 'Chantal', 'Onsite', '2019-01-01', '2019-03-30', 1999.99, 1, 123456, '08:00:00:000'

INSERT INTO		Student(StudentID, StudentName, [Location],StartDate,EndDate, CourseFee,IsActiveStudent,
				InstallmentAmount, PaymentTime)
SELECT			1, 'Chantal', 'Onsite', '2019-01-01', '2019-03-30', 1999.99, 1, 123456, '08:00:00:000'

--OR

INSERT INTO		Student(StudentID, StudentName, [Location],StartDate,EndDate, CourseFee,IsActiveStudent,
				InstallmentAmount, PaymentTime)
SELECT			1, 'Chantal', 'Onsite', '2019-01-01', '2019-03-30', 1999.99, 1, 123456, '08:00:00:000'
UNION 
SELECT			1, 'Chantal', 'Onsite', '2019-01-01', '2019-03-30', 1999.99, 1, 123456, '08:00:00:000'


SELECT			*
FROM			Student

DELETE FROM    Student

INSERT INTO		Student(StudentID, StudentName, [Location],StartDate,EndDate, CourseFee,IsActiveStudent,
				InstallmentAmount, PaymentTime)
SELECT			1, 'Chantal', 'Onsite', '2019-01-01', '2019-03-30', 1999.99, 1, 123456, '08:00:00:000'
UNION ALL 
SELECT			1, 'Chantal', 'Onsite', '2019-01-01', '2019-03-30', 1999.99, 1, 123456, '08:00:00:000'

SELECT			*
FROM			Student

--> Create a back up table called StudentBackUp


SELECT			*  --> write the columns you would like in the backup table
INTO			StudentBackUp 
--> Create automatically a new table called StudentBackUp and i am also inserting records
FROM			Student

SELECT			* 
FROM			StudentBackUp

DROP TABLE		StudentBackUp

CREATE TABLE StudentBackUp
			( StudentID INT,
			StudentName VARCHAR(100),
			[Location] VARCHAR(50),
			StartDate DATETIME,
			EndDate DATE,
			CourseFee MONEY,
			IsActiveStudent BIT,
			InstallmentAmount FLOAT,
			PaymentTime TIME
			)


SELECT		*
FROM		StudentBackUp

INSERT INTO StudentBackUp -- did not write the column name because i created the studentbackup table with the same
--structure as the student table (see above)
SELECT		*
FROM		Student

SELECT		*
FROM		StudentBackUp

--> Comparison Operators 

/*
> greater than , >+
< less than , <=
<> not equal or !=

!> not greater than

!< not less than 


*/


/*

-->Logical Operators

LIKE, NOT LIKE, AND , BETWEEN , IN , NOT IN , EXISTS, NOT EXISTS


*/

SELECT				*
FROM				AdventureWorks2016.Sales.SalesOrderHeader

--> retrieve all records (columns) where the salespersonID is 282

SELECT				*
FROM				AdventureWorks2016.Sales.SalesOrderHeader
WHERE				SalesPersonID = 282

--> Retrieve all records ( columns) where the SalesPersonID is not 282

SELECT				*
FROM				AdventureWorks2016.Sales.SalesOrderHeader
WHERE				SalesPersonID != 282 -- or i could SalesPersonID <> 282

SELECT				*
FROM				AdventureWorks2016.Sales.SalesOrderHeader
WHERE				SalesPersonID <> 282



--> Retrieve all records ( all columns) where the SalesPersonID is 279 
	--the territoryID is 5 

SELECT				*
FROM				AdventureWorks2016.Sales.SalesOrderHeader
WHERE				SalesPersonID =279
AND					TerritoryID = 5

--AND both conditions have to be true

--> Retrieve all records where the TotalDue is greater than 20,000

SELECT				*
FROM				AdventureWorks2016.Sales.SalesOrderHeader
WHERE				TotalDue > 20000

--> Retrieve all records where the Total due is greater than 50,000 and less than 60,000


SELECT				*
FROM				AdventureWorks2016.Sales.SalesOrderHeader
WHERE				TotalDue BETWEEN 50000 AND 60000 --> does not include totaldue = 50000 and totaldue=60000

SELECT				*
FROM				AdventureWorks2016.Sales.SalesOrderHeader
WHERE				TotalDue > 50000
AND					TotalDue < 60000 

--> Retrieve all records where the Total due is greater than and equal to 50,000 
	--and less than and equal to 60,000

SELECT				*
FROM				AdventureWorks2016.Sales.SalesOrderHeader
WHERE				TotalDue >= 50000
AND					TotalDue < = 60000 

SELECT				*
FROM				AdventureWorks2016.Sales.SalesOrderHeader
WHERE				TotalDue = 50000
OR					TotalDue = 60000 

--OR --> Either condition is met

--> Arithmetic Operators
/*
 + --> addition 
 - --> substraction 
 * --> Multiplication
 / --> Division 

 % --> Module ( to find out remainder of a division)

 5 % 2 --> 1

*/

SELECT	(5 + 2) AS Addition  --> ALIAS

SELECT	(5 + 2) Addition

SELECT  5 - 2 AS  Substraction

SELECT  5 * 2 AS Multiplication

SELECT  10 / 2 AS Division

SELECT (5%2) AS [Mod]


SELECT			*
FROM			AdventureWorks2016.Sales.SalesOrderHeader

SELECT [SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[TerritoryID]
      ,[BillToAddressID]
      ,[ShipToAddressID]
      ,[ShipMethodID]
      ,[CreditCardID]
      ,[CreditCardApprovalCode]
      ,[CurrencyRateID]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
   --   ,[TotalDue]
		,([SubTotal] +[TaxAmt] + [Freight]) AS CalculatedTotalDue --> ALIAS --> Creating a column name 
FROM [AdventureWorks2016].[Sales].[SalesOrderHeader]


SELECT [SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[TerritoryID]
      ,[BillToAddressID]
      ,[ShipToAddressID]
      ,[ShipMethodID]
      ,[CreditCardID]
      ,[CreditCardApprovalCode]
      ,[CurrencyRateID]
      --,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
   --   ,[TotalDue]
	 , [TotalDue] - ([TaxAmt] + [Freight]) AS CalculatedSubTotal --> ALIAS --> Creating a column name 
FROM [AdventureWorks2016].[Sales].[SalesOrderHeader]


/*

-->Logical Operators

LIKE, NOT LIKE, AND , BETWEEN , IN , NOT IN , EXISTS, NOT EXISTS


*/

SELECT				*
FROM				AdventureWorks2016.Production.Product


--> Retrieve all columns where the name of the product contains the word BALL

 --> % --> wild card represent
 --> _ --> represents just one character

SELECT				*
FROM				AdventureWorks2016.Production.Product
WHERE				[Name] LIKE '%BALL%' --> 1 or more characters before and after BALL

SELECT				*
FROM				AdventureWorks2016.Production.Product
WHERE				[Name] LIKE '_lade' --> any 1 character string with lade after

--> Retrieve all columns where the product name starts with B


SELECT				*
FROM				AdventureWorks2016.Production.Product
WHERE				[Name] LIKE 'B%'

SELECT				*
FROM				AdventureWorks2016.Production.Product

--> Retrieve all columns where productID is not 329 and is not 317

SELECT				*
FROM				AdventureWorks2016.Production.Product
WHERE				ProductID <> 329
AND					ProductID <> 317


SELECT				*
FROM				AdventureWorks2016.Production.Product
WHERE				ProductID NOT IN (317 , 329)

SELECT				*
FROM				AdventureWorks2016.Production.Product
WHERE				ProductID = 317



SELECT				*
FROM				AdventureWorks2016.Production.Product
WHERE				ProductID IN (317) -- IN (317 , 329)





