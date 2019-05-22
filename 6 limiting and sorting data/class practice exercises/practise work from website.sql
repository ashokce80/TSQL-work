USE ashok_lab1

CREATE TABLE	dbo.lease(
				leaseId int not null primary key,
				leaseName varchar(50),
				leaseType varchar(50) not null,
				city varchar(50),
				sate varchar(50),
				zip varchar(50),
				rentAmount int )

Insert Into	dbo.lease(leaseName,leaseType,city,[state],zip,rentAmount)
Select		'TrumpTower','1 yr','New York','NY',76238,14000
UNION	
Select		'FedEx Building','6 month','Miami','FL',77828,9000

UNION	
Select		'','','',''
UNION	
Select		'','','',''


	USE AdventureWorks2014 ;  
	GO  
	SELECT SalesOrderID, SUM(LineTotal) AS SubTotal  
	FROM Sales.SalesOrderDetail  
	GROUP BY SalesOrderID  
	HAVING SUM(LineTotal) > 100000.00  
	ORDER BY SalesOrderID ;

