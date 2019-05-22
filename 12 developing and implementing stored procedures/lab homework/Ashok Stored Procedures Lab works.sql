/*
Ashok R
Stored Procedures lab work
4.11.19
*/
--- Lab 1

/* 1. Name: CREATE PROCEDURE proc_TerritorySalesByYear
a. Parameter: OrderYear
(Passing Value)
b. Display the Total sales by territory for the Year Parameter
(The following is for the results set, which will be created in your statement in order to pass your parameter to receive the total sales by each territory) */

Go
CREATE PROCEDURE proc_TerritorySalesByYear
@YearOfSale int
As 
Begin
	Select		SOH.TerritoryID,
				ST.Name as TerritoryName,
				ST.CountryRegionCode,
				SUM(SOH.TotalDue) as TerrotorySale, 
				Datepart(YYYY, SOH.OrderDate) as [Order Year]
	From		AdventureWorks2014.[Sales].[SalesOrderHeader] as SOH
	Inner join	AdventureWorks2014.[Sales].[SalesTerritory] as ST
	On			SOH.TerritoryID = ST.TerritoryID
	Where		Datepart(YYYY, SOH.OrderDate) = @YearOfSale
	Group by	SOH.TerritoryID,Datepart(YYYY,SOH.OrderDate),ST.Name,ST.CountryRegionCode
	Order by	SOH.TerritoryID
End
GO

Exec	proc_TerritorySalesByYear '2012'

/*2. Name: CREATE PROCEDURE proc_SalesByTerritory
a. Parameter: Territory Name
(Passing Value)
b. Results set: Display Total sales by Year for the Territory Name Parameter
(The following is for the results set, which will be created in your statement in orderto pass your parameter to receive the total sales by each year) 
*/

GO
Alter PROCEDURE UD_SP_SalesByTerritory
@TerritoryName varchar(100)
As 
Begin
	Select		SOH.TerritoryID,
				ST.[Name],
				ST.CountryRegionCode,
				--Datepart(YYYY, SOH.OrderDate) as YearOfSale,
				SUM(SOH.TotalDue) as TerrotorySale, 
				Datepart(YYYY, SOH.OrderDate) as [Order Year]
	From		AdventureWorks2014.[Sales].[SalesOrderHeader] as SOH
	Inner join	AdventureWorks2014.[Sales].[SalesTerritory] as ST
	On			SOH.TerritoryID = ST.TerritoryID
	Where		ST.[Name] = @TerritoryName
	Group by	SOH.TerritoryID,
				ST.CountryRegionCode,
				Datepart(YYYY,SOH.OrderDate),
				ST.[Name]
	Order by	SOH.TerritoryID
End
GO


Exec UD_SP_SalesByTerritory'Northeast'
GO

/* 3 Name: CREATE PROCEDURE proc_TerritoryTop5Sales_ByProduct
a. Parameter: Territory Name
(Passing Value)
b. Results set: Top 5 Products by year
(The following is for the results set, which will be created in your statement in order to pass in Territory Name to receive the Top 5 Products sold (Sum of Line Total) by each Year) You may need to use a temp table/table variable combination.*/


GO
Create PROCEDURE UD_SP_TerritoryTop5Sales_ByProduct
@TerritoryName varchar(50)
As
Begin
	IF OBJECT_ID('tempdb..#Sales_ByProduct') is not null Drop Table																#Sales_ByProduct
	Select		Pro.Name as ProductName,
				SUM(SOD.LineTotal) as SODLineTotal,
				DATEPART(YYYY,SOH.OrderDate) as OrderYear 
	Into		#Sales_ByProduct
	From		AdventureWorks2014.[Sales].[SalesTerritory] as ST
	Inner Join	AdventureWorks2014.[Sales].[SalesOrderHeader] as SOH
	On			ST.TerritoryID = SOH.TerritoryID  
	Inner join	AdventureWorks2014.[Sales].[SalesOrderDetail] as SOD
	On			SOD.SalesOrderID = SOH.SalesOrderID
	Inner Join	AdventureWorks2014.[Production].[Product] as Pro
	ON			Pro.ProductID = SOD.ProductID
	Where		ST.Name = @TerritoryName
	Group	by	Pro.Name,
				DATEPART(YYYY,SOH.OrderDate)
	Order	by	OrderYear,
				SODLineTotal desc
	IF OBJECT_ID('tempdb..#Sales_ByProductOrderYear') is not null Drop Table															#Sales_ByProductOrderYear
	Select	distinct	OrderYear
	Into				#Sales_ByProductOrderYear
	From				#Sales_ByProduct

	--Select			*	From				#Sales_ByProductOrderYear

	Declare	@OderYr int 
	Set		@OderYr = (Select TOP 1 * from #Sales_ByProductOrderYear)

	IF OBJECT_ID('tempdb..#Top5ProductSoldYrTerri') is not null Drop Table															#Top5ProductSoldYrTerri

	Create	Table	#Top5ProductSoldYrTerri(ProductName Varchar(200),
					SODLineTotal money,
					OrderYear int)

	While	@OderYr is not null
	Begin
		Insert into			#Top5ProductSoldYrTerri
		Select	top 5		*
		From				#Sales_ByProduct
		where				OrderYear = @OderYr
		Order		by		SODLineTotal desc

		Delete From			#Sales_ByProductOrderYear
		Where				OrderYear = @OderYr

		Set		@OderYr = (Select TOP 1 * from #Sales_ByProductOrderYear)
	End

	Select		*
	From		#Top5ProductSoldYrTerri
End

EXEC UD_SP_TerritoryTop5Sales_ByProduct'Northeast'

------------------
/*  4. Stored Procedure with Output Parameters
     a. Add a MgrID column to your emp table.
     b. Populate it accordingly using the integer data type and same number of characters as the empID column
     c.  Build a SP that passes in empID and returns an output parameter of the mgrID - (Create the SP and verify it works correctly) (Keep in mind that the mgrID will also be an individual’s empID., since managers are also employees)
     d.  (Start a New Query and separate it from the previous Stored Procedure) Declare an empid int and manager_name Varchar(50) variable
     e.  Hard code your new empid variable and Pass it into your new SP to return the mgrid(Use an actual empid in the variable location to test and Pass it into your new SP to return the mgrID)
     f.  Capture that mgrid in a variable and use that mgrid variable to determine the Managers name(Create another statement which locates the Manager’s Name by using mgrID)
     e.  Print the Managers name */

Select		*
From		emp
--a. Add a MgrID column to your emp table.
Alter table	dbo.emp
Add			MgrID int
--- b now add MgrID data in table with update 
Update		dbo.emp
Set			MgrID = 4
Where		empId = 3
-- added many records in table for query
--c

GO
Create Proc	UD_SP_getEmpIDbyMgrID
@EmpID int,
@MgrID int output
AS
Begin
	Select	@MgrID = 	MgrID
	From				emp
	where				empId = @EmpID
End

Declare	@MgID int 
Exec UD_SP_getEmpIDbyMgrID'1', @MgrID = @MgID Output
Print	@MgID

--d
GO
Create Proc	UD_SP_getEmpIDbyMgrID1
@EmpID int,
@MgrID int output
AS
Begin
	Select	@MgrID = 	MgrID
	From				emp
	where				empId = @EmpID
End

Declare @epID int, @Manager_name varchar(50), @MgID int
--e
Set		@epID = 9
--f
Exec UD_SP_getEmpIDbyMgrID1 @epID, @MgrID = @MgID Output
Print	@MgID

--Here manager is also employee so we can use MgID as EmpID for manager name because we using only one table to get manager name
--g
Select		empName
From		dbo.emp
Where		empId = @MgID

---------------------------------- LAB 2 now -------------------------
/*Write SQL queries below based on table layout in Example 1.0.*/
Create table	TableA(TabID int)
Insert into		TableA
Values			(1),(2),(3),(4),(4),(5),(6)
Select			* 
From			TableA

Create Table	TableB(TabID int)
Insert into		TableB
Values			(2),(5),(7),(6),(3),(3),(9)
Select			*
From			TableB
Select			* 
From			TableA

--1. Display data from TableA where the values are identical in TableB.

Select			A.TabID
From			TableA A
Inner join		TableB B
On				A.TabID = B.TabID

--2. Display data from TableA where the values are not available in TableB.

Select		A.TabID
From		TableA A
Left join	TableB B
On			A.TabID = B.TabID
Where		B.TabID is null

--or
Select		A.TabID
From		TableA A
Where		A.TabID not in( Select B.TabID from TableB B)

--3. Display data from TableB where the values are not available in TableA.

Select		*
From		TableB B
Where		B.TabID NOT IN (Select A.TabID from TableA A)

--4. Create a Stored Procedure that passes in the SalesOrderID as a parameter. This stored procedure will return the SalesOrderID, the Date of the transaction and a count of how many times the item was purchased.

Go
Create proc	UD_SP_NumOftimesItemPuchased
@SOID int 
As 
	Select		SOD.SalesOrderID,
				Convert(DATE,SOH.OrderDate) as OrderDate,
				SOD.OrderQty as [NumOftimes Item purchased]
	From		AdventureWorks2014.[Sales].[SalesOrderDetail] as SOD
	Inner join	AdventureWorks2014.[Sales].[SalesOrderHeader] As SOH
	ON			SOD.SalesOrderID = SOH.SalesOrderID
	Where		SOD.SalesOrderID = @SOID --43661

Exec	UD_SP_NumOftimesItemPuchased'43662'

-- 5. Create a Stored Procedure that passes in the SalesOrderID as a parameter. This stored procedure will return the SalesOrderID, Date of the transaction, shipping date, City and State.

GO
Create	Proc	UD_SP_OrderDetail
@SOID int
AS
	Select			SOH.SalesOrderID,
					Convert(DATE,SOH.OrderDate) as OrderDate,
					Convert(DATE,SOH.ShipDate) as ShipDate,
					PAdd.City,
					PSPRo.Name as [State]
	From			AdventureWorks2014.[Sales].[SalesOrderHeader] as SOH
	Inner join		AdventureWorks2014.[Person].[Address] as PAdd
	On				SOH.ShipToAddressID = PAdd.AddressID
	Inner join		AdventureWorks2014.[Person].[StateProvince] as PSPRo	
	ON				PAdd.StateProvinceID = PSPRo.StateProvinceID
	Where			SOH.SalesOrderID = @SOID -- 43662
	
Exec	UD_SP_OrderDetail'43665' 

--6. Create a stored procedure that passes in the Territory Name as a parameter. This stored procedure will return the Territory Group, CountryRegionCode, Count of SalesHeaders in 2011, and the Count of SalesDetails in 2011

Go
Create	Proc	UD_SP_TerritoryANDSalesDetail
@TerritoryName varchar(25)
AS
	Select			ST.[Group],
					ST.CountryRegionCode, 
					Count(SOH.SalesOrderID) as NoOfSalesHeaderin2011, 
					COUNT(SOD.SalesOrderID) as NoOfSalesDetailsin2011
	From			AdventureWorks2014.[Sales].[SalesTerritory] as ST
	Inner join		AdventureWorks2014.[Sales].[SalesOrderHeader] as SOH
	ON				SOH.TerritoryID = ST.TerritoryID 
	Inner join		AdventureWorks2014.Sales.SalesOrderDetail as SOD
	ON				SOH.SalesOrderID = SOD.SalesOrderID
	Where			ST.Name = @TerritoryName-- 'Southeast'
	And				DATEPART(YYYY,SOH.OrderDate) = 2011
	Group by		ST.[Group],
					ST.CountryRegionCode

Exec UD_SP_TerritoryANDSalesDetail'Northeast'

--7. Create a stored procedure that passes in the Product name as a parameter. This stored procedure will return the lowest price in History, Highest Price in History, difference between the two prices, Count of SalesDetails and the Sum of LineTotal.

Go
Create Proc UD_SP_PriceDetailonProName
@ProdName varchar(50) = 'AWC Logo Cap'
As
	IF OBJECT_ID('tempdb..#ListPrices') is not null Drop table #ListPrices
	Select 		pph.ListPrice
	Into		#ListPrices
	From		AdventureWorks2014.[Production].[ProductListPriceHistory] as				pph
	Inner join	AdventureWorks2014.[Production].[Product] as Prod
	ON			pph.ProductID = Prod.ProductID
	Where		Prod.Name = @ProdName  --'AWC Logo Cap'
	Order by	StartDate

	Declare @low money = (Select  top 1 ListPrice
							From	#ListPrices)

	Declare	@high money = (Select	top 1 ListPrice From #ListPrices order by								 ListPrice desc)
	--Select @low,@high

	Select			@low as [Lowest Price in History],
					@high as [Highest Price in History],
					@high-@low  as [Price differece in History],
					Sum(SOD.LineTotal) as [Sum of LineTotal],
					Count(SOD.SalesOrderID) as [Count of SalesDetails]
	From			AdventureWorks2014.[Production].[Product] as Prod
	Inner join		AdventureWorks2014.[Production].[ProductListPriceHistory]				as ppriceH
	On				Prod.ProductID = ppriceH.ProductID
	Inner join		AdventureWorks2014.[Sales].[SalesOrderDetail] as SOD
	On				ppriceH.ProductID = SOD.ProductID
	Where			Prod.Name = @ProdName -- 'AWC Logo Cap' 
					--AWC Logo Cap --Long-Sleeve Logo Jersey, M --Mountain-100 Silver, 42

Exec	UD_SP_PriceDetailonProName'Road-650 Red, 44' --'Classic Vest, L'

--8. Create a SP that passes in the OrderYear as a parameter. This stored procedure will return the Count of the SalesHeaders and SalesDetails for the OrderYear parameter.

Go
Create	Proc	UD_SP_CountSHandSDbyOYR
@OrderYear int = 2012
As 
	Select		Count(SOH.SalesOrderID) as CountOfSalesHeader,
				Count(SOD.SalesOrderDetailID) as CountOfSalesDetails
	From		AdventureWorks2014.[Sales].[SalesOrderHeader] as SOH
	Inner join  AdventureWorks2014.[Sales].[SalesOrderDetail] as SOD
	ON			SOH.SalesOrderID = SOD.SalesOrderID
	Where		DATEPART(YYYY,SOH.OrderDate) = @OrderYear--2011

Exec UD_SP_CountSHandSDbyOYR'2013'