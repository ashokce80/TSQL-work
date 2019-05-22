/*  
Stored proc part II
5.18.19
online class 
*/
/*
you have till 9:20 AM to complete the class work1. Create a stored proc to find out the currency exchange rate from USD to EUR		- input param				a. FromCurrency				b. ToCurrencyYour SP should accept a ToCurrency Param.				tables:		Sales.CurrencyRate		Sales.CurrencyDisplay below columns:FromCurrency ToCurrencyCurrencyRateDateEndOfDayRateCountryName*/

Select		 *
From		AdventureWorks2014.Sales.CurrencyRate

Select	*
From		AdventureWorks2014.Sales.Currency

GO
Alter Proc UDSP_currency_exc_rate
@FromCurrency varchar(5) = 'USD',
@ToCurrency   varchar(5)
AS
Begin
	Select		SCR.FromCurrencyCode,
				SCR.ToCurrencyCode,
				SCR.CurrencyRateDate,
				SCR.EndOfDayRate,
				SC.Name as FromCountryName,
				SC1.Name as ToCountryName
	From		AdventureWorks2014.Sales.CurrencyRate as SCR
	Inner join	AdventureWorks2014.Sales.Currency as SC
	On			SCR.FromCurrencyCode = SC.CurrencyCode
	Inner join  AdventureWorks2014.Sales.Currency as SC1
	ON			SCR.ToCurrencyCode = SC1.CurrencyCode
	Where		SCR.FromCurrencyCode = @FromCurrency 
	And			SCR.ToCurrencyCode = @ToCurrency
End

EXeC	UDSP_currency_exc_rate'USD','EUR'

----DATA base diagram related issue for owner ship to me so set it 
EXEC	dbo.sp_changedbowner @loginame = N'sa'

/* Let's create a stored procedure that will take the Sales Person as an input parameter and provide the SalesYTD as an ouput parameter.USE  Sales.SalesPerson and HumanResources.vEmployee*/SELECT	top 1		*FROM			AdventureWorks2014.Sales.SalesPersonSELECT			*FROM			AdventureWorks2014.HumanResources.vEmployee--> Input Parameter = LastName from HumanResources.vEmployee--> Output parameter = SalesYTD from Sales.SalesPerson

Go
Create	Proc	UD_SP_SalesYTDbyLastName
@LastName varchar(20),
@SalesYTD money output
AS
Begin
	Select	@SalesYTD =	SSP.SalesYTD
	From				AdventureWorks2014.Sales.SalesPerson as SSP
	Inner join			AdventureWorks2014.HumanResources.vEmployee as HRvE
	On					SSP.BusinessEntityID = HRvE.BusinessEntityID
	Where				HRvE.LastName = @LastName --'Alberts'
End

Declare	@SalesYTD4Person money
Exec	UD_SP_SalesYTDbyLastName'Alberts',@SalesYTD = @SalesYTD4Person output
Print	@SalesYTD4Person


