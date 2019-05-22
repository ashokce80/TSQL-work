
/* Stored procedure*/
Create Procedure Proc_DeptNameByGroup
(@DeptGroupName varchar(50))
As
Begin
	SET NOCOUNT ON; ---
	Select	 Name
	From	 AdventureWorks2014.HumanResources.Department
	Where	 GroupName = @DeptGroupName
End

EXEC	Proc_DeptNameByGroup 'Manufacturing'


--Stored Procedure with output parameters ,sometimes we may have to store output of stored procedure to variable for futher use as below

GO
Alter	Proc	UDSP_DeptCountbyGrp
	@DeptGroupName Varchar(100),
	@DeptNamecnt int output
As
	Begin
		Set NoCount off;

		Select		Count(Name) --as  NameCount
		From		AdventureWorks2014.HumanResources.Department
		Where		GroupName = @DeptGroupName
	End

Declare		@catchOutput Int
Exec		UDSP_DeptCountbyGrp'Manufacturing',@DeptNamecnt=@catchOutput  OUTPUT
Print		@catchOutput 
-----------
--While loop

Declare @Iteration int
Set		@Iteration = 0
While	@Iteration < 10
Begin
	Set	@Iteration = @Iteration +1
	Select	@Iteration
End
--- Practice 
-- Find top 2 products per department
CREATE TABLE #Products (ProductID int, 
						ProductName varchar(150),
						DeptID int,
						TotalSales money)
INSERT INTO #Products (ProductID,ProductName,DeptID,TotalSales)
SELECT 1000,'Camry',1,35000 UNION
SELECT 1001,'Carolla',1,20000 UNION
SELECT 1002,'Paseo',1,18000 UNION
SELECT 1003,'Tundra',1,48000 UNION
SELECT 1004,'Rav4',1,33000 UNION
SELECT 1005,'Escalade',2,60000 UNION
SELECT 1006,'Deville',2,47000 UNION
SELECT 1007,'STS',2,50000 UNION
SELECT 1008,'CTS',2,40000 UNION
SELECT 1009,'DTS',2,43000

Select		*
From		#Products

Select	Distinct 	DeptId
Into				#ProTempDeptId
From				#Products

Select		*
From		#ProTempDeptId

Select	Distinct	*
Into				#ResultTable
From				#Products

Truncate table	#ResultTable

Declare	@dptID Int 
Set		@dptID = (Select Top 1 * From #ProTempDeptId)

While	@dptID is not null
Begin
	--Get top 2 row based on deptId and store it in different table for result
	Insert into		#ResultTable
	Select Top 2	*
	From			#Products
	Where			DeptID = @dptID
	Order by		TotalSales desc
	--delete row from table for which we have data so we can get next deptId to fetch
	Delete	From	#ProTempDeptId
	Where			DeptID = @dptID	
	--as we need next dpetId to get realted data we have to set it again so while loop can run for next deptid
	Set				@dptID = (Select Top 1 * From #ProTempDeptId)
End
--show final result table as output
Select		*
From		#ResultTable
-- class online practice

Select		top 1 *
From		AdventureWorks2014.HumanResources.Employee

Select		top 1 *
From		AdventureWorks2014.Person.Person

GO
Create	Procedure UDF_SP_empDetail
(@Month int)
As
Begin
	Select		ADPP.FirstName,ADPP.LastName,ADHE.JobTitle, ADHE.Gender,
				CAST(DATEPART(MM,ADHE.BirthDate) as varchar)
				+ ' - ' + Cast(DATEPART(DD,ADHE.BirthDate) as varchar)
	From		AdventureWorks2014.Person.Person as ADPP
	Inner join	AdventureWorks2014.HumanResources.Employee as ADHE
	ON			ADPP.BusinessEntityID = ADHE.BusinessEntityID
	Where		DATEPART(MM,ADHE.BirthDate) = @Month
End

Exec UDF_SP_empDetail 5

---- looping 
--Whike loop

Declare		@Iteration int = 0
While		@Iteration < 20
	Begin	
		Set	@Iteration = @Iteration + 1
		Print	@Iteration -- or Select @Iteration
	End

----
--SP with output parameter
use ashok_lab1
GO

Select		*
From		dbo.emp

GO
Alter Procedure	UD_SP_EmpCount
@empCount int Output
AS
	Begin
		Select	@empCount =	Count(*)
		From		emp		
	End
go

Declare		@empCt int  

Execute		UD_SP_EmpCount @empCt output
Print		@empCt
----------------------------- SP with input parameter and output parameter
Select		*
From		dbo.emp
Where		empName = 'Andy'

go
Create	Proc  UD_SP_empDetailName
@empName varchar(10), 
@empSalary int	OUTPUT
AS
	Begin
		Select	Salary
		From	emp
		Where	empName = @empName
	End
go

Declare		@empS int
Exec		UD_SP_empDetailName 'Andy',@empS OUTPUT
Print		'Salary of Andy is '+ Cast(@empS as varchar)
-------------

-- multiple output variables in SP

Create Proc UDSP_empDetail
@empName varchar(10),
@empDeptID int output,
@empSalary int output,
@empMgrID  int output
AS
	Begin	
		Select	@empDeptID = empId,
				@empSalary = Salary,
				@empMgrID = mgrId
		From	emp	
		Where	empName = @empName
	End
Go

Declare	@eDId int, @eSal int, @eMid int

Exec	UDSP_empDetail'Andy', @eDId Output,
							   @eSal Output,
							   @eMid Output
Select	@eDId,@eSal,@eMid -- It shows last row from output not all data is shows like we stored values in scalar varibale not table variable so that we see one value only
---- lets get table variable as output variable and get all rows into it
-- not possible to put table variable as output variable in SP
--but we can use temp Table to insert data from query in side SP as below

--********** Stored procedure always return value is in Int so we have to conver to int or varchar as per our need if we concate the output/return with anything else *********------
Create	Proc  UD_SP_empDetailToTable
@empName varchar(20)
As
	Begin
		Select	*
		Into	#empDetail1
		From	emp
		Where	empName  = @empName

		Select	*
		From	#empDetail1
	End
Go

-- exec SP will show temp table which was created and filled with select into 
Declare int1 int 

Exec UD_SP_empDetailToTable'Ammy' 
