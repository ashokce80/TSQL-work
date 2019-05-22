-- system function


SELECT		*
FROM		[Person].[EmailAddress]
/* retrieve username, domain name, emailaddress and rest
*/
SELECT		BusinessEntityID,EmailAddressID,EmailAddress,
			LEFT(EmailAddress,CHARINDEX('@',EmailAddress)-1) AS USERNAME,
			--RIGHT(EmailAddress,
			--LEN(EmailAddress)-CHARINDEX('@',EmailAddress)) AS DOMAINNAME,
			SUBSTRING(EmailAddress,CHARINDEX('@',EmailAddress),) AS DOMAINNAME
FROM		[Person].[EmailAddress]

SELECT		LEN(EmailAddress) - CHARINDEX('@',EmailAddress)
from		[Person].[EmailAddress]

use ashok_lab1


SELECT	9.5 AS ORIGINAL,
		CAST(9.5 AS INT) AS ToDTint,
		CAST(9.5 AS DECIMAL(5,4)) AS ToDtDECIMAL;

SELECT	9.5 AS ORIGINAL,
		CONVERT(INT, 9.5) AS TOINT,
		CONVERT(DECIMAL(6,4), 9.50) AS TODECIMAL;

SELECT	ISNULL(NULL,5)

SELECT	ISNUMERIC('ABC0') --0  FALSE
SELECT	ISNUMERIC(1230) --1 TRUE

SELECT	SUBSTRING('HELLO WORLD',2,6)

SELECT	CHARINDEX('i','this is world',4)

SELECT	DATEDIFF(YEAR,'10-12-2015','10-10-2018')

SELECT DATEPART(DD, '10-12-2019')

SELECT	DATEADD(MM,4,'10-10-2019')

SELECT	DATEADD(YY,2,'10-10-2019')

SELECT IsNumeric('45 Help')


DECLARE @FullName varchar(255) = 'Tamburello,Roberto'

DECLARE @LastName VARCHAR(255)= LEFT(@FullName,CHARINDEX(',',@FullName)-1)
SELECT @LastName 

DECLARE @FirstName VARCHAR(255) = Right(@FullName,LEN(@FullName) - CharIndex(',',@FullName))
SELECT @FirstName
