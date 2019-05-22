--working with variables

DECLARE @FullName varchar(255) = 'Tamburello,Roberto'

DECLARE @LastName VARCHAR(255)= LEFT(@FullName,CHARINDEX(',',@FullName)-1)
SELECT @LastName 

DECLARE @FirstName VARCHAR(255) = Right(@FullName,LEN(@FullName) - CharIndex(',',@FullName))
SELECT @FirstName

--or 

DECLARE @FullName VARCHAR(255) = 'Tamburello,Roberto'

DECLARE @LastName VARCHAR(255) 
					--= SUBSTRING(@FullName,1,CHARINDEX(',',@FullName) -1 )
					= LEFT(@FullName,CHARINDEX(',',@FullName)-1)

DECLARE	@FirstName VARCHAR(255) 
					= SUBSTRING(@FullName,CHARINDEX(',',@FullName)+1,LEN(@FullName))

SELECT @LastName AS LASTNAME
SELECT @FirstName AS FIRSTNAME


DECLARE @TerritoryTable	TABLE (
						TerritoryId int,
						TotalSales int
						)
SELECT		*
FROM		Sales.SalesOrderHeader

Insert Into		@TerritoryTable
Select			TerritoryID,
				SUM(TotalDue)
FROM			Sales.SalesOrderHeader
GROUP BY		TerritoryID

SELECT		*
FROM		@TerritoryTable

DECLARE		@NorthAmerica Table (
								TerritoryId int,
								[Name] varchar(255),
								[Group] varchar(255),
								SalesYTD int)

Insert Into		@NorthAmerica
Select			TerritoryID,
				[Name],
				[Group],
				SalesYTD
From			Sales.SalesTerritory
Where			[Group] = 'North America'		

Update			@NorthAmerica			
Set          TerritoryId = 10

Select			*
From			@NorthAmerica		


DECLARE			@FirstName varchar(50)
SET				@FirstName = 'Mr. Test'
Print			@FirstName --- print will display as message not in result
--or 
Select			@FirstName

-- declare var
Declare			@FName varchar(50),
				@LName varchar(50),
				@PhNo  int
--initialize var with select or set
Select			@FName = 'Art'
SET				@LName = 'Van'
Select			@PhNo  = 1234569870 
--query var with select to see in result as table or use print to display value in message
Select			@FName,@LName,@PhNo

DECLARE			@startDate DATETIME,
				@years int

Set				@startDate = '12-15-2018'
Set				@years = 10

Select			DATEADD(yy,@years,@startDate)

---------- Table Variable

Declare			@myTableVar Table (
				empId int,
				empName varchar(50),
				deptId int)

Insert Into		@myTableVar
Select			1,'TestNAme',2
Union
Select			2,'Smith',3
Union
Select			3,'Mike',1

Select			*
From			@myTableVar

Declare			@DeptVar Table(
				deptID int,
				deptName varchar(50))

Insert Into		@DeptVar
Select			1,'Sql'
Union	
Select			2,'FrontEnd'
Union
Select			3,'QA'

Select			*
From			@DeptVar
Where			deptID = 2

--Select			*
--From			@DeptVar
--Union
--Select			*
--From			@myTableVar

Declare		@MaxID int
Select		@MaxID = Max(deptId)
From		dept

Select		@MaxID
