-- Temp Data structure
use AdventureWorks2014
Go

Create		Table	#TempAdd([AddreID] int not null,
								[AddressLine1] [nvarchar](60) NOT NULL,
								[City] [nvarchar](30) NOT NULL,
								[StateProvinceID] [int] NOT NULL,
								[PostalCode] [nvarchar](15) NOT NULL
							)
Insert Into			#TempAdd
Select				[AddressID],
					[AddressLine1],
					[City],
					[StateProvinceID],
					[PostalCode]
From				[Person].[Address]

Select				*
From				#TempAdd

With		CTE_NumEmp
AS (
Select		Count(*) as EmpNum
From		AdventureWorks2014.HumanResources.Employee
Where		MaritalStatus = 'M'
And			VacationHours > 60)

Select		*
From		CTE_NumEmp