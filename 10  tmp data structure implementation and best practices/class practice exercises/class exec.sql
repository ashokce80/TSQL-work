/* Temporary data structure */


If	OBJECT_ID('Tempdb..#NASalesTerritory') IS NOT NULL DROP TABLE #NASalesTerritory
Select		*
Into		#NASalesTerritory
From		AdventureWorks2014.sales.SalesTerritory
Where		[Group] = 'North America'

Select		*
From		#NASalesTerritory

/* Create a local temp table that has the territory group, average cost year to date and the sum of the total sales YTDUse the INTO method
 */

If OBJECT_ID('Tempdb..#TmpTblAvgSumofSales') IS NOT NULL DROP TABLE #TmpTblAvgSumofSales

SELECT		[Group], 
			AVG(CostYTD) AS AvgCostytd,
			SUM(SalesYTD) AS SumSalesYTD
Into		#TmpTblAvgSumofSales
FROM		AdventureWorks2014.sales.SalesTerritory
Group by	[Group]

Select		*
From		#TmpTblAvgSumofSales
