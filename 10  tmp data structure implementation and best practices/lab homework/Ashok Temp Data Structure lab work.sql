/*

Ashok
Temp Data structure
5.4.19
*/
--Lab Work

Use	AdventureWorks2014
Go
--1. Create 10 temp tables using Adventureworks Database.
---1----
Select		*
Into		#PAddress
From		[Person].[Address]
Where		AddressLine2 like 'B%'
And			AddressID Between 400 and 600
Select		*
From		#PAddress
-------2-----
Create		Table	#EmpTemp(
					[BusinessEntityID] [int] NOT NULL,
					[Gender] [nchar](1) NOT NULL,
					[HireDate] [date] NOT NULL,
					[JobTitle] [nvarchar](50) NOT NULL,
					[BirthDate] [date] NOT NULL)

Insert Into			#EmpTemp
Select				[BusinessEntityID],
					[Gender],
					[HireDate],
					[JobTitle],
					[BirthDate]
From				[HumanResources].[Employee]
Where				BusinessEntityID in (10,15)
And					BirthDate not in ('1978-1-1','1975-1-1')

Select		*
From		#EmpTemp
----3---
Select		ProductID,Count(*) AS [Count],AVG(OrderQty) As AVGOrderQty
Into		#TempSalesOrderDetail
From		[Sales].[SalesOrderDetail]
Group by	ProductID

Select		*
From		#TempSalesOrderDetail
------4-----
Select		*
Into		#tempProCult
From		[Production].[Culture]

Insert into		#tempProCult
Select			'jp1','Japanes1','2019-05-08'
Union
Select			'dutch1','German1','2019-05-05'

Select		*
From		#tempProCult
-----5---
If OBJECT_ID('Tempdb..#tempPerPhone')is not null Drop Table #tempPerPhone
Create Table	#tempPerPhone(
				[BusinessEntityID] [int] Primary key Identity(1,1),
				[PhoneNumber] nvarchar(25) NOT NULL,
				[PhoneNumberTypeID] [int] NOT NULL,
				[ModifiedDate] [datetime] NOT NULL)

Insert Into #tempPerPhone([PhoneNumber],[PhoneNumberTypeID],										[ModifiedDate])
Select		[PhoneNumber],[PhoneNumberTypeID],[ModifiedDate]
From		[Person].[PersonPhone]

Select		*
From		#tempPerPhone
--------6----
Create	Table	#SSpecOffer(
				[Description] [nvarchar](255) NOT NULL,
				[DiscountPct] [smallmoney] NOT NULL,
				[Type] [nvarchar](50) NOT NULL)

Insert	Into	#SSpecOffer
Select			[Description]
			   ,[DiscountPct]
			   ,[Type]
From			[Sales].[SpecialOffer]
Where			DiscountPct > 0.25

Select			*
From			#SSpecOffer
Order by		Type
----7---
SELECT		[PhoneNumber],[PhoneNumberTypeID]
FROM		[Person].[PersonPhone]
Group By	[PhoneNumber],[PhoneNumberTypeID]
Having		[PhoneNumberTypeID] > 1
-----8------
Select			WorkOrderID,
				[OrderQty]
				,[StockedQty]
Into			#TempWorkOrder
FROM			[AdventureWorks2014].[Production].[WorkOrder]
Where			[StockedQty] > 10
	
Select		*
From		#TempWorkOrder
Group by		[WorkOrderID],OrderQty,[StockedQty]
Having			OrderQty > 15
------9-----
SELECT	  [BusinessEntityID]
		  ,[EmailAddressID]
		  ,[EmailAddress]
		  ,[rowguid]
		  ,[ModifiedDate]
		  ,Left(EmailAddress,CharIndex('@',EmailAddress)-1) AS						[User]
		  ,Right(EmailAddress,Len(EmailAddress)-CHARINDEX('@',EmailAddress)) As DomainName
Into		#TempEmailAddress
FROM		[AdventureWorks2014].[Person].[EmailAddress]

Select		*
From		#TempEmailAddress

------10-----

Select			[BusinessEntityID]
			  ,[NationalIDNumber]
			  ,[LoginID]
			  ,[OrganizationNode]
			  ,[OrganizationLevel]
			  ,ISNULL([OrganizationLevel],' ') As [New Organization_Level] 
			  ,[JobTitle]
			  ,[BirthDate]
			  ,[Gender]
			  ,[HireDate]
			  ,DATEDIFF(yy,BirthDate, Getdate()) AS Age
			  ,DATENAME(MM,HireDate) As HiredMonth
Into		#TmpEmpDetail
From		[AdventureWorks2014].[HumanResources].[Employee]

Select		*
From		#TmpEmpDetail
-----------
---2. Create the same 10 tables as CTE’s.
---1--------
;
With		CTE_PAddress
AS
(
	Select		*
	From		[Person].[Address]
	Where		AddressLine2 like 'B%'
	And			AddressID Between 400 and 600
)
Select		*
From		CTE_PAddress
------2-----
;
With		CTE_EmpTemp([BusinessEntityID],
					[Gender],
					[HireDate],
					[JobTitle],
					[BirthDate]
)
AS
(
Select				[BusinessEntityID],
					[Gender],
					[HireDate],
					[JobTitle],
					[BirthDate]
From				[HumanResources].[Employee]
Where				BusinessEntityID in (10,15)
And					BirthDate not in ('1978-1-1','1975-1-1')

)
Select			*
From			CTE_EmpTemp
-----3------
;
With		CTE_TempSalesOrderDetail
AS
(
	Select		ProductID,Count(*) AS [Count],AVG(OrderQty) As AVGOrderQty
	From		[Sales].[SalesOrderDetail]
	Group by	ProductID


)
Select		*
From		CTE_TempSalesOrderDetail
------4-----
;
With		CTE_tempProCult
AS
(
	Select		*
	From		[Production].[Culture]
	
	)
Insert into		CTE_tempProCult
Select			'jp1','Japanes1','2019-05-08'
Union
Select			'dutch1','German1','2019-05-05'

Select		*
From		[Production].[Culture]
------5-----
;
With		CTE_tempPerPhone(
				[BusinessEntityID],
				[PhoneNumber] ,
				[PhoneNumberTypeID] ,
				[ModifiedDate] )
AS
(
	Select		*
	From		[Person].[PersonPhone]
)
Select		*
From		CTE_tempPerPhone

------6-----
;
With		CTE_SSpecOffer([Description]
			   ,[DiscountPct]
			   ,[Type]
				)
AS
(
	Select		[Description]
			   ,[DiscountPct]
			   ,[Type]
	From		[Sales].[SpecialOffer]
	Where			DiscountPct > 0.25
	
)
Select		*
From		CTE_SSpecOffer
Order by		Type
------7-----
;
With		CTE_TempPhType
AS
(
	SELECT		[PhoneNumber],[PhoneNumberTypeID]
	FROM		[Person].[PersonPhone]
	Group By	[PhoneNumber],[PhoneNumberTypeID]
	Having		[PhoneNumberTypeID] > 1

)
Select		*
From		CTE_TempPhType
------8-----
;
With		CTE_TempWorkOrder
AS
(	
	Select			WorkOrderID,
					[OrderQty]
					,[StockedQty]
	FROM			[AdventureWorks2014].[Production].[WorkOrder]
	Where			[StockedQty] > 10
	Group by		[WorkOrderID],OrderQty,[StockedQty]
	Having			OrderQty > 15
	
)
Select		*
From		CTE_TempWorkOrder
Order by		WorkOrderID
------9-----
;
With		CTE_TempEmailAddress
AS
(
SELECT	  [BusinessEntityID]
		  ,[EmailAddressID]
		  ,[EmailAddress]
		  ,[rowguid]
		  ,[ModifiedDate]
		  ,Left(EmailAddress,CharIndex('@',EmailAddress)-1) AS						[User]
		  ,DATEPART(YYYY,ModifiedDate) As ModifiedYear
		  --,Right(EmailAddress,Len(EmailAddress)-CHARINDEX('@',EmailAddress)) As DomainName
FROM		[AdventureWorks2014].[Person].[EmailAddress]
)
Select		*
From		CTE_TempEmailAddress


------10-----

;
With		CTE_TmpEmpDetail
AS
(
Select			[BusinessEntityID]
			  ,[NationalIDNumber]
			  ,[LoginID]
			  ,[OrganizationNode]
			  ,[OrganizationLevel]
			  ,ISNULL([OrganizationLevel],' ') As [New Organization_Level] 
			  ,[JobTitle]
			  ,[BirthDate]
			  ,[Gender]
			  ,[HireDate]
			  ,DATEDIFF(yy,BirthDate, Getdate()) AS Age
			  ,DATENAME(MM,HireDate) As HiredMonth
From		[AdventureWorks2014].[HumanResources].[Employee]
)
Select		*
From		CTE_TmpEmpDetail
-----------
--3. Create the same 10 tables as Table Variables.
----1-------
Declare		@TVPAddress	Table(
					[AddressID] [int] NOT NULL,
					[AddressLine1] [nvarchar](60) NOT NULL,
					[AddressLine2] [nvarchar](60) NOT NULL,
					[City] [nvarchar](30) NOT NULL,
					[StateProvinceID] [int] NOT NULL,
					[PostalCode] [nvarchar](15) NOT NULL
					)

Insert Into	@TVPAddress
Select		[AddressID]
		  ,[AddressLine1]
		  ,[AddressLine2]
		  ,[City]
		  ,[StateProvinceID]
		  ,[PostalCode]
From		[Person].[Address]
Where		AddressLine2 like 'B%'
And			AddressID Between 400 and 600

Select		*
From		@TVPAddress
------2-----
Declare		@EmpTemp Table	(
					[BusinessEntityID] [int] NOT NULL,
					[Gender] [nchar](1) NOT NULL,
					[HireDate] [date] NOT NULL,
					[JobTitle] [nvarchar](50) NOT NULL,
					[BirthDate] [date] NOT NULL)

Insert Into			@EmpTemp
Select				[BusinessEntityID],
					[Gender],
					[HireDate],
					[JobTitle],
					[BirthDate]
From				[HumanResources].[Employee]
Where				BusinessEntityID in (10,15)
And					BirthDate not in ('1978-1-1','1975-1-1')

Select		*
From		@EmpTemp
-------3----

Declare		@TempSalesOrderDetail Table(
							[ProductID] [int] NOT NULL,
							[Count] int,
							AVGOrderQty int not null )

Insert Into		@TempSalesOrderDetail
Select			ProductID,Count(*) AS [Count],AVG(OrderQty) As AVGOrderQty
From			[Sales].[SalesOrderDetail]
Group by		ProductID

Select		*
From		@TempSalesOrderDetail
------4-----

Declare		@tempProCult Table (
			[CultureID] [nchar](6) NOT NULL,
			[Name] nvarchar(50) NOT NULL,
			[ModifiedDate] [datetime] NOT NULL)

Insert Into		@tempProCult
Select			*
From		[Production].[Culture]

Insert into		@tempProCult
Select			'jp','Japanes','2019-05-08'
Union
Select			'dutch','German','2019-05-05'

Select		*
From		@tempProCult

------5-----

Declare		@tempPerPhone Table(
				[BusinessEntityID] [int] Primary key Identity(1,1),
				[PhoneNumber] nvarchar(25) NOT NULL,
				[PhoneNumberTypeID] [int] NOT NULL,
				[ModifiedDate] [datetime] NOT NULL)

Insert Into		@tempPerPhone
Select			[PhoneNumber],[PhoneNumberTypeID],[ModifiedDate]
From			[Person].[PersonPhone]

Select		*
From		@tempPerPhone
----6-------
Declare @SSpecOffer	Table	(
				[Description] [nvarchar](255) NOT NULL,
				[DiscountPct] [smallmoney] NOT NULL,
				[Type] [nvarchar](50) NOT NULL)

Insert	Into	@SSpecOffer
Select			[Description]
			   ,[DiscountPct]
			   ,[Type]
From			[Sales].[SpecialOffer]
Where			DiscountPct > 0.25
Order by		Type

Select			*
From			@SSpecOffer

-------7----
Declare		@TempPerPh Table(
				[PhoneNumber] [dbo].[Phone] NOT NULL,
				[PhoneNumberTypeID] [int] NOT NULL)

Insert Into	@TempPerPh
SELECT		[PhoneNumber],[PhoneNumberTypeID]
FROM		[Person].[PersonPhone]
Group By	[PhoneNumber],[PhoneNumberTypeID]
Having		[PhoneNumberTypeID] > 1

Select		*
From		@TempPerPh
-----8------

Declare		@TempWorkOrder Table(
				[WorkOrderID] [int] IDENTITY(1,1) NOT NULL,
				[OrderQty] [int] NOT NULL,
				[StockedQty] int not null
				)

Insert Into		@TempWorkOrder
Select			[OrderQty]
				,[StockedQty]
FROM			[AdventureWorks2014].[Production].[WorkOrder]
Where			[StockedQty] > 10

Select			*
From			@TempWorkOrder
Group by		[WorkOrderID],OrderQty,[StockedQty]
Having			OrderQty > 15
Order by		WorkOrderID 

-----9------
Declare		@TempEmailAddress Table([BusinessEntityID] [int] NOT NULL,
									[EmailAddressID] [int] IDENTITY(1,1) NOT NULL,
									[EmailAddress] [nvarchar](50) NULL,
									[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
									[ModifiedDate] [datetime] NOT NULL,
									[User] varchar(25),
									ModifiedYear int)

Insert Into			@TempEmailAddress
SELECT			  [BusinessEntityID]
				  ,[EmailAddress]
				  ,[rowguid]
				  ,[ModifiedDate]
				  ,Left(EmailAddress,CharIndex('@',EmailAddress)-1) AS [User]
				  ,DATEPART(YYYY,ModifiedDate) As ModifiedYear
FROM			[AdventureWorks2014].[Person].[EmailAddress]

Select			*
From			@TempEmailAddress
-----10------
Declare		@TmpEmpDetail Table(
			[BusinessEntityID] [int] NOT NULL,
			[NationalIDNumber] [nvarchar](15) NOT NULL,
			[LoginID] [nvarchar](256) NOT NULL,
			[OrganizationNode] [hierarchyid] NULL,
			[OrganizationLevel]  varchar(10),
			[New Organization_Level] varchar(10),
			[JobTitle] [nvarchar](50) NOT NULL,
			[BirthDate] [date] NOT NULL,
			[Gender] [nchar](1) NOT NULL,
			[HireDate] [date] NOT NULL,
			Age int,
			HiredMonth varchar(10)		)

Insert Into		@TmpEmpDetail
Select			[BusinessEntityID]
			  ,[NationalIDNumber]
			  ,[LoginID]
			  ,[OrganizationNode]
			  ,[OrganizationLevel]
			  ,ISNULL([OrganizationLevel],' ') As [New Organization_Level] 
			  ,[JobTitle]
			  ,[BirthDate]
			  ,[Gender]
			  ,[HireDate]
			  ,DATEDIFF(yy,BirthDate, Getdate()) AS Age
			  ,DATENAME(MM,HireDate) As HiredMonth
From		[AdventureWorks2014].[HumanResources].[Employee]

Select		*
From		@TmpEmpDetail

-----------------
