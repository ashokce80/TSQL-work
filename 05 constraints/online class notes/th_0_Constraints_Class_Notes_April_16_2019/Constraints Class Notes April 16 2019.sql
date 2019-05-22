/*

Date:April 16 2019
Section 5: Constraints
Class: March 30 2019 Online Class

*/

--> CONSTRAINTS are set of rules that you implement in your SQL tables


CREATE DATABASE ColaberryClass
GO

USE ColaberryClass
GO

--> PRIMARY KEY

	--1-> The records will be unique 
	--2-> It will not allow NULL values
	--3-> No duplicate records


	/*

To create a primary key

1- In Object Explorer, right-click the table to which you want to add a unique constraint, 
and click Design.

2- In Table Designer, click the row selector for the database column you want to define as 
the primary key. If you want to select multiple columns, hold down the CTRL key while you click 
the row selectors for the other columns.

3- Right-click the row selector for the column and select Set Primary Key.

*/

CREATE TABLE Toys
			(
			 ToyID INT NOT NULL,--PRIMARY KEY, --> creating the table with the constraint
			 ToyName VARCHAR(50),
			 ToyCost MONEY
			 )

SELECT		*
FROM		Toys

CREATE TABLE  ToySales
			(
			SalesID INT,
			ToyID INT NOT NULL,
			PurchaseDate DATETIME,
			UnitCount INT,
			ReceiptID INT
			)

SELECT		*
FROM		ToySales

ALTER TABLE Toys
ADD CONSTRAINT PK_Toys_ToyID PRIMARY KEY(ToyID) --> create a primary key constraint

ALTER TABLE Toys
DROP CONSTRAINT PK_Toys_ToyID



INSERT INTO	Toys
SELECT		1,'Fire Truck', 25
UNION ALL
SELECT		2,'Towing Truck', 35


SELECT		*
FROM		Toys

INSERT INTO Toys
SELECT		1,'Fire Truck', 25 --> Violation of PRIMARY KEY constraint 'PK_Toys_ToyID'. 
								--Cannot insert duplicate key in object 'dbo.Toys'.
								-- The duplicate key value is (1).

INSERT INTO Toys
SELECT		1,'Garbage Truck', 20 --> Violation of PRIMARY KEY constraint 'PK_Toys_ToyID'. 
								--Cannot insert duplicate key in object 'dbo.Toys'.
								-- The duplicate key value is (1).

INSERT INTO Toys
SELECT		NULL,'Garbage Truck', 30 -->Cannot insert the value NULL into column 'ToyID',
									--table 'ColaberryClass.dbo.Toys'; column does not allow nulls. 
									--INSERT fails.

--UNIQUE KEY 
			--> No duplicate records
			--> Rows are unique 
			--> it will allow ONE NULL value

/* 
To create a unique constraint
1- In Object Explorer, select the table to which you want to add a unique constraint, 
and from the Database menu click Open Table Definition.

The table opens in Table Designer.

2- From the Table Designer menu, RIGHT click AND CLICK ON Indexes/Keys.

3- In the Indexes/Keys dialog box, click Add.

4- In the grid, click Type and choose Unique Key from the drop-down list box to the right of 
the property.

*/

--> create a unique constraint on the ToySales Table 

SELECT		*
FROM		ToySales

ALTER TABLE  ToySales
ADD CONSTRAINT UK_ToySales_SalesID UNIQUE (SalesID)

ALTER TABLE  ToySales
DROP CONSTRAINT UK_ToySales_SalesID 

INSERT INTO ToySales(SalesID,ToyID, PurchaseDate, UnitCount, ReceiptID)
SELECT NULL, 1, '2019/04/16', 5 , 100

INSERT INTO ToySales(SalesID,ToyID, PurchaseDate, UnitCount, ReceiptID)
SELECT NULL, 2, '2018/04/16', 10, 101

--Violation of UNIQUE KEY constraint 'UK_ToySales_ToyID'.
	-- Cannot insert duplicate key in object 'dbo.ToySales'.
 -- The duplicate key value is (<NULL>).

 --NOT NULL Constraint 

 --Right Click on Design then use the checkbox by the column to allow / not allow NULLS

 ALTER TABLE ToySales
 ALTER COLUMN ToyID INT NULL

 ALTER TABLE ToySales
 ALTER COLUMN ToyID INT NOT NULL 

 DROP TABLE ToySales

 --> how to add the UNIQUE and NOT NULL constraints when creating a table

 CREATE TABLE ToySales 
			  (
			  SalesID INT UNIQUE, --> add the unique constraint
			  ToyID INT NOT NULL,
			  PurchaseDate DATETIME,
			  UnitCount INT,
			  ReceiptID INT
			  )

-- class work
/* USE the CREATE TABLE SCRIPT 

Create a table "Student"
		columns
				INT -->StudentID  -- PrimaryKey
				VARCHAR(50) --> StudentName	-- NOT NULL
				INT -->StudentPaymentRefID -- Unique
				DATE -->EnrollDate -- NOT NULL


Add listed Constraints on the columns.
*/

CREATE TABLE Student 
			 (
			 StudentID INT PRIMARY KEY,
			 StudentName VARCHAR(50) NOT NULL,
			 StudentPaymentRefID INT UNIQUE,
			 EnrollDate DATE NOT NULL
			 )

--> FOREIGN KEY

/*
Using SQL Server Management Studio

1- In Object Explorer, right-click the table that will be on the foreign-key side of the
 relationship and click Design.

The table opens in Table Designer.

2- From the Table Designer menu, click Relationships.

3- In the Foreign-key Relationships dialog box, click Add.

The relationship appears in the Selected Relationship list with a system-provided name 
in the format FK_<tablename>_<tablename>, where tablename is the name of the foreign key table.

4- Click the relationship in the Selected Relationship list.

5- Click Tables and Columns Specification in the grid to the right and click the ellipses (...) 
to the right of the property.

6- In the Tables and Columns dialog box, in the Primary Key drop-down list, 
choose the table that will be on the primary-key side of the relationship.

7- In the grid beneath, choose the columns contributing to the table's primary key. 
In the adjacent grid cell to the left of each column, choose the corresponding foreign-key 
column of the foreign-key table.

 Table Designer suggests a name for the relationship. To change this name, edit 
the contents of the Relationship Name text box.

8- Choose OK to create the relationship.
*/

SELECT			*
FROM			Toys

SELECT			*
FROM			ToySales

ALTER TABLE		ToySales
ADD CONSTRAINT  FK_ToySales_ToyID_Toys_ToyID FOREIGN KEY (ToyID)
REFERENCES Toys(ToyID)  --> which table is it referencing?

INSERT INTO		ToySales
SELECT			5 , 1, '2019-04-16', 5 , 100 --> ToyID 1 exists in the Toys table


INSERT INTO		ToySales
SELECT			6 , 10, '2019-04-16', 5 , 100 --> ToyID 10 did not exist in the Toys table

--> Msg 547, Level 16, State 0, Line 163
-->The INSERT statement conflicted with the FOREIGN KEY constraint "FK_ToySales_ToyID_Toys_ToyID". The conflict occurred in database "ColaberryClass", table "dbo.Toys", column 'ToyID'.
-->The statement has been terminated.


INSERT INTO Toys
SELECT	10, 'Garbage Truck', 50 --> now we have Toy ID 10 in the Toys table


INSERT INTO		ToySales
SELECT			6 , 10, '2019-04-16', 5 , 100



CREATE TABLE  Transactions 
						(TransactionID INT,
						 ToyID INT,
						 SalesID INT,
						 TransactionAmount MONEY,
						 TransactionDate DATE
						 )

-->Create a Foreign Key on ToyID references the Toys Table (ToyId)

ALTER TABLE Transactions
ALTER COLUMN ToyID INT NOT NULL

ALTER TABLE Transactions
ADD CONSTRAINT FK_Transactions_ToyID_Toys_ToyID FOREIGN KEY
REFERENCES Toys(ToyID)

ALTER TABLE ToySales
ALTER COLUMN SalesID INT NOT NULL 

ALTER TABLE ToySales
ADD CONSTRAINT PK_ToySales_SalesID PRIMARY KEY (SalesID)

ALTER TABLE Transactions
ADD CONSTRAINT FK_Transactions_SalesID_ToySales_SalesID FOREIGN KEY (SalesID)
REFERENCES ToySales(SalesID)

--CHECK : Validation check before entering data into a column

/*
1- In Object Explorer, expand the table to which you want to add a check constraint, 
right-click Constraints and click New Constraint.

2-In the Check Constraints dialog box, click in the Expression field and 
 then click the ellipses (...).

3-In the Check Constraint Expression dialog box, type the SQL expressions for the check constraint. 


*/

CREATE TABLE	StudentDetails
				(
				StudentID INT,
				StudentName VARCHAR(50),
				StudentPaymentRefID INT,
				EnrollDate DATE,
				StudentAge INT --CHECK (StudentAge >7)
				)
--> create a CHECK constraint on the column StudentAge

ALTER TABLE   StudentDetails
ADD CONSTRAINT CK_StudentAge CHECK (StudentAge > 7 ) 

INSERT INTO StudentDetails
SELECT		1 , 'Chantal',500, '2019-04-16', 7
--The INSERT statement conflicted with the CHECK constraint "CK_StudentAge". 
 --The conflict occurred in database "ColaberryClass", table "dbo.StudentDetails", 
 --column 'StudentAge'.

INSERT INTO StudentDetails
SELECT		1 , 'Chantal',500, '2019-04-16', 30


ALTER TABLE   StudentDetails
DROP CONSTRAINT CK_StudentAge 

ALTER TABLE  StudentDetails
ADD CONSTRAINT CK_StudentAge CHECK (StudentAge >  7 AND StudentAge < 15)

--> Since i have the prior record with StudentAge 30 i am not able to add that CHECK

DELETE FROM StudentDetails

SELECT			*
FROM			StudentDetails

--> DEFAULT Constraint: Default value given if no data is specified for a column

	/*

Object Explorer
1- In Object Explorer, right-click the table with columns for which you want to change the 
scale and click Design.

2-Select the column for which you want to specify a default value.

3-In the Column Properties tab, enter the new default value in the Default Value or Binding property.

To enter a numeric default value, enter the number. For an object or function enter its name. 
For an alphanumeric default enter the value inside single quotes.

4-On the File menu, click Save table name.

	*/

SELECT			*
FROM			ToySales

SELECT			*
FROM			Toys

SELECT			GETDATE() --> Current System date and time

ALTER TABLE		ToySales
ADD CONSTRAINT  DF_PurchaseDate DEFAULT GETDATE() FOR PurchaseDate

INSERT INTO		ToySales(SalesID, ToyID, UnitCount, ReceiptID)
SELECT		    10, 2, 50, 101 

SELECT			*
FROM			ToySales

ALTER TABLE		ToySales
DROP CONSTRAINT DF_PurchaseDate

ALTER TABLE		ToySales
ALTER COLUMN	PurchaseDate DATE --> will remove the time from the GETDATE() 

ALTER TABLE		ToySales
ADD CONSTRAINT  DF_PurchaseDate DEFAULT GETDATE() FOR PurchaseDate

INSERT INTO		ToySales(SalesID, ToyID, UnitCount, ReceiptID)
SELECT		    11, 2, 50, 101 

SELECT			*
FROM			ToySales


--IDENTITY Constraint 
--> Auto Number field to automatically assign values to column
	--> unique 
   --> mostly used on primary key 

--> Identity seed = the starting point 
--> Increment By = interval you want to increment the data by 

/*
ALTER TABLE TableName
ADD ColumnName INT IDENTITY(1, 100) 
*/

CREATE TABLE  StudentRecords
			(StudentID INT PRIMARY KEY IDENTITY (10, 1), --(identity seed, increment)
			 StudentName VARCHAR(50),
			 StudentAge INT
			 )

INSERT INTO StudentRecords (StudentName, StudentAge)
SELECT      'Hanad', 20
UNION 
SELECT		'Tanya', 19

SELECT		*
FROM		StudentRecords

DROP TABLE   StudentRecords


--> Go to Tools Options then Designers --> tables and databases designers
  --> Unchek all the options on that page

-->Go through the object explorer to add the identity constraint

CREATE TABLE  StudentRecords
			(StudentID INT, --PRIMARY KEY IDENTITY (10, 1), --(identity seed, increment)
			 StudentName VARCHAR(50),
			 StudentAge INT
			 )

INSERT INTO StudentRecords (StudentName, StudentAge)
SELECT      'Hanad', 20
UNION 
SELECT		'Tanya', 19

SELECT		*
FROM		StudentRecords



/*
ALTER TABLE TableName
ALTER COLUMN  INT IDENTITY (1, 100) 
*/
