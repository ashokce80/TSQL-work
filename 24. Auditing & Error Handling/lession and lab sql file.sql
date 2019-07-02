
Select	CURRENT_TIMESTAMP

bcp "SELECT TOP 100 * FROM AdventureWorks2014.Person.Person ORDER BY BusinessEntityID" in C:\Users\Ashok\Desktop\PersonData.csv -c -t, -S LAPTOP-PF3DBQTQ\CB2016SQLSERVER -T

--Error handinglin 
-- control flow level with event handler

Create table	ErrorCFLevelDetail(
				PackageName varchar(250)
				,TaskSourceName varchar(250)
				,ErrorDetail nvarchar(400))

Select		*
From		ErrorCFLevelDetail
GO
alter table ErrorCFLevelDetail
add runTime	datetime

USe ashok_lab1
go
Insert into	ErrorCFLevelDetail
values		('tet','tes','rr');
go

[Execute SQL Task] Error: Executing the query "Insert  into	ErrorCFLevelDetail
values(?,?,?)" failed with the following error: "The statement has been terminated.". Possible failure reasons: Problems with the query, "ResultSet" property not set correctly, parameters not set correctly, or connection not established correctly.
go
Insert  into [dbo].[ErrorCFLevelDetail] values(?,?,?)

--export all table data to text file AdventureWorks2014.Person.Person 
--[ashok_lab1].[dbo].[emp]
Declare @str nvarchar(2000) = 'bcp [ashok_lab1].[dbo].[emp] out C:\Users\Ashok\Desktop\emp1.txt -c -T -S LAPTOP-PF3DBQTQ\CB2016SQLSERVER'
Exec	master..xp_cmdshell  @str
Exec   xp_cmdshell 'whoami'

--bcp ashok_lab1.dbo.emp out C:\Users\Ashok\Desktop\emp.txt -c -t, -S LAPTOP-PF3DBQTQ\CB2016SQLSERVER -T




---lab realted
GO
Create table	tbl_dic_Location(
				LocationID int identity(5,5) Primary key
				,LocationCity varchar(250)
				,LocationState varchar(250)
				,Active varchar(250)
				,CreateDate datetime
				,UpdateDate datetime
				)

Alter table		tbl_dic_Location
Add	Default		(getDate()) for CreateDate
GO
Create table	tbl_dic_Company(
				CompanyID int identity(10,10) Primary key
				,CompanyName varchar(250)
				,Active varchar(250)
				,CreateDate datetime
				,UpdateDate datetime
				)
Alter table		tbl_dic_Company
Add	Default		(getDate()) for CreateDate
GO
Create table	tbl_dic_Title(
				TitleID int identity(1,1) Primary key
				,TitleName varchar(250)
				,Active varchar(250)
				,CreateDate datetime
				,UpdateDate datetime
				)
Alter table		tbl_dic_Title
Add	Default		(getDate()) for CreateDate
GO
Create table	tbl_dic_Department(
				DepartmentID int identity(10,10) Primary key
				,DepartmentName varchar(250)
				,Active varchar(250)
				,CreateDate datetime
				,UpdateDate datetime
				)
Alter table		tbl_dic_Department
Add	Default		(getDate()) for CreateDate


Select	*
From	[dbo].[tbl_stg_Prospects]

Select	*
From	[dbo].[tbl_dic_Company]
Where		 CompanyName = 'Mayo Clinic'

Truncate table [dbo].[tbl_dic_Company]

Update		 [dbo].[tbl_dic_Company]
set			 Active = 'Yes', UpdateDate = getDate()
Where		 CompanyName = 'Mayo Clinic'

Select		*
From		[dbo].[tbl_dic_Department]
DepartmentID		Active	CreateDate	UpdateDate

Update		 [dbo].[tbl_dic_Department]
set			 Active = ?, UpdateDate = getdate()
Where		 DepartmentName = ?

Select	*
From	[dbo].[tbl_dic_Company]

select * 
from [dbo].[tbl_dic_Department]

Select	*
From	[dbo].[tbl_dic_Location]

Select	*
From	[dbo].[tbl_dic_Title]

Create table AuditFileLoad(
			 FileProcessedBy nvarchar(255)
			 ,FileProcessTime datetime 
			 ,isArchived nvarchar(15))

Select		*
From		 AuditFileLoad

Create Proc UD_SP_AuditFileLoad
@FileName nvarchar(255)
AS
	Begin
		Insert into AuditFileLoad (FileProcessedBy,FileProcessTime,isArchived)
		Select	@FileName,GETDATE(),'Yes'
	End

Exec UD_SP_AuditFileLoad  'Prospects-abc.xls'


Declare @str varchar(255)
set @str = 'thisis\te\FileName'--'C:\Users\Ashok\Desktop\Data Analytics Course\Data Analytics Sections\SSIS\ExcelFiles\prospect_B.xls'
Declare @newStr varchar(255) = (@str)

Select REVERSE( SUBSTRING(Reverse(@newStr),0,CHARINDEX('\',Reverse(@newStr))))

 (DT_WSTR, 50) FINDSTRING( @[User::File_Path] , "\", 1) 
FINDSTRING("New York, NY, NY", "NY", 1) 

--to get filename from location file path
 (DT_WSTR, 50)REVERSE( SUBSTRING(Reverse( @[User::File_Path]) ,1, FINDSTRING( Reverse( @[User::File_Path] ) ,"\\" ,1 )-1))

Select		*
From		 AuditFileLoad

Select		*
From		[dbo].[tbl_stg_Prospects]

Select *
From [dbo].[tbl_stg_Prospects_Null_DATA]

Select	*
From	[dbo].[ErrorCFLevelDetail]

CREATE TABLE [dbo].[ErrorDFLevelDetail](
	[PackageName] [varchar](250) NULL,
	[TaskSourceName] [varchar](250) NULL,
	[ErrorDetail] [nvarchar](400) NULL,
	[runTime] [datetime] NULL
) ON [PRIMARY]
GO

Select	*
From	[dbo].[ErrorDFLevelDetail]

Insert into [dbo].[ErrorDFLevelDetail] 
Values(?,?,?,?)


