/*
Joins
5.7.19
*/
use AdventureWorks2014
GO
-- inner join
Select		A.AddressID,A.StateProvinceID,A.City,
			ST.Name,ST.CountryRegionCode
From		[Person].[Address] as A
Inner join	[Person].[StateProvince] as ST
ON			A.StateProvinceID = ST.StateProvinceID

--Left outer Join
Select			A.AddressID,A.StateProvinceID,A.City,
				ST.Name,ST.CountryRegionCode
From			[Person].[Address] as A
Left Outer join	[Person].[StateProvince] as ST
ON				A.StateProvinceID = ST.StateProvinceID

--Right outer join
Select			A.AddressID,A.StateProvinceID,A.City,
				ST.Name,ST.CountryRegionCode
From			[Person].[Address] as A
Right Outer join	[Person].[StateProvince] as ST
ON				A.StateProvinceID = ST.StateProvinceID

-------------------------------------------------------------------------
--<cfquery name="qUpdateTest" datasource="#REQUEST.DSN.Source#">
  --  <!--- Declare in-memory data tables. --->
    Create TABLE boy
        (
            id INT,
            name VARCHAR( 30 ),
            is_stud TINYINT
        )
    ;
    Create TABLE girl 
        
        (
            id INT,
            name VARCHAR( 30 )
        )
    ;
    Create TABLE relationship 
        
        (
            boy_id INT,
            girl_id INT,
            date_started DATETIME,
            date_ended DATETIME
        )
    ;

	Select		*
	From		boy
	
	Select		*
	From		girl
	
	Select		*
	From		relationship
  /*  <!---
        Populate the boy table with some information.
        Notice that as I populate the IS_STUD column, all
        the values are going to be ZERO (meaning that these
        dudes are not very studly). This will be updated
        based on the relationship JOIN.
    --->*/
    INSERT INTO boy
    (
        id,
        name,
        is_stud
    )(
        SELECT 1, 'Ben', 0 UNION ALL
        SELECT 2, 'Arnold', 0 UNION ALL
        SELECT 3, 'Vincent', 0
    );
   -- <!--- Populate the girl table with some information. --->
    INSERT INTO girl
    (
        id,
        name
    )(
        SELECT 1, 'Maria Bello' UNION ALL
        SELECT 2, 'Christina Cox' UNION ALL
        SELECT 3, 'Winona Ryder'
    );
   -- <!--- Populate the relationship table. --->
    INSERT INTO relationship
    (
        boy_id,
        girl_id,
        date_started,
        date_ended
    )(
        SELECT 1, 1, '2007/01/01', NULL UNION ALL
        SELECT 1, 3, '2004/09/15', '2005/06/15' UNION ALL
        SELECT 2, 1, '2006/05/14', '2006/05/23'
    );
   /* <!---
        Update the in-memory table. Here, we are going to join
        the boy, girl, and relationship table to see if any of
        the boys have been studly enough to date Winona Ryder.
        If so, that BOY record will be updated date with the
        is_studly flag.
    --->*/
    UPDATE
        b
    SET
        b.is_stud = 1
    FROM
        boy b
    INNER JOIN
        relationship r
    ON
        b.id = r.boy_id
    INNER JOIN
        girl g
    ON
        (
                r.girl_id = g.id
            AND
                g.name = 'Winona Ryder'
        )
    ;
   /* <!---
        To see if the update has taken place, let's grab
        the records from the boy table.
    --->*/
    SELECT
        id,
        name,
        is_stud
    FROM
        boy
    ;
	/*
</cfquery>


<!--- Dump out the updated record set. --->
<cfdump
    var="#qUpdateTest#"
    label="Updated BOY Table"
    /> */

	Select	*
        
    --SET        --b.is_stud = 1
    FROM
        boy b
    INNER JOIN
        relationship r
    ON
        b.id = r.boy_id
    INNER JOIN
        girl g
    ON
        --(
                r.girl_id = g.id
            AND
                g.name = 'Winona Ryder'
        )
    ;
