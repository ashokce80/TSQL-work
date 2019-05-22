/* 
Ashok
Combining multiple data from different sources
Lab work 
5.7.19*/

-------lab 1-----
Create Table Stg_Emp(EmpID int, 
					EmpName varchar(50))
Insert Into	Stg_Emp
Select		1,'John Doe'
Union
Select		2,'Jane Doe'

Insert Into	Stg_Emp
Select		3,'Sally Mae'

Select		*
From		Stg_Emp

Create Table	Emp_list(EmpId int,
						EmpName varchar(50))

Insert Into		Emp_list
Select			1,'John Doe'
Union
Select			2,'Jane Doe'
Union
Select			5,'Peggy Sue'

Select		*
From		Stg_emp

Select		*
From		Emp_list

---Find new employee list
Select		STE.EmpID,STE.EmpName, EL.EmpName
From		Stg_Emp as STE
Left join	Emp_list as EL
On			STE.EmpName = EL.EmpName
Where		EL.EmpName is NULL
Or			StE.EmpName is NULl

--Find former employee list

Select		EL.EmpId, El.EmpName,StE.EmpName
From		Emp_list as EL
Left Join	Stg_Emp as StE
On			El.EmpName = StE.EmpName
Where		StE.EmpName is NULl 
OR			EL.EmpName is NULL


----------------- Lab work 2----------
--1. How many Sales Orders (Headers) used Vista credit cards in October 2012
Use AdventureWorks2014
;

Select		Count(*) AS SalesUsedVistaCard
From		[Sales].[SalesOrderHeader] as SO
Inner join	[Sales].[CreditCard] as CC
ON			(SO.CreditCardID = CC.CreditCardID
			And CC.CardType = 'Vista'
			And	Datepart(YYYY,SO.OrderDate) = 2012
			And	DatePart(MM,SO.OrderDate) = 10 )

--2. Store the answer to Q1. in a variable.

Declare @SalesUsedVistaCard Table( NoOfSalesUsedVistaCard int)

Select	*
From	@SalesUsedVistaCard

Insert into @SalesUsedVistaCard(NoOfSalesUsedVistaCard)
Select		Count(*) AS SalesUsedVistaCard
From		[Sales].[SalesOrderHeader] as SO
Inner join	[Sales].[CreditCard] as CC
ON			(SO.CreditCardID = CC.CreditCardID
			And CC.CardType = 'Vista'
			And	Datepart(YYYY,SO.OrderDate) = 2012
			And	DatePart(MM,SO.OrderDate) = 10 )			

Select	*
From	@SalesUsedVistaCard

/*3. Create a UDF that accepts start date and end date. The function will return
the number of Sales Orders (Using Vista credit cards) that took place between
the start date and end date entered by the user.*/


Go
Create	Function	UDF_NumSaleOrdInDateFrame
(@StartDate datetime, @EndDate datetime)
Returns		Int
As
	Begin
		Return ( 
			Select		Count(*)
			From		[Sales].[SalesOrderHeader] as SO
			Inner join	[Sales].[CreditCard] as CC
			ON			(SO.CreditCardID = CC.CreditCardID
						And CC.CardType = 'Vista'
						And	SO.OrderDate 
						Between @StartDate And @EndDate)
		)
	End
Go

Select	dbo.UDF_NumSaleOrdInDateFrame('2011-10-01','2012-01-05') as NumOfsales

/*4. Using the SalesOrderHeader table - Find out how much Revenue (TotalDue) was brought in by
the North American Territory Group from 2011 through 2012*/

Select		sum(TotalDue)
From		[Sales].[SalesOrderHeader] AS SOH
Inner Join	[Sales].[SalesTerritory] AS ST
On			SOH.TerritoryID = ST.TerritoryID
			And	ST.[Group] like 'North America'
			And	DATEPART(YYYY,SOH.OrderDate) 
			Between 2011 And 2012

/*5 What is the Sales Tax Rate, StateProvinceCode and CountryRegionCode for Texas? */			
/* Select		*   --- Texas Sales Tax rate, common stateprovinceID
From		[Sales].[SalesTaxRate]

Select		* --StateProvinceCode  ,CountryRegionCode   cmnn stateprovinceID
From        [Person].[StateProvince]*/
		
Select			ST.StateProvinceID, ST.TaxRate, PSP.StateProvinceCode, 								PSP.CountryRegionCode, PSP.[Name]
From			[Sales].[SalesTaxRate] as ST
Inner JOIN		[Person].[StateProvince] as PSP
ON				ST.StateProvinceID = PSP.StateProvinceID
And				PSP.[Name]	like '%Texas%'	

--6. Store the information from Q5 in a variable.

Declare			@TexasTax Table
(StateProvinceID int,TaxRate float,StateProvinceCode Varchar(10), CountryRegionCode varchar(5),[Name] Varchar(20))

Insert Into		@TexasTax
Select			ST.StateProvinceID, ST.TaxRate, PSP.StateProvinceCode, 								PSP.CountryRegionCode, PSP.[Name]
From			[Sales].[SalesTaxRate] as ST
Inner JOIN		[Person].[StateProvince] as PSP
ON				ST.StateProvinceID = PSP.StateProvinceID
And				PSP.[Name]	like '%Texas%'	


Select			*
From			@TexasTax

/*7. Create a UDF that accepts the State Province and returns the associated
Sales Tax Rate, StateProvinceCode and CountryRegionCode.*/
GO
Create	Function	UDF_StateandTax
(@StateProvince varchar(25))
Returns	Table
	Return(
			Select		ST.StateProvinceID, ST.TaxRate,PSP.StateProvinceCode,				PSP.CountryRegionCode
			From		[Sales].[SalesTaxRate] as ST
			Inner JOIN	[Person].[StateProvince] as PSP
			ON			ST.StateProvinceID = PSP.StateProvinceID
			And			PSP.[Name]	= @StateProvince
		)

Select		*
From		UDF_StateandTax('Texas')

/*8. Show a list of Product Colors. For each Color show how many SalesDetails there are and the Total SalesAmount (UnitPrice * OrderQty). Only show Colors with a Total SalesAmount more than $50,000 and eliminate the products that do not have a color.*/
Select	*
From	[Production].[Product]
Select	*
From	[Sales].[SalesOrderDetail]

Select		PP.Color,Count(SSO.SalesOrderDetailID) as TotalSalesDetails,
			SUM(SSO.UnitPrice * SSO.OrderQty) As TotalSalesAmt
From		[Production].[Product] as PP
Inner join	[Sales].[SalesOrderDetail] as SSO
ON			PP.ProductID  =  SSo.ProductID
And			PP.Color is not null
Group by	PP.Color--,SSO.UnitPrice, SSO.OrderQty
Having		SUM(SSO.UnitPrice * SSO.OrderQty) > 50000

/*
Create a join using 4 tables in AdventureWorks database. Explain what the join is doing and post it to
the Google Group.

ANS:   In word Document for pic but code is shown below */

--Find the Year to Date sale of Product by country 
--or find product name and their sales year to date in all countries
Select		PP.[Name] as ProductName, SST.[Name] as Country, SST.SalesYTD as SalesYearToDate
From		[Sales].[SalesOrderDetail] as SOD
Inner join	[Production].[Product]   as PP
On			SOD.ProductID = PP.ProductID
Inner join	[Sales].[SalesOrderHeader] as SOH
ON			SOH.SalesOrderID = SOD.SalesOrderID
Inner join	[Sales].[SalesTerritory] as SST
On			SST.TerritoryID = SOH.TerritoryID
Group by	PP.[Name], SST.[Name], SST.SalesYTD
Order by	PP.[Name]

 
