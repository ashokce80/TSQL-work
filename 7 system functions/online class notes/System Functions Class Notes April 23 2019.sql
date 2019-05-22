/*

Date: 04/23/2019
Section: System Functions
Class: March Online 2019

*/

/*
STRING FUNCTIONS:

1. LEFT
2. RIGHT
3. LEN
4. SUBSTRING
5. CHARINDEX
6. LTRIM 
7. RTRIM 

DATE FUNCTIONS:

8. DATEDIFF
9. DATEADD
10.DATEPART
11.DATENAME
12.ISDATE

CONVERT/CAST FUNCTIONS:

13. CAST
14. CONVERT

STRING/NUMERIC REPLACE FUNCTIONS

15. NULL
16. COALESCE

*/ 

--1. LEFT
		--> TO GET THE LEFT PART OF A STRING
		--> SYNTAX LEFT('EXPRESSION', INT )
		--> IT TAKES TWO PARAMETERS

SELECT		LEFT('MarchOnline', 5 ) AS ClassMonth

--2. RIGHT
		--> TO GET THE RIGHT PART OF A STRING
		--> SYNTAX RIGHT('EXPRESSION', INT)
		--> IT TAKES TWO PARAMETERS

SELECT		RIGHT('MarchOnline', 6) AS ClassType


SELECT		[SalesOrderID]
			,[SalesOrderDetailID]
			,[CarrierTrackingNumber]
			,LEFT([CarrierTrackingNumber],4) AS Left4Char
			,RIGHT([CarrierTrackingNumber],2) AS Right2Char
			,[OrderQty]
			,[ProductID]
			,[SpecialOfferID]
			,[UnitPrice]
			,[UnitPriceDiscount]
			,[LineTotal]
FROM		Sales.SalesOrderDetail

--3. LEN
		--> TO GET THE LENGTH OF A STRING
		--> SYNTAX  LEN('EXPRESSION')
		--> IT DOES EXCLUDE TRAILING BLANKS

SELECT	 LEN('MarchOnline') AS NumberofLetters --11

SELECT	 LEN('MarchOnline   ') AS NumberofLetters  --11

SELECT		 BusinessEntityID
			,[PersonType]
			,[NameStyle]
			,[Title]
			,[FirstName]
			,LEN([FirstName]) AS LenOfFirstName
			,[MiddleName]
			,[LastName]
			,LEN([LastName]) AS LenOfLastName
			,[Suffix]
			,[EmailPromotion]
			,[AdditionalContactInfo]
			,[Demographics]
FROM		 Person.Person

--4. SUBSTRING

	--> Returns the substring of the first argument starting at the position specified in 
		-- the second argument and the length specified in the third argument.
	--> SYNTAX SUBSTRING('March30OnlineSession',8,6)

SELECT		 SUBSTRING('March30OnlineSession',8,6)

SELECT		[SalesOrderID]
			,[SalesOrderDetailID]
			,[CarrierTrackingNumber]
			,LEFT([CarrierTrackingNumber],4) AS Left4Char
			,RIGHT([CarrierTrackingNumber],2) AS Right2Char
			,SUBSTRING([CarrierTrackingNumber], 6 , 4) AS MiddleChar
			,[OrderQty]
			,[ProductID]
			,[SpecialOfferID]
			,[UnitPrice]
			,[UnitPriceDiscount]
			,[LineTotal]
FROM		Sales.SalesOrderDetail

--5. CHARINDEX

	--> It searches for an expression in another expression and returns
		-- the starting position if found
	--> SYNTAX CHARINDEX('ExpressionToFind','ExpressionToSearch'[,StartingPosition])
	 --> the third argument is defaulted to 1st ExpressionToFind

SELECT		[SalesOrderID]
			,[SalesOrderDetailID]
			,[CarrierTrackingNumber]
			,LEFT([CarrierTrackingNumber],4) AS Left4Char
			,RIGHT([CarrierTrackingNumber],2) AS Right2Char
			,SUBSTRING([CarrierTrackingNumber], 6 , 4) AS MiddleChar
			,CHARINDEX('-',[CarrierTrackingNumber]) AS DashPosition
			,[OrderQty]
			,[ProductID]
			,[SpecialOfferID]
			,[UnitPrice]
			,[UnitPriceDiscount]
			,[LineTotal]
FROM		Sales.SalesOrderDetail

SELECT		[SalesOrderID]
			,[SalesOrderDetailID]
			,[CarrierTrackingNumber]
			,LEFT([CarrierTrackingNumber],4) AS Left4Char
			,RIGHT([CarrierTrackingNumber],2) AS Right2Char
			,SUBSTRING([CarrierTrackingNumber], 6 , 4) AS MiddleChar
			,CHARINDEX('-',[CarrierTrackingNumber],6) AS DashPosition --> To find the second dash
			,[OrderQty]
			,[ProductID]
			,[SpecialOfferID]
			,[UnitPrice]
			,[UnitPriceDiscount]
			,[LineTotal]
FROM		Sales.SalesOrderDetail

--> Retrieve the username (example ken0), Domain Name (adventure-works.com), 
  --EmailAddress, BusinessID, EmailAddressID

  --> Step 1

SELECT		EmailAddress,
			UserName = LEFT(EmailAddress,2),
			EmailAddressID,
			BusinessEntityID
FROM		[Person].[EmailAddress]

--> step 2

SELECT		EmailAddress,
			UserName = LEFT(EmailAddress,CHARINDEX('@',EmailAddress)),
			EmailAddressID,
			BusinessEntityID
FROM		[Person].[EmailAddress]

--> step 3

SELECT		EmailAddress,
			UserName = LEFT(EmailAddress,CHARINDEX('@',EmailAddress)- 1),
			EmailAddressID,
			BusinessEntityID
FROM		[Person].[EmailAddress]


SELECT		EmailAddress,
			UserName = LEFT(EmailAddress,CHARINDEX('@',EmailAddress)- 1), -- same as below 
			LEFT(EmailAddress,CHARINDEX('@',EmailAddress)- 1) AS UserName,
			EmailAddressID,
			BusinessEntityID
FROM		[Person].[EmailAddress]

--> step 4

SELECT		EmailAddress,
			UserName = LEFT(EmailAddress,CHARINDEX('@',EmailAddress)- 1),
			RIGHT(EmailAddress, 19) AS DomainName,
			EmailAddressID,
			BusinessEntityID
FROM		[Person].[EmailAddress]

--> step 5

SELECT		EmailAddress,
			UserName = LEFT(EmailAddress,CHARINDEX('@',EmailAddress)- 1),
			RIGHT(EmailAddress,19 ) AS DomainName,
			EmailAddressID,
			BusinessEntityID
FROM		[Person].[EmailAddress]

--> step 6

SELECT		EmailAddress,
			UserName = LEFT(EmailAddress,CHARINDEX('@',EmailAddress)- 1),
			RIGHT(EmailAddress, LEN(EmailAddress) - CHARINDEX('@',EmailAddress)) AS DomainName,
			EmailAddressID,
			BusinessEntityID
FROM		[Person].[EmailAddress]

SELECT		EmailAddress,
			UserName = LEFT(EmailAddress,CHARINDEX('@',EmailAddress)- 1),
			SUBSTRING(EmailAddress, CHARINDEX('@',EmailAddress) + 1  , LEN(EmailAddress)) AS DomainName,
			EmailAddressID,
			BusinessEntityID
FROM		[Person].[EmailAddress]


--6. LTRIM  --> Trim Open spacing starting from the left 

SELECT		'       MarchOnlineClass'

SELECT LTRIM('       MarchOnlineClass')

SELECT		'MarchOnlineClass'





--7. RTRIM --> Trim Open spacing starting from the right 


SELECT		'MarchOnlineClass     '

SELECT		RTRIM('MarchOnlineClass     ')

SELECT		RTRIM('MarchOnlineClass')


--8- DATEDIFF -- returns the number of date and time boundaries crossed between
				--two specified dates

SELECT		DATEDIFF(YY,'1990-01-01',GETDATE()) --'2019-04-23' --> 29 years

SELECT		DATEDIFF(DD,'1990-01-01',GETDATE()) --'2019-04-23' --> 10704 days

SELECT		DATEDIFF(MM,'1990-01-01',GETDATE()) --'2019-04-23' --> 351 months

SELECT		DATEDIFF(HH,'1990-01-01',GETDATE()) --'2019-04-23' -->256916 hours

/*
datepart	Abbreviations

year		yy, yyyy
quarter		qq, q
month		mm, m
dayofyear	dy, y
day			dd, d
week		wk, ww
weekday		dw
hour		hh
minute		mi, n
second		ss, s

*/

SELECT			*,
				DATEDIFF(DD,OrderDate,ShipDate) AS DaysBtwOrderAndShipment --> INT 
FROM			Sales.SalesOrderHeader

--9. DATEADD   It adds(subtract) number of given interval (DD/HH/YY/MM)in a given datetime

 --> SYNTAX: DATEADD(Datepart,number, DATE)

 --> add 5 years to today's date

 SELECT			DATEADD(YY, 5 , GETDATE())  --> 2024-04-23

 --> substract 5 years from today's date

 SELECT			DATEADD(YY,-5,GETDATE())  --> 2014-04-23


--> Yesterday's date

SELECT			DATEADD(DD,-1, GETDATE())  --> 2019-04-22

--> Add 5 hours to today's date and time

SELECT			DATEADD(HH,5,CURRENT_TIMESTAMP) --> 2019-04-24 01:38:13.363

--10. DATEPART

SELECT			DATEPART(MM, GETDATE()) --> 04

SELECT			DATEPART(YEAR, GETDATE()) --> 2019

SELECT			DATEPART(DD, GETDATE())  --> 23

--11.DATENAME

SELECT			DATENAME(MM, GETDATE()) --> April

SELECT			DATENAME(Weekday, GETDATE()) --> Tuesday

-- find out the employees who have their birthday in next month

SELECT			*
FROM			HumanResources.Employee

SELECT			DATEPART(MM,GETDATE()) + 1 

SELECT			*,
				DATEPART(MM, BirthDate) AS BirthMonth,
				DATENAME (MM, BirthDate) AS BirthMonthName
FROM			HumanResources.Employee
WHERE			DATEPART(MM, BirthDate) = DATEPART(MM,GETDATE()) + 1 

SELECT			GETDATE()  --> 04/23/2019
SELECT			DATEADD(MM,1, GETDATE()) --> 05/23/2019
SELECT			DATENAME(MM,DATEADD(MM,1, GETDATE())) --> May

--> SELECT			DATENAME(MM,DATEADD(MM,1, GETDATE())) --> MAY

SELECT			*,
				DATEPART(MM, BirthDate) AS BirthMonth,
				DATENAME (MM, BirthDate) AS BirthMonthName
FROM			HumanResources.Employee
WHERE			DATENAME(MM, BirthDate) = DATENAME(MM,DATEADD(MM,1, GETDATE()))

-->12. ISDATE 
	--> Returns either 1  or 0

SELECT	ISDATE('2012-11-1')  --> 1  --> it is an actual date

SELECT	ISDATE('2012-110-1') --> 0 --> it is not a date

--> ISNUMERIC

SELECT ISNUMERIC('xyz') --> 0 --> it is not a number

SELECT ISNUMERIC (15)  --> 1 --> it is a number 

--13.CAST 

SELECT	 CAST('12345' AS INT) --> FROM A STRING VARCHAR TO AN INTEGER

SELECT		'12345'

SELECT	'12345' + '1'  --> 123451

SELECT	CAST('12345' AS INT) + CAST('1' AS INT) --> 12346

--> CONVERT AN INTEGER TO A DATE
  --> YOU HAVE TO CONVERT THE INTEGER TO A STRING (VARCHAR)
   --> THEN CONVERT THE STRING (VARCHAR) TO A DATE

--14.CONVERT

SELECT	 CONVERT(DECIMAL(8,2),19.0381359)  --> 19.04  decimal(P,S) P FOR PRECISION S FOR SCALE

SELECT 19.0381359

SELECT  CONVERT(VARCHAR(11),GETDATE()) --> Apr 23 2019

--> Example: decimal(5,2) is a number that has 3 digits before the decimal and 2 digits after the decimal

SELECT	 GETDATE()

SELECT  CONVERT(VARCHAR(10),GETDATE(),103) --> 23/04/2019 


SELECT  CONVERT(VARCHAR(10),GETDATE(),104) --> 23.04.2019

--> ISNULL

SELECT		ISNULL(NULL,'Not Applicable')

SELECT		[BusinessEntityID]
		  ,[PersonType]
		  ,[NameStyle]
		  ,[Title]
		  ,ISNULL([Title],'No Title') AS [NewTitle]
		  ,[FirstName]
		  ,[MiddleName]
		  ,[LastName]
		  ,[Suffix]
		  ,[EmailPromotion]
		  ,[AdditionalContactInfo]
		  ,[Demographics]
FROM		Person.Person

--> COALESCE evaluate in order the current value of the first expression that initially 
  -- do not evaluate to a NULL

  SELECT   [BusinessEntityID]
		  ,[PersonType]
		  ,[NameStyle]
		  ,[Title]
		  ,ISNULL([Title],'No Title') AS [NewTitle]
		  ,COALESCE([Suffix],Title,'No Title Found') AS NewTitle2
		  ,[FirstName]
		  ,[MiddleName]
		  ,[LastName]
		  ,[Suffix]
		  ,[EmailPromotion]
		  ,[AdditionalContactInfo]
		  ,[Demographics]
FROM	  Person.Person


