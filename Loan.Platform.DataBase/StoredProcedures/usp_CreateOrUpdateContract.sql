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
				UDTCR.SwitchIn=CR.SwitchIn AND
				UDTCR.SwitchOut=CR.SwitchOut AND
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

