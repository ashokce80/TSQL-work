/*
Ashok 
User Defined Functions
Lab work 4.30.19
*/

Use		AdventureWorks2014
Go
--Use the HumanResources.Employee Table in the Adventureworks Database

--1. Create a UDF that accepts EmployeeID (2012: BusinessEntityID) and returns UserLoginID. The UserLoginID is the last part of the LogID column. It’s only the part that comes after the \
GO
Create Function		UDF_UserLogidID(@EmpID int)
Returns	varchar(20)
AS
	Begin
	Return	(Select	SUBSTRING(LoginID,CHARINDEX('\',LoginID)+1,Len(LoginID)) 
			From	[HumanResources].[Employee]
			Where	BusinessEntityID = @EmpID
			)
	End
Go

Select		dbo.UDF_UserLogidID(10) AS				UserLoginID


--2. Create a UDF that accepts EmployeeID (2012: BusinessEntityID) and returns their age.
GO
Alter		Function	UDF_EmpAge(@EmpID int)
Returns		int
AS
	Begin
		Return (
				Select		DATEDIFF(YY,BirthDate,GETDATE()) 
				From		[HumanResources].[Employee]
				Where		BusinessEntityID = @EmpID
				)
	End
Go

Select		dbo.UDF_EmpAge(5) AS EmpAge


--3. Create a UDF that accepts the Gender and returns the avg VacationHours

Create		Function	UDF_AvgVacationHrs(@Gender varchar(2))
Returns		int
AS
	Begin
		Return (
				Select		Avg(VacationHours) 
				From		[HumanResources].[Employee]
				Where		Gender = @Gender
				
				)
	End
Go

Select		dbo.UDF_AvgVacationHrs('F') AS AvgVacationHrs

/*4. Create a UDF that accepts ManagerID (2012: JobTitle) and returns all of that Managers (2012:
JobTitle) Employee Information.
a. LoginID
b. Gender
c. HireDate */

Create	Function	UDF_MangEmpInfo(@EmpId int)
Returns Table
As	--Provided extra colums for clarification of manager and ID
	Return (Select		BusinessEntityID,JobTitle,LoginID, Gender, HireDate
			From		[HumanResources].[Employee]
			Where		JobTitle like	'%Man%'
			And			BusinessEntityID = @EmpId
			)

Select		*
From		UDF_MangEmpInfo(10)

