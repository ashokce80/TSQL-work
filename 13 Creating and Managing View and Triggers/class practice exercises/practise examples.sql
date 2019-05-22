/* practise view and triggers */

/* The Sales Department would like to know how many Credit Cards are expiring each month. The information is stored in the Sales.CreditCard table but the Sales Department can�t see the Credit Card number. Create a View that includes all of the columns in the Sales.CreditCard table except the Credit Card Number. */
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
--This trigger is fired after an update on the table. Let�s create the trigger

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