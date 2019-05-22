/*
Ashok
Variables
4.27.19
*/
USE ashok_lab1
GO
drop table Flight
CREATE TABLE Flights(
					FlightID int primary key,
					FlightDateTime datetime,
					FlightDepartureCity varchar(50),
					FlightDestinationCity varchar(50),
					Ontime int)


INSERT INTO		dbo.Flights (
							FlightDateTime, 
							FlightDepartureCity,
							FlightDestinationCity,
							Ontime)
SELECT '1/1/2012','Dallas-Texas','L.A.',1 
UNION
SELECT '1/2/2012','Austin-Texas','New York',1 
UNION
SELECT '1/3/2012','Houston-Texas','New Jersy',0 
UNION
SELECT '1/4/2012','San Antonio-Texas','Mesquite',1 
UNION
SELECT '1/5/2012','Lewisville-Texas','Albany',0 
UNION
SELECT '1/6/2012','Orlando-Florida','Atlanta',1 
UNION
SELECT '1/7/2012','Chicago-Illinois','Oklahoma City',1 
UNION
SELECT '1/8/2012','New Orleans-Louisiana','Memphis',0 
UNION
SELECT '1/9/2012','Miami-Florida','Charlotte',1 
UNION
SELECT '1/10/2012','Sacramento-California','San Francisco',1

Select		*
From		Flights

--3. Create and set a Variable equal to the number of Flights that were late.

Declare		@NumFlightLate int;
Select		@NumFlightLate = (Select		count(FlightID)
							From		Flights
							Where		Ontime = 0)
Select		@NumFlightLate AS [Number of Flights Late]


--4. Multiply that amount by the amount lost per late flight ($1,029) and store the amount in another variable.

Declare		@CostOfLateFlights int = @NumFlightLate * 1029
Select		@CostOfLateFlights 
--5. Take the total amount lost (#4) and subtract it from Total profit ($45,000) and store that number in a variable.

Declare		@ProfitAfterFlightLate int = 45000 - @CostOfLateFlights
Select		@ProfitAfterFlightLate 

--6. Find out the Earliest FlightDate and add 10 years to it and store it in a variable.

Declare			@EarlyFlight10 datetime = DATEADD(YY,10,
											(Select	Top 1	FlightDateTime
											From			Flights))
SELECT			@EarlyFlight10

--7. Find out the day of the week for the Latest FlightDate and store it in a variable.

Declare		@DayOfLatestFlight int =	(SELECT DATEPART(WEEKDAY,
										(Select	TOP 1	FlightDateTime
										From			Flights
										ORDER BY		FlightDateTime DESC
										)))
Select		@DayOfLatestFlight as DayOfLatestFlight

--8. Create a table variable with Departure City and State in 2 different columns along with Flight Destination City and Ontime.

Declare			@TableVarFlights Table(
										DepartureCity varchar(50),
										State varchar(50),
										FlightDestinationCity varchar(50),
										Ontime int) 
Select			*
From			@TableVarFlights


--9. Create a Table Variable storing all info from the dbo.Flights table of flights that were on time.

Declare		@OntimeVar Table(
							FlightID int primary key,
							FlightDateTime datetime,
							FlightDepartureCity varchar(50),
							FlightDestinationCity varchar(50),
							Ontime int)
Insert into @OntimeVar
Select		*
From		Flights
Where		Ontime = 1		
Select		*
From		@OntimeVar

--10. Create a Table Variable storing all info from the dbo.Flights table of non Texas Flights.
Declare		@NonTXFlights Table(
								FlightID int primary key,
								FlightDateTime datetime,
								FlightDepartureCity varchar(50),
								FlightDestinationCity varchar(50),
								Ontime int)
Insert Into		@NonTXFlights
Select			*
From			Flights
Where			Substring(
							FlightDepartureCity, 
							CharIndex('-',FlightDepartureCity)+1,
							Len(FlightDepartureCity)) not like 'T%'
Select			*
From			@NonTXFlights


--------------------------------------------------------------------------------
CREATE TABLE	[dbo].[HospitalStaff](
										[EmpID] [int] IDENTITY(1000,1) NOT NULL,
										[NameJob] [varchar](50) NULL,
										[HireDate] [datetime] NULL,
										[Location] [varchar](150) NULL,
										CONSTRAINT [PK_HospitalStaff] PRIMARY KEY CLUSTERED
										(
										[EmpID] ASC
										)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,								IGNORE_DUP_KEY = OFF,
										ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
										) ON [PRIMARY]

INSERT INTO		[dbo].[HospitalStaff] ([NameJob],[HireDate],[Location])
SELECT 'Dr. Johnson_Doctor' ,'1/1/2012', 'Dallas-Texas'
UNION
SELECT 'Nurse Jackie_Nurse' ,'10/15/2011', 'Mesquite-Texas'
UNION
SELECT 'Anne_Nurse Assistant' ,'11/1/2010', 'Denton-Texas'
UNION
SELECT 'Dr. Jackson_Doctor' ,'4/2/2008', 'Irving-Texas'
UNION
SELECT 'Jamie_Nurse' ,'2/15/2005', 'San Francisco-California' 
UNION
SELECT 'Aesha_Nurse Assistant' ,'6/30/2003', 'Oakland-California' 
UNION
SELECT 'Dr. Ali_Doctor' ,'7/4/1999', 'L.A.-California'
UNION
SELECT 'Evelyn_Nurse' ,'1/7/2007', 'Fresno-California' 
UNION
SELECT 'James Worthy_Nurse Assistant' ,'1/1/2012','Orlando-Florida' 
UNION
SELECT 'Anand_Doctor' ,'3/1/2012', 'Miami-Florida'

SELECT *
FROM dbo.HospitalStaff

--11. Create a Variable to store how many employees have been employed with the company for more than 3 years.

Declare		@NumSeniorEmp int = (Select		count(*)
								From		HospitalStaff
								Where		DateAdd(yy,3,HireDate) < GETDATE())
Select		@NumSeniorEmp


--12. Create and populate a Variable to store the number of all employees from Texas

Declare		@NumEmpFromTX int = (Select		Count(*)
								From		HospitalStaff
								Where		SUBSTRING(Location,CHARINDEX('-',Location)+1,Len(Location))			  like 'T%')
Select		@NumEmpFromTX AS NumEmpFromTX

--13. Create and populate a Variable to store the number of Doctor’s from Texas

Declare		@NumDRFromTX int = (Select		Count(*)
								From		HospitalStaff
								Where		SUBSTRING(Location,CHARINDEX('-',Location)+1,Len(Location))			  like 'TE%' 
								AND			SUBSTRING(Namejob,CHARINDEX('_',NameJob)+1,Len(NameJob))			  like 'DOC%')
Select		@NumDRFromTX AS NumDRFromTX

/*14.Create a table variable using data in the dbo.HospitalStaff table with the following 4 columns
a. Name – Located in the NameJob Column : Everything before the _
b. Job – Located in the NameJob Column : Everything after the _
c. HireDate
d. City – Located in the Location Column : Everything before the –
e. State – Located in the Location Column : Everyting after the –
*/

Declare		@TVHospStaff Table( [Name] varchar(55),
								Job varchar(50),
								HireDate datetime,
								City Varchar(50),
								[State] Varchar(50))
Insert Into		@TVHospStaff
Select			Left(NameJob, CHARINDEX('_',NameJob)-1),
				Right(NameJob,Len(NameJob) - CHARINDEX('_',NameJOb)),
				HireDate,
				Left(Location,CHARINDEX('-',Location)-1),
				Right(Location,LEN(Location) - CharIndex('-',Location))
From			HospitalStaff

Select			*
From			@TVHospStaff

/*15. Create a Table Variable using data in the dbo.HospitalStaff table with the following 4 columns
a. NameJob
b. DateYear – The Year of the HireDate
c. DateMonth – The Month of the HireDate
d. DateDay – The Day of the HireDate */

Declare		@TVDate	Table(
						NameJob varchar(255),
						DateYear int,
						DateMonth int,
						DateDay int)

Insert Into		@TVDate
Select			NameJob,
				DATEPART(yyyy,HireDate),
				DATEPART(MM,HireDate),
				DATEPART(DAY,HireDate)
From			HospitalStaff

Select			*
From			@TVDate

Select		*
From		HospitalStaff