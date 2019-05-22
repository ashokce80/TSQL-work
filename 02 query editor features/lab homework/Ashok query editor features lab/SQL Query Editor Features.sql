/*
Name; Ashok Rathod
Lesson: Query Editor Features
Date: 4.6.19
*/
/* SQL file for part of LAB work

4. CREATING SELECT STATEMENTS - If the statements below don’t match your data, alter your data to
be able to answer the questions.*/4

-- a. Retrieve all records from Employee table

SELECT	* 
FROM	[dbo].[emp];


--b. Retrieve all records from Emp table
SELECT	*
FROM	[dbo].[emp];

--c. Retrieve all records from dept table
SELECT	* 
FROM	[dbo].[dept];

--d. Retrieve all columns from the emp table where first name = Ali
SELECT	* 
FROM	emp WHERE empName = 'Andy';

--e. Retrieve empname and Salary from the Employee table where Salary is greater than $30,000
SELECT	empName,Salary
FROM	emp WHERE Salary >30000;

--f. Find the deptname of deptid 1
SELECT deptName 
FROM dept where deptId = 1;

--g. Select all empid’s from Employee table where mgrid = 5
SELECT	*
FROM	emp WHERE mgrId = 5;

--h. Select all empid’s from Phone table where employee does not have a phone number.
SELECT	*
FROM	Phone 
WHERE  phNumber = ' ' ;

/* 5. CREATE TABLES USING SCRIPT Create emp2 (empid int,empname varchar(50),deptid int) &amp; dept2
(deptid int,deptname(50)) TABLES using CREATE TABLE.*/

CREATE TABLE emp2
	(
		empid int NOT NULL, 
		empName varchar(50), 
		deptId int
	);

CREATE TABLE dept2
	(
		deptId int NOT NULL,
		deptName varchar(50)
	); 
