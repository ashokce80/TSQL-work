/*
Ashok R
SQL review Lab work
5.28.19
*/

--1. What does the acronym T-SQL stand for?
		---Transact Structure Query Language


--2. What keyword in a SQL query do you use to extract data from a database table?   ---SELECT

--3. What keyword in a SQL query do you use to modify data from a database table? ---Update


--4. What keyword in a SQL query do you use to add data from a database table?
		--Insert

--5. What is the difference between the following joins?
--a. Left Join 
	-- The LEFT JOIN returns all records from the left table, and the matched records from the right table. If there is no match from the right side table then it will put NULL for those records.
--b. Inner Join
	--The Inner join return all matched values/records from left and right tables
--c. Right Join
	---- The Right JOIN returns all records from the right table, and the matched records from the left table. If there is no match from the left side table then it will put NULL for those records.

--6. What is the difference between a table and a view?
	--Table is a set of data elements (values) using a model of vertical columns (identifiable by name) and horizontal rows, the cell being the unit where a row and column intersect. 
	--Table is stored in Database.
	-- View is virtual table which represent one or more base table's data as per it's creation sql code. It is based on the result-set of an SQL statement. It's SQL query is store as object for fatching data from base tables.


--7. What is the difference between a temporary and variable table?
	--Temporary Table
		--Created with # tag with tableName
		--it is stored in tempdb database
		--it is only visible in current session so can not be used out side of sessions's query
		--The most often used senarios for temp tables is within a loop of some sorting.

	--Variable Table / Table Variable
		--It is created with Declare statement.
		--It resides in tempdb and it is only accessible within the current Batch, it can not be used/accessed outside of the Batch.
		--table variables are useful with small amounts of data 
		--Rollback is not possible in table variables
		--Syntax as declare @t table (value int) 

/* Example 1.0:
TableA TableB
Field1 Field1
1		2
2		5
3		7
4 		6
4 		3
5 		3
6 		9
*/
Select * From [dbo].[TableA]
Select * From [dbo].[TableB]
--Write SQL queries below based on table layout in Example 1.0.
--8. Display data from TableA where the values are identical in TableB.
	Select		*
	From		[dbo].[TableA] A
	Inner join	[dbo].[TableB] B
	On			A.TabID = B.TabID

--9. Display data from TableA where the values are not available in TableB.
	
	Select		A.TabID, B.TabID
	From		[dbo].[TableA] A
	Left join	[dbo].[TableB] B
	On			A.TabID = B.TabID
	Where		B.TabID is  null

--10. Display data from TableB where the values are not available in TableA.
	
	Select		A.TabID, B.TabID
	From		TableA A
	Right join	TableB B
	On			B.TabID = A.TabID
	Where		A.TabID is null

--11. Display unique values from TableA.
	
	Select distinct *
	From			TableA

--12. Display the total number of records, per unique value, in TableA.
	
	Select distinct * 
	Into			#TableAUniqueV
	From TableA

	Select	count (*) as [Total num of Records]
	From	#TableAUniqueV
	
--13. Display the unique value from TableB where it occurs more than once.
	
	Select	 TabID
	From	TableB
	Group by TabID
	Having	Count(TabID) > 1
	
--14. Display the greatest value from TableB.
	
	Select	 MAX(TabID)
	From	TableB

--15. Display the smallest value from TableA.
	
	Select	 Min(TabID)
	From	TableA

--16. Write a SQL statement to create a variable called Variable1 that can handle the value such as “Welcome to planet earth”.
	GO
	Declare @variable1 varchar(50)
	Select	@variable1 = '"Welcome to planet earth"'

	Print   @variable1

--17. Write a SQL statement that constructs a table called Table1 with the following fields:
--a. Field1 – this field stores numbers such as 1, 2, 3 etc.
--b. Field2 – this field stores the date and time.
--c. Field3 – this field stores the text up to 500 characters.
	
	Create Table	Table1(Field1 int, 
							Field2 datetime,
							Field3 varchar(500))
	Select	*
	From	Table1

--18. Write a SQL statement that adds the following records to Table1:
/*
Field1		Field2			Field3
34			1/19/2012		Mars Saturn
			08:00 AM



65			 2/15/2012		 Big Bright Sun
			10:30 AM



89				3/31/2012		Red Hot Mercury
				09:15 PM
*/

Insert into Table1
Values		(34,Convert(datetime, '3/31/2012 08:00 AM'),'Mars Saturn')
			,(65,Convert(datetime, '2/15/2012 10:30 AM'),'Big Bright Sun')
			,(89,Convert(datetime,'3/31/2012 09:15 PM'),'Red Hot Mercury')

Select	*
From	Table1

--19. Write a SQL statement to change the value for Field3 in Table1 to the value stored in Variable1 (From question 16), on the record that is 34.

Update	Table1
Set		Field3 = @variable1
Where	Field1 = 34
GO

--20. Write a SQL statement for record 89 to return the total number of characters for Field3.

Select	len(Field3) as [F3 charLenght]
From	Table1
where	Field1 = 89



--21. Write a SQL statement for record 65 to return the first occurrence of a space in Field3.

Select	CHARINDEX(' ',Field3) as CharPositionOfSpace
From	Table1
Where	Field1 = 65

Select	*
From	Table1

--22. Write a SQL statement for record 65 to return the value “Bright” from		Field3.

Select		SUBSTRING(SUBSTRING(Field3,CHARINDEX(' ',Field3)+1,len(Field3)),0,CHARINDEX(' ',SUBSTRING(Field3,CHARINDEX(' ',Field3)+1,len(Field3))))
From		Table1
Where		Field1 = 65

--OR

Select		Left(SUBSTRING(Field3,CHARINDEX(' ',Field3)+1,len(Field3)),CHARINDEX(' ',SUBSTRING(Field3,CHARINDEX(' ',Field3)+1,len(Field3)) ))
From		Table1
Where		Field1 = 65



--23. Write a SQL statement for record 34 to return the day from the Field2.

Select	DATEPART(DAY,Field2) as [Day]
From	Table1
Where	Field1 = 34

--24. Write a SQL statement for record 34 to return the first day of the month from the Field2.

SELECT DATEFROMPARTS(YEAR(Field2),MONTH(Field2),1) as FirstDayOfMonth
From   Table1
Where	Field1 = 34

--25. Write a SQL statement for record 34 to return the previous end of the month from the Field2.

Select	EOMONTH(DATEADD(MONTH,-1,Field2)) as PreviousEndOfMonth
From	Table1
Where	Field1 = 34

--26. Write a SQL statement for record 34 to return the day of the week from the Field2.

Select	DATEPART(WEEKDAY,Field2) as [Day of Week]
From	Table1
Where	Field1 = 34

--27. Write a SQL statement for record 34 to return the date as CCYYMMDD from the Field2.

Select convert(varchar(10),convert(int,year(Field2)/100 )+1) +
		right(convert(varchar(10), Field2, 112),6) AS CCYYMMDD
From	Table1
Where	Field1 = 34


--28. Write a SQL statement to add a new column, Field4 (data type can be of any preference), to Table1.

Alter Table	Table1
Add			Field4 int

Select	*
From	Table1

--29. Write a SQL statement to remove record 65 from Table1.

Delete	Table1
Where	Field1 = 65

--30. Write a SQL statement to wipe out all records in Table1.

Truncate table Table1

--31. Write a SQL statement to remove Table1.

Drop Table Table1


--32. Create a sql statement that returns the TerritoryName, SalesPerson (LastName Only), ship method, credit card type (If no credit card, it should say cash), OrderDate and TotalDue for ALL Transactions in the NorthWest Territory.

Select			SST.Name as TerritoryName
				,PP.LastName as SalesPersonLastName
				,PSM.Name as ShipMethod
				,CASE
					When SCC.CardType = Null then 'CASH'
					Else SCC.CardType
				End as CardType
				,SSOH.OrderDate
				,SSOH.TotalDue
From			AdventureWorks2014.[Sales].[SalesTerritory] AS SST
Inner join		AdventureWorks2014.[Sales].[SalesPerson] as SSP
On				SST.TerritoryID = SSP.TerritoryID
Inner join		AdventureWorks2014.[Person].[Person] as PP
On				PP.BusinessEntityID = SSP.BusinessEntityID
Inner join		AdventureWorks2014.[Sales].[SalesOrderHeader] as SSOH
On				SSOH.TerritoryID = SSP.TerritoryID
Inner join		AdventureWorks2014.[Purchasing].[ShipMethod] as PSM
On				PSM.ShipMethodID = SSOH.ShipMethodID
Inner join		AdventureWorks2014.[Sales].[CreditCard] as SCC
ON				SCC.CreditCardID = SSOH.CreditCardID
Where			SST.Name = 'NorthWest'



