[dbo].[sp_send_dbmail]

Exec msdb..sp_send_dbmail

-- Profile name : DBMailAshok , Account name : AshokGmailSmtp
Go
Create proc UDF_SP_SendMail
/*
Date:7.2.19
Name:Ashok
Detail:
	This store procedure will send email using system store proc sp_send_dbmail
example: 
	Exec UDF_SP_SendMail 'DBMailAshok','ashvi616@gmail.com' , 'Package test email','Check yout excel file'

*/

@Profile varchar(255),
@Rec	 varchar(255),
@Sub	Varchar(255),
@emailBody varchar(max)

As
	Begin	
		Exec msdb..sp_send_dbmail @profile_name = @Profile, @recipients = @Rec, @Subject = @Sub, @body = @emailBody
	end
Go
Exec UDF_SP_SendMail 'DBMailAshok','ashvi616@gmail.com' , 'Package test email','Check yout excel file'

Exec UDF_SP_SendMail 'DBMailAshok','ashvi616@gmail.com' ,'SSIS Package Unsuccessfull executed',?

Go
Create Table	dbo.tbl_Prospects(
				Conatact_Id int identity(1,1) primary key
				,Contact_FirstName varchar(255) null
				,Contact_LastName varchar(255) null
				,Title_Id int null
				,Dept_ID int null
				,Company_ID int null
				,Location_ID int null
				,Active varchar(5) default 'Yes'
				,Created_date datetime default getDate()
				,Update_date datetime default getDate()
)

Select		*	
From		[dbo].[tbl_Prospects]
--------------------------------------------
--Truncate all table so we can load again 
truncate table	[dbo].[tbl_stg_Prospects]

truncate table	[dbo].[tbl_dic_Department]
truncate table	[dbo].[tbl_dic_Company]
truncate table	[dbo].[tbl_dic_Title]
truncate table	[dbo].[tbl_dic_Location]
------------------------------------------------

Select		*
From		[dbo].[tbl_stg_Prospects]
Order by	Name

where	Designation = 'student'
----------------------------------------------
go
Select	*
From	[dbo].[tbl_dic_Department]
go 
Select	*
From	[dbo].[tbl_dic_Company]

Select	*
From	[dbo].[tbl_dic_Location]

Select	*
From	[dbo].[tbl_dic_Title]
where	TitleName = 'student'

----------------------------------------------

select	@@SERVERNAME

Select	TitleName,
From	[dbo].[tbl_dic_Title]
--where	TitleName = Null
Order by TitleName

go
Select		p.Name,p.Designation,
			t.TitleName, t.TitleID
From		[dbo].[tbl_stg_Prospects] as p
left join	[dbo].[tbl_dic_Title] as t
On			p.Designation = t.TitleName
where		t.TitleName = p.Designation--'student'

-----------
Select		*	
From		[dbo].[tbl_Prospects]

go
Select		d.DepartmentName, p.Dept_ID
From		[dbo].[tbl_dic_Department] as d
Inner join  dbo.tbl_Prospects as p
On			p.Dept_ID = d.DepartmentID
Where		p.Dept_ID = 270


Select		c.CompanyName, p.Company_ID
From		[dbo].[tbl_dic_Company] as c
Inner join  dbo.tbl_Prospects as p
On			p.Company_ID = c.CompanyID




