/*
user defined functions
4.30.19
*/


/* 
Create a table valued function that will return the employee information 
	based on a given birth month
	*Hint* you should be able to pass a range of months
	Ex: January to March
Columns to provide are: BusinessEntityID, NationalIDNumber,JobTitle, Birthdate
MaritalStatus, Gender and HireDate

*/
use ashok_lab1
go
Create Function USD_EMPINFO(@StartMonth int, @EndMonth int) --in advework2014 db
Returns		Table
As
		
Return		(
				Select		BusinessEntityID, NationalIDNumber,JobTitle, BirthDate, MaritalStatus, Gender, HireDate
				From		AdventureWorks2014.HumanResources.Employee
				Where		DATEPART(MM,BirthDate) Between  @StartMonth and @EndMonth)


Select		*
From		USD_EMPINFO(1,4)

Select		BusinessEntityID, NationalIDNumber,JobTitle, BirthDate, MaritalStatus, Gender, HireDate
From		AdventureWorks2014.HumanResources.Employee
Where		DATEPART(MM,BirthDate) Between  01 and 03
	