/*
Ashok Rathod
Limiting and Sorting 
4.20.19
*/
--------------------------
---- LAB WORK 1-----------
--------------------------
use ashok_lab1
CREATE TABLE	Menu(
				itemId int not null Primary Key,
				itemName varchar(50),
				itemType varchar(50) not null,
				costToMake money check(costToMake > 0),
				price money,
				weeklySales int,
				monthlySales int,
				yearlySales int)

INSERT INTO dbo.Menu
SELECT 'Big Mac','Hamburger',1.25,3.24,1015,5000,15853
union
SELECT 'Quarter Pounder / Cheese','Hamburger',1.15,3.24,1000,4589,16095
union
SELECT 'Half Pounder / Cheese','Hamburger',1.35,3.50,500,3500,12589
union
SELECT 'Whopper','Hamburger',1.55,3.99,989,4253,13000
union
SELECT 'Kobe Cheeseburger','Hamburger',2.25,5.25,350,1500,5000
union
SELECT 'Grilled Stuffed Burrito','Burrito',.75,5.00,2000,7528,17896
union
SELECT 'Bean Burrito','Burrito',.50,1.00,1750,7000,18853
union
SELECT '7 layer Burrito','Burrito',.78,2.50,350,1000,2563
union
SELECT 'Dorrito Burrito','Burrito',.85,1.50,600,2052,9857
union
SELECT 'Turkey and Cheese Sub','Sub Sandwich',1.75,5.50,1115,7878,16853
union
SELECT 'Philly Cheese Steak Sub','Sub Sandwich',2.50,6.00,726,2785,8000
union
SELECT 'Tuna Sub','Sub Sandwich',1.25,4.50,825,3214,13523
union
SELECT 'Meatball Sub','Sub Sandwich',1.95,6.50,987,4023,15287
union
SELECT 'Italian Sub','Sub Sandwich',2.25,7.00,625,1253,11111
union
SELECT '3 Cheese Sub','Sub Sandwich',.25,6.00,815,3000,11853

SELECT		*
FROM		Menu

SELECT		*
INTO		MenuBackup
FROM		Menu

--4. The 3 Cheese Sub is now made with 4 Cheeses. The new name will be 4 Cheese Sub

UPDATE Menu
SET itemName = '4 Cheeses Sub'
Where itemName = '3 Cheese Sub';

--5. Italian Sub Monthly Sales were reported incorrectly. There were really 1353 Sales.
UPDATE	Menu
SET		monthlySales = 1353
Where	itemName = 'italian Sub'

--6. The Whopper increased it’s price to $4.25
UPDATE	Menu
SET		price = 4.25
Where	itemName = 'Whopper'



7. It now cost $2.75 to make the 7 layer Burrito

UPDATE	Menu
SET		costToMake = 2.75
Where	itemName = '7 layer Burrito'

SELECT		*
FROM		Menu

--8. The prices of tortillas have gone up. All Burrito prices should increase 10%
UPDATE	Menu
SET		price = (price + (price * 0.10))
Where	itemType = 'Burrito'

--9. All products that bring in < $1.00 profit per purchase need to be deleted

DELETE	Menu
WHERE	(price - costToMake) < 1

--10. We will be discontinuing any products that didn’t clear $10,000 in YearlySales Profit. (delete)

DELETE	Menu
WHERE	((price - costToMake)*yearlySales) <= 10000

SELECT *
FROM	Menu

--11. We just found out all the previous changes were incorrect. Truncate the dbo.menu_backup table.

TRUNCATE TABLE [dbo].[MenuBackup]

--------------------------
---- LAB WORK 2-----------
--------------------------

INSERT INTO dbo.Menu
SELECT 'Big Mac','Hamburger',1.25,3.24,1015,5000,15853
union
SELECT 'Quarter Pounder / Cheese','Hamburger',1.15,3.24,1000,4589,16095
union
SELECT 'Half Pounder / Cheese','Hamburger',1.35,3.50,500,3500,12589
union
SELECT 'Whopper','Hamburger',1.55,3.99,989,4253,13000
union
SELECT 'Kobe Cheeseburger','Hamburger',2.25,5.25,350,1500,5000
union
SELECT 'Grilled Stuffed Burrito','Burrito',.75,5.00,2000,7528,17896
union
SELECT 'Bean Burrito','Burrito',.50,1.00,1750,7000,18853
union
SELECT '7 layer Burrito','Burrito',.78,2.50,350,1000,2563
union
SELECT 'Dorrito Burrito','Burrito',.85,1.50,600,2052,9857
union
SELECT 'Turkey and Cheese Sub','Sub Sandwich',1.75,5.50,1115,7878,16853
union
SELECT 'Philly Cheese Steak Sub','Sub Sandwich',2.50,6.00,726,2785,8000
union
SELECT 'Tuna Sub','Sub Sandwich',1.25,4.50,825,3214,13523
union
SELECT 'Meatball Sub','Sub Sandwich',1.95,6.50,987,4023,15287
union
SELECT 'Italian Sub','Sub Sandwich',2.25,7.00,625,1253,11111
union
SELECT '3 Cheese Sub','Sub Sandwich',.25,6.00,815,3000,11853

--3. Retrieve all Burritos and sort by Price

SELECT		*
FROM		Menu
WHERE		itemType = 'Burrito'
ORDER BY	price

--4. Retrieve all items that Cost more than $1.00 to make and sort by WeeklySales

SELECT		*
FROM		Menu
WHERE		costToMake > 1
ORDER BY	weeklySales

--5. What’s the sum of total profit by ItemType

SELECT		itemType, SUM(price - costToMake) AS totalProfit
FROM		Menu
GROUP BY	itemType

--6. Retrieve Total Weekly Sales by ItemType of only items with more than 3000 weekly Sales. Sort by Total Weekly Sales descending.

SELECT		itemType, SUM(weeklySales) AS weeklySales
FROM		Menu
GROUP BY	itemType
HAVING		SUM(weeklySales) > 3000
ORDER BY	SUM(weeklySales) DESC

--7. Find out the profit made Weekly, Monthly and Yearly on Big Mac’s

SELECT		((price - costToMake) * weeklySales) AS weeklyProfit,
			((price - costToMake)*monthlySales) AS monthlyProfit,
			((price-costToMake)*yearlySales) AS yearlyProfit
FROM		Menu
WHERE		itemName ='BIG Mac'

--8. Retrieve the ItemType has more than $20,000 in Monthly Sales

SELECT		itemType, SUM(monthlySales) AS itemTypeMonthlySales
FROM		Menu
GROUP BY	itemType
HAVING		SUM(monthlySales) > 20000

--9. Retrieve the ItemType that had the best Profit from MonthlySales

SELECT	TOP 1	itemType, SUM((price - costToMake)* monthlySales) AS MonthlyProfit
FROM			Menu
GROUP BY		itemType
ORDER BY		MonthlyProfit DESC

