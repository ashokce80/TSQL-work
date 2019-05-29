/*
Ashok R
SQL review Lab work
5.28.19
*/

--1. What does the acronym T-SQL stand for?
		---Transact Structure Query Language


--2. What keyword in a SQL query do you use to extract data from a database table?   ---SELECT

--3. What keyword in a SQL query do you use to modify data from a database table? ---Update


--4. What keyword in a SQL query do you use to add data from a database table?
		--Insert

--5. What is the difference between the following joins?
--a. Left Join 
	-- The LEFT JOIN returns all records from the left table, and the matched records from the right table. If there is no match from the right side table then it will put NULL for those records.
--b. Inner Join
	--The Inner join return all matched values/records from left and right tables
--c. Right Join
	---- The Right JOIN returns all records from the right table, and the matched records from the left table. If there is no match from the left side table then it will put NULL for those records.

--6. What is the difference between a table and a view?
	--Table is a set of data elements (values) using a model of vertical columns (identifiable by name) and horizontal rows, the cell being the unit where a row and column intersect. 
	--Table is stored in Database.
	-- View is virtual table which represent one or more base table's data as per it's creation sql code. It is based on the result-set of an SQL statement. It's SQL query is store as object for fatching data from base tables.


--7. What is the difference between a temporary and variable table?
	--Temporary Table
		--Created with # tag with tableName
		--it is stored in tempdb database
		--it is only visible in current session so can not be used out side of sessions's query
		--The most often used senarios for temp tables is within a loop of some sorting.

	--Variable Table / Table Variable
		--It is created with Declare statement.
		--It resides in tempdb and it is only accessible within the current Batch, it can not be used/accessed outside of the Batch.
		--table variables are useful with small amounts of data 
		--Rollback is not possible in table variables
		--Syntax as declare @t table (value int) 