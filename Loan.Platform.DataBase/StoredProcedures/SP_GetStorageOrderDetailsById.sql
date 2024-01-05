CREATE PROCEDURE [dbo].[SP_GetStorageOrderDetailsById]
@Id INT,
@CurrentRole NVARCHAR(MAX)
AS
BEGIN
	DECLARE @CARSSTORED INT = 0;

	SELECT
		@CARSSTORED = COUNT(ISNULL(CRCM.Id,0))
	FROM
		ContractRailCarMapping CRCM
	INNER JOIN
		Contract C
	ON
		C.Id = CRCM.ContractId
	WHERE
		CRCM.ContractId = @Id
		AND CONVERT(VARCHAR(10),CONVERT(DATE,CRCM.ArrivalDate)) <= CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE()))
		AND (CRCM.DepartureDate IS NULL OR CONVERT(VARCHAR(10),CONVERT(DATE,CRCM.DepartureDate)) >= CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())))
		AND CONVERT(VARCHAR(10),CONVERT(DATE,C.EffectiveDate)) <= CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE()))
		AND CONVERT(VARCHAR(10),CONVERT(DATE,C.ExpiryDate)) >= CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE()));

	UPDATE 
		[Contract]
	SET 
		CarsStored=@CARSSTORED 
	WHERE 
		Id = @Id

	SELECT
		Distinct C.id,
		C.Rider,V.Organization as VendorName,V.Id as VendorId,
		SF.[Name] as StorgeFacilityName, SF.Id as StorgeFacilityId,
		C.EffectiveDate ,C.ExpiryDate as ExpiryDate ,C.TotalCars,
		C.CarsStored, C.[Location],Cu.Id as CustomerId, CusOrg.Name as CustomerName,
		CT.Id as ContractTypeId, CT.[Name] as ContractTypeName,
		Cur.Id as CurrencyId, Cur.Name as CurrencyName, C.CreatedTime,
		C.IsFlatRateContract,C.IsAdvancedSwitchingRatesEnabled, C.ReservedSpaces,C.[Description]
	INTO
		#ContractTmp
	FROM
		[Contract] C
	INNER JOIN
	vendor V
	ON
		C.VendorId = V.Id
	INNER JOIN
		StorageFacility SF
	ON
		C.StorageFacilityId = SF.Id
	INNER JOIN
		Customers Cu
	ON
		C.CustomerId = Cu.Id
	INNER JOIN
		Currency Cur
	ON
		C.CurrencyId = Cur.Id
	INNER JOIN
		ContractType CT
	ON
		C.ContractTypeId = CT.Id
	INNER JOIN
		Organization CusOrg
	ON
		CusOrg.Id=Cu.OrganizationId
	WHERE
		C.Id = @id AND
		C.IsActive=1;

	-- RESULT-1, GET CONTRACT DETAIL
	SELECT
		Id, Rider, VendorName, VendorId, StorgeFacilityName, StorgeFacilityId,
		EffectiveDate, ExpiryDate, TotalCars, CarsStored, [Location],
		CustomerId, CustomerName, ContractTypeId,ContractTypeName,
		CurrencyId,CurrencyName,CreatedTime, IsFlatRateContract,IsAdvancedSwitchingRatesEnabled,
		ReservedSpaces,[Description]
	FROM
		#ContractTmp;

	-- RESULT-2, GET CONTRACT RATE DETAIL
	SELECT
		CNRT.Id,
		CNRT.ContractId,
		CNRT.RateTypeId,
		CNRT.SwitchIn,
		CNRT.SwitchOut,
		CNRT.SpecialSwitchingRate,
		CNRT.DailyStorageRate,
		CNRT.SwitchingRate,
		CNRT.HazmatSurcharge,
		CNRT.LoadedSurcharge,
		CNRT.ReservationRate,
		CNRT.CherryPickingRate,
		CNRT.IsAdvancedHazmatSwitchingEnabled,
		CNRT.IsAdvancedLoadedSwitchingEnabled,
		CNRT.HazmatSwitchIn,
		CNRT.HazmatSwitchOut,
		CNRT.LoadedSwitchIn,
		CNRT.LoadedSwitchOut,
		(CASE
			WHEN @CurrentRole='vendor' THEN 0
			ELSE CNRT.BookingFee
		END) AS BookingFee,
		(CASE
			WHEN @CurrentRole='customer' THEN 0
			ELSE CNRT.ListingFee
		END) AS ListingFee,
		RTTYP.[Name] As RateType
	FROM
		#ContractTmp CT
	INNER JOIN
		dbo.ContractRate CNRT
	ON
		CT.Id=CNRT.ContractId
	INNER JOIN
		dbo.RateType RTTYP
	ON
		RTTYP.Id=CNRT.RateTypeId
	WHERE
		CNRT.IsActive=1

	-- RESULT-3, GET STORAGE FEATURES DETAIL
	Select
		SFF.Id AS StorageFeatureId,
		SFF.[Name] AS StorageFeatureName
	FROM
		#ContractTmp T
	INNER JOIN
		ContractSFFeatureMapping CFM
	ON
		T.id = CFM.ContractId AND CFM.IsActive=1
	INNER JOIN
		StorageFeature SFF
	ON
		SFF.id =CFM.StorageFeatureId;

	DROP TABLE #ContractTmp;

END