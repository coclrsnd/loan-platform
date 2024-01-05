BEGIN TRANSACTION


PRINT 'DROP PROCEDURE [dbo].[usp_CreateOrUpdateContract]';
GO

DROP PROCEDURE [dbo].[usp_CreateOrUpdateContract];
GO


PRINT 'DROP TYPE [dbo].[ContractUDT]';
GO

DROP TYPE [dbo].[ContractUDT];
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
	[IsActive] [bit] NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL
)
GO


PRINT 'DROP TYPE [dbo].[ContractRateUDT]';
GO

DROP TYPE [dbo].[ContractRateUDT];
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
[TenantId] [bigint] NOT NULL

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
		UDTCR.OrganizationId,UDTCR.TenantId 
	INTO #ContractRateDetails 
	FROM @ContractRate UDTCR 
	LEFT JOIN dbo.ContractRate CR on UDTCR.Id=CR.Id AND
              UDTCR.ContractId=CR.ContractId AND 
			  UDTCR.RateTypeId=CR.RateTypeId AND
              UDTCR.SwitchIn=CR.SwitchIn AND
              UDTCR.SwitchOut=CR.SwitchOut AND
              ISNULL(UDTCR.SpecialSwitchingRate ,0) = ISNULL(CR.SpecialSwitchingRate,0) AND
              UDTCR.DailyStorageRate=CR.DailyStorageRate AND
              ISNULL(UDTCR.SwitchingRate ,0) = ISNULL(CR.SwitchingRate ,0) AND
              UDTCR.HazmatSurcharge=CR.HazmatSurcharge AND
              UDTCR.LoadedSurcharge=CR.LoadedSurcharge AND
              UDTCR.ReservationRate=CR.ReservationRate AND
              UDTCR.CherryPickingRate=CR.CherryPickingRate AND
             (ISNULL(UDTCR.BookingFee ,0) = ISNULL(CR.BookingFee ,0) OR @CurrentRole='vendor') AND
              (ISNULL(UDTCR.ListingFee ,0) = ISNULL(CR.ListingFee  ,0) OR @currentRole='customer')AND 
			  UDTCR.IsActive=1  where CR.Id IS NULL  ; 


	DECLARE @ContractId BIGINT;

	IF NOT EXISTS(SELECT 1 FROM  @Contract UDTCR INNER JOIN Contract CR ON UDTCR.Id = CR.Id)
	BEGIN
		-- SAVE CONTRACT DETAIL
	    INSERT INTO dbo.[Contract] (VendorId,CustomerId,Rider,StorageFacilityId,EffectiveDate,ExpiryDate,ContractTypeId,
									TotalCars,ReservedSpaces,CurrencyId,[Description],[Location],CarsStored,
									IsFlatRateContract,IsActive,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,
									OrganizationId,TenantId)
		SELECT VendorId,CustomerId,Rider,StorageFacilityId,EffectiveDate,ExpiryDate,ContractTypeId,TotalCars,ReservedSpaces,
				CurrencyId,[Description],[Location],CarsStored,IsFlatRateContract,IsActive,CreatedTime,CreatedBy,
				ModifiedTime,ModifiedBy,OrganizationId,TenantId
        FROM @Contract

        SELECT @ContractId=SCOPE_IDENTITY();

	

		-- SAVE CONTRACT RATE DETAIL
		INSERT INTO dbo.[ContractRate] (ContractId,RateTypeId,SwitchIn,SwitchOut,SpecialSwitchingRate,DailyStorageRate,
										SwitchingRate,HazmatSurcharge,LoadedSurcharge,ReservationRate,CherryPickingRate,
										BookingFee,ListingFee,IsActive,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,
										TenantId)
		SELECT @ContractId,RateTypeId,SwitchIn,SwitchOut,SpecialSwitchingRate,DailyStorageRate,SwitchingRate,HazmatSurcharge,
				LoadedSurcharge,ReservationRate,CherryPickingRate,BookingFee,ListingFee,IsActive,CreatedTime,CreatedBy,
				ModifiedTime,ModifiedBy,OrganizationId,TenantId
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

		SET @ContractId  = (SELECT Id FROM @Contract)

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
										OrganizationId,TenantId)
			SELECT ContractId,RateTypeId,SwitchIn,SwitchOut,SpecialSwitchingRate,DailyStorageRate,SwitchingRate,HazmatSurcharge,
							LoadedSurcharge,ReservationRate,CherryPickingRate,BookingFee,ListingFee,IsActive,CreatedTime,
							CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId
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
			USING @ContractSFFeatureMapping	AS Source
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
  --  VALUES  (SUSER_SNAME(), @MESSAGE, GETDATE());

		-- return the error inside the CATCH block
		RAISERROR(@MESSAGE, @ERRORSEVERITY, @ERRORSTATE);
	END CATCH
END

GO

PRINT 'ALTER PROCEDURE [dbo].[SP_GetStorageOrderDetailsById]';
GO

ALTER PROCEDURE [dbo].[SP_GetStorageOrderDetailsById]  
@Id INT,
@CurrentRole  NVARCHAR(MAX)
AS  
BEGIN    
	DECLARE @CARSSTORED INT = 0;
    
	SELECT 
		@CARSSTORED =  COUNT(ISNULL(CRCM.Id,0)) 
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
		AND CONVERT(VARCHAR(10),CONVERT(DATE,C.ExpiryDate)) >= CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE()))
    
	UPDATE Contract SET CarsStored=@CARSSTORED WHERE Id = @Id
     
    SELECT   
        Distinct C.id,    
        C.Rider,V.Organization as VendorName,V.Id as VendorId,   
        SF.[Name] as StorgeFacilityName, SF.Id as StorgeFacilityId,  
        C.EffectiveDate ,C.ExpiryDate as ExpiryDate ,C.TotalCars,    
         C.CarsStored, C.[Location],Cu.Id as CustomerId, CusOrg.Name as CustomerName,   
        CT.Id as ContractTypeId, CT.[Name] as ContractTypeName,   
        Cur.Id as CurrencyId, Cur.Name as CurrencyName, C.CreatedTime,
		C.IsFlatRateContract, C.ReservedSpaces,C.[Description]
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
        CurrencyId,CurrencyName,CreatedTime, IsFlatRateContract, ReservedSpaces,[Description]
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
		CASE
			WHEN @CurrentRole='vendor' THEN 0
			ELSE CNRT.BookingFee
		END AS BookingFee,
		CASE
			WHEN @CurrentRole='customer' THEN 0
			ELSE CNRT.ListingFee
		END AS ListingFee,
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
		SFF.Id as StorageFeatureId,SFF.Name as StorageFeatureName    
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

PRINT 'DROP Constraint DF_Contract_IsAdvancedSwitchingRatesEnabled in [dbo].[Contract] table';
GO

ALTER TABLE [dbo].[Contract]
DROP CONSTRAINT DF_Contract_IsAdvancedSwitchingRatesEnabled;

PRINT 'DROP Constraint DF_ContractRate_IsAdvancedHazmatSwitchingEnabled,DF_ContractRate_IsAdvancedLoadedSwitchingEnabled in [dbo].[ContractRate] table';
GO

ALTER TABLE [dbo].[ContractRate]
DROP CONSTRAINT DF_ContractRate_IsAdvancedHazmatSwitchingEnabled,DF_ContractRate_IsAdvancedLoadedSwitchingEnabled;

PRINT 'ALTER TABLE [dbo].[Contract]';
GO

ALTER TABLE [dbo].[Contract]
DROP COLUMN 
IsAdvancedSwitchingRatesEnabled
GO

PRINT 'ALTER TABLE [dbo].[ContractRate]';
GO

ALTER TABLE [dbo].[ContractRate]
DROP COLUMN 
IsAdvancedHazmatSwitchingEnabled,
IsAdvancedLoadedSwitchingEnabled,
HazmatSwitchIn,
HazmatSwitchOut,
LoadedSwitchIn,
LoadedSwitchOut
GO

COMMIT TRANSACTION