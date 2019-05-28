/* practise view and triggers */

/* The Sales Department would like to know how many Credit Cards are expiring each month. The information is stored in the Sales.CreditCard table but the Sales Department can’t see the Credit Card number. Create a View that includes all of the columns in the Sales.CreditCard table except the Credit Card Number. */
GO
Create View	VW_CreditCardEXPdetail
AS
	Select		CreditCardID,CardType,ExpMonth,ExpYear
	From		AdventureWorks2014.[Sales].[CreditCard]

GO --get cardid expiring in 2008 from created View
Select		*
From		VW_CreditCardEXPdetail
Where		ExpYear = 2008

--get defination of view

Select OBJECT_DEFINITION(OBJECT_ID('VW_CreditCardEXPdetail')) as VW_CreditCardEXPdetailDefi
--result as shown in result copied
  Create View VW_CreditCardEXPdetail  AS   Select  CreditCardID,CardType,ExpMonth,ExpYear   From  AdventureWorks2014.[Sales].[CreditCard]    

-------- Triggers 

-- After triggers
-- After Insert Trigger
-- we need to create table 
Create table Emp_test(Emp_ID int Identity,
						Emp_name varchar(100),
						Emp_sal Decimal(10,2))

Insert into Emp_test
Values		('Anees',1000),
('Rick',1200),
('John',1100),
('Stephen',1300),
('Maria',1400)

Select	*
From	Emp_test

-- create trigger for after insert on Emp_test 
-- so if there is any data is inserted in Emp_test then specific trigger will invoke and will do something but we can set as it will insert the same data to another table for audit purpost
-- First create table for audit purpost

CREATE TABLE Employee_Test_Audit
	(
	Emp_ID int,
	Emp_name varchar(100),
	Emp_Sal decimal (10,2),
	Audit_Action varchar(100),
	Audit_Timestamp datetime
	)

	-- creat trigger
	--After Insert Trigger
Go
Create	Trigger TRG_AfterInsert on [dbo].[Emp_test]
For Insert
AS
	declare @empID int 
	declare	@empName varchar(100)
	declare @empSal decimal(10,2)
	declare @auditAction varchar(100)

	Select	@empID = i.Emp_ID from inserted i ---here inserted = [dbo].[Emp_test] or In the trigger body, table named inserted has been used. This table is a logical table and contains the row that has been inserted.
	Select	@empName = i.Emp_name from inserted i
	Select	@empSal = i.Emp_sal from inserted i
	Select	@auditAction = 'Inserted record -- After insert trigger'


	Insert into Employee_Test_Audit(Emp_ID,Emp_name,Emp_Sal,Audit_Action,Audit_Timestamp)
	Values(@empID,@empName,@empSal,@auditAction,GETDATE())

	Print ' After Insert Trigger is fired'

	-- now lets see who trigger is fired after we insert data in main table 

Insert into Emp_test
Values		('Toy',2500)

Insert Into Emp_test
Values		('Tom',1500),
			('Mik',2750) -- if we pass this way like multiple data at same time in one row then trigger will be fired one time but main table have more then one row inserted

Select * from Emp_test
Select * from Employee_Test_Audit

--After Update trigger
--This trigger is fired after an update on the table. Let’s create the trigger

Go
Create Trigger TRG_AfterUpdate on [dbo].[Emp_test]
For Update
As
	Declare	@empIDAU int
	Declare	@empNameAU varchar(100)
	Declare @empSalAU decimal(10,2)
	Declare @auditActionAU varchar(100)

	Select	@empIDAU= i.Emp_ID From inserted i
	Select	@empNameAU = i.Emp_name From inserted i 
	Select	@empSalAU = i.Emp_sal From inserted i
	--update for table can be done one one column or all so we need to check with if to get record 
	If UPDATE(Emp_name)
		Set	@auditActionAU = 'Updated Record -- After Update Trigger.'
	If UPDATE(Emp_sal)
		set @auditActionAU = 'Updated Record -- After update Trigger.'

	Insert into Employee_Test_Audit(Emp_ID,Emp_name,Emp_Sal,Audit_Action,Audit_Timestamp)
	Values(@empIDAU,@empNameAU,@empSalAU,@auditActionAU,GETDATE())
	Print 'After update trigger fired'

Update	Emp_test 
Set		Emp_sal = 2710
Where	Emp_ID = 7

Select * from Emp_test
Select * from Employee_Test_Audit

---After Delete Trigger

--this trigger will be fired after any delete on table is done

Go
Alter Trigger TRG_AfterDelete ON [dbo].[Emp_test]
For delete
AS
	Declare	@empIdAD int
	Declare @empNameAD varchar(100)
	Declare @empSalAD decimal(10,2)
	Declare @auditActionAD varchar(100)

	Select	@empIdAD = d.Emp_ID from deleted d -- we need to delete here
	Select	@empNameAD = d.Emp_name from deleted d
	Select	@empSalAD = d.Emp_sal from deleted d
	Set		@auditActionAD ='Delete -- After Delete Trigger'

	Insert into Employee_Test_Audit(Emp_ID,Emp_name,Emp_Sal,Audit_Action,Audit_Timestamp)
	Values(@empIdAD,@empNameAD,@empSalAD,@auditActionAD,GETDATE())
	Print 'After delete trigger fired'

Delete	Emp_test
Where	Emp_ID = 9

Select * from Emp_test
Select * from Employee_Test_Audit


---------CASE expression

Declare @A int = 5, @B int = 10, @C int = 4
--simple case 
Select	
	Case @C
		when 1 then 'its 1'
		when 4 then 'its 4'
		when 5 then 'its 5'
		else 'non'
	End
-- searched case expression
	--it can run untill it get right value  expression is executed 
	-- here result from below code is 'its right' not last one  
	--we can use case for one column only but we can add multiple case expression for other colums too each case exp for each column if we need to use but not one case for all columns because if any line is correct then next line will not be checked in case.
Select	
	Case
		when @C > 4 then '>4'
		When @C = 5 then 'its 4'
		When @A = 4 then 'its not right'
		When @A = 5 then 'its right'
		When @B = 5 then 'its not right'
		else 'its non'
	End

GO
Create view VW_emp
as
	Select	*
	From	emp
	Where Salary > 10000

Select	*
From	VW_emp

Alter table	emp
add			test varchar(10) not null default'hi'

Select	*
From	VW_emp -- same old result no new test column is shown

GO
Alter view VW_emp
As
	Select	*
	From	emp

Select		*
From		VW_emp

Create table test1(id int not null)

Select	* from test1

go
Create view VW_test1
As	
	Select	*
	From	test1

Select	*
From	VW_test1

Insert into test1
Values	(1),(2),(5)

Go
Alter	Trigger	TG_test1 
ON				test1
For Update
As
	if UPDATE(id)
	Begin
		print'"Update columns is not allowed -- Trigger of table"'
		Rollback Transaction
	end

Insert into test1
Values (7)

update test1
set id = 3	

--lets create audit table for test1 for any new inserts

Alter table test1_audit 
Add change Varchar(50)

Select	* 
from test1_audit

GO
Alter Trigger TG_test1_insert on test1
For Insert
AS
	Declare @idTG int

	Select	@idTG = i.id From inserted i

	Insert into test1_audit
	Values	(@idTG,'this row is added to table')
	Print	'From inset trigger '

Insert into test1
Values (10)

Select	* 
from test1_audit


--- create view from emp and dept
Go
Alter View VW_EMP_DPT
AS
	Select			e.empID, e.empName,e.Salary,d.deptName
	From			emp e
	inner join		dept d
	on				d.deptId = e.deptId

Select			*
From			emp e
	
Select			*
From			dept d

Select	* From VW_EMP_DPT	

-- now update data in view for emp dpt but it will not be possible as view can only update one table data on one statement 
--so we have to use trigger on view to insert data into emp and dept tables


Insert into VW_EMP_DPT(empID,empName,Salary,deptName)
Values				 (10,'Treff',1500,'Admin') -- error for 2 table insert

--now create inseted of insert trigger for data insertio to base tables

GO
Alter Trigger TR_EMPDPT_InsteadOFInsert
ON				VW_EMP_DPT
Instead of Insert -- for what we use trigger 
AS
Begin	
		--Select	* From inserted
		--Print 'the select from trigger'
		
		Declare @deptID int
		Select	@deptID = d.deptId 
		From	dept d
		Inner join	inserted i
		on		i.deptName = d.deptName

		IF(@deptID is null)
		begin
			Print'dept name is not valid'
			Return
		End

		Insert into emp(empID,empName,Salary,deptId)
		Select			empID,empName,Salary,@deptID
		From			inserted
		Print 'Insted of insert Trigger is executed'
End

Select			*
From			emp e
	
Select			*
From			dept d

Select	* From VW_EMP_DPT	

Insert into VW_EMP_DPT(empID,empName,Salary,deptName)
Values				 (12,'Teff',2500,'BI')
GO
-- after delete trigger
Select	*
From	[dbo].[emp4]

Create table	emp4_audit(empID int, empName varchar(20), deptID int)

Select		*
From		emp4_audit

Go
Alter Trigger	TR_emp4_afterDelete
ON				emp4
After Delete
AS
Begin
	
	Select	*
	From	deleted
	Print 'From after delete trigger'

	Declare @empID int
	Declare @empName varchar(20)
	Declare @deptID int

	Select	*
	Into	#deletedBackup
	From	deleted

	While Exists (Select * From	#deletedBackup)
	begin	
		Select	top 1 @empID = db.empId
					  ,@empName = db.empName
					  ,@deptID = db.deptId 
		From		  #deletedBackup db
		order by	  db.empId asc

		Insert into		emp4_audit
		Values			(@empID,@empName,@deptID)

		delete			#deletedBackup
		Where			@empID = empId
	end
	
End

Insert into emp4
Values		(1,'Tom',2)
			,(3,'Mary',3)
			,(4,'Mike',2)
			,(5,'Sam',3)
			,(6,'Ren',4)

Delete emp4
Where	deptId = 3

Select	*
From	[dbo].[emp4]

Select		*
From		emp4_audit




