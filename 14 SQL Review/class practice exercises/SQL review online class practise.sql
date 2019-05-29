/*
SQL review class online
5.28.19
*/

Select top 1		*
From		AdventureWorks2014.Sales.SalesOrderHeader


Select		SUM(TotalDue) as TotalOfTotalDue
			, SUM(TaxAmt + Freight) as TAXANDFREIGHT
			,Case	When SUM(TaxAmt + Freight) > 10000 Then 'High Tax Group'
					When SUM(TaxAmt + Freight) > 8000 and SUM(TaxAmt + Freight) < 10000 
						 Then 'Medium Tax Group'
					When SUM(TaxAmt + Freight) < 8000 
						 Then 'Low Tax Group'
					Else 'No Tax Group'
			End as Tax_Group
			,SalesPersonID
From		AdventureWorks2014.Sales.SalesOrderHeader
Group by	SalesPersonID		

/*
Take the above query and create a stored procedure and add the following 
columns SalesPersonFirstName, SalesPersonLastName, JobTitle, TerritoryName
TotalOfTotalDue,TaxAndFreight,TaxGroup
Input parameter will be the Territory Name */

Select top 1		*
From		AdventureWorks2014.Sales.SalesOrderHeader

Select top 1	*
From			AdventureWorks2014.[Sales].[SalesPerson]

Select top 1	*
From			AdventureWorks2014.[HumanResources].[Employee]
--businessentiid
Select top 1	*
From			AdventureWorks2014.[Person].[Person]

Select top 1	*
From			AdventureWorks2014.[Sales].[SalesTerritory]

Go
Alter Proc UD_SP_DataForTerritory
@TName varchar(25)  
as
Select		SUM(TotalDue) as TotalOfTotalDue
			, SUM(TaxAmt + Freight) as TAXANDFREIGHT
			,Case	When SUM(TaxAmt + Freight) > 10000 Then 'High Tax Group'
					When SUM(TaxAmt + Freight) > 8000 and SUM(TaxAmt + Freight) < 10000 
						 Then 'Medium Tax Group'
					When SUM(TaxAmt + Freight) < 8000 
						 Then 'Low Tax Group'
					Else 'No Tax Group'
			End as Tax_Group
			,SalesPersonID
			,PP.FirstName as SalesPersonFirstName
			,PP.LastName as SalesPersonLastName
			,HRE.JobTitle
			,SST.Name as TerrirotyName
From		AdventureWorks2014.Sales.SalesOrderHeader as SSOH
Left join	AdventureWorks2014.[Sales].[SalesTerritory] as SST
ON			SST.TerritoryID = SSOH.TerritoryID
Left join	AdventureWorks2014.[Sales].[SalesPerson] as SSP
ON			SSP.TerritoryID = SSOH.TerritoryID
Left join	AdventureWorks2014.[HumanResources].[Employee] as HRE
ON			HRE.BusinessEntityID = SSP.BusinessEntityID
Left join	AdventureWorks2014.[Person].[Person] as PP
On			PP.BusinessEntityID = HRE.BusinessEntityID
Where		SST.Name = @TName --'Northwest'
Group by	SalesPersonID
			,PP.FirstName
			,PP.LastName 
			,HRE.JobTitle
			,SST.Name 


Exec UD_SP_DataForTerritory'Northwest'

--good try i need the where clause for the territory name and also you want to show all the records from the first query and then left join it to all the tables

---- OR----

-- =============================================
-- Author:		<Ashok>
-- Create date: <5.28.19>
-- Description:	<tax group based on the total of tax amoint and the freight as we ass provice sales person name job title and territory name>
--Input Parameter: terrotoryName
-- =============================================
Go
Alter Proc UD_SP_DataTerritory1
@TerritoryName varchar(25)  
as
	Set	Nocount on;
If OBJECT_ID('Tempdb..#BaseT') is not null drop table #BaseT

Select		SUM(TotalDue) as TotalOfTotalDue
			, SUM(TaxAmt + Freight) as TAXANDFREIGHT
			,Case	When SUM(TaxAmt + Freight) > 10000 Then 'High Tax Group'
					When SUM(TaxAmt + Freight) > 8000 and SUM(TaxAmt + Freight) < 10000 
						 Then 'Medium Tax Group'
					When SUM(TaxAmt + Freight) < 8000 
						 Then 'Low Tax Group'
					Else 'No Tax Group'
			End as Tax_Group
			,SalesPersonID
			,TerritoryID
Into		#BaseT
From		AdventureWorks2014.Sales.SalesOrderHeader
Group by	SalesPersonID,TerritoryID

Select		TotalOfTotalDue
			,TAXANDFREIGHT
			,Tax_Group
			,SalesPersonID
			,PP.FirstName as SalesPersonFirstName
			,PP.LastName as SalesPersonLastName
			,HRE.JobTitle
			,SST.Name as TerrirotyName
From		#BaseT BT
left join	AdventureWorks2014.[HumanResources].[Employee] as HRE
ON			BT.SalesPersonID = HRE.BusinessEntityID
Left join	AdventureWorks2014.[Person].[Person] as PP
ON			PP.BusinessEntityID = HRE.BusinessEntityID
	
Left join	AdventureWorks2014.[Sales].[SalesTerritory] as SST
ON			SST.TerritoryID = BT.TerritoryID
Where		SST.Name = @TerritoryName --'Northwest'

Exec		UD_SP_DataTerritory1'Southwest'
--------------------------------------------------------------------

Go
Create Function	Fn_value(@a Int)
Returns table
AS
	Return (Select * From dbo.Emp_test Where Emp_sal > @a)
Go

Select		*
From		Fn_value(1200)

Select * From [dbo].[Emp_test]

