/* 
Name: Ashok Rathod
Lab for Operators Data 
Date: 4.9.19*/
-------------------

/* LAB 1
1. Write two statements for each of the following operators using the emp
and dept tables. Be sure to include AND &amp; OR statements as well.
OPERATORS:
= (equals)
<>; (not equal to)
>; (greater than)
<; (less than)
in
not in
LIKE
between
not LIKE
*/
SELECT		*
FROM		emp;

SELECT		*
FROM		emp
WHERE		empName = 'Andy';

SELECT		*
FROM		emp
WHERE		empName = 'Bob';

SELECT		*
FROM		emp
WHERE		Salary <> 21000;

SELECT		*
FROM		dept
WHERE		deptId <> 2;

SELECT		*
FROM		emp
WHERE		Salary > 8000;

SELECT		*
FROM		dept
WHERE		deptId > 5;

SELECT		*
FROM		dept
WHERE		deptId < 4;

SELECT		*
FROM		emp
WHERE		Salary < 10000;

SELECT		*
FROM		emp
WHERE		Salary IN (5000, 15000);

SELECT		*
FROM		dept
WHERE		deptId IN	(2,4);

SELECT		*
FROM		emp
WHERE		Salary NOT IN	(5000,10000);

SELECT		*
FROM		dept
WHERE		deptId	NOT IN	(5,8);

SELECT		*
FROM		emp
WHERE		empName LIKE '%y';

SELECT		* 
FROM		emp
WHERE		empName LIKE '%m%';

SELECT		*
FROM		emp
WHERE		Salary BETWEEN 4000 AND 15000;

SELECT		*
FROM		emp
WHERE		mgrId BETWEEN 1 AND 3;

SELECT		*
FROM		emp
WHERE		empName NOT LIKE '%a%'

SELECT		* 
FROM		emp
WHERE		Salary	NOT LIKE '%8%';

------------------------------------------------
SELECT		empName
FROM		emp
WHERE		empName = 'Andy'
or			empName = 'Mark';
 --IN ('Andy', 'Mark');

 ----------- From LAB2 document
 use	ashok_lab1

 INSERT INTO	dbo.players
 VALUES			(1, 'Running Back',22,'1/1/2012')

 INSERT INTO	[dbo].[coaches]
 VALUES			(1, 'John Starks', 'Running Back Coach','1/1/2012')

 SELECT		*
 FROM		dbo.players

 SELECT		*
 FROM		dbo.coaches

 use ashok_lab1
 
 INSERT INTO		[dbo].[players]
 SELECT				2,'Running',23,'10/1/2015'
 UNION
 SELECT				3,'Walking back',11,'1/1/2015'
 UNION
 SELECT				4,'Willing',10,'1/2/2016'
 UNION
 SELECT				5,'Dancing',14,'10/10/2017'
 UNION
 SELECT				6,'Playing',15,'12/12/2018'
 UNION
 SELECT				7,'Checking',18,'7/5/2012'
 UNION
 SELECT				8,'Walking',19,'11/11/2014'
 UNION
 SELECT				9,'Run',20,'1/1/2019'
 UNION
 SELECT				10,'Goal',21,'5/1/2010'
 UNION
 SELECT				11,'Keeper',5,'1/1/2012'
 
 
INSERT INTO	[dbo].[coaches]
SELECT			2, 'John Ss', 'Running Coach','1/1/2012'
UNION
SELECT			3, 'Matt Steff', 'Walking Coach','10/10/2015'
UNION
SELECT			4, 'Ronnt M', 'Willing Coach','1/1/2016'
UNION
SELECT			5, 'Ronald J', 'Dancing Coach','1/1/2013'
UNION
SELECT			6, 'John M', 'Playing Coach','1/1/2011'
UNION
SELECT			7, 'Fan F', 'Checking Coach','1/1/2017'
UNION
SELECT			8, 'Andy A', 'Walking Coach','1/1/2018'
UNION
SELECT			9, 'Monn N', 'Running Coach','1/1/2015'
UNION
SELECT			10, 'Tonny F', 'Goal Coach','1/1/2013'
UNION
SELECT			11, 'Greg G', 'Keeper Coach','2/10/2019'


-- Retrieve All Players with Jersey numbers in the 20’s
use ashok_lab1;

SELECT		* 
FROM		players
WHERE		JerseyNumber like '2%';

--III. Retrieve All Coaches with CoachID less than 5

SELECT		*
FROM		coaches
WHERE		CoachID < 5;

--IV. Retrieve All players who joined the team this year.

SELECT		*
FROM		dbo.players
WHERE		StartDate like '%2019%';

--V. Retrieve All coaches who joined the team last year.

SELECT		*
FROM		dbo.coaches
WHERE		StartDate like '%2018%';

--VI. Retrieve All players with PlayerID greater than 5

SELECT		*
FROM		dbo.players
WHERE		PlayerID > 5;

--VII. Retrieve All running backs

SELECT		*
FROM		dbo.players
WHERE		Position = 'running back';

--VIII. Retrieve All Quarter Back Coaches

SELECT		*
FROM		dbo.coaches
WHERE		CoachType like '%Quarter Back%';

--Create a player backup table (player_backup) using the SELECT INTO statement

SELECT		*
INTO		PlayersBackUp
FROM		dbo.players;

SELECT		*
FROM		dbo.PlayersBackUp
--Create a coach backup table (coach_backup) using the SELECT INTO statement

SELECT		*
INTO		CoachesBackUp
FROM		dbo.coaches;

SELECT		*
FROM		CoachesBackUp;
