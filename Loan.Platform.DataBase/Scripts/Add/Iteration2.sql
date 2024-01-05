BEGIN TRANSACTION

PRINT 'ALTER TABLE [dbo].[Contract]';
GO

ALTER TABLE [dbo].[Contract]
ADD
IsAdvancedSwitchingRatesEnabled BIT NOT NULL 
CONSTRAINT DF_Contract_IsAdvancedSwitchingRatesEnabled DEFAULT(0)
GO

PRINT 'ALTER TABLE [dbo].[ContractRate]';
GO

ALTER TABLE [dbo].[ContractRate]
ADD
IsAdvancedHazmatSwitchingEnabled BIT NOT NULL CONSTRAINT DF_ContractRate_IsAdvancedHazmatSwitchingEnabled DEFAULT(0),
IsAdvancedLoadedSwitchingEnabled BIT NOT NULL CONSTRAINT DF_ContractRate_IsAdvancedLoadedSwitchingEnabled DEFAULT(0),
HazmatSwitchIn decimal(18,2) null,
HazmatSwitchOut decimal(18,2) null,
LoadedSwitchIn decimal(18,2) null,
LoadedSwitchOut decimal(18,2) null
GO

PRINT 'DROP PROCEDURE [dbo].[usp_CreateOrUpdateContract]';
GO

DROP PROCEDURE [dbo].[usp_CreateOrUpdateContract];
GO

PRINT 'DROP TYPE [dbo].[ContractUDT]';
GO

DROP TYPE [dbo].[ContractUDT];
GO

PRINT 'DROP TYPE [dbo].[ContractRateUDT]';
GO

DROP TYPE [dbo].[ContractRateUDT];
GO

PRINT 'CREATE TYPE [dbo].[ContractUDT]';
GO

CREATE TYPE [dbo].[ContractUDT] AS TABLE(
	[Id] [bigint] NULL,
	[VendorId] [bigint] NOT NULL,
	[CustomerId] [bigint] NOT NULL,
	[Rider] [nvarchar](max) NOT NULL,
	[StorageFacilityId] [bigint] NOT NULL,
	[EffectiveDate] [datetime2](7) NOT NULL,
	[ExpiryDate] [datetime2](7) NULL,
	[ContractTypeId] [bigint] NULL,
	[TotalCars] [int] NULL,
	[CurrencyId] [smallint] NULL,
	[Description] [nvarchar](max) NULL,
	[Location] [nvarchar](max) NULL,
	[CarsStored] [bigint] NOT NULL,
	[ReservedSpaces] [int] NULL,
	[IsFlatRateContract] [bit] NOT NULL,
	[IsAdvancedSwitchingRatesEnabled] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL
)
GO


PRINT 'CREATE TYPE [dbo].[ContractRateUDT]';
GO

CREATE TYPE [dbo].[ContractRateUDT] AS TABLE(
[Id] [bigint] NULL,
[ContractId] [bigint] NOT NULL,
[RateTypeId] [bigint] NOT NULL,
[SwitchIn] [decimal](18, 2) NULL,
[SwitchOut] [decimal](18, 2) NULL,
[SpecialSwitchingRate] [decimal](18, 2) NULL,
[DailyStorageRate] [decimal](18, 2) NOT NULL,
[SwitchingRate] [decimal](18, 2) NULL,
[HazmatSurcharge] [decimal](18, 2) NULL,
[LoadedSurcharge] [decimal](18, 2) NULL,
[ReservationRate] [decimal](18, 2) NULL,
[CherryPickingRate] [decimal](18, 2) NULL,
[BookingFee] [decimal](18, 2) NULL,
[ListingFee] [decimal](18, 2) NULL,
[IsActive] [bit] NOT NULL,
[CreatedTime] [datetime2](7) NOT NULL,
[CreatedBy] [bigint] NOT NULL,
[ModifiedTime] [datetime2](7) NOT NULL,
[ModifiedBy] [bigint] NOT NULL,
[OrganizationId] [bigint] NOT NULL,
[TenantId] [bigint] NOT NULL,
[IsAdvancedHazmatSwitchingEnabled] [bit] NOT NULL,
[IsAdvancedLoadedSwitchingEnabled] [bit] NOT NULL,
[HazmatSwitchIn] [decimal](18, 2) NULL,
[HazmatSwitchOut] [decimal](18, 2) NULL,
[LoadedSwitchIn] [decimal](18, 2) NULL,
[LoadedSwitchOut] [decimal](18, 2) NULL

)
GO

PRINT 'CREATE PROCEDURE [dbo].[usp_CreateOrUpdateContract]';
GO

CREATE PROCEDURE [dbo].[usp_CreateOrUpdateContract]
@Contract ContractUDT readonly,
@ContractRate ContractRateUDT readonly,
@ContractSFFeatureMapping ContractSFFeatureMappingUDT readonly,
@CurrentRole NVARCHAR(MAX)
AS
BEGIN
DECLARE @ERRORNUMBER INT,
@ERRORMESSAGE VARCHAR(500),
@ERRORSEVERITY INT,
@ERRORSTATE INT,
@ERRORLINE INT,
@ERRORPROCEDURE VARCHAR(200),
@PARAMS VARCHAR(500),
@MESSAGE NVARCHAR(MAX),
@MODIFIEDBY INT,
@MODIFIEDDATETIME DATETIME,
@BOOKINGFEE [decimal](18, 2),
@LISTINGFEE [decimal](18, 2);
BEGIN TRY

IF(@currentRole='vendor')
SELECT @BOOKINGFEE = (SELECT PercentageMargin FROM Customers C INNER JOIN @Contract CT ON CT.CustomerId=c.Id)
ELSE
SELECT @BOOKINGFEE=BookingFee FROM @ContractRate

IF(@currentRole='customer')
SELECT @LISTINGFEE =ListingFee,@BOOKINGFEE=BookingFee FROM @ContractRate
ELSE
SELECT @LISTINGFEE=ListingFee FROM @ContractRate


SELECT
UDTCR.Id,UDTCR.ContractId,UDTCR.RateTypeId,UDTCR.SwitchIn,UDTCR.SwitchOut,UDTCR.SpecialSwitchingRate,UDTCR.DailyStorageRate,
UDTCR.SwitchingRate,UDTCR.HazmatSurcharge,UDTCR.LoadedSurcharge,UDTCR.ReservationRate,UDTCR.CherryPickingRate,
@BOOKINGFEE AS BookingFee,
@LISTINGFEE AS ListingFee,
UDTCR.IsActive,UDTCR.CreatedTime,UDTCR.CreatedBy,UDTCR.ModifiedTime,UDTCR.ModifiedBy,
UDTCR.OrganizationId,UDTCR.TenantId,UDTCR.IsAdvancedHazmatSwitchingEnabled,UDTCR.IsAdvancedLoadedSwitchingEnabled,
UDTCR.HazmatSwitchIn,UDTCR.HazmatSwitchOut,UDTCR.LoadedSwitchIn,UDTCR.LoadedSwitchOut
INTO #ContractRateDetails
FROM @ContractRate UDTCR
LEFT JOIN dbo.ContractRate CR on UDTCR.Id=CR.Id AND
UDTCR.ContractId=CR.ContractId AND
UDTCR.RateTypeId=CR.RateTypeId AND
ISNULL(UDTCR.SwitchIn,0)=ISNULL(CR.SwitchIn,0) AND
ISNULL(UDTCR.SwitchOut,0)=ISNULL(CR.SwitchOut,0) AND
ISNULL(UDTCR.SpecialSwitchingRate ,0) = ISNULL(CR.SpecialSwitchingRate,0) AND
UDTCR.DailyStorageRate=CR.DailyStorageRate AND
ISNULL(UDTCR.SwitchingRate ,0) = ISNULL(CR.SwitchingRate ,0) AND
ISNULL(UDTCR.HazmatSurcharge ,0)=ISNULL(CR.HazmatSurcharge,0) AND
ISNULL(UDTCR.LoadedSurcharge ,0)=ISNULL(CR.LoadedSurcharge,0) AND
ISNULL(UDTCR.ReservationRate ,0)=ISNULL(CR.ReservationRate,0) AND
ISNULL(UDTCR.CherryPickingRate,0)=ISNULL(CR.CherryPickingRate,0) AND
UDTCR.IsAdvancedLoadedSwitchingEnabled = CR.IsAdvancedLoadedSwitchingEnabled AND
UDTCR.IsAdvancedHazmatSwitchingEnabled = CR.IsAdvancedHazmatSwitchingEnabled AND
ISNULL(UDTCR.HazmatSwitchIn ,0) = ISNULL(CR.HazmatSwitchIn ,0) AND
ISNULL(UDTCR.HazmatSwitchOut ,0) = ISNULL(CR.HazmatSwitchOut ,0) AND
ISNULL(UDTCR.LoadedSwitchIn ,0) = ISNULL(CR.LoadedSwitchIn ,0) AND
ISNULL(UDTCR.LoadedSwitchOut ,0) = ISNULL(CR.LoadedSwitchOut ,0) AND
(ISNULL(UDTCR.BookingFee ,0) = ISNULL(CR.BookingFee ,0) OR @CurrentRole='vendor') AND
(ISNULL(UDTCR.ListingFee ,0) = ISNULL(CR.ListingFee ,0) OR @currentRole='customer')AND
UDTCR.IsActive=1 where CR.Id IS NULL ;


DECLARE @ContractId BIGINT;

IF NOT EXISTS(SELECT 1 FROM @Contract UDTCR INNER JOIN Contract CR ON UDTCR.Id = CR.Id)
BEGIN
-- SAVE CONTRACT DETAIL
INSERT INTO dbo.[Contract] (VendorId,CustomerId,Rider,StorageFacilityId,EffectiveDate,ExpiryDate,ContractTypeId,
TotalCars,ReservedSpaces,CurrencyId,[Description],[Location],CarsStored,
IsFlatRateContract,IsAdvancedSwitchingRatesEnabled,IsActive,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,
OrganizationId,TenantId)
SELECT VendorId,CustomerId,Rider,StorageFacilityId,EffectiveDate,ExpiryDate,ContractTypeId,TotalCars,ReservedSpaces,
CurrencyId,[Description],[Location],CarsStored,IsFlatRateContract,IsAdvancedSwitchingRatesEnabled,IsActive,CreatedTime,CreatedBy,
ModifiedTime,ModifiedBy,OrganizationId,TenantId
FROM @Contract

SELECT @ContractId=SCOPE_IDENTITY();



-- SAVE CONTRACT RATE DETAIL
INSERT INTO dbo.[ContractRate] (ContractId,RateTypeId,SwitchIn,SwitchOut,SpecialSwitchingRate,DailyStorageRate,
SwitchingRate,HazmatSurcharge,LoadedSurcharge,ReservationRate,CherryPickingRate,
BookingFee,ListingFee,IsActive,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,
TenantId,IsAdvancedHazmatSwitchingEnabled,IsAdvancedLoadedSwitchingEnabled,
HazmatSwitchIn,HazmatSwitchOut,LoadedSwitchIn,LoadedSwitchOut )
SELECT @ContractId,RateTypeId,SwitchIn,SwitchOut,SpecialSwitchingRate,DailyStorageRate,SwitchingRate,HazmatSurcharge,
LoadedSurcharge,ReservationRate,CherryPickingRate,BookingFee,ListingFee,IsActive,CreatedTime,CreatedBy,
ModifiedTime,ModifiedBy,OrganizationId,TenantId,IsAdvancedHazmatSwitchingEnabled,IsAdvancedLoadedSwitchingEnabled,
HazmatSwitchIn,HazmatSwitchOut,LoadedSwitchIn,LoadedSwitchOut
FROM #ContractRateDetails ;

INSERT INTO ContractSFFeatureMapping
(ContractId
,StorageFeatureId
,IsActive
,CreatedTime
,CreatedBy
,ModifiedTime
,ModifiedBy
,OrganizationId
,TenantId)
SELECT
@ContractId
,StorageFeatureId
,IsActive
,CreatedTime
,CreatedBy
,ModifiedTime
,ModifiedBy
,OrganizationId
,TenantId
FROM
@ContractSFFeatureMapping
END
ELSE
BEGIN

SET @ContractId = (SELECT Id FROM @Contract)

UPDATE dbo.[Contract]
SET VendorId=UDTCT.VendorId,
CustomerId=UDTCT.CustomerId,
Rider=UDTCT.Rider,
StorageFacilityId=UDTCT.StorageFacilityId,
EffectiveDate=UDTCT.EffectiveDate,
ExpiryDate=UDTCT.ExpiryDate,
ContractTypeId=UDTCT.ContractTypeId,
TotalCars=UDTCT.TotalCars,
ReservedSpaces=UDTCT.ReservedSpaces,
CurrencyId=UDTCT.CurrencyId,
[Description]=UDTCT.[Description],
[Location]=UDTCT.[Location],
CarsStored=UDTCT.CarsStored,
IsFlatRateContract=UDTCT.IsFlatRateContract,
IsAdvancedSwitchingRatesEnabled=UDTCT.IsAdvancedSwitchingRatesEnabled,
IsActive=UDTCT.IsActive,
ModifiedTime=UDTCT.ModifiedTime,
ModifiedBy=UDTCT.ModifiedBy,
OrganizationId=UDTCT.OrganizationId,
TenantId=UDTCT.TenantId
FROM dbo.[Contract] CT
INNER JOIN @Contract UDTCT ON CT.Id=UDTCT.Id;

UPDATE
dbo.[ContractRate]
SET
IsActive=0
FROM
dbo.[ContractRate] CTRT
INNER JOIN
#ContractRateDetails UDCTRT
ON
CTRT.Id=UDCTRT.Id AND CTRT.ContractId=UDCTRT.ContractId;

INSERT INTO dbo.[ContractRate] (ContractId,RateTypeId,SwitchIn,SwitchOut,SpecialSwitchingRate,DailyStorageRate,
SwitchingRate,HazmatSurcharge,LoadedSurcharge,ReservationRate,CherryPickingRate,
BookingFee,ListingFee,IsActive,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,
OrganizationId,TenantId,IsAdvancedHazmatSwitchingEnabled,IsAdvancedLoadedSwitchingEnabled,
HazmatSwitchIn,HazmatSwitchOut,LoadedSwitchIn,LoadedSwitchOut )
SELECT ContractId,RateTypeId,SwitchIn,SwitchOut,SpecialSwitchingRate,DailyStorageRate,SwitchingRate,HazmatSurcharge,
LoadedSurcharge,ReservationRate,CherryPickingRate,BookingFee,ListingFee,IsActive,CreatedTime,
CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId,IsAdvancedHazmatSwitchingEnabled,IsAdvancedLoadedSwitchingEnabled,
HazmatSwitchIn,HazmatSwitchOut,LoadedSwitchIn,LoadedSwitchOut
FROM #ContractRateDetails ;

(SELECT TOP 1 @MODIFIEDBY=ModifiedBy,@MODIFIEDDATETIME=ModifiedTime FROM @ContractRate);

IF((SELECT COUNT(Id) FROM @ContractRate) <> (SELECT COUNT(Id) FROM #ContractRateDetails))
BEGIN
UPDATE dbo.[ContractRate]
SET
ModifiedBy=@MODIFIEDBY,
ModifiedTime= @MODIFIEDDATETIME
FROM dbo.[ContractRate] CTRT
LEFT JOIN #ContractRateDetails UDCTRT ON CTRT.Id=UDCTRT.Id
WHERE UDCTRT.Id IS NULL AND CTRT.ContractId=@ContractId AND CTRT.IsActive=1;
END

MERGE ContractSFFeatureMapping AS Target
USING @ContractSFFeatureMapping AS Source
ON Source.ContractId = Target.ContractId AND Source.StorageFeatureId = Target.StorageFeatureId

WHEN NOT MATCHED BY Target THEN
INSERT (ContractId,
StorageFeatureId,
IsActive,
CreatedTime,
CreatedBy,
ModifiedTime,
ModifiedBy,
OrganizationId,
TenantId)
VALUES (Source.ContractId,
Source.StorageFeatureId,
Source.IsActive,
Source.CreatedTime,
Source.CreatedBy,
Source.ModifiedTime,
Source.ModifiedBy,
Source.OrganizationId,
Source.TenantId)

WHEN MATCHED THEN UPDATE SET
Target.IsACtive=Source.IsActive,
Target.ModifiedTime=Source.ModifiedTime,
Target.ModifiedBy=Source.ModifiedBy,
Target.OrganizationId=Source.OrganizationId,
Target.TenantId =Source.TenantId;
END
SELECT @ContractId
END TRY
BEGIN CATCH
SELECT
@ERRORMESSAGE = ERROR_MESSAGE(),
@ERRORSEVERITY = ERROR_SEVERITY(),
@ERRORNUMBER = ERROR_NUMBER(),
@ERRORPROCEDURE = ERROR_PROCEDURE(),
@ERRORLINE = ERROR_LINE(),
@ERRORSTATE = ERROR_STATE();

SET @PARAMS = 'Parameter 1:'+ CAST(@ContractId AS varchar(10));
SET @MESSAGE = 'ERROR NUMBER:' + CAST(@ERRORNUMBER AS VARCHAR(5)) + CHAR(13)
+'PROCEDURE NAME:'+ @ERRORPROCEDURE + CHAR(13)
+'PROCEDURE LINE:'+ CAST(@ERRORLINE AS VARCHAR(5)) + CHAR(13)
+'ERROR MESSAGE:'+ @ERRORMESSAGE + CHAR(13)
+'PARAMETERS:'+@PARAMS + CHAR(13);

--INSERT INTO [dbo].[DB_Errors]
-- VALUES (SUSER_SNAME(), @MESSAGE, GETDATE());

-- return the error inside the CATCH block
RAISERROR(@MESSAGE, @ERRORSEVERITY, @ERRORSTATE);
END CATCH
END
GO

PRINT 'ALTER PROCEDURE [dbo].[SP_GetStorageOrderDetailsById]';
GO

ALTER PROCEDURE [dbo].[SP_GetStorageOrderDetailsById]
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

GO

--Book Now scripts

IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name like 'SP_GetOpportunityDetailsById')
BEGIN
	DROP PROC SP_GetOpportunityDetailsById
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name like 'usp_CreateOrUpdateOpportunity')
BEGIN
	DROP PROC usp_CreateOrUpdateOpportunity
END
GO

/****** Object:  Table [dbo].[OpportunityReservedSpaces]    Script Date: 10-10-2022 13:43:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpportunityReservedSpaces]') AND type in (N'U'))
DROP TABLE [dbo].[OpportunityReservedSpaces]
GO
/****** Object:  Table [dbo].[OpportunityRailcarDetails]    Script Date: 10-10-2022 13:43:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpportunityRailcarDetails]') AND type in (N'U'))
DROP TABLE [dbo].[OpportunityRailcarDetails]
GO
/****** Object:  Table [dbo].[OpportunityFeatures]    Script Date: 10-10-2022 13:43:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpportunityFeatures]') AND type in (N'U'))
DROP TABLE [dbo].[OpportunityFeatures]
GO
/****** Object:  Table [dbo].[OpportunityAttachments]    Script Date: 10-10-2022 13:43:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpportunityAttachments]') AND type in (N'U'))
DROP TABLE [dbo].[OpportunityAttachments]
GO
/****** Object:  Table [dbo].[Opportunity]    Script Date: 10-10-2022 13:43:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Opportunity]') AND type in (N'U'))
DROP TABLE [dbo].[Opportunity]
GO

IF  EXISTS (SELECT * FROM sys.types WHERE name like 'OpportunityRailcarDetailsUDT')
BEGIN
	DROP TYPE OpportunityRailcarDetailsUDT
END
GO
IF  EXISTS (SELECT * FROM sys.types WHERE name like 'OpportunityAttachmentsUDT')
BEGIN
	DROP TYPE OpportunityAttachmentsUDT
END
GO
IF  EXISTS (SELECT * FROM sys.types WHERE name like 'OpportunityFeaturesUDT')
BEGIN
	DROP TYPE OpportunityFeaturesUDT
END
GO
IF  EXISTS (SELECT * FROM sys.types WHERE name like 'OpportunityUDT')
BEGIN
	DROP TYPE OpportunityUDT
END
GO
/****** Object:  UserDefinedTableType [dbo].[OpportunityAttachmentsUDT]    Script Date: 10-10-2022 13:43:12 ******/
CREATE TYPE [dbo].[OpportunityAttachmentsUDT] AS TABLE(
	[Id] [bigint] NULL,
	[OpportunityId] [bigint] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Path] [nvarchar](max) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL,
	[Size] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[OpportunityFeaturesUDT]    Script Date: 10-10-2022 13:43:12 ******/
CREATE TYPE [dbo].[OpportunityFeaturesUDT] AS TABLE(
	[Id] [bigint] NULL,
	[OpportunityId] [bigint] NOT NULL,
	[FeatureId] [bigint] NOT NULL,
	[Comments] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[OpportunityRailcarDetailsUDT]    Script Date: 10-10-2022 13:43:12 ******/
CREATE TYPE [dbo].[OpportunityRailcarDetailsUDT] AS TABLE(
	[Id] [bigint] NULL,
	[OpportunityID] [bigint] NOT NULL,
	[ExpectedNumberOfCars] [bigint] NULL,
	[LEId] [bigint] NOT NULL,
	[Commodity] [nvarchar](max) NULL,
	[IsHazmat] [bit] NOT NULL,
	[CarType] [bigint] NOT NULL,
	[RailcarIds] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[OpportunityUDT]    Script Date: 10-10-2022 13:43:12 ******/
CREATE TYPE [dbo].[OpportunityUDT] AS TABLE(
	[Id] [bigint] NULL,
	[Name] [nvarchar](max) NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[BookingStatus] [bigint] NOT NULL,
	[AgreementPath] [nvarchar](max) NULL,
	[VendorId] [bigint] NOT NULL,
	[CustomerId] [bigint] NOT NULL,
	[FacilityId] [bigint] NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL
)
GO
/****** Object:  Table [dbo].[Opportunity]    Script Date: 10-10-2022 13:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Opportunity](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[BookingStatus] [bigint] NOT NULL,
	[AgreementPath] [nvarchar](max) NULL,
	[VendorId] [bigint] NOT NULL,
	[CustomerId] [bigint] NOT NULL,
	[FacilityId] [bigint] NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL,
 CONSTRAINT [PK_Opportunity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpportunityAttachments]    Script Date: 10-10-2022 13:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpportunityAttachments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OpportunityId] [bigint] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Path] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL,
	[Size] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_OpportunityAttachments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpportunityFeatures]    Script Date: 10-10-2022 13:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpportunityFeatures](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OpportunityId] [bigint] NOT NULL,
	[FeatureId] [bigint] NOT NULL,
	[Comments] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL,
 CONSTRAINT [PK_OpportunityFeatures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpportunityRailcarDetails]    Script Date: 10-10-2022 13:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpportunityRailcarDetails](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OpportunityID] [bigint] NOT NULL,
	[ExpectedNumberOfCars] [bigint] NULL,
	[LEId] [bigint] NOT NULL,
	[Commodity] [nvarchar](max) NULL,
	[IsHazmat] [bit] NOT NULL,
	[CarType] [bigint] NOT NULL,
	[RailcarIds] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL,
 CONSTRAINT [PK_OpportunityRailcarDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpportunityReservedSpaces]    Script Date: 10-10-2022 13:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpportunityReservedSpaces](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OpportunityId] [bigint] NOT NULL,
	[ReservedSpaces] [bigint] NOT NULL,
	[EffectiveDate] [datetime2](7) NOT NULL,
	[ExpirationDate] [datetime2](7) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL,
 CONSTRAINT [PK_OpportunityReservedSpaces] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetOpportunityDetailsById]    Script Date: 10-10-2022 13:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[SP_GetOpportunityDetailsById]
@OpportunityId BIGINT
AS
BEGIN
		--Opportunity Record
		SELECT DISTINCT
			OP.Id,
			[Name],
			StartDate,
			EndDate,
			BookingStatus,
			AgreementPath,
			VendorId,
			CustomerId,
			FacilityId,
			SUM(ORCD.ExpectedNumberOfCars) OVER() AS TotalNoApproxSpaces,
			SUM(ORS.ReservedSpaces) OVER() AS TotalNoReservedSpaces
		FROM 
			Opportunity OP
		LEFT JOIN 
			OpportunityRailcarDetails ORCD 
			ON OP.Id=ORCD.OpportunityID AND ORCD.IsActive=1
		LEFT JOIN 
			OpportunityReservedSpaces ORS
			ON OP.Id=ORS.OpportunityID AND ORCD.IsActive=1
		WHERE
			OP.ID=@OpportunityId

		--OpportunityRailcar Records
		SELECT 
			ORCD.Id,
			OpportunityId,
			ExpectedNumberOfCars,
			LEId,
			LE.[Name] AS LandE,
			Commodity,
			IsHazmat,
			CarType,
			RailcarIds,
			RCT.[Name] AS CarTypeName

		FROM 
			[dbo].[OpportunityRailcarDetails] ORCD
		LEFT JOIN 
			LEContent LE ON ORCD.LEId=LE.Id
		LEFT JOIN
			RailCarType RCT ON RCT.Id=ORCD.CarType
		WHERE
			OpportunityID=@OpportunityId AND ORCD.IsActive=1

		--OpportunityAttachments Records
		SELECT 
			Id,
			OpportunityId,
			[Name],
			[Path],
			IsActive,
			Size,
			CreatedDate
		FROM 
			[dbo].[OpportunityAttachments]			
		WHERE
			OpportunityID=@OpportunityId AND IsActive=1
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CreateOrUpdateOpportunity]    Script Date: 10-10-2022 13:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[usp_CreateOrUpdateOpportunity]
	@Opportunity OpportunityUDT READONLY,
	@OpportunityRailcarDetails OpportunityRailcarDetailsUDT READONLY,
	@OpportunityAttachments OpportunityAttachmentsUDT READONLY
AS
BEGIN
	
	
	DECLARE @OpportunityName VARCHAR(100);

	--Parameters used for error handling
	DECLARE @ERRORNUMBER INT,
			@ERRORMESSAGE VARCHAR(500),
			@ERRORSEVERITY INT,
			@ERRORSTATE INT,
			@ERRORLINE INT,
			@ERRORPROCEDURE VARCHAR(200),
			@PARAMS VARCHAR(500),
			@MESSAGE NVARCHAR(MAX);

	BEGIN TRY 				

		DECLARE @OpportunityId BIGINT;	
		IF NOT EXISTS(SELECT 1 FROM  @Opportunity UDOPNT INNER JOIN Opportunity OPNT ON UDOPNT.Id = OPNT.Id)
		BEGIN
		
			DECLARE @VendorName VARCHAR(100);
			DECLARE @CustomerName VARCHAR(100);
			DECLARE @VendorId BIGINT;
			DECLARE @CustomerId BIGINT;
			DECLARE @Count BIGINT;

			SELECT @VendorId=VendorId, @CustomerId=CustomerId FROM @Opportunity
			SELECT @VendorName=org.[Name] FROM Organization org INNER JOIN Vendor ven ON org.Id=ven.OrganizationId WHERE ven.Id=@VendorId
			SELECT @CustomerName=org.[Name] FROM Organization org INNER JOIN Customers cust ON org.Id=cust.OrganizationId WHERE org.Id=@CustomerId
			SELECT @Count=COUNT(*) FROM Opportunity WHERE VendorId=@VendorId AND CustomerId=@CustomerId and YEAR(CreatedTime)=YEAR(GETDATE())
			
			SET @OpportunityName= @VendorName + ' - ' + @CustomerName + ' '+CAST(DATEPART(YYYY,GETDATE()) AS VARCHAR)+ ' - ' + CAST(@Count+1 AS varchar)+' - INPROCESS';
	
			-- Save Opportunity
		    INSERT INTO dbo.[Opportunity] ([Name],StartDate,EndDate,BookingStatus,AgreementPath,VendorId
				,CustomerId,FacilityId,IsActive,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId)
			SELECT @OpportunityName,StartDate,EndDate,BookingStatus,AgreementPath,VendorId,CustomerId,FacilityId			,IsActive
				,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId
			FROM @Opportunity
	
	        SELECT @OpportunityId=SCOPE_IDENTITY();
	
			-- Save OpportunityRailCarDetails
			INSERT INTO dbo.[OpportunityRailcarDetails](OpportunityID,ExpectedNumberOfCars,LEId,Commodity,IsHazmat,CarType,RailcarIds,
				IsActive,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId)
			SELECT @OpportunityId,ExpectedNumberOfCars,LEId,Commodity,IsHazmat,CarType,RailcarIds,IsActive,CreatedTime,CreatedBy
	            ,ModifiedTime,ModifiedBy,OrganizationId,TenantId
			FROM @OpportunityRailcarDetails

			-- Save OpportunityAttachments
			INSERT INTO OpportunityAttachments (OpportunityId,[Name],[Path],IsActive,CreatedTime,CreatedBy,ModifiedTime
				,ModifiedBy,OrganizationId,TenantId,Size,CreatedDate)
			SELECT @OpportunityId,[Name],[Path],IsActive,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId,Size,CreatedDate
			FROM @OpportunityAttachments
	
		END
		ELSE
		BEGIN

			SET @OpportunityId  = (SELECT Id FROM @Opportunity)
			DECLARE @BookingStatusId INT
			SELECT TOP 1 @BookingStatusId=BookingStatus FROM @Opportunity

			SELECT TOP 1 @OpportunityName=Name FROM Opportunity WHERE Id=@OpportunityId

			IF @BookingStatusId = 3
			BEGIN 				
				SET @OpportunityName= REPLACE(@OpportunityName,'INPROCESS','SUBMITTED')
			END
	
			--Update Opportunity
			UPDATE dbo.[Opportunity]
			SET	
				Name=@OpportunityName,
				StartDate=UDTOPNT.StartDate,
				EndDate=UDTOPNT.EndDate,
				BookingStatus=UDTOPNT.BookingStatus,
				AgreementPath=UDTOPNT.AgreementPath,
				VendorId=UDTOPNT.VendorId,
				CustomerId=UDTOPNT.CustomerId,
				FacilityId=UDTOPNT.FacilityId,
				IsActive=UDTOPNT.IsActive,
				ModifiedTime=UDTOPNT.ModifiedTime,
				ModifiedBy=UDTOPNT.ModifiedBy,
				OrganizationId=UDTOPNT.OrganizationId,
				TenantId=UDTOPNT.TenantId
			FROM dbo.[Opportunity] OPNT
			INNER JOIN @Opportunity UDTOPNT ON OPNT.Id=UDTOPNT.Id;
	
			--Update or Add OpportunityRailCarDetails
			MERGE 
				OpportunityRailcarDetails AS Target
			USING 
				@OpportunityRailcarDetails AS Source
			ON 
				Source.Id = Target.Id AND Source.OpportunityID = Target.OpportunityID
			
			WHEN NOT MATCHED BY Target THEN
				INSERT (OpportunityID,ExpectedNumberOfCars,LEId,Commodity,IsHazmat,CarType,RailcarIds,IsActive
						,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId)
				VALUES (@OpportunityId,Source.ExpectedNumberOfCars,Source.LEId,Source.Commodity,Source.IsHazmat,Source.CarType,Source.RailcarIds,
				Source.IsActive,Source.CreatedTime,Source.CreatedBy,Source.ModifiedTime,Source.ModifiedBy,Source.OrganizationId,Source.TenantId)
			
			WHEN MATCHED THEN UPDATE SET
				Target.LEId=Source.LEId,		
				Target.Commodity=Source.Commodity,	
				Target.ExpectedNumberOfCars=Source.ExpectedNumberOfCars,
				Target.RailcarIds=Source.RailcarIds,
				Target.IsHazmat=Source.IsHazmat,	
				Target.CarType=Source.CarType,	
				Target.IsActive=Source.IsActive,
				Target.ModifiedTime=Source.ModifiedTime,
				Target.ModifiedBy=Source.ModifiedBy,
				Target.OrganizationId=Source.OrganizationId,
				Target.TenantId =Source.TenantId;


			--Update or Add OpportunityAttachments
			MERGE 
				OpportunityAttachments AS Target
			USING 
				@OpportunityAttachments AS Source
			ON 
				Source.Id = Target.Id AND Source.OpportunityID = Target.OpportunityID
			
			WHEN NOT MATCHED BY Target THEN
				INSERT (OpportunityId,[Name],[Path],IsActive,CreatedTime,CreatedBy,ModifiedTime
				,ModifiedBy,OrganizationId,TenantId,Size,CreatedDate)
				VALUES (Source.OpportunityId,Source.[Name],Source.[Path],Source.IsActive,Source.CreatedTime,Source.CreatedBy,Source.ModifiedTime
				,Source.ModifiedBy,Source.OrganizationId,Source.TenantId,Source.Size,Source.CreatedDate)
			
			WHEN MATCHED THEN UPDATE SET
				Target.[Name]=Source.[Name],
				Target.[Path]=Source.[Path],
				Target.IsActive=Source.IsActive,
				Target.ModifiedTime=Source.ModifiedTime,
				Target.ModifiedBy=Source.ModifiedBy,
				Target.OrganizationId=Source.OrganizationId,
				Target.TenantId	=Source.TenantId;			
	END
	SELECT @OpportunityId
	END TRY
	BEGIN CATCH
		 SELECT 
				@ERRORMESSAGE = ERROR_MESSAGE(), 
				@ERRORSEVERITY = ERROR_SEVERITY(),
				@ERRORNUMBER = ERROR_NUMBER(),
				@ERRORPROCEDURE = ERROR_PROCEDURE(),
				@ERRORLINE = ERROR_LINE(),
				@ERRORSTATE = ERROR_STATE();
	
				 SET @PARAMS = 'Parameter 1:'+ CAST(@OpportunityId AS varchar(10));
				 SET @MESSAGE = 'ERROR NUMBER:' + CAST(@ERRORNUMBER AS VARCHAR(5)) + CHAR(13)
							   +'PROCEDURE NAME:'+ @ERRORPROCEDURE + CHAR(13)
							   +'PROCEDURE LINE:'+ CAST(@ERRORLINE AS VARCHAR(5)) + CHAR(13)
							   +'ERROR MESSAGE:'+ @ERRORMESSAGE + CHAR(13)
							   +'PARAMETERS:'+@PARAMS + CHAR(13);
	 
			--INSERT INTO [dbo].[DB_Errors]
			--  VALUES  (SUSER_SNAME(), @MESSAGE, GETDATE());
	
			-- return the error inside the CATCH block
			RAISERROR(@MESSAGE, @ERRORSEVERITY, @ERRORSTATE);
	END CATCH
END
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_SearchFacility] @isMulticityEnable BIT = 1,
                                          @origin            NVARCHAR(100) =NULL,
                                          @destination       NVARCHAR(100) =NULL,
                                          @railroads         NVARCHAR(max) =NULL,
                                          @region            INT = NULL,
										  @expiryDate        NVARCHAR(max) =NULL,
                                          @effectiveDate     NVARCHAR(max) =NULL,
                                          @dailyRate         INT = NULL,
                                          @switchingFee      INT = NULL,
                                          @features          NVARCHAR(max) =NULL,
                                          @range             INT = NULL,
                                          @splcs             NVARCHAR(max) =NULL,
										  @splcMilesMap      SPLCMileUDT READONLY
AS
/*--------------- Stored Procedure execution---------------*/
  -- EXEC [dbo].[sp_SearchFacility] 0,NULL,NULL,NULL, @splcs ='43216000,43216001',@effectiveDate='2022-06-14 18:50:19.823',@expiryDate='2023-06-14 18:50:19.823',@features=N'3,4,1',@dailyRate=15,@switchingFee=4,@region=1
  --exec sp_SearchFacility @isMulticityEnable=0,@origin=N'Melfort, SK',@destination=N'Vancouver, WA',@railroads=N'CN',@region=Null,@expiryDate='2022-06-14 18:50:19.823',@dailyRate=15,@effectiveDate='2022-06-14 18:50:19.823',@switchingFee=4,@features=N'3,4,1'
/*---------------------------------------------------------*/
  /*
  Name:[sp_SearchFacility]
  Purpose: Search Storage facilities to be displayed on map.
  Ref: API request from RL
  History:
  Modified - Amit Jain to include all the filter Criatiria.
  */
  BEGIN
      SET nocount ON
      SET ansi_warnings ON
      SET ansi_padding ON
      SET ansi_nulls ON
      SET arithabort ON
      SET quoted_identifier ON
      SET ansi_null_dflt_on ON
      SET concat_null_yields_null ON

      --Parameters used for error handling
      DECLARE @ERRORNUMBER    INT,
              @ERRORMESSAGE   VARCHAR(MAX),
              @ERRORSEVERITY  INT,
              @ERRORSTATE     INT,
              @ERRORLINE      INT,
              @ERRORPROCEDURE VARCHAR(200),
              @PARAMS         VARCHAR(Max),
              @MESSAGE        NVARCHAR(max);

      BEGIN try
          DECLARE @WhereClause NVARCHAR(2000)
          DECLARE @Query NVARCHAR(max)
          DECLARE @WhereClauseFeatures NVARCHAR(2000)
		  Declare @WhereClauseDate nVarchar(1000)

          DECLARE @name VARCHAR(50)

		   CREATE TABLE #tmpsplcmiles
            (
			splc nvarchar(max),
               miles       NVARCHAR(256)
			)

          SET @WhereClause =''
          SET @WhereClauseFeatures = ''
		  Set @WhereClauseDate = ''

          IF @region IS NOT NULL
            BEGIN
                SET @WhereClause = @WhereClause + ' And  RegionID = '
                                   + Str(@region)
            END
		  
		  IF @railroads <> ''
            BEGIN
                SET @WhereClause = @WhereClause + ' And  markCode = '
                                   +'''' + @railroads  + '''' 
            END

          IF @dailyRate IS NOT NULL
            BEGIN
                SET @WhereClause = @WhereClause + ' And  DailyRate < '
                                   + Str(@dailyRate)
            END

          IF @switchingFee IS NOT NULL
            BEGIN
                SET @WhereClause = @WhereClause + ' And  SwitchingRate < '
                                   + Str(@switchingFee)
          END

		 IF exists(select 1 from @splcMilesMap)
		  BEGIN
				insert into #tmpsplcmiles
				select * from @splcMilesMap
				SET @WhereClause = @WhereClause + ' And splc IN (select SPLC FROM #tmpsplcmiles) '
		  END

          IF @features IS NOT NULL AND @features <> ''
            BEGIN
                SET @WhereClauseFeatures = 'And  (1=0 '

                DECLARE db_cursor CURSOR FOR
                  SELECT item
                  FROM   dbo.Fnsplit(@features, ',')

                OPEN db_cursor

                FETCH next FROM db_cursor INTO @name

                WHILE @@FETCH_STATUS = 0
                  BEGIN
                      SET @WhereClauseFeatures = @WhereClauseFeatures + ' or '''
                                                 + Trim(Str(@name))
                                                 +
                      ''' IN (SELECT item FROM dbo.fnSplit(FeatureID , '','')) '

                      FETCH next FROM db_cursor INTO @name
                  END

                SET @WhereClauseFeatures = @WhereClauseFeatures + ')'

                --Set @WhereClause = @WhereClause + ' And ''' + trim(str(@features)) + ''' IN (SELECT item FROM dbo.fnSplit(FeatureID , '','')) ' 
                CLOSE db_cursor

                DEALLOCATE db_cursor
            END


		--IF @effectiveDate is not null and @expiryDate is not null
		--	Begin
		--		Set @WhereClauseDate = ' AND ((effectivedate   between ''' + @effectiveDate + ''' and ''' + @expiryDate + ''')'
		--		Set @WhereClauseDate = @WhereClauseDate + ' or (expirydate   between ''' + @effectiveDate + ''' and ''' + @expiryDate + '''))'
		--	End

			IF @effectiveDate is not null and @expiryDate is not null
			Begin

				Set @WhereClauseDate = ' AND ((''' + @effectiveDate  + ''' between effectiveDate  and expiryDate )'
				Set @WhereClauseDate = @WhereClauseDate + ' or (''' + @expiryDate  + ''' between effectiveDate  and  expiryDate ))'
			End

			
		  CREATE TABLE #tmpstoragefacility
            (
               storagefacilityid INT,
			   interchange       NVARCHAR(256),
			   markCode			 NVARCHAR(256),
               splc              NVARCHAR(16),
               NAME              NVARCHAR(256),
               description       NVARCHAR(512),
               lat               NVARCHAR(256),
               long              NVARCHAR(256),
               availablecars     INT,
               capacity          INT,
               city              NVARCHAR(128),
               statecode         NVARCHAR(8),
               rating            FLOAT,
               dailyrate         DECIMAL(18, 2),
               featurelist       NVARCHAR(MAX),
               effectivedate     DATETIME,
               expirydate        DATETIME,
               switchingrate     DECIMAL(18, 2),
               regionid          INT,
               featureid         NVARCHAR(MAX),
			   Interchanges		 NVARCHAR(MAX),
			   vendorid			 INT,
			   currencycode		 NVARCHAR(MAX)
            )

          INSERT INTO #tmpstoragefacility
          SELECT distinct SF.id,
				 INTER.[RailRoadName] AS Interchange,
				 INTER.MarkCode,
                 IL.splc,
                 SF.[name],
                 SF.[description],
                 SF.lat,
                 SF.long,
                 SF.availablecars,
                 SF.capacity,
                 SF.city,
                 S.code                   AS StateCode,
                 SF.rating,
                 SFR.dailystoragerate AS DailyRate,
                 Isnull(Stuff((SELECT ', ' + COALESCE(SFT.[name], '')
                               FROM   [storagefacilityfeaturemapping] SFM
                                      INNER JOIN [storagefeature] SFT
                                              ON SFT.id = SFM.storagefeatureid
                               WHERE  SFM.storagefacilityid = SF.id
                               FOR xml path(''), type).value('.[1]',
                        'NVARCHAR(MAX)'),
                        1,
                        1, ''),
                 'Not Assigned Yet')      AS FeatureList,
                 SF.effectivedate,
                 SF.expirydate,
                 SFR.switchingrate,
                 SF.regionid,
                 Isnull(Stuff((SELECT ',' + COALESCE(Trim(Str(SFT.id)), '')
                               FROM   [storagefacilityfeaturemapping] SFM
                                      INNER JOIN [storagefeature] SFT
                                              ON SFT.id = SFM.storagefeatureid
                               WHERE  SFM.storagefacilityid = SF.id
                               FOR xml path(''), type).value('.[1]',
                        'NVARCHAR(MAX)'),
                        1,
                        1, ''),
                 NULL)                    AS FeatureID,
			Isnull(Stuff((SELECT distinct ', ' + COALESCE(INTER.MarkCode, '')
                               FROM   [StorageFacilityInterchange] INTER
                                      INNER JOIN [storagefeature] SFT
                                              ON INTER.storagefacilityid = SF.id
                               WHERE  INTER.storagefacilityid = SF.id
                               FOR xml path(''), type).value('.[1]',
                        'NVARCHAR(MAX)'),
                        1,
                        1, ''),
                 'Not Assigned Yet') AS Interchanges,
				 SF.VendorId,
				 CUR.Code as CurrencyCode
          FROM   [dbo].[storagefacility] SF
                 LEFT JOIN [storagefacilityrate] SFR
                        ON SFR.storagefacilityid = SF.id 
				 LEFT JOIN [Currency] CUR
						ON  SFR.CurrencyId=CUR.Id
                 LEFT JOIN [state] S
                        ON SF.stateid = S.id
                 LEFT JOIN [StorageFacilityInterchange] INTER
                        ON INTER.storagefacilityid = SF.id
                 LEFT JOIN [StorageFacilityInterchangeLocation] IL
                        ON IL.interchangeid = INTER.id
		 WHERE SF.IsActive = 1 AND SFR.IsActive = 1 AND INTER.IsActive = 1 AND IL.IsActive = 1
	
		  SET @Query = 'Select storagefacilityid AS Id, * from (select t.*,
             row_number() over (partition by storagefacilityid order by storagefacilityid) as seqnum
      from #tmpStorageFacility t where 1=1 '++ @WhereClause + @WhereClauseFeatures + @WhereClauseDate+'
     ) t
where seqnum = 1 '--+ @WhereClause + @WhereClauseFeatures + @WhereClauseDate

          --SET @Query = 'Select distinct storagefacilityid AS Id, * from #tmpStorageFacility Where 1=1 '
          --             + @WhereClause + @WhereClauseFeatures + @WhereClauseDate
		
		  Print @Query
		  EXECUTE Sp_executesql  @Query
		  
 

      END try

      BEGIN catch
          SELECT @ERRORMESSAGE = Error_message(),
                 @ERRORSEVERITY = Error_severity(),
                 @ERRORNUMBER = Error_number(),
                 @ERRORPROCEDURE = Error_procedure(),
                 @ERRORLINE = Error_line(),
                 @ERRORSTATE = Error_state();

          SET @PARAMS = 'Parameter 1:'
                        + Cast(@isMulticityEnable AS VARCHAR(10));
          SET @MESSAGE = 'ERROR NUMBER:'
                         + Cast(@ERRORNUMBER AS VARCHAR(5))
                         + Char(13) + 'PROCEDURE NAME:' + @ERRORPROCEDURE
                         + Char(13) + 'PROCEDURE LINE:'
                         + Cast(@ERRORLINE AS VARCHAR(5)) + Char(13)
                         + 'ERROR MESSAGE:' + @ERRORMESSAGE + Char(13)
                         + 'PARAMETERS:' + @PARAMS + Char(13);

          INSERT INTO [dbo].[DB_Errors]
          VALUES      (Suser_sname(),
                       @MESSAGE,
                       Getdate());

          

          -- return the error inside the CATCH block
          RAISERROR(@MESSAGE,@ERRORSEVERITY,@ERRORSTATE);
      END catch
  END
  GO

IF NOT EXISTS(SELECT 1 FROM NotificationEvent WHERE NAME = 'OpportunityOrderPlaced')
BEGIN
INSERT INTO NotificationEvent
( [Name]
      ,[Description]
      ,[PeriodEnd]
      ,[PeriodStart]
      ,[IsActive]
      ,[CreatedTime]
      ,[CreatedBy]
      ,[ModifiedTime]
      ,[ModifiedBy]
      ,[OrganizationId]
      ,[TenantId])
VALUES
('OpportunityOrderPlaced'
      ,'OpportunityOrderPlaced'
      ,DEFAULT
      ,DEFAULT
      ,1
      ,GETDATE()
      ,1
      ,GETDATE()
      ,1
      ,0
      ,1)


	  INSERT INTO [MailConfiguration] (
	  NotificationEventId
	  ,Subject
      ,Body
      ,PeriodEnd
      ,PeriodStart
      ,IsActive
      ,CreatedTime
      ,CreatedBy
      ,ModifiedTime
      ,ModifiedBy
      ,OrganizationId
      ,TenantId)
values
(@@IDENTITY,'Your order {orderNo} has been received!', 
'<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
	<tbody>
	<tr>
		<td style="border-bottom:5px solid #709ce9; background:#1a335f">
			<span style="display:block;font-size:22px;padding:10px">
			<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>
			</span>
		</td>
	</tr>
	<tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			<br />
			{companyName}
			<br />
			Woo hoo! We’re happy to let you know that we’ve received your order.
			<br /><br />
			Your order details can be found below:
			<br />
			Order Number: {orderNo}
			<br />
			Order Date: {orderDate}
			<br /><br />
			Please find the copy of your order summary attached for your reference. You will be contacted by  Standard Rail™ team shortly.
			<br />
		</td>
	</tr>
	  <tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			If you wish to contact us regarding your order, please reach out to
			<a style="color: #0d6efd;" href="mailto:rclsupport@standardrail.com?Subject=Railcar Lounge: ">
				rclsupport@standardrail.com
			</a> <br /> <br />
		</td>
	</tr>
	<tr>
		<td>
		Thank you for placing your order!<br>
		<br /><br />  Best,<br /> 
Standard Rail™ Team
<br /> <br /> 
		<span style="color:#555555;font-weight:normal;font-family:Tahoma,Geneva,sans-serif">Railcar Lounge</span><br><br><br>
		</td>
	</tr>
    <tr bgcolor="#ffffff">
    <td style="font-family:Tahoma,Helvetica,sans-serif;border-top:1px solid #ccc;border-bottom:1px solid #ccc;color:#333333;text-align:center;font-size:14px;padding:15px 0;text-align:center">
         This is an auto generated mail. Please do not reply
      <br></td>
  </tr>
  <tr>
  	<td>
  		<br><br>
  	</td>
  </tr>
</tbody></table>',
DEFAULT,DEFAULT,1,GETDATE(),1,GETDATE(),1,0,1)
END
GO

	
IF NOT EXISTS(SELECT 1 FROM NotificationEvent WHERE NAME = 'VendorOpportunityOrderPlaced')
BEGIN

	INSERT INTO NotificationEvent
	(
		[Name],
		[Description],
		[PeriodEnd],
		[PeriodStart],
		[IsActive],
		[CreatedTime],
		[CreatedBy],
		[ModifiedTime],
		[ModifiedBy],
		[OrganizationId],
		[TenantId]
	)
	VALUES
	(
		'VendorOpportunityOrderPlaced',
		'VendorOpportunityOrderPlaced',
		DEFAULT,
		DEFAULT,
		1,
		GETDATE(),
		1,
		GETDATE(),
		1,
		0,
		1
	)

	INSERT INTO [MailConfiguration] 
	(
		NotificationEventId,
		Subject,
		Body,
		PeriodEnd,
		PeriodStart,
		IsActive,
		CreatedTime,
		CreatedBy,
		ModifiedTime,
		ModifiedBy,
		OrganizationId,
		TenantId
	)
	VALUES
	(
		@@IDENTITY,
		'You have received a booking on your storage facility', 
		'<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
			<tbody>
			<tr>
				<td style="border-bottom:5px solid #709ce9; background:#1a335f">
					<span style="display:block;font-size:22px;padding:10px">
					<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>
					</span>
				</td>
			</tr>
			<tr>
				<td style="font-family:Tahoma,Geneva,sans-serif">
					<br />
					Hello {vendorName},
					<br />
					<br />
					Woo hoo! We’re happy to let you know that you’ve received a booking on your storage facility.
					<br /><br />
					Your order details can be found below:
					<br />
					Order Number: {orderNo}
					<br />
					Order Date: {orderDate}
					<br /><br />
					Please find a copy of the customer order summary attached for your reference. A representative from Railcar Lounge™ will contact you with the storage order booking details.
					<br />
				</td>
			</tr>
			  <tr>
				<td style="font-family:Tahoma,Geneva,sans-serif">
					If you wish to contact us regarding your order, please reach out to
					<a style="color: #0d6efd;" href="mailto:rclsupport@standardrail.com?Subject=Railcar Lounge: ">
						rclsupport@standardrail.com
					</a> <br /> <br />
				</td>
			</tr>
			<tr>
				<td>
				Thank you for choosing Railcar Lounge™ for your storage facility needs!
				<br /><br />  Best Regards,<br /> 
		Railcar Lounge™ Team
		<br /> <br /> 
				</td>
			</tr>
		    <tr bgcolor="#ffffff">
		    <td style="font-family:Tahoma,Helvetica,sans-serif;border-top:1px solid #ccc;border-bottom:1px solid #ccc;color:#333333;text-align:center;font-size:14px;padding:15px 0;text-align:center">
		         This is an auto generated mail. Please do not reply
		      <br></td>
		  </tr>
		  <tr>
		  	<td>
		  		<br><br>
		  	</td>
		  </tr>
		</tbody></table>',
		DEFAULT,
		DEFAULT,
		1,
		GETDATE(),
		1,
		GETDATE(),
		1,
		0,
		1
	)

END
GO

COMMIT TRANSACTION