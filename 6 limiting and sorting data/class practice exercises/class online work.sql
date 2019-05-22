/*limiting and sorting*/
-- topics to cover
/*topics for today where having update delete truncate order by top*/

-- EXCEPT keyword used to find difference between two tables with refernces to first table from script

--INTERSECT keyword used to find common record between two tables with reference to first table from script

--> RETRIEVE THE TERRITORY WITH THE HIGHEST TOTAL SALES		--> COLUMNS TO RETRIEVE IS GROUP AND THE TOTAL SALESYTDSELECT			* --MAX(SalesYTD)FROM			Sales.SalesTerritory


SELECT TOP 1	[Group], sum(SalesYTD) AS totalSales
FROM			Sales.SalesTerritory
GROUP BY		[Group]
ORDER BY		SUM(SalesYTD) DESC
 