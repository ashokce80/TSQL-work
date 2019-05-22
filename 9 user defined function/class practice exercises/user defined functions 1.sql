--Table valued function
use ashok_lab1
go

CREATE TABLE Company(CompanyID int,
					CompanyName varchar(50),
					City varchar(50))

INSERT INTO dbo.Company (CompanyID,CompanyName,City)
SELECT 1,'Walmart','Dallas' UNION
SELECT 2,'Target','Irving' UNION
SELECT 3,'K-Mart','Carrollton' UNION
SELECT 4,'K-Mart','Dallas' UNION
SELECT 5,'Target','Carrollton' UNION
SELECT 6,'Burger King','Irving' UNION
SELECT 7,'Taco Bell','Irving' UNION
SELECT 8,'KFC','Dallas'

Select		*
From		Company

go
Create Function UDF_CompByCity(@City varchar(15))
	Returns Table
	As
			Return(
					Select		*
					From		Company
					Where		City = @City
				  )
go

Select		*
From		dbo.UDF_CompByCity('Irving')

CREATE		FUNCTION	UDF_CityByComp(@Company varchar(50))
Returns		Table
AS
	Return(Select	*
			From	Company
			Where	CompanyName = @Company)

Select		*
From		dbo.UDF_CityByComp('k-mart')


--Class work
Create		Function	UDF_Address(@city varchar(25))
Returns		Table
As
	Return (
				Select		AddressID, AddressLine1, City, StateProvinceID, PostalCode
			From		AdventureWorks2014.Person.Address
			Where		City = @city
			)

Select		*
From		UDF_Address('Seattle')

---
Select		*
From		sales.CreditCard

Select	DATEPART(MM,GEtDATE())+1
