/*

Date: 04/27/2019
Section 8: Working with Variables
Class: March 30 Online

*/

SELECT			*
FROM			Sales.SalesOrderHeader
WHERE			OrderDate = '2011-05-31'  --> value has been a constant

/*-

We have been dealing with constant values but starting today we will be 
looking at variables

Variable: allows you to change the value over times
Variables are stored in memory meaning their life span ends once the statement has been 
executed.


--> How to create a variable

Step 1 --> Create a variable
Step 2 --> Initialize a value to that variable / assigning a value to the variable
Step 3 --> extract the value / use the variable

--> Best Practices about Variables

--Start with a letter or an underscore example @_VariableName or @VariableName
--Do not include special characters such ! , @ , #, %, &, ^, *
--Avoid having spaces in a name
--if the name of the variable is a combination of multiple words, start each letter
with uppercase @VariableName

--> Two types of variables

		--> SCALAR variable holds 1 value
		--> TABLE variable holds a table


*/

--> SCALAR VARIABLE 

--Step 1 --> Create a variable name VariableName

DECLARE @VariableName VARCHAR(255) 


--Step 2 --> Initialize a value to that variable / assigning a value to the variable

SET	@VariableName = 'MarchOnlineClass'
SELECT @VariableName = 'MayOnlineClass' --> overwrite the value in a variable
		

--Step 3 --> extract the value / use the variable

SELECT @VariableName  

--OR 

--PRINT  @VariableName

--> Retrieve all female married employees

SELECT				*
FROM				HumanResources.Employee
WHERE				MaritalStatus = 'S' -- 'M'
AND					Gender = 'M'--'F'

--> Retrieve all female married employees

DECLARE				@Gender VARCHAR(5) = 'M' ,
					@MaritalStatus VARCHAR(5) = 'S' --> declare and initialize the variable

SELECT				*
FROM				HumanResources.Employee
WHERE				MaritalStatus = @MaritalStatus
AND					Gender = @Gender


DECLARE				@A INT = 5,
					@B INT = 10,
					@C INT = 7


SELECT				(@C + @A)- @B AS Total


--> USE the table Sales.SalesOrderDetail

SELECT				*
FROM				Sales.SalesOrderDetail

--> Retrieve the total Sales for product 775

--DECLARE				@ProductID INT = 702 --926  --775

SELECT				ProductID,
					SUM(LineTotal) AS TotalSales
FROM				Sales.SalesOrderDetail
WHERE				ProductID = @ProductID --775
GROUP BY			ProductID


--------------------------------------CLASS WORK-------------------------------------------------------------

DECLARE		@FullName VARCHAR(255) = 'Smith, John' --'Tamburello,Roberto'

--> Use the variable @FullName to create two variables @LastName and @FirstName 

--DO NOT DO THIS BELOW 
--DECLARE			@LastName VARCHAR(255) = 'Tamburello'
--DECLARE			@FirstName VARCHAR(255) = 'Roberto'

--> Here is the correct way to do it

--> DECLARE the variables

DECLARE			@LastName VARCHAR(255),
				@FirstName VARCHAR (255)

--> INITIALIZE the variables

--SET @LastName = LEFT(@FullName,CHARINDEX(',',@FullName) - 1)

SET @LastName =  SUBSTRING(@FullName, 1, CHARINDEX(',',@FullName) - 1)

--SET @FirstName = SUBSTRING(	@FullName, CHARINDEX(',',@FullName) + 1, LEN(@FullName))

SET @FirstName = (SELECT RIGHT(@FullName, LEN(@FullName) - CHARINDEX(',',@FullName)))


--> extract the values of the variables 

SELECT	@FullName AS FullName,
		@LastName AS LastName, 
		@FirstName AS FirstName 


CREATE TABLE NewCellPhones						(						 BrandID INT IDENTITY (100,1) PRIMARY KEY,						 Brand VARCHAR(50),						 PhoneName VARCHAR(50),						 Carrier VARCHAR(50),						 Price MONEY						)INSERT INTO	NewCellPhones (Brand, PhoneName, Carrier, Price)		VALUES ('Samsung', 'Note 7', 'Verizon', 600),
	   ('Apple', 'IPhone 8','AT&T', 700),
	   ('Apple','IPhone 6','T-Mobile',500),
	   ('LG','G3','Verizon',700),
	   ('Samsung','Galaxy 7','T-Mobile',650),
	   ('Nokia','3310','Metro PCS',450),
	   ('Motorola','Razor','AT&T',350),
	   ('Blackberry','Storm','Verizon',200),
	   ('Blackberry','Curve','Verizon',150),
	   ('Samsung','Galaxy 6','Sprint', 550)

SELECT		*
FROM		NewCellPhones

--> Retrieve the brand of the phones with a price that is equal to $350

SELECT		Brand
FROM		NewCellPhones
WHERE		Price = 350 -- hardcoding

--> LEt's use variables to make the above query dynamic

DECLARE		@Brand  VARCHAR(50)

SET         @Brand = (			
								SELECT  Brand
								FROM	NewCellPhones
								WHERE	Price = 350

					 )

--SELECT	@Brand AS BrandName

SELECT		Brand
FROM		NewCellPhones
WHERE		Brand = @Brand


DECLARE			@Price MONEY = 350

SELECT			Brand
FROM			NewCellPhones
WHERE			Price = @Price

----------------------------TABLE VARIABLE----------------------------------

--Table Variable can hold more than 1 value ( it is a variable that holds a table)

--Table Variable will not be stored in your database like a physical table

--> How do we create a table variable

DECLARE			@TableName  TABLE  (
								Name VARCHAR(250),
								DateOfBirth DATE,
								City  VARCHAR(250),
								State  VARCHAR(250)
								)

--SELECT			 *
--FROM			@TableName

INSERT INTO		@TableName
VALUES			('John','1990-01-01','Dallas','TX')

SELECT			* 
FROM			@TableName

SELECT			*
FROM			AdventureWorks2016.HumanResources.Employee

--> Create a table variable with the login ID, Job Title, Birthdate, HireDate

DECLARE		@EmployeeTable TABLE (
										LoginID NVARCHAR(255),
										JobTitle VARCHAR(255),
										Birthdate DATE,
										HireDate DATE,
										YearsEmployed INT
										)
INSERT INTO @EmployeeTable
SELECT		LoginID,
			JobTitle,
			Birthdate,
			HireDate,
			DATEDIFF(YY, HireDate, GETDATE())
			
FROM		AdventureWorks2016.HumanResources.Employee

DELETE FROM	 @EmployeeTable
WHERE		 LoginID = 'adventure-works\ken0'

SELECT			*
FROM			 @EmployeeTable


--> Retrieve the variable of productID and the sum of the LineTotal from the table 
	--SALES.SALESORDERDETAIL and store the results in a table variable



--SELECT			ProductID,
--				SUM(LineTotal) AS TotalSales
--FROM			Sales.SalesOrderDetail
--WHERE			ProductID = 776
--GROUP BY		ProductID

--DECLARE			@ProductID INT = 776

--SELECT			ProductID,
--				SUM(LineTotal) AS TotalSales
--FROM			Sales.SalesOrderDetail
--WHERE			ProductID = @ProductID
--GROUP BY		ProductID


DECLARE			@ProductID INT = (
								  SELECT	TOP 1 ProductID
								  FROM 		Sales.SalesOrderDetail
								  ORDER By	ProductID DESC
								 )



DECLARE			@ProductTable TABLE (
									ID INT,
									SumOfLineTotal INT
									)
INSERT INTO		@ProductTable
SELECT			ProductID,
				SUM(LineTotal) AS TotalSales
FROM			Sales.SalesOrderDetail
WHERE			ProductID = @ProductID
GROUP BY		ProductID

SELECT			*
FROM			@ProductTable

--> Table Variable with an identity constraint

DECLARE   @TableVariableWithIdentity TABLE
											(
											ID INT IDENTITY (1000,10),
											ColumnName VARCHAR(255)

											)

INSERT INTO		@TableVariableWithIdentity (ColumnName)
VALUES			('Hanna'),
				('Emebet'),
				('Bibha')

SELECT			*
FROM			@TableVariableWithIdentity 



--> Create a table variable and insert the columns 
   --TerritoryID and the total Sales   (SUM of TotalDue)

SELECT			*
FROM			Sales.SalesOrderHeader


DECLARE			@TerritoryTable TABLE
									( TerritoryID INT,
									 TotalSales INT
									 )

INSERT INTO		@TerritoryTable
SELECT			TerritoryID,
				SUM(TotalDue) 
FROM			Sales.SalesOrderHeader
GROUP BY		TerritoryID

SELECT			TerritoryID,
				TotalSales
FROM			@TerritoryTable
ORDER BY		TotalSales DESC


--> Create a table variable named NorthAmerica and insert the columns
	--TerritoryID, Name, Group and SalesYTD from the table
	--Sales.SalesTerritory for the group North America

	--> Once the table variable has been created, 
	    --change all territoryIDs to TerritoryID 10
	 

SELECT			*
FROM			Sales.SalesTerritory


SELECT			TerriToryID,
				Name, 
				[Group],
				SalesYTD
FROM			Sales.SalesTerritory
WHERE			[Group] = 'North America'

DECLARE			@NorthAmerica TABLE 
									(  TerriToryID INT,
										Name VARCHAR(50), 
										[Group] VARCHAR(50),
										SalesYTD MONEY
									)

INSERT INTO		@NorthAmerica
SELECT			TerriToryID,
				Name, 
				[Group],
				SalesYTD
FROM			Sales.SalesTerritory
WHERE			[Group] = 'North America'

UPDATE			@NorthAmerica
SET				TerriToryID = 10

SELECT			*
FROM			@NorthAmerica


