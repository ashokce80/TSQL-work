/* Name: Ashok Rathod
   Session: Constraints
   Date: 4.16.19
*/

CREATE TABLE	customer(
				custId int,
				custName varchar(50),
				entryDate datetime)

CREATE TABLE	salesReps(
				repId int,
				repName varchar(50),
				hireDate datetime)

CREATE TABLE	sales(
				salesId int,
				custId int,
				repId int,
				salesDate datetime,
				unitCount int,
				varificationCode varchar(50))

--1. Create Primary Keys on all 3 tables

ALTER TABLE		customer
ADD CONSTRAINT  PK_customer_custId PRIMARY KEY(custId)

ALTER TABLE		salesReps
ADD CONSTRAINT	PK_salesReps_repId PRIMARY KEY(repId)

ALTER TABLE		sales
ADD CONSTRAINT	PK_sales_salesId PRIMARY KEY(salesId)

-- 2. All 3 tables should have IDENTITY columns as the PRIMARY KEY’s. They must start at 100 and increment by 2.

-- **** Done, pics in Word file ***

--3. Create a Unique Key on dbo.Sales.VerficationCode
	
ALTER TABLE		sales
ADD CONSTRAINT	uk_sales_verificationCode UNIQUE(verificationCode)

--4. Create a relationship between the Customer / SalesRep and the Sales Table
--relation between customer and sales table

ALTER TABLE		sales
ADD CONSTRAINT	fk_sales_custId_customer_custId
FOREIGN KEY		(custID)
REFERENCES		customer(custID)

--relation between customer and sales table

ALTER TABLE		sales
ADD CONSTRAINT	fk_sales_repID_salesReps_repID
FOREIGN KEY		(repId)
REFERENCES		salesReps(repId)

/*5. No nulls will be allowed in the following tables.columns
	a. dbo.Sales.SalesDate
	b. dbo.Sales.VerificationCode*/

ALTER TABLE		sales
ALTER COLUMN	salesDate datetime not null 

/* 6. The following tables.columns will default to GetDate() if no Date is      given.
	a. Dbo.Customer.EntryDate
	b. Dbo.SalesRep.HireDate
	c. Dbo.Sales.SalesDate*/

ALTER TABLE		customer
ADD CONSTRAINT	df_customer_entryDate 
Default			GETDATE()
FOR				entryDate;

ALTER TABLE		salesReps
ADD CONSTRAINT	df_salesReps_hireDate
Default			getdate()
FOR				hireDate;

ALTER TABLE		sales
ADD CONSTRAINT	df_sales_salesDate
Default			getDate()
FOR				salesDate;

7. dbo.Sales.UnitCount should not allow NULLS or Zero’s

ALTER TABLE		sales
ADD CONSTRAINT	ck_sales_unitCount CHECK(unitCount != null AND unitCount > 0 )
-- Insert data into table to check all created constraints 

INSERT INTO dbo.customer(CustName)
SELECT 'Ali' UNION
SELECT 'Anand' 
UNION
SELECT 'Alex' 
UNION
SELECT 'Jack' 
UNION
SELECT 'Nina' 
UNION
SELECT 'Joel' 
UNION
SELECT 'Keon' 
UNION
SELECT 'James' 
UNION
SELECT 'Mike' 
UNION
SELECT 'Sai' 
UNION
SELECT 'Terry'

INSERT INTO dbo.salesReps(RepName)
SELECT 'Joseph' 
UNION
SELECT 'Jermaine' 
UNION
SELECT 'Marshall' 
UNION
SELECT 'Marvin' 
UNION
SELECT 'Mitchell' 
UNION
SELECT 'Johnson' 
UNION
SELECT 'Robert' 
UNION
SELECT 'Rachel' 
UNION
SELECT 'Rene' 
UNION
SELECT 'Brandy'
UNION
SELECT 'Dirk'

INSERT INTO dbo.Sales (custID, repID,unitCount,verificationCode)
SELECT 100,120,1,'Ver01' 
UNION
SELECT 102,118,2,'Ver02' 
UNION
SELECT 104,116,3,'Ver03' 
UNION
SELECT 106,114,4,'Ver04' 
UNION
SELECT 108,112,5,'Ver05' 
UNION
SELECT 110,110,1,'Ver06' 
UNION
SELECT 112,108,2,'Ver07' 
UNION
SELECT 114,106,3,'Ver08' 
UNION
SELECT 116,104,4,'Ver09' 
UNION
SELECT 118,102,5,'Ver10' 
UNION
SELECT 120,100,6,'Ver11'

SELECT		*
FROM		sales
SELECT		*
FROM		salesReps
SELECT		*
FROM		customer