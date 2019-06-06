CREATE TABLE VISIBILITY_EXAMPLE_TABLE (
  Product_ID            INT IDENTITY( 1  , 1  ) PRIMARY KEY NOT NULL,
  ProductCode       VARCHAR(20),
  ProductName       VARCHAR(100),
  ProductColor      VARCHAR(20),
  QuantityAvailable INT,
  SupplierName      VARCHAR(50),
  SupplierRegion    VARCHAR(30),
  Price				int
  
)

GO


INSERT INTO DBO.VISIBILITY_EXAMPLE_TABLE
           ([ProductCode],
            [ProductName],
            [ProductColor],
            [QuantityAvailable],
            [SupplierName],
            [SupplierRegion],[price])
VALUES    ('A001',
            'Apple',
            'Red',
            '500',
            'Great Apple Supply',
            'NorthEast',5),

			('A002',
            'Apple',
            'Green',
            '1000',
            'Abundant Grannies',
            'NorthEast',2),

			('OR001',
            'Orange',
            'Orange',
            '40000',
            'Only Oranges',
            'SouthEast',8),

			('P001',
            'Pear',
            'Brown',
            '4550',
            'Shapely Pear Co',
            'NorthEast',7),

			('A001',
            'Apple',
            'Red',
            '500000',
            'Western Apple Co',
            'NorthWest',6),

			('G001',
            'Grape',
            'Red',
            '20000',
            'Western Fruit Inc',
            'NorthWest',8),


			('A001',
            'Apple',
            'Red',
            '400',
            'Western Fruit Inc',
            'NorthWest',4),

			('B001',
            'Banana',
            'Yellow',
            '45500',
            'Western Fruit Inc',
            'NorthWest',7),

			('OR001',
            'Orange',
            'Orange',
            '55555',
            'Western Fruit Inc',
            'NorthWest',9),

			('A001',
            'Apple',
            'Green',
            '7410',
            'Western Fruit Inc',
            'NorthWest',10),

			('A002',
            'Apple',
            'Green',
            '52258',
            'Great Apple Supply',
            'NorthEast',12)
	
GO

Select	*
From	[dbo].[VISIBILITY_EXAMPLE_TABLE]
