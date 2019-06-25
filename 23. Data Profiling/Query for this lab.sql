
Create Database Prospects
USe Prospects
Create table tbl_stg_Prospects 
(	Name varchar(255),
	Title varchar(255)
	,Company varchar(255)
	,Location varchar(255)
	,FirstName varchar(255)
	,LastName varchar(255)
	,Designation varchar(255)
	,Dept varchar(255)
	,City varchar(255)
	,[State] varchar(255)
)

Select	*
From 	tbl_stg_Prospects

Select	*
From 	tbl_stg_Prospects  --13767 rows,, not null 13243,, null 524
Where	Name is not null 
And		Name != ''
And		Title is not null
and		Company is not null
and		Location is not null
and		FirstName is not null
and		LastName is not null
And		Designation is not null
And		Dept is not null
And		City is not null
and		State is not null
order by Name 


ISNULL([Name ]) ==  TRUE  || ISNULL([Title ]) ==  TRUE  || ISNULL([Company ]) ==  TRUE  || ISNULL(Location) ==  TRUE

Select	*
From 	tbl_stg_Prospects  --13767 rows,, not null 13243
Where	Name is  null 
or		Name = ''
or		Title is  null
or		Company is  null
or		Location is  null
or		FirstName is null
or		LastName is null
or		Designation is null
or		Dept is null
or		City is null
or		State is null
order by Name 

Alter Table tbl_stg_Prospects 
add Designation varchar(255)

Alter Table		tbl_stg_Prospects 
Add				FirstName varchar(250),
				LastName varchar(250),
				Dept varchar(250), 
				City varchar(250), 
				[State] varchar(250);

						

Truncate table tbl_stg_Prospects 

Select	SUBSTRING(Name,0,CHARINDEX(',',Name)),Name
--Select	CHARINDEX(',',Name), name
From	tbl_stg_Prospects 

--For OLE DB Command Transformation  to update the existing dat with new one in table SSIS
Update tbl_stg_Prospects
set		Title = ?,
		Company = ?,
		Location = ?,
		FirstName = ?,
		LastName = ?,
		Designation = ?,
		Dept = ?,
		City = ?,
		State = ?
Where	Name = ?

Select	*
From 	tbl_stg_Prospects 
Where name ='Erpot, Treff'

Select	*
From 	tbl_stg_Prospects --13768 rows

Select	*
From 	tbl_stg_Prospects -- not null 13244
Where	Name is not null 
And		Name != ''
And		Title is not null
and		Company is not null
and		Location is not null

Select	*
From 	tbl_stg_Prospects  -- null 524
Where	Name is  null 
or		Name = ''
or		Title is  null
or		Company is  null
or		Location is  null


Create table tbl_stg_Prospects_Null_DATA
(	Name varchar(255),
	Title varchar(255)
	,Company varchar(255)
	,Location varchar(255)
	)

Select	Name, count(Title)
From 	tbl_stg_Prospects
Group by name
having	Count(title) >1

Select	*
From 	tbl_stg_Prospects
Where	name = 'Brown, Kevin'

Select	*
From 	[dbo].[tbl_stg_Prospects_Null_DATA]

Truncate table tbl_stg_Prospects

Truncate table [dbo].[tbl_stg_Prospects_Null_DATA]

