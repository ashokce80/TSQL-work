/* 
Ashok R
View and Triggers Lab work
5.21.19
*/
/*
1. CREATE the following tables –
a. Dept_triggers – Add Identity Column (1000,1)
b. Emp_triggers– Add Identity Column (1000,1)
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
Values		('Torr',3)

--b. Trigger 2 – Build a tirgger on the emp table after an update of the empname or deptid column - It updates the subsequent empname and/or deptid in the emp_history table.

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


--3. Run this script – Results should show 10 records in the emp history table all with an active status of 0

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


---