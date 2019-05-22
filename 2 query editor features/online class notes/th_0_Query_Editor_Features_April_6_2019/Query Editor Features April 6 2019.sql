/*

March 30 Online Class
Section  Query Editor Features
Date April 6 2019

*/


--Homework Etiquette Heading 

/*

Name:	Chantal Togbey
Lesson:  Query Editor Features
Date:	04/06/2019

*/


-- For multiple lines of comments/notes use

		/*
		--
		--
		*/

--For Single Line of comments use -- 

--> how to change databases 
	--> GUI (Graphical User Interface)
		--> click on Available Databases drop down menu and choose the database
			--AdventureWorks2016

	-->Script 

USE AdventureWorks2016

--> CREATE A DATABASE 

	--via the GUI 
		-- step 1 RightClick on Databases in Object Explorer
			--> step 2 Click on New Database
				--> step 3 Enter the Name of the new Database and Click on OK
				
	--> via a script

CREATE DATABASE MarchOnline

--> DELETE DATABASE

 --> via the GUI
		--> step 1 Right Click on the database i want to delete 
			--> step 2 Click on Delete

 --> via the script

DROP DATABASE MarchOnline

--> Create a table 

		--> A table is an object in a database where you store your data in columns and rows

--> Create a table via the GUI

--> Create a table via the SCRIPT

USE					MarchOnline2019

CREATE TABLE		Emp
					(
					EmployeeID INT NOT NULL ,
					EmployeeName VARCHAR(50) ,
					DepartmentID INT
					)

--> Delete a table 

		--> via the GUI
--Right Click on the table you would like to delete then click on DELETE

		--> via the SCRIPT

DROP TABLE dbo.Emp

--> HOW TO VIEW RECORDS IN THE EMPLOYEE TABLE

SELECT		*  -- The star means "ALL" ( all the columns from the table)
FROM		EMPLOYEE --or dbo.employee




--> Insert Data into the Employee table 

--> via the GUI

	--> Right Click on the employee table
		--> Click on Edit Top 200 Rows

--> via the SCRIPT

INSERT INTO		dbo.employee ([EmployeeID],EmployeeName, DepartmentID)
SELECT			3,'Chantal', 3 	

INSERT INTO		Employee (EmployeeID, EmployeeName, DepartmentID)
VALUES			(15, 'Tayo', 1)

--> How to insert multiple rows via the SCRIPT 

INSERT INTO		Employee (EmployeeName, EmployeeID, DepartmentID)
VALUES			('Jesse', 4 , 20),
				('Vanessa',10 ,2),
				('Lawrence', 11, 1)

SELECT			*
FROM			Employee


--> Retrieve all columns in the Employee table

SELECT			*
FROM			Employee	


--> Retrieve all columns where the employee name is Mika

SELECT			*
FROM			Employee
WHERE			EmployeeName = 'Mika' --'Mika'

--> Retrieve the department ID and the employee name columns of the employee Chantal

SELECT			DepartmentID,
				EmployeeName
FROM			Employee
WHERE			EmployeeName = 'Chantal'


