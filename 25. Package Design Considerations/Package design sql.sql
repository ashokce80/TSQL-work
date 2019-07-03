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

Select	*
From	[dbo].[tbl_stg_Prospects]

Select	*
From	[dbo].[tbl_dic_Department]

Select	*
From	[dbo].[tbl_dic_Title]

Select	*
From	[dbo].[tbl_stg_Prospects]

Create Table	dbo.tbl_Prospects(
				Conatact_Id int identyty(1,1) primary key
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