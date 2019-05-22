
SELECT		*
FROM		dbo.Toys

INSERT INTO		Toys(toyName,toyCost)
Select			'Car',10
UNION			
SELECT			'Truck',12


