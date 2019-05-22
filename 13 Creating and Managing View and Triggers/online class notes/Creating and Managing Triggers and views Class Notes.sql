/*
Date: 05/21/2019
Section 13: Creating and Managing Triggers and Views
Class: March Online 2019
*/


/*
 A view is like a virtual table that consists of columns from one or more tables.

 Where are views located at?

 --> Open the node for a specific Database --> Click on node for Views
*/

 --> Syntax for a view

 CREATE VIEW [MyFirstView]
 AS 

 --> Write your script

 GO 


--> example of a view from AdventureWorks

SELECT			*
FROM			[HumanResources].[vEmployee]

--> to find the view's query

SELECT		   OBJECT_DEFINITION(OBJECT_ID ('[HumanResources].[vEmployee]')) AS vEmployeeDefinition

GO
CREATE VIEW		[HumanResources].[vEmployee]   
AS   
SELECT       e.[BusinessEntityID]      
			,p.[Title]      
			,p.[FirstName]      
			,p.[MiddleName]      
			,p.[LastName]      
			,p.[Suffix]      
			,e.[JobTitle]        
			,pp.[PhoneNumber]      
			,pnt.[Name] AS [PhoneNumberType]      
			,ea.[EmailAddress]      
			,p.[EmailPromotion]      
			,a.[AddressLine1]      
			,a.[AddressLine2]      
			,a.[City]      
			,sp.[Name] AS [StateProvinceName]       
			,a.[PostalCode]      
			,cr.[Name] AS [CountryRegionName]       
			,p.[AdditionalContactInfo]  
FROM		[HumanResources].[Employee] e   
INNER JOIN  [Person].[Person] p   
ON			p.[BusinessEntityID] = e.[BusinessEntityID]      
INNER JOIN [Person].[BusinessEntityAddress] bea       
ON			bea.[BusinessEntityID] = e.[BusinessEntityID]       
INNER JOIN [Person].[Address] a       
ON			a.[AddressID] = bea.[AddressID]      
INNER JOIN [Person].[StateProvince] sp       
ON			sp.[StateProvinceID] = a.[StateProvinceID]      
INNER JOIN [Person].[CountryRegion] cr       
ON			cr.[CountryRegionCode] = sp.[CountryRegionCode]     
LEFT OUTER JOIN [Person].[PersonPhone] pp      
ON			pp.BusinessEntityID = p.[BusinessEntityID]      
LEFT OUTER JOIN [Person].[PhoneNumberType] pnt      
ON			pp.[PhoneNumberTypeID] = pnt.[PhoneNumberTypeID]      
LEFT OUTER JOIN [Person].[EmailAddress] ea      
ON			p.[BusinessEntityID] = ea.[BusinessEntityID];  

GO
ALTER VIEW 	[HumanResources].[vEmployee]   
AS   
SELECT       e.[BusinessEntityID]      
			,p.[Title]      
			,p.[FirstName]      
			,p.[MiddleName]      
			,p.[LastName]      
			,p.[Suffix]      
			,e.[JobTitle]        
			,pp.[PhoneNumber]      
			,pnt.[Name] AS [PhoneNumberType]      
			,ea.[EmailAddress]      
			,p.[EmailPromotion]      
			,a.[AddressLine1]      
			,a.[AddressLine2]      
			,a.[City]      
			,sp.[Name] AS [StateProvinceName]       
			,a.[PostalCode]      
			,cr.[Name] AS [CountryRegionName]       
			,p.[AdditionalContactInfo]  
FROM		[HumanResources].[Employee] e   
INNER JOIN  [Person].[Person] p   
ON			p.[BusinessEntityID] = e.[BusinessEntityID]      
INNER JOIN [Person].[BusinessEntityAddress] bea       
ON			bea.[BusinessEntityID] = e.[BusinessEntityID]       
INNER JOIN [Person].[Address] a       
ON			a.[AddressID] = bea.[AddressID]      
INNER JOIN [Person].[StateProvince] sp       
ON			sp.[StateProvinceID] = a.[StateProvinceID]      
INNER JOIN [Person].[CountryRegion] cr       
ON			cr.[CountryRegionCode] = sp.[CountryRegionCode]     
LEFT OUTER JOIN [Person].[PersonPhone] pp      
ON			pp.BusinessEntityID = p.[BusinessEntityID]      
LEFT OUTER JOIN [Person].[PhoneNumberType] pnt      
ON			pp.[PhoneNumberTypeID] = pnt.[PhoneNumberTypeID]      
LEFT OUTER JOIN [Person].[EmailAddress] ea      
ON			p.[BusinessEntityID] = ea.[BusinessEntityID];  

/*

Sales.SalesOrderHeader
Sales.SalesTerritory

Create a view to display / include the columns from above two tables
		1. Order date
		2. Due Date
		3. Status
		4. Online Flag
		5. Territory
		6. Freight
		7. TotalDue

*/

/*
GO
 CREATE VIEW [MyFirstView]
 AS 

 --> Write your script

 */

 GO
 CREATE VIEW   VSalesDetails
 AS 

 SELECT		    OrderDate,
				DueDate,
				Status,
				OnlineOrderFlag,
				Name as Territory,
				Freight,
				TotalDue
 FROM			AdventureWorks2016.Sales.SalesOrderHeader  SOH
 INNER JOIN		AdventureWorks2016.Sales.SalesTerritory ST
 ON				SOH.TerritoryID = ST.TerritoryID



 SELECT			*
 FROM			VSalesDetails
 WHERE			Territory ='Northwest'

 --OR

  SELECT		    OrderDate,
				DueDate,
				Status,
				OnlineOrderFlag,
				Name as Territory,
				Freight,
				TotalDue
 FROM			AdventureWorks2016.Sales.SalesOrderHeader  SOH
 INNER JOIN		AdventureWorks2016.Sales.SalesTerritory ST
 ON				SOH.TerritoryID = ST.TerritoryID
 WHERE			ST.Name = 'Northwest'

 --> to change the code in a view

  GO
 ALTER VIEW   VSalesDetails
 AS 

 SELECT		    OrderDate,
				DueDate,
				Status,
				OnlineOrderFlag,
				Name as Territory,
				SOH.TerritoryID,
				Freight,
				TotalDue
 FROM			AdventureWorks2016.Sales.SalesOrderHeader  SOH
 INNER JOIN		AdventureWorks2016.Sales.SalesTerritory ST
 ON				SOH.TerritoryID = ST.TerritoryID

 SELECT			*
 FROM			VSalesDetails


 ---------------------------------------------------------------------------------------
 ------------------------------TRIGGERS-------------------------------------------------
 ---------------------------------------------------------------------------------------


 /*

 a TRIGGER	is a special kind of stored procedure that is called whenever there is an 
 attempt made to modify data in a table it protects

 It is a database object 

 --> Database --> table --> Triggers

 --> two types of TRIGGERS

 ** AFTER trigger (FOR Trigger)
 ** INSTEAD OF trigger

 */


 /*************************************************************

 AFTER Trigger (For Trigger)
 The after trigger run after an insert, update or delete on a table

	--> AFTER INSERT Trigger
	--> AFTER UPDATE Trigger
	--> AFTER DELETE Trigger

 ****************************************************************/

 USE MarchOnline2019
 GO

 CREATE TABLE  Emp
 (
 EmpID INT IDENTITY (1,1),
 EmpName VARCHAR(255),
 EmpSalary INT
  )

  INSERT INTO Emp(EmpName, EmpSalary)
  SELECT 'Taiwo', 1000
  UNION ALL 
  SELECT 'Selam', 1200
  UNION ALL 
  SELECT  'Maria', 1100
  UNION ALL
  SELECT 'Gee', 1300
  UNION ALL 
  SELECT 'Alex', 1400

  SELECT			*
  FROM				Emp

--> Create an audit table to store actions on records in the Emp table

CREATE TABLE EmpAudit
(
EmpID INT,
EmpName VARCHAR(255),
EmpSalary INT,
AuditAction NVARCHAR(255),
Audit_TimeStamp DATETIME,
ModifiedBy NVARCHAR(255)
)

SELECT			*
FROM			EmpAudit

SELECT			*
FROM			Emp



/*

CREATE AN AFTER TRIGGER ON THE TABLE emp and use the EmpAudit table to keep a history
of any inserts made to the emp table

*/

GO
CREATE TRIGGER		Trg_AfterInsert  --> name the trigger
ON					Emp   --Table you are creating the trigger on
FOR INSERT			--> OR AFTER INSERT
AS

--> your code goes here

DECLARE				@EmpID INT,
					@EmpName VARCHAR(255),
					@EmpSalary INT,
					@AuditAction NVARCHAR(255),
					@Audit_TimeStamp DATETIME,
					@ModifiedBy NVARCHAR(255)
					
--with triggers we use logical tables
		--> inserted ( it will have values of records being inserted )
		--> deleted	(it will have values of records being deleted)						
		
SELECT		       	@EmpID = i.EmpID  --> empID value being inserted into the table Emp
FROM				inserted AS i	--> logical table

--> inserted is a logical table that allows you to get the values of the inserted record in the Emp table

SELECT				@EmpName = i.EmpName  --> EmpName value being inserted into the table Emp
FROM				inserted AS i

SELECT			    @EmpSalary = i.EmpSalary --> EmpSalary value being inserted into the table Emp
FROM				inserted AS i

SELECT				@AuditAction = 'Record Inserted in the Emp table'

SELECT				@Audit_TimeStamp = CURRENT_TIMESTAMP

SELECT				@ModifiedBy = SYSTEM_USER

INSERT INTO			EmpAudit
SELECT				@EmpID, @EmpName, @EmpSalary, @AuditAction, @Audit_TimeStamp, @ModifiedBy



-------------------------------------------------------------------------------------------------

--Let's insert a new record in our Emp table after the trigger has been created

  INSERT INTO		Emp(EmpName, EmpSalary)
  SELECT			'Lawrence', 900	

  SELECT			*
  FROM				Emp

  SELECT			*
  FROM				EmpAudit

/*

CREATE AN AFTER TRIGGER (FOR TRIGGER) FOR DELETE

*/


GO
CREATE TRIGGER		Trg_AfterDelete  --> name the trigger
ON					Emp   --Table you are creating the trigger on
FOR DELETE			--> OR AFTER DELETE
AS

DECLARE				@EmpID INT,
					@EmpName VARCHAR(255),
					@EmpSalary INT,
					@AuditAction NVARCHAR(255),
					@Audit_TimeStamp DATETIME,
					@ModifiedBy NVARCHAR(255)
					
--> assign values to the variable using the records that have been deleted

SELECT				@EmpID = d.EmpID
FROM				deleted d	

SELECT				@EmpName = d.EmpName
FROM				deleted d

SELECT				@EmpSalary = d.EmpSalary
FROM				deleted d

SET					@AuditAction = 'Record Deleted from the Emp Table'

SET					@Audit_TimeStamp = CURRENT_TIMESTAMP

SET					@ModifiedBy = SYSTEM_USER

INSERT INTO			EmpAudit

SELECT				@EmpID, @EmpName, @EmpSalary, @AuditAction, @Audit_TimeStamp, @ModifiedBy

--> you dont have to use variables for AuditAction, Audit_TimeStamp and ModifiedBy

--SELECT				@EmpID, @EmpName, @EmpSalary,'Record Deleted from the Emp Table',CURRENT_TIMESTAMP, SYSTEM_USER

----------------------------------------------Test the FOR DELETE TRIGGER 

DELETE FROM			Emp
WHERE				EmpID = 1

SELECT				*
FROM				Emp

SELECT				*
FROM				EmpAudit

--> I dont want to use the variables for the columns  AuditAction, Audit_TimeStamp and ModifiedBy

GO
ALTER TRIGGER		Trg_AfterDelete  --> name the trigger
ON					Emp   --Table you are creating the trigger on
FOR DELETE			--> OR AFTER DELETE
AS

DECLARE				@EmpID INT,
					@EmpName VARCHAR(255),
					@EmpSalary INT --,
					--@AuditAction NVARCHAR(255),
					--@Audit_TimeStamp DATETIME,
					--@ModifiedBy NVARCHAR(255)
					
--> assign values to the variable using the records that have been deleted

SELECT				@EmpID = d.EmpID
FROM				deleted d	

SELECT				@EmpName = d.EmpName
FROM				deleted d

SELECT				@EmpSalary = d.EmpSalary
FROM				deleted d

--SET					@AuditAction = 'Record Deleted from the Emp Table'

--SET					@Audit_TimeStamp = CURRENT_TIMESTAMP

--SET					@ModifiedBy = SYSTEM_USER

INSERT INTO			EmpAudit

--SELECT				@EmpID, @EmpName, @EmpSalary, @AuditAction, @Audit_TimeStamp, @ModifiedBy

--> you dont have to use variables for AuditAction, Audit_TimeStamp and ModifiedBy

SELECT				@EmpID, @EmpName, @EmpSalary,'Record Deleted from the Emp Table',CURRENT_TIMESTAMP, SYSTEM_USER

----------------------------------------------Test the FOR DELETE TRIGGER 

DELETE FROM		Emp
WHERE			EmpID = 5

SELECT			*
FROM			Emp

SELECT			*
FROM			EmpAudit

/*

We want to show the user deleting the records that there is an audit table 

*/

GO
ALTER TRIGGER		Trg_AfterDelete  --> name the trigger
ON					Emp   --Table you are creating the trigger on
FOR DELETE			--> OR AFTER DELETE
AS

DECLARE				@EmpID INT,
					@EmpName VARCHAR(255),
					@EmpSalary INT --,
					--@AuditAction NVARCHAR(255),
					--@Audit_TimeStamp DATETIME,
					--@ModifiedBy NVARCHAR(255)
					
--> assign values to the variable using the records that have been deleted

SELECT				@EmpID = d.EmpID
FROM				deleted d	

SELECT				@EmpName = d.EmpName
FROM				deleted d

SELECT				@EmpSalary = d.EmpSalary
FROM				deleted d

--SET					@AuditAction = 'Record Deleted from the Emp Table'

--SET					@Audit_TimeStamp = CURRENT_TIMESTAMP

--SET					@ModifiedBy = SYSTEM_USER

PRINT ('Please check the audit table for the deleted records!!!!!!!!!')

INSERT INTO			EmpAudit

--SELECT				@EmpID, @EmpName, @EmpSalary, @AuditAction, @Audit_TimeStamp, @ModifiedBy

--> you dont have to use variables for AuditAction, Audit_TimeStamp and ModifiedBy

SELECT				@EmpID, @EmpName, @EmpSalary,'Record Deleted from the Emp Table',CURRENT_TIMESTAMP, SYSTEM_USER

----------------------------------------------Test the FOR DELETE TRIGGER ---------------

DELETE FROM			Emp
WHERE				EmpID = 3

SELECT				*
FROM				Emp

SELECT				*
FROM				EmpAudit

/*

AFTER TRIGGER (UPDATE)

We are going to create a FOR UPDATE TRIGGER on the emp table to record any update made on 
the columns EmpName and EmpSalary ( Empid has an identity constraint)using the EmpAudit table

*/


GO 
CREATE TRIGGER trg_AfterUpdate
ON				Emp
FOR				UPDATE 
AS

--> Declare my variables

DECLARE			@EmpID INT,
				@EmpName VARCHAR(255),
				@EmpSalary INT,
				@AuditAction NVARCHAR(255),
				@Audit_TimeStamp DATETIME,
				@ModifiedBy NVARCHAR(255)

--> Assign values from inserted for the columns EmpID, EmpName, EmpSalary

SELECT			@EmpID = i.EmpId
FROM			inserted AS i

SELECT			@EmpName = i.EmpName
FROM			inserted AS i

SELECT			@EmpSalary = i.EmpSalary
FROM			inserted AS i

--SELECT			@AuditAction = 'Record has been updated in the Emp table'
SELECT			@Audit_TimeStamp = CURRENT_TIMESTAMP
SELECT		    @ModifiedBy = SYSTEM_USER

--> Let's be specific on the column that was updated

IF UPDATE (EmpName)
			SET @AuditAction = 'EmpName has been updated in the Emp Table'
IF UPDATE (EmpSalary)
			SET @AuditAction = 'EmpSalary has been updated in the Emp Table'

INSERT INTO		EmpAudit
SELECT			@EmpID, @EmpName, @EmpSalary, @AuditAction, @Audit_TimeStamp, @ModifiedBy

---------------------------------------------------------------------------------------------

SELECT			*
FROM			EmpAudit

SELECT			*
FROM			Emp

UPDATE			Emp
SET				EmpSalary = 2400
WHERE			EmpID = 6

SELECT			*
FROM			EmpAudit


--> we just want to insert a record when an update occured we do not need to track what column
 --was updated in the emp table in the AuditAction column 

 
GO 
ALTER TRIGGER trg_AfterUpdate
ON				Emp
FOR				UPDATE 
AS

--> Declare my variables

DECLARE			@EmpID INT,
				@EmpName VARCHAR(255),
				@EmpSalary INT,
				@AuditAction NVARCHAR(255),
				@Audit_TimeStamp DATETIME,
				@ModifiedBy NVARCHAR(255)

--> Assign values from inserted for the columns EmpID, EmpName, EmpSalary

SELECT			@EmpID = i.EmpId
FROM			inserted AS i

SELECT			@EmpName = i.EmpName
FROM			inserted AS i

SELECT			@EmpSalary = i.EmpSalary
FROM			inserted AS i

SELECT			@AuditAction = 'Record has been updated in the Emp table'
SELECT			@Audit_TimeStamp = CURRENT_TIMESTAMP
SELECT		    @ModifiedBy = SYSTEM_USER

--> Let's be specific on the column that was updated

--IF UPDATE (EmpName)
--			SET @AuditAction = 'EmpName has been updated in the Emp Table'
--IF UPDATE (EmpSalary)
--			SET @AuditAction = 'EmpSalary has been updated in the Emp Table'

INSERT INTO		EmpAudit
SELECT			@EmpID, @EmpName, @EmpSalary, @AuditAction, @Audit_TimeStamp, @ModifiedBy


---------------------------------------------------------------------------

UPDATE			Emp
SET				EmpSalary = 1500
WHERE			EmpID = 2

SELECT			*
FROM			Emp

SELECT			*
FROM			EmpAudit