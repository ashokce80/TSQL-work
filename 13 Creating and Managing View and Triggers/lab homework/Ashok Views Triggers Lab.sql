/* 
Ashok R
View and Triggers Lab work
5.21.19
*/
/*
1. CREATE the following tables �
a. Dept_triggers � Add Identity Column (1000,1)
b. Emp_triggers� Add Identity Column (1000,1)
c. Emphistory */

Create table	Emp_triggers(
				empID int not null Identity(1000,1) Primary key
				,empName varchar(50)
				,deptID int )

Create table	Dept_triggers(
				deptID int not null Identity(1000,1) Primary key
				)
Create Table	EmpHistory (empId int
				,empName varchar(50)
				,deptId int
				,isActive int)

Select	*
From			Emp_triggers
	
Select	*
From			EmpHistory
	
Select	*
From			Dept_triggers



---2. TRIGGERS

--a. Trigger 1 - Build a trigger on the emp table after insert that adds a record into the emp_History table and marks IsActive column to 1

Go
Alter Trigger TR_empTR_afterInsert 
on Emp_triggers
After Insert
AS
Begin 
		Declare @empId int,	@empName varchar(50), @deptId int
		--Select * From	inserted

		Select	@empId = i.empID from inserted i	
		Select	@empName = i.empName From inserted	i
		Select	@deptId = i.deptID from inserted i	
		
		Insert Into EmpHistory(empId,empName,deptId,isActive)
		Values		(@empId,@empName,@deptId,1)
		Print 'After Insert Trigger for Emp'
End

Insert into Emp_triggers(empName,deptID)
Values		('Torer',3)

--b. Trigger 2 � Build a tirgger on the emp table after an update of the empname or deptid column - It updates the subsequent empname and/or deptid in the emp_history table.

Go
Alter Trigger TR_empTR_AfterUpdate
On Emp_triggers
After Update
AS
Begin	
	declare @empID int, @empName varchar(100), @deptID int
	
	Select	@empName = i.empName From inserted i
	Select	@empID = i.empID  From inserted i	
	Select	@deptID = i.deptID From inserted i
	
	If UPDATE(empName)
	Begin	
		Update		EmpHistory
		Set			empName = @empName
		Where		 empId = @empID
	End

	If UPDATE(deptID)
	Begin
	    Update		EmpHistory
		Set			deptId = @deptID
		Where		empId = @empID
	End		
	Print 'After Update Trigger for Emp'
end

Update Emp_triggers
Set	   empName = 'jeffo' 
Where	empID = 1000

--c. Build a trigger on the emp table after delete that marks the isactive status = 0 in the emp_History table.

Go
Alter Trigger TR_empTR_afterDelete
On				Emp_triggers
After Delete
AS
Begin
	declare @empID int, @empName varchar(100), @deptID int

	Select		*
	Into		#empHistoryBackup
	From		deleted

	--Select		*
	--From		#empHistoryBackup

	while exists(Select * From #empHistoryBackup)
	Begin
		Select top 1 @empID = eHB.empID
					,@empName = eHB.empName
					,@deptID = eHB.deptID
	    From		#empHistoryBackup eHB
		Order by	eHB.empID asc
		
		--Print @empID	
		
		Update  EmpHistory
		Set		isActive = 0
		Where	@empID = empId
		--OR		@empName = empName
		--OR		@deptID = deptId

		Delete #empHistoryBackup
		Where  @empID = empID
		
		--Select		*
		--From		#empHistoryBackup

		Print @empID
	End
		Print'AFter delete for EMP trigger set isActive 0 in empHistory table'
End


Select	*
From 	Emp_triggers
	
Select	*
From	EmpHistory

Select	*
From	Dept_triggers

Delete			Emp_triggers
Where			deptID = 3


--3. Run this script � Results should show 10 records in the emp history table all with an active status of 0

INSERT INTO dbo.Emp_triggers
SELECT 'Ali',1000
INSERT INTO dbo.Emp_triggers
SELECT 'Buba',1000
INSERT INTO dbo.Emp_triggers
SELECT 'Cat',1001
INSERT INTO dbo.Emp_triggers
SELECT 'Doggy',1001
INSERT INTO dbo.Emp_triggers
SELECT 'Elephant',1002
INSERT INTO dbo.Emp_triggers
SELECT 'Fish',1002
INSERT INTO dbo.Emp_triggers
SELECT 'George',1003
INSERT INTO dbo.Emp_triggers
SELECT 'Mike',1003
INSERT INTO dbo.Emp_triggers
SELECT 'Anand',1004
INSERT INTO dbo.Emp_triggers
SELECT 'Kishan',1004
DELETE FROM dbo.Emp_triggers

Select	*
From	EmpHistory


--4. Create 5 views � Each view will use 3 tables and have 9 columns with 3 coming from each table.
--a. Create a view using 3 Human Resources Tables (Utilize the WHERE clause)

Go
Create View Vw_HRresourceTbls
AS
	Select		HRE.BusinessEntityID
				,HRE.LoginID
				,SUBSTRING(HRE.LoginID,CHARINDEX('\',HRE.LoginID)+1,LEN(HRE.LoginID)) as LoginName
				,HRE.JobTitle
				,HREDH.DepartmentID
				,HREDH.StartDate
				,HREDH.EndDate
				,HRD.[Name]
				,HRD.GroupName
				,HRD.ModifiedDate
	From		[AdventureWorks2014].[HumanResources].[Employee] as HRE
	Inner join	[AdventureWorks2014].[HumanResources].											[EmployeeDepartmentHistory] as HREDH
	on			HRE.BusinessEntityID = HREDH.BusinessEntityID
	Inner join	[AdventureWorks2014].[HumanResources].[Department] as HRD
	On			HRD.DepartmentID = HREDH.DepartmentID
GO

Select			*
From			Vw_HRresourceTbls

--b. Create a view using 3 Person Tables (Utilize 3 system functions)

GO
Create View VW_PersonTables
as 
Select		PEMAIL.BusinessEntityID
			,PP.PersonType 
			,PP.Title
			,CONCAT(PP.FirstName,' ',PP.LastName) as [Full Name]
			, SUBSTRING(PEMAIL.EmailAddress,CHARINDEX('@',PEMAIL.EmailAddress)+1,LEN(PEMAIL.EmailAddress)) AS DomainName
			,PEMAIL.ModifiedDate as [Person Email Modified date]
			,PBusE.AddressID
			,PBusE.AddressTypeID
			,PBusE.ModifiedDate as [BusEntity Modified Date]
From		[AdventureWorks2014].[Person].[Person] as PP
INNER JOIN	[AdventureWorks2014].[Person].[EmailAddress] AS PEMAIL
On			PP.BusinessEntityID = PEMAIL.BusinessEntityID
Inner join	[AdventureWorks2014].[Person].[BusinessEntityAddress] as PBusE
On			PBusE.BusinessEntityID = PEMAIL.BusinessEntityID
Go

Select		*
From		VW_PersonTables

--c. Create a view using 3 Production Tables (Utilize the Group By Statement)

Go
Create	View	VW_ProductTables
as
Select			PPro.ProductID, PPro.Name as Product_Name
				,SUM(ListPrice - StandardCost) as Profit
				,PPro.DaysToManufacture
				,PTran.TransactionDate as TansactionDate
				,PTran.TransactionID, PTran.ActualCost
				,PProCat.ProductCategoryID
				,PProCat.Name as Product_Category_Name
				,PProSubC.Name as [Product Sub-Category]
From			[AdventureWorks2014].[Production].[Product] as PPro
Inner join		[AdventureWorks2014].[Production].[TransactionHistory] as PTran
On				PPro.ProductID = PTran.ProductID
Inner join		[AdventureWorks2014].[Production].ProductSubcategory as							PProSubC
On				PProSubC.ProductSubcategoryID = PPro.ProductSubcategoryID
Inner join		[AdventureWorks2014].[Production].ProductCategory as PProCat
On				PProCat.ProductCategoryID = PProSubC.ProductCategoryID
Group	by		PPro.ProductID,PProSubC.Name,PProCat.Name ,  PPro.[Name]
				,PPro.DaysToManufacture
				,PTran.TransactionDate 
				,PTran.TransactionID, PTran.ActualCost
				,PProCat.ProductCategoryID
GO

Select			*
From			VW_ProductTables


--d. Create a view using 3 Purchasing Tables (Utilize the HAVING clause)

GO
Create View VW_ProOrderedMorethen10
As
Select			PPOD.OrderQty 
				,PPOD.ProductID
				,Count(PPOD.ProductID) as ProductOrdered
				,PPOD.LineTotal as OrderTotal
				,PProV.StandardPrice,PProV.AverageLeadTime 
				,PPurV.BusinessEntityID
				,PPurV.Name as VendorName ,PPurV.AccountNumber 
From			[AdventureWorks2014].[Purchasing].[PurchaseOrderDetail] as PPOD
Inner join		[AdventureWorks2014].[Purchasing].[ProductVendor] as PProV
ON				PProV.ProductID = PPOD.ProductID
Inner join		[AdventureWorks2014].[Purchasing].[Vendor] as PPurV
On				PProV.BusinessEntityID = PPurV.BusinessEntityID	
Group by		PPOD.OrderQty 
				,PPOD.ProductID
				,PPOD.LineTotal 
				,PProV.StandardPrice,PProV.AverageLeadTime 
				,PPurV.BusinessEntityID
				,PPurV.Name ,PPurV.AccountNumber 
Having			Count(PPOD.ProductID) > 10
Go

Select			*
From			VW_ProOrderedMorethen10

--e. Create a view using 3 Sales Tables (Utilize the CASE Statement)

Go
Create View VW_SalesOrderTotalDueRange
As
Select			SC.StoreID
				,SC.TerritoryID
				,SC.CustomerID
				,SSoh.OrderDate
				,SSoh.SalesOrderNumber
				,SSoh.ShipDate
				,SSod.OrderQty
				,SSod.ProductID
				,SSod.UnitPrice
				,SSoh.TotalDue
				,Case 
					When	 SSoh.TotalDue > 10000 and SSoh.TotalDue < 20000
							 Then 'TotalDue in between 10k to 20K'
					When	 SSoh.TotalDue > 20000 and SSoh.TotalDue < 30000 
							Then 'TotalDue in between 20k to 30K'
					When	 SSoh.TotalDue > 30000 and SSoh.TotalDue < 40000   
							Then 'TotalDue in between 30k to 40K'
					When	 SSoh.TotalDue > 40000 and SSoh.TotalDue < 50000 
							Then 'TotalDue in between 40k to 50K'
					When	 SSoh.TotalDue > 50000 
							Then 'TotalDue > 50K'
					End as [TotalDue Range]
From			[AdventureWorks2014].[Sales].[Customer] as SC
Inner join		[AdventureWorks2014].[Sales].[SalesOrderHeader] as SSoh
On				SSoh.CustomerID = SC.CustomerID
Inner join		[AdventureWorks2014].[Sales].[SalesOrderDetail] as SSod
on				SSod.SalesOrderID = SSoh.SalesOrderID
Where			SSoh.TotalDue > 25000
Go		

Select			*
From			VW_SalesOrderTotalDueRange