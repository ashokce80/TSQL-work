USe LearningSSIS

Create Table	tblEmployee (
EMPID int,	EmpName varchar(50), JobTitle varchar(50),	Salary money)

Select		*
From		tblEmployee

Create Database LearningSSIS2

USE	LearningSSIS2

Create Table	tblEmp (
EMPID int,	EmpName varchar(50), JobTitle varchar(50),	Salary money)

Select		*
From		tblEmp

Create Database Prospects
USe Prospects
Create table tbl_stg_Prospects 
(	Name varchar(250),
	Title varchar(250)
	,Company varchar(250)
	,Location varchar(250)
)

Select	*
From	tbl_stg_Prospects 

Truncate Table	tbl_stg_Prospects	


go
Select	EMPID, EmpName, JobTitle, Salary
From	[dbo].[tblEmp]
go

Select	*
From	[HumanResources].[vEmployee]

SELECT DISTINCT JobTitle
FROM			HumanResources.vEmployee
WHERE			JobTitle LIKE '%technician%' 

Create Table Emp_SSIS_Import(
EmpID int, Name varchar(50),JobTitle Varchar(50))

Select	*
From	Emp_SSIS_Import

Delete from Emp_SSIS_Import

SELECT 
  BusinessEntityID, 
  NationalIDNumber
FROM 
  HumanResources.Employee
WHERE
  BusinessEntityID < 250;

  SELECT 
  BusinessEntityID,
  FirstName,
  LastName,
  JobTitle
FROM
  HumanResources.vEmployee;
  
  
Select	*
From	[dbo].[tblEmp]

CREATE TABLE [dbo].[tblEmpQLEDBCommTrsfn](
	[EMPID] [int] NULL,
	[EmpName] [varchar](50) NULL,
	[JobTitle] [varchar](50) NULL,
	[Salary] [money] NULL
) ON [PRIMARY]

Select	*
From	 [dbo].[tblEmpQLEDBCommTrsfn]
--Commange trnsformation
Insert into  [dbo].[tblEmpQLEDBCommTrsfn] 
values(?,?,?,?)

Go
Select		ProductID,Count(Quantity) as NumOfQty,TransactionType, Max(ActualCost) as MaxActualCost
From		AdventureWorks2014.[Production].[TransactionHistory]
Group by	ProductID
			,TransactionType

Select		*
From		AdventureWorks2014.[Production].[TransactionHistory]
Where		Year(TransactionDate) = 2014

GO
