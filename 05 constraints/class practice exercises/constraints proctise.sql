-- exercises for contraints 

CREATE table	dbo.Toys(
				toyId int,
				toyName varchar(50),
				toyCost money)

SELECT		*
FROM		Toys

CREATE TABLE	dbo.toySales(
				salesId int,
				toyId int,
				purchaseDate datetime,
				unitCount int,
				receiptId int)

SELECT			*
FROM			dbo.toySales
-- primary key GUI way

-- Unique key query way

ALTER TABLE		toySales
ADD CONSTRAINT	uk_toySales_receiptId 
unique(receiptId)

-- Foreign key
--GUI way
--not null
--default
--check (put the expressing for it )
--identity for auto generated numbers (1seed,increment by)

INSERT INTO dbo.Toys (ToyName,ToyCost)
SELECT 'Toy Truck','5.00' UNION
SELECT 'Basketball','15.00' UNION
SELECT 'Football','20.00' UNION
SELECT 'Frisbee','4.00' UNION
SELECT 'Bike','65.00' UNION
SELECT 'Teddy Bear','25.00' UNION
SELECT 'Water Gun','35.00' UNION
SELECT 'Baseball Bat','15.00' UNION
SELECT 'Baseball','3.00' UNION
SELECT 'Skateboard','40.00'

SELECT		*
FROM		Toys

INSERT INTO dbo.ToySales (ToyID, UnitCount, ReceiptID)
SELECT 1000,1,10001 UNION
SELECT 1000,2,10002 UNION
SELECT 1001,3,10003 UNION
SELECT 1001,4,10004 UNION
SELECT 1002,5,10005 UNION
SELECT 1003,1,10006 UNION
SELECT 1004,2,10007 UNION
SELECT 1005,3,10008 UNION
SELECT 1005,4,10009 UNION
SELECT 1006,5,10010 UNION
SELECT 1008,6,10011

SELECT		*
FROM		toySales

