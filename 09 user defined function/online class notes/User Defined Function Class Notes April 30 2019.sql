/*

Date: 04/30/2019
Section: User Defined Function
Class: March 30 2019 Online

*/

--We have two types of User Defined Functions (UDF)
  --> Scalar Valued Function (return 1 value)
  --> Table Valued Function (return a table)

--> Where are the UDFs stored at?
 --> ServerName --> Database -->Programmability --> Functions


 --> Syntax of a scalar value function 
/*
 CREATE FUNCTION YourFunctionName 
 (Input Parameters)
 RETURNS DATATYPE
 AS 
 BEGIN 

 RETURN

 END 
 */

--> Create a scalar valued function that add two numbers and return the addition


CREATE FUNCTION UDF_AddTwoNumbers
(  --Input Parameters
@Nbr1 INT , @Nbr2 INT	
)
RETURNS INT  --> what the UDF will return
AS 
BEGIN 

RETURN @Nbr1 + @Nbr2

END 
GO


SELECT	dbo.UDF_AddTwoNumbers( 1, 5) AS [Sum]

SELECT	dbo.UDF_AddTwoNumbers( 10, 100) AS [Sum]

--OR

GO

CREATE FUNCTION UDF_AddTwoNumberS_V2
(  --Input Parameters
@Nbr1 INT , @Nbr2 INT	
)
RETURNS INT  --> what the UDF will return
AS 
BEGIN 

DECLARE  @SUM INT  --DECLARE YOUR RESULT AS A VARIABLE
SET @SUM = @Nbr1 + @Nbr2 --ASSIGN A VALUE TO THE YOUR RETURN VARIABLE 

RETURN @SUM  --> RETURN THE SUM VARIABLE

END 
GO

SELECT		DBO.UDF_AddTwoNumberS_V2 (1 , 5) AS ADDITION

/*
CREATE FUNCTION <Scalar_Function_Name, sysname, FunctionName> 
(
	-- Add the parameters for the function here
	@Nbr1 INT , @Nbr2 INT	
)
RETURNS INT 
AS
BEGIN
	-- Declare the return variable here
	  DECLARE  @SUM INT

	-- Add the T-SQL statements to compute the return value here
	SET @SUM = @Nbr1 + @Nbr2 

	-- Return the result of the function
	RETURN @SUM 

END
GO

*/

--Create a scalar valued function that will provide us the number of employees 
 --for each gender


SELECT			*
FROM			AdventureWorks2016.HumanResources.Employee

SELECT			COUNT(*)
FROM			AdventureWorks2016.HumanResources.Employee
WHERE			Gender =  'M' --'F' @Gender

GO
CREATE FUNCTION UDF_GetNbrOfEmployeesPerGender
( @Gender VARCHAR(1)) --Input Parameter
RETURNS  INT  --> count of employees
AS 
BEGIN 
DECLARE @Count INT  --return value

SET @Count = (  SELECT			COUNT(*)
				FROM			AdventureWorks2016.HumanResources.Employee
				WHERE			Gender = @Gender
				)

RETURN @Count
END 
GO


SELECT			dbo.UDF_GetNbrOfEmployeesPerGender('F') AS NbrOfFemaleEmployees

SELECT			dbo.UDF_GetNbrOfEmployeesPerGender('M') AS NbrOfMaleEmployees


--Create a scalar valued function that will provide the number of employees per	marital status

		--> Create the query to put in the function 

SELECT		COUNT(*), MaritalStatus
FROM		AdventureWorks2016.HumanResources.Employee
GROUP BY	MaritalStatus

--> input parameter will be maritalstatus ( either M or S)
--> RETURNS --> 
SELECT		COUNT(*)
FROM		AdventureWorks2016.HumanResources.Employee
WHERE		MaritalStatus  = 'M' -- or 'S' 

GO
CREATE FUNCTION Udf_GetNbrOfEmpPerMaritalStatus
-- Input Parameter
( @MaritalStatus VARCHAR(1))
RETURNS    INT --Count of employees per marital status
AS 
BEGIN 

RETURN		(SELECT		COUNT(*)
			FROM		AdventureWorks2016.HumanResources.Employee
			WHERE		MaritalStatus = @MaritalStatus
			)
END 
GO


SELECT   dbo.Udf_GetNbrOfEmpPerMaritalStatus('S') AS NbrOfSingleEmployees

--equal to what we have below

SELECT		COUNT(*)
FROM		AdventureWorks2016.HumanResources.Employee
WHERE		MaritalStatus = 'S'



SELECT			*,
				dbo.Udf_GetNbrOfEmpPerMaritalStatus('S') AS NbrOfSingleEmployees	
FROM			AdventureWorks2016.HumanResources.Employee


--Create a scalar valued function to provide the jobtitle of an employee
	--based on their gender and BusinessEntityId

--Input Parameters (Gender and BusinessEntityID)  --> WHERE Clause
--Results from the UDF --> jobtitle



SELECT			Jobtitle
FROM			AdventureWorks2016.HumanResources.Employee
WHERE			BusinessEntityID = 1 -- input parameters
AND				Gender = 'M' --input parameters


DECLARE			@Gender VARCHAR(1) 
--SET				@Gender = 'M'  
--or
SET				@Gender = (SELECT TOP 1 Gender
						  FROM AdventureWorks2016.HumanResources.Employee
						  )
DECLARE			@BusinessEntityID INT 
SET				@BusinessEntityID = (SELECT TOP 1 BusinessEntityID 
									 FROM AdventureWorks2016.HumanResources.Employee)

--Final code that i will put in the UDF

SELECT			Jobtitle
FROM			AdventureWorks2016.HumanResources.Employee
WHERE			BusinessEntityID = @BusinessEntityID
AND				Gender = @Gender

GO
CREATE FUNCTION UDF_GetJobTitle
(@Gender VARCHAR(1) , @BusinessEntityID INT )
RETURNS			VARCHAR(250)
AS 
BEGIN 
RETURN	(
SELECT			Jobtitle
FROM			AdventureWorks2016.HumanResources.Employee
WHERE			BusinessEntityID = @BusinessEntityID
AND				Gender = @Gender
)
END 
GO

SELECT			*
FROM			AdventureWorks2016.HumanResources.Employee


SELECT		dbo.UDF_GetJobTitle('M', 22) AS JobTitle

SELECT		dbo.UDF_GetJobTitle('F', 22) AS JobTitle  --> the business entity id 22 is a male employee

--Create a scalar valued function that will return the postal code when
  -- a city name is provided as an input parameter

SELECT			*
FROM			AdventureWorks2016.Person.Address

--> Input Parameter -->  City
--> Result --> Postal Code

SELECT			PostalCode, AddressID
FROM			AdventureWorks2016. Person.Address
WHERE			City = 'Bothell'  -- input parameter

SELECT DISTINCT	PostalCode
FROM			AdventureWorks2016. Person.Address
WHERE			City = 'Bothell'  -- input parameter	

GO
CREATE FUNCTION UDF_GetPostalCode
( @City VARCHAR(255))
RETURNS			NVARCHAR (15) --DataType  --> the column Postal Code
AS 
BEGIN 

DECLARE			@PostalCode NVARCHAR (15)
SET				@PostalCode = ( SELECT DISTINCT	PostalCode
			            	    FROM AdventureWorks2016. Person.Address
								WHERE			City = @City
								)
RETURN			@PostalCode
END
GO						

SELECT			DBO.UDF_GetPostalCode('DALLAS') AS Dallas_PostalCode

GO
ALTER FUNCTION UDF_GetPostalCode
( @City VARCHAR(255))
RETURNS			NVARCHAR (15) --DataType  --> the column Postal Code
AS 
BEGIN 

RETURN				 (			SELECT DISTINCT	PostalCode
			            	    FROM AdventureWorks2016. Person.Address
								WHERE			City = @City
								)
END
GO						

SELECT			DBO.UDF_GetPostalCode('Berlin') AS Berlin_PostalCode
	
--Berlin has more than 1 distinct postal code so we need to make changes to the query to 
 --pull only one value 
GO
 ALTER FUNCTION UDF_GetPostalCode
( @City VARCHAR(255))
RETURNS			NVARCHAR (15) --DataType  --> the column Postal Code
AS 
BEGIN 

RETURN				 (			SELECT TOP 1	PostalCode
			            	    FROM AdventureWorks2016. Person.Address
								WHERE			City = @City
								)
END
GO		

SELECT			DBO.UDF_GetPostalCode('Berlin') AS Berlin_PostalCode


--Table Valued Functions

CREATE TABLE Company 
					(
					CompanyID INT,
					CompanyName VARCHAR(50),
					City VARCHAR(50)
					)
						
INSERT INTO dbo.Company (CompanyID,CompanyName,City)
   SELECT 1,'Walmart','Dallas' UNION
   SELECT 2,'Target','Irving' UNION
   SELECT 3,'K-Mart','Carrollton' UNION
   SELECT 4,'K-Mart','Dallas' UNION
   SELECT 5,'Target','Carrollton' UNION
   SELECT 6,'Burger King','Irving' UNION
   SELECT 7,'Taco Bell','Irving' UNION
   SELECT 8,'KFC','Dallas'			

SELECT			*
FROM			Company	

--> Syntax for the Table Valued Function 

CREATE FUNCTION YourFunctionName
(@InputParameter datatype)
RETURNS TABLE 
AS
RETURN 

--> Calculations

/* 
Create a table valued function which will accept the city as an input parameter
and will return all the company in that given city

*/

SELECT			*
FROM			Company
WHERE			City = 'Irving'		--> hardcoding

DECLARE			@City VARCHAR(50)
SET				@City = 'Irving'

SELECT			*
FROM			Company
WHERE			City = @City		

GO
CREATE FUNCTION UDF_GetCompanyCityInformation
(@City VARCHAR(50))  --> input Parameter
RETURNS   TABLE --> it returns 
AS

RETURN		
			(
			SELECT			*
			FROM			Company
			WHERE			City = @City	
			)
GO

SELECT		*
FROM		dbo.UDF_GetCompanyCityInformation('Irving') 

--> Only retrieve companies that start with the letter T in Irving

SELECT		*
FROM		dbo.UDF_GetCompanyCityInformation('Irving') 
WHERE		CompanyName LIKE 'T%'

--> Store the results of the table valued function dbo.UDF_GetCompanyCityInformation for Dallas 
		--in a table variable

SELECT			*
FROM			dbo.UDF_GetCompanyCityInformation('Dallas')

DECLARE			@DallasCompanies TABLE (CompanyID INT,
									CompanyName VARCHAR(50),
									City VARCHAR(50)
									)

INSERT INTO		@DallasCompanies
SELECT			*
FROM			dbo.UDF_GetCompanyCityInformation('Dallas')

SELECT			CompanyID,
				CompanyName AS DallasCompanyName,
				City
FROM			@DallasCompanies

/* 
Create a table valued function that will return the employee information 
	based on a given birth month
	*Hint* you should be able to pass a range of months
	Ex: January to March
Columns to provide are: BusinessEntityID, NationalIDNumber,JobTitle, Birthdate
MaritalStatus, Gender and HireDate

*/

SELECT			*
FROM			AdventureWorks2016.HumanResources.Employee


SELECT			BusinessEntityID, 
				NationalIDNumber,
				JobTitle, 
				Birthdate,
				MaritalStatus, 
				Gender,
				HireDate
FROM			AdventureWorks2016.HumanResources.Employee
WHERE			DATEPART(MONTH,Birthdate) = 5  --> hardcoding the birth month

DECLARE			@BithMonth INT 
SET				@BithMonth = 5  --> this is an example

SELECT			BusinessEntityID, 
				NationalIDNumber,
				JobTitle, 
				Birthdate,
				MaritalStatus, 
				Gender,
				HireDate
FROM			AdventureWorks2016.HumanResources.Employee
WHERE			DATEPART(MONTH,Birthdate) = @BithMonth


DECLARE			@FromMonth INT = 1 , @ToMonth INT = 3

SELECT			BusinessEntityID, 
				NationalIDNumber,
				JobTitle, 
				Birthdate,
				MaritalStatus, 
				Gender,
				HireDate
FROM			AdventureWorks2016.HumanResources.Employee
WHERE			DATEPART(MONTH,Birthdate) BETWEEN @FromMonth AND @ToMonth

GO
CREATE  FUNCTION UDF_GetEmplInfoByBirthMonth
(@FromMonth INT , @ToMonth INT)  --> input parameters
RETURNS TABLE 
AS 
RETURN 
			(
			SELECT			BusinessEntityID, 
							NationalIDNumber,
							JobTitle, 
							Birthdate,
							MaritalStatus, 
							Gender,
							HireDate
			FROM			AdventureWorks2016.HumanResources.Employee
			WHERE			DATEPART(MONTH,Birthdate) BETWEEN @FromMonth AND @ToMonth
			)
GO

SELECT			*
FROM			UDF_GetEmplInfoByBirthMonth (10, 12)


--> to verify the birthmonth from the above query

SELECT		DISTINCT MONTH(Birthdate) 
FROM		UDF_GetEmplInfoByBirthMonth (10, 12)	


--> To make changes to the table valued function

GO
ALTER  FUNCTION UDF_GetEmplInfoByBirthMonth
(@BirthMonth INT)
--(@FromMonth INT , @ToMonth INT)  --> input parameters
RETURNS TABLE 
AS 
RETURN 
			(
			SELECT			BusinessEntityID, 
							NationalIDNumber,
							JobTitle, 
							Birthdate,
							MaritalStatus, 
							Gender,
							HireDate
			FROM			AdventureWorks2016.HumanResources.Employee
			WHERE			DATEPART(MONTH,Birthdate) = @BirthMonth -- BETWEEN @FromMonth AND @ToMonth
			)
GO


SELECT			*
FROM			dbo.UDF_GetEmplInfoByBirthMonth(7)