/*

Date: 04/20/2019
Section: Limiting and Sorting Data
Class: March 30th Online 2019

*/



/* CLASS WORK:
------------------

Add the constraints when creating the following tables:


Dept
	DeptID --PK
	DeptName -- Unique
	Description


ReportingManager
	ManagerID -- pk, IndentityColumn SEED 10 AND INCREMENT BY 1
	Name
	StartDate -- Default

Employee
		EmployeeID -- pk
		EmpName -- NOT NULL
		Location
		DeptID -- FK
		ManagerID --FK
		StartDate  -- default constraint

*/

USE ColaberryClass
GO

CREATE TABLE Dept
			(
			DeptID INT PRIMARY KEY,
			DeptName VARCHAR(255) UNIQUE,
			[Description] VARCHAR(MAX)
			)

CREATE TABLE ReportingManager
			(
			ManagerID INT PRIMARY KEY IDENTITY (10,1),
			[Name] VARCHAR(255),
			StartDate DATE DEFAULT GETDATE()
			)

CREATE TABLE Employee
			(
			EmployeeID INT PRIMARY KEY,
			EmployeeName VARCHAR(255) NOT NULL,
			[Location] VARCHAR(255), 
			DeptID INT FOREIGN KEY REFERENCES Dept(DeptID),
			ManagerID INT FOREIGN KEY REFERENCES ReportingManager(ManagerID),
			StartDate DATE DEFAULT  CURRENT_TIMESTAMP --GETDATE()
			)

/*
WHERE 
HAVING
UPDATE 
DELETE 
TRUNCATE
ORDER BY
TOP
*/

CREATE TABLE 	Lease (
				LeaseID INT PRIMARY KEY IDENTITY (1000,1),
				LeaseName VARCHAR(50),
				LeaseType VARCHAR(50) NOT NULL,
				City VARCHAR(50),
				[State] VARCHAR (50),
				Zip VARCHAR (50),
				RentAmount INT
					)

SELECT			*
FROM			Lease


INSERT INTO dbo.Lease(LeaseName, LeaseType, City, [State], Zip,RentAmount)
VALUES   ( 'TrumpTowers', '1yr', 'New York', 'NY', '75238', 14000),
		 ( 'FedexBuilding', '6 months', 'Miami', 'FL', '77828', 9000),
		 ('Radison Towers', '2 yr', 'Chicago', 'IL', '72578', 8000),
		 ( 'Federal Building', '6 months', 'New York', 'NY', '76329', 12500),
		 ( 'Ocean Side Building', '2 yr', 'Dallas', 'TX', '75007', 5000),
		 ( 'Radison Twin Towers', '1 yr', 'Dallas', 'TX', '75238', 6000),
		 ( 'Chump City High', '6 months', 'Miami', 'FL', '77829', 7500),
		 ( 'Georgia Towers', '1 yr', 'Atlanta', 'GA', '85249', 6700),
		 ( 'Empire State Building', '2 yrs', 'New York', 'NY', '75238', 15000),
		 ('Austin Building Towers', '1 yr', 'Houston', 'TX', '77385', 6500),
		 ('Overly Building', '2 yr', 'Austin','TX','77440', 7000)

--> or

INSERT INTO dbo.Lease(LeaseName, LeaseType, City, [State], Zip,RentAmount)
SELECT    'TrumpTowers', '1yr', 'New York', 'NY', '75238', 14000
UNION ALL --0R UNION depending if you want duplicate records or not
SELECT	  'FedexBuilding', '6 months', 'Miami', 'FL', '77828', 9000
		 


SELECT			*
FROM			Lease

--> Back Up Table

SELECT			*
INTO			LeaseBackUp --> creating the table and inserting the records at the same
FROM			Lease

SELECT			*
FROM			LeaseBackUp

--> When using SELECT INTO 
  ---> constraints, indexes do not get transferred to the new table 
  --> The nullability, columns data types, column orders, column values, 
		-- and the identity on the columns do get transferred over to the new table


INSERT INTO dbo.LeaseBackUp(LeaseName, LeaseType, City, [State], Zip,RentAmount)
VALUES   ( 'Dallas Towers', '1yr', 'Dallas', 'TX', '75243', 14000)

INSERT INTO dbo.LeaseBackUp(LeaseName, LeaseType, City, [State], Zip,RentAmount)
VALUES   ( 'Dallas Towers', '1yr', 'Dallas', 'TX', '75243', 5000)

INSERT INTO dbo.LeaseBackUp(LeaseName, LeaseType, City, [State], Zip,RentAmount)
VALUES   ( 'Sears Towers', '4yr', 'Paris', 'FR', '12345', 16000)

SELECT			*
FROM			LeaseBackUp

--> Retrieve all leases where the state is TX

SELECT			*
FROM			Lease
WHERE			State = 'TX'


SELECT			*
FROM			Lease
WHERE			State LIKE 'TX'

SELECT			*
FROM			Lease
WHERE			State IN ('TX')

SELECT			*
FROM			Lease 
WHERE			State = 'TX'
OR				City = 'Dallas'


--> Retrieve all leases where the city is not Dallas but the state is TX 

SELECT			*
FROM			Lease
WHERE			State IN ('TX')
AND				City NOT IN ('Dallas') -- or !=

--> UNION OR UNION ALL

SELECT			A.*
INTO			BothLeaseTables --> CREATE A NEW TABLE AND INSERT BOTH RECORDS FROM LEASE AND LEASE BACK UP
FROM 
(

SELECT			*
FROM			Lease

UNION ALL

SELECT			*
FROM			LeaseBackUp

) A

SELECT			*
FROM			BothLeaseTables

--> EXCEPT  -->  TO FIND THE DIFFERENT RECORDS BETWEEN BOTH TABLES  

 --> retrieve leases that are in the first table (lease) but are not in the second table (leasebackup)

--> INTERSECT --> TO FIND THE  COMMON RECORDS BETWEEN BOTH TABLES

--> Retrieve leases that are in both tables (lease and the leasebackup)


DELETE FROM		LeaseBackUp
WHERE			LeaseID <= 1007

SELECT			A.*
INTO			LeaseExceptLeaseBackUp
FROM			(

SELECT			*
FROM			Lease
EXCEPT
SELECT			*
FROM			LeaseBackUp
				)A

SELECT			B.*
INTO			LeaseIntersectLeaseBackUp
FROM			(

SELECT			*
FROM			Lease
INTERSECT
SELECT			*
FROM			LeaseBackUp

				)B


SELECT			*
FROM			LeaseExceptLeaseBackUp



SELECT			*
FROM			LeaseIntersectLeaseBackUp


--> UPDATE --> All Austin Leases have been moved to Houston

SELECT			*
FROM			Lease
WHERE			City = 'Austin' --> the city in the table needs to be Houston

SELECT			*
FROM			Lease
WHERE			City = 'Houston'

UPDATE			Lease
SET				City = 'Houston'
WHERE			City = 'Austin' --WHERE LeaseName = 'Overly Building'


--> All Paris Leases have been moved to Houston and the lease type has to match all current Houston leases

SELECT			*
FROM			LeaseBackUp


UPDATE			LeaseBackUp
SET				City= 'Houston',
				LeaseType = '1 yr'
WHERE			City  ='Paris'

--> OR

UPDATE			LeaseBackUp
SET				City= 'Houston'
WHERE			City  ='Paris'

UPDATE			LeaseBackUp
SET				LeaseType ='1 yr'
WHERE			City  ='Houston'


--> Retrieve all TX leases with the total RentAmount greater than 12,000
		--> City, State and the total RentAmount

--> What am i grouping by? City and State

-->What am i aggregating? RentAmount (SUM)

SELECT			City,
				State,
				SUM(RentAmount) AS TotalRentAmount
FROM			dbo.Lease
WHERE			State = 'TX'  --> use when applying requirment to an existing column
GROUP BY		City,
				State
HAVING			SUM(RentAmount) > 12000 --> use when applying requirements on the column being aggregated


--> YOU CAN NOT DO THIS BELOW

SELECT			City,
				State,
				SUM(RentAmount) AS TotalRentAmount
FROM			dbo.Lease
WHERE			State = 'TX'  --> use when applying requirment to an existing column
GROUP BY		City,
				State
HAVING			TotalRentAmount > 12000 --> THIS WONT WORK

--> order by does work when i use the new column name

SELECT			City,
				State,
				SUM(RentAmount) AS TotalRentAmount
FROM			dbo.Lease
WHERE			State = 'TX'  --> use when applying requirment to an existing column
GROUP BY		City,
				State
ORDER BY		SUM(RentAmount) DESC 

SELECT			City,
				State,
				SUM(RentAmount) AS TotalRentAmount
FROM			dbo.Lease
WHERE			State = 'TX'  --> use when applying requirment to an existing column
GROUP BY		City,
				State
ORDER BY		TotalRentAmount DESC  --> THIS IS THE ONLY TIME I CAN USE THE NEW COLUMN NAME

USE [AdventureWorks2016]
GO


/*CLASS WORK*/

--> RETRIEVE THE GROUP WITH THE HIGHEST TOTAL SALES
		--> COLUMNS TO RETRIEVE IS GROUP AND THE TOTAL SALESYTD

		--> what are we grouping by? --> Group
		--> what are we aggregating? --> SalesYTD

--> list of reserved words at  https://docs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=RSQL_reservedwords 

--> Step 1

SELECT	 		[Group], --> reserved SQL word
				SUM(SalesYTD) TotalYTD
FROM			[Sales].[SalesTerritory]		
GROUP BY		[Group]

--> Step 2	

SELECT	 		[Group], --> reserved SQL word
				SUM(SalesYTD) TotalYTD
FROM			[Sales].[SalesTerritory]		
GROUP BY		[Group]	
ORDER BY		SUM(SalesYTD) DESC

--> Step 3

SELECT	TOP 1 	[Group], --> reserved SQL word
				SUM(SalesYTD) TotalYTD
FROM			[Sales].[SalesTerritory]		
GROUP BY		[Group]	
ORDER BY		SUM(SalesYTD) DESC

--> Retrieve the top 5 TerritoryID based on the SalesYTD(FROM THE HIGHEST TO THE LOWEST SALESYTD)

SELECT	TOP   5		TerritoryID,
					Name
FROM				[Sales].[SalesTerritory]
ORDER BY			SalesYTD DESC


SELECT			*
FROM			[Sales].[SalesTerritory]


SELECT				*
FROM				[Sales].[SalesTerritory]
ORDER BY			SalesYTD ASC  --> ORDERING THE RECORDS FROM THE SMALLER VALUE TO THE HIGHEST VALUE

--> ASC IS THE DEFAULT ONE.

--> ORDER BY Clause 
			--> sort the data ascending (by default) and descending order
			--> it is used in the last statement in the syntax block

--> The highest City State and total Rent Amount for leases in TX

SELECT	TOP 1	City,
				State,
				SUM(RentAmount) AS TotalRentAmount
FROM			dbo.Lease
WHERE			State = 'TX'  --> use when applying requirment to an existing column
GROUP BY		City,
				State
HAVING			SUM(RentAmount) < 12000 --> use when applying requirements on the column being aggregated
ORDER BY		SUM(RentAmount) DESC
 
/*

DELETE Command 
		--> DML command Data Manipulation Language Command
		--> It allows you to delete records from the table one row at a time
		--> Because DELETE removes records one row at a time it takes longer to execute
		--> When DELETE is used, the records can be rolled back ( use back up to get data back)
		--> DELETE does not reset the identity constraint on a column

DELETE FROM TableName

DELETE FROM TableName
WHERE		ColumName = ..

*/


/* TRUNCATE TABLE TableName
			--> DDL Command Data Definition Language Command
			--> TRUNCATE is faster than DELETE 
			--> Can not be rolled back 
			--> Resets the identity constraint on a column

TRUNCATE TABLE TableName

*/

SELECT			*
FROM			ColaberryClass.dbo.Lease

INSERT INTO ColaberryClass.dbo.Lease(LeaseName, LeaseType, City, [State], Zip,RentAmount)
VALUES   ( 'Dallas Towers', '1yr', 'Dallas', 'TX', '75243', 14000)

DELETE FROM ColaberryClass.dbo.Lease
WHERE		LeaseID = 1011

INSERT INTO ColaberryClass.dbo.Lease(LeaseName, LeaseType, City, [State], Zip,RentAmount)
VALUES   ( 'Dallas Towers', '1yr', 'Dallas', 'TX', '75243', 14000)

SELECT			*
FROM			ColaberryClass.dbo.Lease

TRUNCATE TABLE ColaberryClass.dbo.Lease

INSERT INTO ColaberryClass.dbo.Lease(LeaseName, LeaseType, City, [State], Zip,RentAmount)
VALUES   ( 'Dallas Towers', '1yr', 'Dallas', 'TX', '75243', 14000)

SELECT			*
FROM			ColaberryClass.dbo.Lease

DELETE FROM ColaberryClass.dbo.Lease

INSERT INTO ColaberryClass.dbo.Lease(LeaseName, LeaseType, City, [State], Zip,RentAmount)
VALUES   ( 'Dallas Towers', '1yr', 'Dallas', 'TX', '75243', 14000)

SELECT			*
FROM			ColaberryClass.dbo.Lease


INSERT INTO dbo.Lease(LeaseName, LeaseType, City, [State], Zip,RentAmount)
VALUES   ( 'TrumpTowers', '1yr', 'New York', 'NY', '75238', 14000),
		 ( 'FedexBuilding', '6 months', 'Miami', 'FL', '77828', 9000),
		 ('Radison Towers', '2 yr', 'Chicago', 'IL', '72578', 8000),
		 ( 'Federal Building', '6 months', 'New York', 'NY', '76329', 12500),
		 ( 'Ocean Side Building', '2 yr', 'Dallas', 'TX', '75007', 5000),
		 ( 'Radison Twin Towers', '1 yr', 'Dallas', 'TX', '75238', 6000),
		 ( 'Chump City High', '6 months', 'Miami', 'FL', '77829', 7500),
		 ( 'Georgia Towers', '1 yr', 'Atlanta', 'GA', '85249', 6700),
		 ( 'Empire State Building', '2 yrs', 'New York', 'NY', '75238', 15000),
		 ('Austin Building Towers', '1 yr', 'Houston', 'TX', '77385', 6500),
		 ('Overly Building', '2 yr', 'Austin','TX','77440', 7000)