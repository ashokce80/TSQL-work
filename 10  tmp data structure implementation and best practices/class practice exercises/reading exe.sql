use	ashok_lab1

CREATE TABLE	#emp(
					empId int,
					empName	varchar(50),
					deptId int)

Select	*
From	#emp

Insert Into		#emp(empId,empName,deptId)
Select			1,'Mark',2
Union			
Select			2,'Mike',1
union
Select			3,'Tom',2

Select			*
Into			emp4
From			#emp

Select			*
From			emp4


GO
WITH	CTE_EmpTable1 (empID, empNAME, deptID)
AS 	(Select		empId,
				empName,
				deptId
	From		emp4
	)

SELECT		*
FROM		CTE_EmpTable1

GO
WITH   CTE_MyFirstCTE
AS 

	(SELECT  BusinessEntityID,
			 LoginID,
			 JobTitle,
			 Birthdate,
			 MaritalStatus,
			 Gender,
			 HireDate
	FROM	 AdventureWorks2014.HumanResources.Employee
	)  

	
CREATE TABLE  #TempStoreResultsfromCTE( BusinessEntityID INT,
										LoginID NVARCHAR(255),
										JobTitle NVARCHAR(255),
										BirthDate DATE,
										MaritalStatus NVARCHAR(5),
										Gender NVARCHAR(5),
										HireDate DATE
										)

;
WITH  

CTE_MyFirstCTE
AS 

	(SELECT  BusinessEntityID,
			 LoginID,
			 JobTitle,
			 Birthdate,
			 MaritalStatus,
			 Gender,
			 HireDate
	FROM	 AdventureWorks2014.HumanResources.Employee
	)  

INSERT INTO		#TempStoreResultsfromCTE
SELECT			*
FROM			CTE_MyFirstCTE
WHERE			Gender = 'F'

SELECT			*
FROM			#TempStoreResultsfromCTE


Exec sp_help'emp4' --get table information


SELECT			*
FROM			AdventureWorks2014.HumanResources.Employee


GO
WITH   CTE_MyFirstCTE
AS 

	(SELECT  BusinessEntityID,
			 LoginID,
			 JobTitle,
			 Birthdate,
			 MaritalStatus,
			 Gender,
			 HireDate
	FROM	 AdventureWorks2014.HumanResources.Employee
	)  


SELECT		*
FROM		CTE_MyFirstCTE
WHERE		Gender = 'F'


CREATE TABLE #TEMP1(name varchar(50),
					YOB int)


Insert Into		#TEMP1(name, YOB)
Select			'Mike',1988
Union		
Select			'Tom',2000
Union
Select			'Joben',1985
Union
Select			'Rot',1987

Select		*
From		#TEMP1

Select		name
From		tempdb..sysobjects
Where		name like '%#TEMP1%'

---- put temp table data into temp variable

Declare		@tempVar	Table(Name varchar(50),
								YOb int)

Insert Into	@tempVar(Name,YOb)
Select		*
From		#TEMP1

Select		*
From		@tempVar

CREATE TABLE	#temTable(ID int, Name varchar(25))

Select		*
From		#temTable

---to find temp table exist before we crete new with same name if yes then delete it
If OBJECT_ID('tempdb..#temTable') IS NOT NULL BEGIN DROP table #temTable END

Create	Table	#temTAble(Name varchar(10),ID int)

Select		*
From		#temTAble

---- CTE common table expression

Use AdventureWorks2014
GO
--Define CTE expression name and it's colums
WITH CTE_SALES(SalesPersonID, SalesOrderID,SalesYear)
AS
( -- define CTE query
	Select	SalesPersonID,SalesOrderID, Year(OrderDate) as SalesYear
	From	Sales.SalesOrderHeader
	Where	SalesPersonID is not null
)
--define outer query referencing CTE 
Select		SalesPersonID, Count(SalesOrderID) as TotalSales, SalesYear
From		CTE_SALES
Group by	SalesYear, SalesPersonID
Order by	SalesPersonID, SalesYear
Go

Select		*
From		Sales.SalesOrderHeader

Create Table	ContactInfo(
							Name varchar(50),
							email varchar(50))
Insert Into		ContactInfo
values			('Tom','Tom@test.com'),
				('Mike','Mike@test.com'),
				('Tom','Tom@test.com'),
				('Pop','Pop@test.com'),
				('Mike','Mike@test.com'),
				('Tom','Tom@test.com'),
				('Pop','Pop@test.com')

Select			*
From			ContactInfo

With			CTE_delDup(name,email,dup_count)
As				(
				Select	Name, 
						Email,
						ROW_NUMBER() OVER (PARTITION BY [Name], email Order by			[Name], email) As Duplicate_records
				From	ContactInfo

				)
--See distinct record with use of CTE
/*Select			*
From			CTE_delDup
Where			dup_count = 1
*/
--delete duplicate record from real table using CTE 
Delete From		CTE_delDup
Where			dup_count > 1

Select			*
From			ContactInfo