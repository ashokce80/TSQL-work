/*
Ashok Rathod
System functions
4.23.19
*/

use ashok_lab1

SELECT LEN('Hello world!!') AS LENoFSTR
SELECT	LEN(12345) AS LENoFSTR

SELECT LEFT('TEST@TEST.COM',4) 

SELECT LEFT(' THIS IS TEST STRING' ,6)

SELECT RIGHT('TEST@TEST.COM',5)
SELECT RIGHT('THIS IS TEST STRING ',5)

SELECT SUBSTRING('THIS IS TEST STRING',5,4)
SELECT	SUBSTRING('HELLO WORLD',2,6)

SELECT	CHARINDEX('i','this is world')
SELECT	CHARINDEX('i','this is world',4)

SELECT LTRIM('   THIS IS STRING WITH SPACE.')
SELECT LTRIM(  123456)

SELECT RTRIM('STRING WITH SPACE AT THE END    ')
SELECT RTRIM(123456   )

SELECT	DATEDIFF(YEAR,'10-12-2015','10-10-2018')

SELECT DATEDIFF(mm,'01-02-2000','05-07-2010')

SELECT DATEPART(MM,'05-07-2019')

SELECT DATEPART(YYYY,'05-07-2010')

SELECT DATEADD(MM,4,'02-04-2019')

SELECT DATEADD(DD,5,'01-10-2019')

SELECT	9.5 AS ORIGINAL,
		CAST(9.5 AS INT) AS ToDTint,
		CAST(9.5 AS DECIMAL(5,4)) AS ToDtDECIMAL;

SELECT	9.5 AS ORIGINAL,
		CONVERT(INT, 9.5) AS TOINT,
		CONVERT(DECIMAL(6,4), 9.50) AS TODECIMAL;

SELECT ISDATE('00-01-2019')
SELECT ISDATE(12345)
SELECT ISDATE('05-04-2019')

SELECT	ISNULL(NULL,5)
SELECT	ISNULL(11,'ABC')

SELECT	ISNUMERIC('ABC0') --0  FALSE
SELECT	ISNUMERIC(1230) --1 TRUE

--If a table has a list of multiple foreclosure codes, and you don’t know how much unique codes are in the table, how could you get a list of unique codes within the table.

SELECT	COUNT( DISTINCT columnName)
FROM	tableName;

/* What function/process could you use to combine two datasets/tables together (assume the tables have   the same number of columns and data types?
Answer----
	we can use UNION to combine two datasets/tables together. 
	we have to use two differenct queries and union them to gether get combined result of it.
*/

--4. What statement would you use to remove all rows from a table?

 DELETE FROM tableName
 --or 
 Truncate Table tableName


--5. What statement would you use to delete the entire table (remove all data, triggers, indexes)?
	
	Truncate Table tableName
	
--6. I want to add 2 months to todays date?

	SELECT DATEADD(MM,2,GETDATE())

--7. I have two dates (3/25/2007 and 4/1/2009) how can I get the number of months between the two dates?
	
	SELECT DATEDIFF(MM,'3/25/2007','4/1/2009') AS mothDiff

	
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Loan]') AND type in (N'U'))

DROP TABLE [dbo].[Loan]

CREATE TABLE	[dbo].[Loan](
				[LoanNumber] [int] IDENTITY(1000,1) NOT NULL,
				[CustomerFname] [varchar](50) NULL,
				[CustomerLname] [varchar](50) NULL,
				[PropertyAddress] [varchar](150) NULL,
				[City] [varchar](150) NULL,
				[State] [varchar](50) NULL,
				[BankruptcyAttorneyName] [varchar](50) NULL,
				[UPB] MONEY NULL,
				[LoanDate] [Datetime] NULL
 CONSTRAINT [PK_Loan] PRIMARY KEY CLUSTERED 
					  (
						[LoanNumber] ASC
					  )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
					  ) ON [PRIMARY]

TRUNCATE TABLE dbo.Loan

INSERT INTO [dbo].[Loan]
           ([CustomerFname]
           ,[CustomerLname]
           ,[PropertyAddress]
           ,[City]
           ,[State]
           ,[BankruptcyAttorneyName]
		   ,[UPB]
		   ,[LoanDate])
SELECT	'Mr. Anand','Dasari','1212 Main St.','Plano','TX','Jerry',85000,'1/1/2012' UNION
SELECT	'Mr. John','Nasari','1215 Joseph St.','Garland','TX','Jerry',95000,'4/2/2012' UNION
SELECT	'Dr. Ali','Muwwakkil','2375 True True St.','Atlanta','GA','Diesel',115000,'5/3/2008' UNION
SELECT	'Mr. John','Brown','11532 Chain St.','SanFrancisco','CA','Mora',350000,'6/13/2004' UNION
SELECT	'Dr. Kishan','Johnson','4625 Miller Rd.','Atlanta','GA','Diesel',225000,'8/9/2002' UNION
SELECT	'Mr. John','Jackson','972 Flower Rd.','Dallas','TX','Jerry',150000,'3/1/2012' UNION
SELECT	'Sr. Ralph','Jenkins','1518 Mission Ridge St.','SanFrancisco','CA','Mora',650000,'12/15/2011' UNION
SELECT	'Dr. John','Howard','102 Washington','Dallas','TX','Jerry',450000,'4/5/2010' UNION
SELECT	'Mrs. Marsha','Tamrie','1301 Solana','SanFrancisco','CA','Mora',750000,'7/1/2000' UNION
SELECT	'Mrs. Alexis','Gibson','1111 Phillips Rd.','Atlanta','GA','Diesel',99000,'6/1/2012' 
        
SELECT * FROM [dbo].[Loan] 


--8. Write a SQL query to retrieve loan number, state, city, UPB and todays date for loans in the state of TX that have a UPB greater than $100,000 or loans that are in the state of CA or FL that have a UPB greater than or equal to $500,000

SELECT	LoanNumber,[State], City, UPB, LoanDate
FROM	Loan
WHERE	(State = 'TX' AND UPB > 100000) 
OR		((State = 'CA' 
		OR State = 'FL')
		AND UPB > = 500000)

--9. Write a SQL query to retrieve loan number, customer first name, customer last name, property address, and bankruptcy attorney name. I want all the records that have the same attorney name to be together, then the customer last name in order from Z-A (ex.Customer last name of Wyatt comes before customer last name of Anderson)

SELECT		LoanNumber, CustomerFname, CustomerLname, PropertyAddress,								  BankruptcyAttorneyName
FROM		Loan
ORDER BY	BankruptcyAttorneyName, CustomerLname DESC

--10. Write a sql query to retrieve the loan number, state and city, customer first name for loans that are in the states of CA,TX,FL,NV,NM but exclude the following cities (Dallas, SanFrancisco, Oakland) and only return loans where customer first name begins with John.

SELECT		LoanNumber, State, City, SUBSTRING(CustomerFname, CHARINDEX('.',CustomerFname)+2, LEN						(CustomerFName)) AS CustomerFName
FROM		Loan
WHERE		STATE IN ('CA','TX','FL','NV','NM') 
AND			City NOT IN('Dallas', 'SanFrancisco', 'Oakland')
AND			SUBSTRING(CustomerFname, CHARINDEX('.',CustomerFname)+2, LEN												(CustomerFName)) = 'John'

--or

SELECT		LoanNumber, State, City, CustomerFName
FROM		Loan
WHERE		STATE IN ('CA','TX','FL','NV','NM') 
AND			City NOT IN('Dallas', 'SanFrancisco', 'Oakland')
AND			CustomerFName like '%John'

--11. Find out how many days old each Loan is?

SELECT		DATEDIFF(DD,LoanDate,GETDATE()) AS [Loan old in Days]
FROM		Loan

--12. Find the State with the highest Avg UPB.

SELECT	TOP 1	State, AVG(UPB) AS AvgUPB
FROM			Loan
GROUP	BY		State

--13. Each Loan has a length of 30 years. Retrieve the LoanNumber, Attorney Name and the anticipated Finish Date of the Loan.

SELECT		LoanNumber,BankruptcyAttorneyName, DATEADD(YYYY,30,LoanDate) AS [Anticipated Finish Date of					Loan]
FROM		Loan

--14. The Title of the Customer is Located in the CustomerFname Column. Separate the title into its own column and also retrieve CustomerFname, CustomerLname, City, State and LoanDate of Loans that are more than 1 yr old.

SELECT		LEFT(CustomerFname,CHARINDEX('.',CustomerFname)-1)as Title,
			SUBSTRING(CustomerFname, CHARINDEX('.',CustomerFname)+2, LEN(CustomerFName)) AS CustomerFName,
			CustomerLname, City, State, LoanDate
FROM		Loan
WHERE		DATEDIFF(YY,LoanDate,GETDATE()) > 1

OR 

SELECT		LEFT([CustomerFname], (CHARINDEX('.', [CustomerFname])) -1) AS Title,
			RIGHT( [CustomerFname], LEN([CustomerFname]) - CHARINDEX('.',[CustomerFname])) AS [CustomerFname], 
	--SUBSTRING ([CustomerFname], CHARINDEX('.',[CustomerFname]) + 1 , LEN([CustomerFname])) AS [CustomerFname] 
	[CustomerLname], [City], [State], [LoanDate] FROM [dbo].[Loan] WHERE DATEDIFF(YEAR, [LoanDate], GETDATE()) > 1

/*Find another function not used above. Explain what it does. Create a Statement using the new function
and post it to the discussions. Take a screenshot of the posted article, paste it to a Word Doc and
submit it with this assignment.*/
	
	--in doc file
