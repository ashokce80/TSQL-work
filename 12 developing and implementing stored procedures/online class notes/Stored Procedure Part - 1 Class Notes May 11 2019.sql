/*
Date: 05/11/2019
Section: Stored Procedure Part - 1
Class: March Online 2019

*/


/*

Stored Procedure : Set of SQL scripts that are saved in the database server
and can be called (executed) by using EXEC or EXECUTE in front of the name
of the stored procedure.

Purposes and Advantages of Stored Procedures:

When to use a stored procedure:

*/


--> Syntax 

 --> Creating a stored procedure

 CREATE PROCEDURE	USP_YourFirstStoredProcedure				--CREATING A STORED PROCEDURE
 --OR USE CREATE PROC
 -- IN THE FIELD WE CALL IT SP OR PROC 
 (@YourInputParameter Datatype)
 AS
	BEGIN 
	--	SET NOCOUNT OFF; --> avoid showing the messages (default)
		SET NOCOUNT ON;--> always do this to reduce execution time for the 
--stored procedure. It will avoid the numbers of rows affected to show

--> YOUR CODE GOES HERE

	END


--> HOW TO CALL/INVOKE/EXECUTE

EXEC USP_YourFirstStoredProcedure('INPUT PARAMETER VALUE')

--OR

EXECUTE USP_YourFirstStoredProcedure ('INPUT PARAMETER VALUE')


/*
Create a stored procedure that will take Gender as an input parameter
and provide the number of employees, the job title and the gender columns
*/

USE MarchOnline2019
GO

 CREATE PROCEDURE	USP_GetNbrOfEmployees				

 (@Gender VARCHAR(1))
 AS
	BEGIN 
		SET NOCOUNT ON;

-- your code goes here

		SELECT				COUNT(*) AS NbrOfEmployees,
							JobTitle,
							Gender
		FROM				AdventureWorks2016.HumanResources.Employee
		WHERE				Gender = @Gender
		GROUP BY			JobTitle,
							Gender
		ORDER BY			NbrOfEmployees DESC

	END

EXEC [dbo].[USP_GetNbrOfEmployees]'F'

--OR

EXEC [dbo].[USP_GetNbrOfEmployees] @Gender = 'F'

--> it is the same as 

SELECT				COUNT(*) AS NbrOfEmployees,
					JobTitle,
					Gender
FROM				AdventureWorks2016.HumanResources.Employee
WHERE				Gender = 'F'
GROUP BY			JobTitle,
					Gender
ORDER BY			NbrOfEmployees DESC

EXEC SP_HELPTEXT'USP_GetNbrOfEmployees'

--> copy and paste the results which is below

--> let's alter the above stored procedure by adding an extra column
  --> MaritalStatus

ALTER PROCEDURE USP_GetNbrOfEmployees      
  
 (@Gender VARCHAR(1))  
 AS  
 BEGIN   
  SET NOCOUNT ON;  
  
-- your code goes here  
  
  SELECT    COUNT(*) AS NbrOfEmployees,  
       JobTitle,  
       Gender  ,
	   MaritalStatus
  FROM    AdventureWorks2016.HumanResources.Employee  
  WHERE    Gender = @Gender  
  GROUP BY   JobTitle,  
			Gender ,
			MaritalStatus 
  ORDER BY   NbrOfEmployees DESC  
  
 END


 EXEC [dbo].[USP_GetNbrOfEmployees]@Gender = 'M'


 /*
 alter the above stored procedure by adding an additional input
 parameter MaritalStatus
 */

--make sure you are in the database where the stored procedure is saved

 EXEC SP_HELPTEXT'[dbo].[USP_GetNbrOfEmployees]'

 ALTER PROCEDURE USP_GetNbrOfEmployees        
    
 (@Gender VARCHAR(1), @MaritalStatus VARCHAR(1))    
 AS    
 BEGIN     
  SET NOCOUNT ON;    
    
-- your code goes here    
    
  SELECT    COUNT(*) AS NbrOfEmployees,    
			JobTitle,    
			Gender,  
			@MaritalStatus  AS MaritalStatus 
  FROM		AdventureWorks2016.HumanResources.Employee    
  WHERE		Gender = @Gender   
  AND		MaritalStatus = @MaritalStatus 
  GROUP BY   JobTitle,    
			Gender ,  
			MaritalStatus   
  ORDER BY   NbrOfEmployees DESC    
    
 END

EXECUTE [dbo].[USP_GetNbrOfEmployees]'F','S' -->needs to follow input parameter order
  --in the stored procedure

EXECUTE [dbo].[USP_GetNbrOfEmployees] @Gender ='F', @MaritalStatus = 'S'

EXECUTE [dbo].[USP_GetNbrOfEmployees]  @MaritalStatus = 'S', @Gender ='F'


/*
Create a stored procedure that will provide the first name, last name,
job title, gender and the birth day and month of the employees 
that will have a birthday in two months.

*/

SELECT			top 1 *
FROM			AdventureWorks2016.HumanResources.Employee

SELECT			top 1 *
FROM			AdventureWorks2016.Person.Person

SELECT			DATENAME(MM, Birthdate) as BirthMonth, 
				CAST(DATEPART(DD, Birthdate)AS VARCHAR(20)) as BirthDay,
				DATENAME(MM, Birthdate) + ' - '+ DATEPART(DD, Birthdate) AS BirthMonthAndDay,
				Birthdate
FROM			AdventureWorks2016.HumanResources.Employee 

--> the above query gives you the error below so you need to convert the birthdate day
--Conversion failed when converting the nvarchar value 'January - ' to data type int.


SELECT			DATENAME(MM, Birthdate) as BirthMonthName, 
				DATEPART(MM,Birthdate) AS BirthMonth,
				DATEPART(MM, GETDATE()) AS TodaysMonth,
				DATEPART(MM, GETDATE()) + 2 AS InTwoMonthsFromTodaysMonth,
				CAST(DATEPART(DD, Birthdate)AS VARCHAR(20)) as BirthDay,
				DATENAME(MM, Birthdate) + ' - '+ CAST(DATEPART(DD, Birthdate)AS VARCHAR(20)) AS BirthMonthAndDay,
				Birthdate
FROM			AdventureWorks2016.HumanResources.Employee 

SELECT			P.FirstName,
				P.LastName,
				Emp.JobTitle,
				Emp.Gender,
				DATENAME(MM, Emp.Birthdate) + ' - '+ CAST(DATEPART(DD, Emp.Birthdate)AS VARCHAR(20)) AS BirthMonthAndDay

FROM			AdventureWorks2016.HumanResources.Employee Emp
INNER JOIN		AdventureWorks2016.Person.Person P
ON				Emp.BusinessEntityID = P.BusinessEntityID
WHERE			DATEPART(MM,Emp.BirthDate) = DATEPART(MM, GETDATE()) + 2 -- DATEPART(MM,DATEADD(MM,2, GETDATE()))

SELECT			DATEPART(MM, GETDATE()) + 2

--> getting two months from today

SELECT			DATEADD(MM, 2, GETDATE()) --> 2019-07-11 10:15:16.720

--> to get the month of the 2019-07-11 10:15:16.720

SELECT			DATEPART(MM,DATEADD(MM,2, GETDATE()))


--> let's create our stored procedure

CREATE PROCEDURE USP_GetEmpBirthdays
AS
BEGIN

SELECT			P.FirstName,
				P.LastName,
				Emp.JobTitle,
				Emp.Gender,
				DATENAME(MM, Emp.Birthdate) + ' - '+ CAST(DATEPART(DD, Emp.Birthdate)AS VARCHAR(20)) AS BirthMonthAndDay

FROM			AdventureWorks2016.HumanResources.Employee Emp
INNER JOIN		AdventureWorks2016.Person.Person P
ON				Emp.BusinessEntityID = P.BusinessEntityID
WHERE			DATEPART(MM,Emp.BirthDate) =  DATEPART(MM,DATEADD(MM,2, GETDATE()))

END


EXEC USP_GetEmpBirthdays

/*

Create a stored procedure that will provide the first name, last name,
job title, gender and the birthdate  day and month of the employees 
 with the input parameter being the month (for example today's month is 5)

*/

SELECT			*
FROM			AdventureWorks2016.HumanResources.Employee
SELECT			*
FROM			AdventureWorks2016.Person.Person


----------------------------------WHILE LOOP-----------------------------------------------------

/*
looping is using a single SQL command or a set of SQL statements to be executed repeatedly. 
If a condition is true the loop is executed.

*/
			

DECLARE		@iterationstart INT 
SET			@iterationstart = 20   --> start value 

WHILE		@iterationstart < 35  --> condition to meet for the while loop to stop 
BEGIN 
			-- your code goes here
			SET @iterationstart = @iterationstart + 5 --> re-initialization of the value 
			PRINT @iterationstart

END 

/*
25
30
35

*/


DECLARE		@test INT 
SET			@test = 20   --> start value 

WHILE		@test < 35  --> condition to meet for the while loop to stop 
BEGIN 
			-- your code goes here
			PRINT @test
			SET @test = @test + 5 --> re-initialization of the value 

END 


/* results 
20
25
30
*/


/*-----------------------------------------------

Find top two products per Department ( highest two total sales product per dept)

*/-----------------------------------------------

/*
Logic to follow :

Step 1: first set a initial value for @deptID variable
Step 2:create another table to store the expected result to get top 2 product 
Step 3:reset @deptID so that at the end there is no deptID left to loop thru

*/


CREATE TABLE Products (ProductID int, 
						ProductName varchar(150), 
						DepartmentID int, 
						TotalSales money)

INSERT INTO Products (ProductID,ProductName,DepartmentID,TotalSales)
SELECT		1000,'Camry',1,35000 UNION
SELECT		1001,'Carolla',1,20000 UNION
SELECT		1002,'Paseo',1,18000 UNION
SELECT		1003,'Tundra',1,48000 UNION
SELECT		1004,'Rav4',1,33000 UNION
SELECT		1005,'Escalade',2,60000 UNION
SELECT		1006,'Deville',2,47000 UNION
SELECT		1007,'STS',2,50000 UNION
SELECT		1008,'CTS',2,40000 UNION
SELECT		1009,'DTS',2,43000 UNION
SELECT		1008,'CTS',4,40000 UNION
SELECT		1009,'DTS',4,43000 UNION
SELECT		1008,'CTS',5,40000 UNION
SELECT		1009,'DTS',5,43000 UNION
SELECT		1008,'CTS1',5,40000 UNION
SELECT		1009,'DTS2',5,43000 



/*

Find top two products per Department ( highest two total sales product per dept)

*/


/*
Logic to follow :

Step 1: first set a initial value for @deptID variable
Step 2:create another table to store the expected result to get top 2 product 
Step 3:reset @deptID so that at the end there is no deptID left to loop thru

*/

--> this code below wont provide you with the results requested


SELECT		TOP 2 ProductID,
				  ProductName,
				  DepartmentID,
				  TotalSales
FROM			  Products
ORDER BY		  TotalSales DESC 

SELECT			*
FROM			Products

--> hard coding to get the results requested but it does not work when there are new departmentID 

SELECT			A.*
FROM			(

SELECT			TOP 2 ProductID,
				  ProductName,
				  DepartmentID,
				  TotalSales
FROM			Products
WHERE			DepartmentID = 1 --> we need this same code for all departments (1,2,4,5)
ORDER BY		TotalSales DESC 

UNION ALL

SELECT			TOP 2 ProductID,
				  ProductName,
				  DepartmentID,
				  TotalSales
FROM			Products
WHERE			DepartmentID = 2 --> we need this same code for all departments (1,2,4,5)
ORDER BY		TotalSales DESC 

UNION ALL

SELECT			TOP 2 ProductID,
				  ProductName,
				  DepartmentID,
				  TotalSales
FROM			Products
WHERE			DepartmentID = 4 --> we need this same code for all departments (1,2,4,5)
ORDER BY		TotalSales DESC 


UNION ALL

SELECT			TOP 2 ProductID,
				  ProductName,
				  DepartmentID,
				  TotalSales
FROM			Products
WHERE			DepartmentID = 5 --> we need this same code for all departments (1,2,4,5)
ORDER BY		TotalSales DESC 
)A


IF OBJECT_ID('Tempdb..#Products') IS NOT NULL DROP TABLE #Products

SELECT		*
INTO		#Products
FROM		Products


--> step 1

DECLARE			 @DepartmentID INT
SET				 @DepartmentID = (SELECT TOP 1 DepartmentID
								  FROM			#Products
								  )

--> Step 2 

IF OBJECT_ID('Tempdb..#Top2ProductByDep') IS NOT NULL
DROP TABLE #Top2ProductByDep

CREATE TABLE	 #Top2ProductByDep  --> highest 2 total sales per department
							(
							DepartmentID INT,
							ProductName VARCHAR(150),
							TotalSales INT
							)



WHILE			 @DepartmentID IS NOT NULL --> condition: as long as this is true

		BEGIN 
				INSERT INTO 	#Top2ProductByDep (DepartmentID,ProductName,TotalSales)
				SELECT	TOP		2 DepartmentID,
								   	ProductName,
									TotalSales
				FROM			#Products 
				WHERE			DepartmentID = @DepartmentID
				ORDER BY		TotalSales DESC
				
				
				DELETE FROM		#Products --> i can not use the physical table
				WHERE			DepartmentID =  @DepartmentID 	
--Step 3
				SET				@DepartmentID = (SELECT TOP 1 DepartmentID
												 FROM			#Products
												 )
		END


--Find top two products per Department ( highest two total sales product per dept)

--> Final Output which is what is being asked above

SELECT			*
FROM			#Top2ProductByDep


SELECT			*
FROM			#Products

------------------------------------------OR--------------------------------------------------

IF OBJECT_ID('Tempdb..#Products') IS NOT NULL 
DROP TABLE #Products

SELECT		*
INTO		#Products
FROM		Products


SELECT			*
FROM			#Products

--> this code below wont provide you with the results requested


SELECT		TOP 2 ProductID,
				  ProductName,
				  DepartmentID,
				  TotalSales
FROM			  Product
ORDER BY		  TotalSales DESC 


--> step 1 

IF OBJECT_ID('Tempdb..#departmentID') IS NOT NULL 
DROP TABLE #departmentID


SELECT	DISTINCT  DepartmentID
INTO			 #departmentID
FROM			 #Products

SELECT			*
FROM			#departmentID

DECLARE			 @DepartmentID INT
SET				 @DepartmentID = (SELECT TOP 1 DepartmentID
								  FROM			#departmentID
								  )

--> Step 2 

IF OBJECT_ID('Tempdb..#Top2ProductByDep') IS NOT NULL
DROP TABLE #Top2ProductByDep
CREATE TABLE	 #Top2ProductByDep
							(
							DepartmentID INT,
							ProductName VARCHAR(150),
							TotalSales INT
							)

WHILE			 @DepartmentID IS NOT NULL

		BEGIN 
				INSERT INTO 	#Top2ProductByDep (DepartmentID,ProductName,TotalSales)
				SELECT	TOP		2 DepartmentID,
								   	ProductName,
									TotalSales
				FROM			#Products
				WHERE			    DepartmentID = @DepartmentID
				ORDER BY		TotalSales DESC
				
				
				DELETE FROM		#departmentID
				WHERE			DepartmentID = @DepartmentID 	
--Step 3
				SET				@DepartmentID = (SELECT TOP 1 DepartmentID
												 FROM			#departmentID
												 )
		END


--Find top two products per Department ( highest two total sales product per dept)

--> Final Output which is what is being asked above

SELECT			*
FROM			#Top2ProductByDep

----------------------CREATING OUR STORED PROCEDURE-------------------------------------

ALTER PROCEDURE dbo.USP_GetTop2Product
AS 
	BEGIN 

	SET NOCOUNT ON;


IF OBJECT_ID('Tempdb..#departmentID') IS NOT NULL 
DROP TABLE #departmentID


SELECT	DISTINCT	 DepartmentID
INTO				 #departmentID
FROM				 MarchOnline2019.dbo.Products



DECLARE			 @DepartmentID INT
SET				 @DepartmentID = (SELECT TOP 1  DepartmentID
								  FROM			#departmentID
								  )

--> Step 2 

IF OBJECT_ID('Tempdb..#Top2ProductByDep') IS NOT NULL
DROP TABLE #Top2ProductByDep

CREATE TABLE	 #Top2ProductByDep
							(
							DepartmentID INT,
							ProductName VARCHAR(150),
							TotalSales INT
							)

WHILE			 @DepartmentID IS NOT NULL

		BEGIN 
				INSERT INTO 	#Top2ProductByDep (DepartmentID,ProductName,TotalSales)
				SELECT	TOP		2  DepartmentID,
								   	ProductName,
									TotalSales
				FROM			    MarchOnline2019.dbo.Products
				WHERE			    DepartmentID = @DepartmentID
				ORDER BY		TotalSales DESC
				
				
				DELETE FROM		#departmentID
				WHERE			DepartmentID = @DepartmentID 	
--Step 3
				SET				@DepartmentID = (SELECT TOP 1	DepartmentID
												 FROM			#departmentID
												 )
		END

--> results from the stored procedure

SELECT			*
FROM			#Top2ProductByDep

END 

EXECUTE		MarchOnline2019.dbo.USP_GetTop2Product


---we will do the OUTPUT parameter with stored procedures next tuesday May 14 2019