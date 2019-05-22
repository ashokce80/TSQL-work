use ashok_lab1

SELECT		*
FROM		dbo.dept

SELECT		*
FROM		dbo.emp;

SELECT		*
INTO		dbo.emp3
FROM		dbo.emp;

SELECT		*
From		dbo.emp3;

CREATE TABLE	dbo.dept3 (dept3Id int, dept3Name varchar(50));

INSERT INTO		dbo.dept3 (dept3Id, dept3Name)
SELECT			*
FROM			dbo.dept;

SELECT			*
FROM			dbo.dept;

SELECT			*
FROM			dbo.dept3;


INSERT INTO		dbo.dept3 -- only one data is inserted as its duplicate
SELECT			12, 'IT'
UNION			
SELECT			12, 'IT';

INSERT INTO		dbo.dept3
SELECT			13, 'Comp'
UNION All					-- dont filter data so duplicate data is inserted fast to do
SELECT			13, 'Comp';

DELETE FROM		dbo.dept3
WHERE			dept3Id = 13

INSERT INTO		dbo.dept3
SELECT			13, 'COMP'
UNION			
SELECT			14, 'MGR'
UNION	
SELECT			15,	 'FINANCE'
UNION
SELECT			16,  'TAX'

INSERT INTO		dbo.dept3
values			(15,'abc'),
				(16,'xyz'),
				(17,'abx');

SELECT			*
FROM			dbo.dept3
WHERE			dept3Id >=7
AND				dept3ID <=12;

SELECT			*
FROM			dbo.dept3
WHERE			dept3Id IN (10,11,12)

/* % wild card for multiple combination of word 
as %at can be bat, cat, dat, goat, loat, etc but it must be used with LIKE word

_ which is for one char different value... */

select		* 
from		emp;

SELECT		*
FROM		emp
WHERE		empName LIKE '%y';

SELECT * 
FROM	emp
WHERE	empName in ('Mark', 'Bob')
WHERE	empName LIKE '_ndy';

use ashok_lab1

CREATE TABLE student(
					studentId int NULL,
					studentName varchar(50) NULL,
					studentClass varchar(50) NULL,
					studentAge int NULL,
					studentRank int NULL,
					testScore int NULL
					);
SELECT	*
FROM	student;

INSERT INTO	student
VALUES	(1,'Jack','Freshman',18,1,100),
		(2,'Mike','Sophomore',19,3,85);

INSERT	INTO student
SELECT 3,'Ralph','Junior',20,2,95
Union
SELECT 4,'Kishan','Freshman',19,1,93
Union
SELECT 5,'Ali','Sophomore',19,2,91
Union
SELECT 6,'Terrel','Junior',20,3,87
Union
SELECT 7,'Anand','Freshman',20,3,86
Union
SELECT 8,'Sai','Sophomore',21,1,99
Union
SELECT 9,'Larry','Junior',22,1,98
Union
SELECT 10,'Deion','Freshman',18,4,82
Union
SELECT 11,'Sammy','Senior',21,4,81
Union
SELECT 12,'Ralph','Senior',22,3,87
Union
SELECT 13,'Simon','Senior',21,2,90
Union
SELECT 14,'Lebron','Senior',20,1,97

SELECT		*
FROM		student
ORDER BY	studentClass ASC;

SELECT		studentClass,
			AVG(testScore) AS AVGTestScore
FROM		student
GROUP BY	studentClass;

SELECT		studentClass,
			COUNT(studentClass)
FROM		student
GROUP BY	studentClass;

SELECT		studentClass,
			MIN(studentAge) AS MinAge,
			MAX(studentAge) AS MaxAge
FROM		student
GROUP BY	studentClass;

SELECT		studentId,
			studentName,
			studentClass
FROM		student
ORDER BY	3;

use ashok_lab1
CREATE TABLE Student1(
			 StudentID INT NOT NULL PRIMARY KEY,
			 StudentName varchar(50) NOT NULL,
			 StudentPaymentRefID INT Unique,
			 EnrollDate DATE)


