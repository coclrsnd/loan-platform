/*
Name:[sp_GetVendorDetails]
Purpose: Get full vendor details based by Id
Ref: API request from RL
*/
--drop procedure usp_CreateOrUpdateVendor
----------------------------------------------------------------------------------------
CREATE  Procedure [dbo].[usp_CreateOrUpdateVendor]
@Vendor VendorUDT readonly,
@StorageFacility StorageFacilityUDT readonly,
@StorageFacilityRates StorageFacilityRateUDT readonly,
@StorageFacilityFeatures StorageFacilityFeaturesUDT readonly,
@StorageFacilityInterchanges StorageFacilityInterchangesUDT readonly,
@StorageFacilityInterchangeLocations StorageFacilityInterchangeLocationsUDT readonly
AS
BEGIN
SET NOCOUNT ON
SET ANSI_WARNINGS OFF
SET ANSI_PADDING ON
SET ANSI_NULLS ON
SET ARITHABORT ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULL_DFLT_ON ON
SET CONCAT_NULL_YIELDS_NULL ON

--Parameters used for error handling
DECLARE @ERRORNUMBER INT,
		@ERRORMESSAGE VARCHAR(500),
		@ERRORSEVERITY INT,
		@ERRORSTATE INT,
		@ERRORLINE INT,
		@ERRORPROCEDURE VARCHAR(200),
		@PARAMS VARCHAR(500),
		@MESSAGE NVARCHAR(MAX);
BEGIN TRAN
BEGIN TRY 
	DECLARE @VendorId BIGINT
	IF EXISTS(select 1 from @vendor where id=0)
	BEGIN
	
		insert into Vendor(ContactPersonName,PrimaryContactNo,SecondaryContactNo,Organization,[Address],ZipCode,City,StateId,CountryId,RegionId,PercentageMargin,EffectiveDate,
        ExpiryDate,PrimaryContactEmail,SecondaryContactEmail,Website,[Description],CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId)
        select ContactPersonName,PrimaryContactNo,SecondaryContactNo,Organization,[Address],ZipCode,City,StateId,CountryId,RegionId,PercentageMargin,EffectiveDate,
        ExpiryDate,PrimaryContactEmail,SecondaryContactEmail,Website,[Description],CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId
        from @Vendor
        SELECT @VendorId=SCOPE_IDENTITY()
		
		insert into StorageFacility(Name,Lat,Long,Capacity,AvailableCars,Rating,Address,PrimaryContactNumber,SecondaryContactNumber,
		PrimaryEmail,SecondaryEmail,ZipCode,City,StateId,CountryId,VendorId,RegionId,EffectiveDate,ExpiryDate,SPLC,Priority,Description,Mark,
		CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId,IsTrimbleVerified)
		select Name,Lat,Long,Capacity,AvailableCars,Rating,Address,PrimaryContactNumber,SecondaryContactNumber,
		PrimaryEmail,SecondaryEmail,ZipCode,City,StateId,CountryId,@VendorId,RegionId,EffectiveDate,ExpiryDate,SPLC,Priority,Description,Mark,
		CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId,IsTrimbleVerified 
		from @StorageFacility
		
		insert into StorageFacilityRate(StorageFacilityId,CurrencyId,DailyStorageRate,SwitchIn,SwitchOut,
		SwitchingRate,SpecialSwitchingRate,HazmatSwitchInRate,HazmatSwitchOutRate,LoadedSwitchInRate,LoadedSwitchOutRate,CherryPickingRate,ReservationRate,EffectiveDate,
		ExpiryDate,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId)
		select sf.Id,sfr.CurrencyId,sfr.DailyStorageRate,sfr.SwitchIn,sfr.SwitchOut,
		sfr.SwitchingRate,sfr.SpecialSwitchingRate,sfr.HazmatSwitchInRate,sfr.HazmatSwitchOutRate,sfr.LoadedSwitchInRate,sfr.LoadedSwitchOutRate,sfr.CherryPickingRate,
		sfr.ReservationRate,sfr.EffectiveDate,sfr.ExpiryDate,sfr.CreatedTime,sfr.CreatedBy,sfr.ModifiedTime,sfr.ModifiedBy,
		sfr.OrganizationId,sfr.TenantId
		from @StorageFacilityRates sfr
		inner join StorageFacility sf on sf.Name=sfr.StorageFacilityName and VendorId=@VendorId
		
		insert into StorageFacilityFeatureMapping(StorageFacilityid,StorageFeatureId,CreatedTime,CreatedBy,ModifiedTime,
		ModifiedBy,OrganizationId,TenantId)
		select sf.Id,sff.StorageFeatureId,sff.CreatedTime,sff.CreatedBy,sff.ModifiedTime,sff.ModifiedBy,sff.OrganizationId,sff.TenantId
		from @StorageFacilityFeatures sff
		inner join StorageFacility sf on sf.Name=sff.StorageFacilityName and VendorId=@VendorId
		
		insert into StorageFacilityInterchange(StorageFacilityid,RailRoadId,RailRoadName,MarkCode,GrossRailRoadCapacity,UnitId,CreatedTime,CreatedBy,ModifiedTime,
		ModifiedBy,OrganizationId,TenantId)
		select sf.id,sfi.RailRoadId,sfi.RailRoadName,sfi.MarkCode,sfi.GrossRailRoadCapacity,sfi.UnitId,
		sfi.CreatedTime,sfi.CreatedBy,sfi.ModifiedTime,sfi.ModifiedBy,sfi.OrganizationId,sfi.TenantId from @StorageFacilityInterchanges sfi 
		inner join StorageFacility sf on sf.Name=sfi.StorageFacilityName and VendorId=@VendorId

		insert into StorageFacilityInterchangeLocation(InterchangeId,CountryId,StateId,City,SPLC,R260,FSAC,Lat,Long,Description,CreatedTime,CreatedBy,ModifiedTime,
        ModifiedBy,OrganizationId,TenantId)
        select sfi.id,sfil.CountryId, sfil.StateId,sfil.City,sfil.SPLC,sfil.R260,sfil.FSAC,sfil.Lat,sfil.long,sfil.description,
        sfi.CreatedTime,sfi.CreatedBy,sfi.ModifiedTime,sfi.ModifiedBy,sfi.OrganizationId,sfi.TenantId from @StorageFacilityInterchangeLocations sfil
        inner join StorageFacility sf on sf.Name=sfil.StorageFacilityName and VendorId=@VendorId
        inner join StorageFacilityInterchange sfi on sfi.RailRoadId=sfil.RailRoadId AND sfi.StorageFacilityId= sf.Id

		COMMIT TRAN
	end
	else
	BEGIN
		SELECT @VendorId= Id from @Vendor
		update vendor
		set ContactPersonName=vt.ContactPersonName,
		PrimaryContactNo=vt.PrimaryContactNo,
		SecondaryContactNo=vt.SecondaryContactNo,
		Organization=vt.Organization,
		[Address]=vt.[Address],
		ZipCode=vt.ZipCode,
		City=vt.City,
		StateId=vt.StateId,
		CountryId=vt.CountryId,
		RegionId=vt.RegionId,
		PercentageMargin=vt.PercentageMargin,
		EffectiveDate=vt.EffectiveDate,
		ExpiryDate=vt.ExpiryDate,
		PrimaryContactEmail=vt.PrimaryContactEmail,
		SecondaryContactEmail=vt.SecondaryContactEmail,
		Website=vt.Website,
		[Description]=vt.[Description],
		ModifiedTime=vt.ModifiedTime,
		ModifiedBy=vt.ModifiedBy,
		OrganizationId=vt.OrganizationId,
		TenantId=vt.TenantId
		from vendor
		inner join @Vendor vt on vendor.Id=vt.Id
		
		MERGE StorageFacility AS Target
		USING @StorageFacility	AS Source
		ON Source.Id = Target.Id
    
		-- For Inserts
		WHEN NOT MATCHED BY Target THEN
			insert (Name,Lat,Long,Capacity,AvailableCars,Rating,Address,PrimaryContactNumber,SecondaryContactNumber,
			PrimaryEmail,SecondaryEmail,ZipCode,City,StateId,CountryId,VendorId,RegionId,EffectiveDate,ExpiryDate,SPLC,Priority,Description,Mark,
			CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId,IsTrimbleVerified)
			values (Source.Name,Source.Lat,Source.Long,Source.Capacity,Source.AvailableCars,Source.Rating,Source.Address,Source.PrimaryContactNumber,Source.SecondaryContactNumber,
			Source.PrimaryEmail,Source.SecondaryEmail,Source.ZipCode,Source.City,Source.StateId,Source.CountryId,@VendorId,Source.RegionId,Source.EffectiveDate,Source.ExpiryDate,Source.SPLC,Source.Priority,Source.Description,Source.Mark,
			Source.CreatedTime,Source.CreatedBy,Source.ModifiedTime,Source.ModifiedBy,Source.OrganizationId,Source.TenantId,Source.IsTrimbleVerified)			
    
		-- For Updates
		WHEN MATCHED THEN UPDATE SET
			Target.Name	= Source.Name,
			Target.Lat		= Source.Lat,
			Target.Long	= Source.Long,
			Target.Capacity		= Source.Capacity,
			Target.AvailableCars	= Source.AvailableCars,
			Target.Rating		= Source.Rating,
			Target.Address	= Source.Address,
			Target.PrimaryContactNumber		= Source.PrimaryContactNumber,
			Target.SecondaryContactNumber	= Source.SecondaryContactNumber,
			Target.PrimaryEmail		= Source.PrimaryEmail,
			Target.SecondaryEmail	= Source.SecondaryEmail,
			Target.ZipCode		= Source.ZipCode,
			Target.City	= Source.City,
			Target.StateId		= Source.StateId,
			Target.CountryId	= Source.CountryId,
			Target.VendorId		= @VendorId,
			Target.RegionId	= Source.RegionId,
			Target.EffectiveDate		= Source.EffectiveDate,
			Target.ExpiryDate	= Source.ExpiryDate,
			Target.SPLC		= Source.SPLC,
			Target.Priority	= Source.Priority,
			Target.Description		= Source.Description,
			Target.Mark = Source.Mark,
			Target.ModifiedTime	= Source.ModifiedTime,
			Target.ModifiedBy		= Source.ModifiedBy,
			Target.OrganizationId	= Source.OrganizationId,
			Target.TenantId		= Source.TenantId,
			Target.IsTrimbleVerified = Source.IsTrimbleVerified;
			
		MERGE StorageFacilityRate AS Target
		USING (select sfr.*,sf.id as sfId from @StorageFacilityRates sfr
		inner join StorageFacility sf on sf.Name=sfr.StorageFacilityName and VendorId=@VendorId) AS Source
		ON Source.Id = Target.Id

		-- For Inserts
		WHEN NOT MATCHED BY Target THEN
			insert (StorageFacilityId,CurrencyId,DailyStorageRate,SwitchIn,SwitchOut,
				SwitchingRate,SpecialSwitchingRate,HazmatSwitchInRate,HazmatSwitchOutRate,LoadedSwitchInRate,LoadedSwitchOutRate,CherryPickingRate,ReservationRate,EffectiveDate,
				ExpiryDate,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId,IsActive)
			values ( Source.sfId,Source.CurrencyId,Source.DailyStorageRate,Source.SwitchIn,Source.SwitchOut,
				Source.SwitchingRate,Source.SpecialSwitchingRate,Source.HazmatSwitchInRate,Source.HazmatSwitchOutRate,Source.LoadedSwitchInRate,Source.LoadedSwitchOutRate,
				Source.CherryPickingRate,Source.ReservationRate,Source.EffectiveDate,
				Source.ExpiryDate,Source.CreatedTime,Source.CreatedBy,Source.ModifiedTime,Source.ModifiedBy,Source.OrganizationId,Source.TenantId,Source.IsActive)		

		--For Updates
		WHEN MATCHED THEN UPDATE SET
			Target.CurrencyId	= Source.CurrencyId,
			Target.DailyStorageRate	= Source.DailyStorageRate,
			Target.SwitchIn	= Source.SwitchIn,
			Target.SwitchOut		= Source.SwitchOut,
			Target.SwitchingRate	= Source.SwitchingRate,
			Target.SpecialSwitchingRate		= Source.SpecialSwitchingRate,
			Target.HazmatSwitchInRate	= Source.HazmatSwitchInRate,
			Target.HazmatSwitchOutRate		= Source.HazmatSwitchOutRate,
			Target.LoadedSwitchInRate	= Source.LoadedSwitchInRate,
			Target.LoadedSwitchOutRate		= Source.LoadedSwitchOutRate,
			Target.CherryPickingRate	= Source.CherryPickingRate,
			Target.ReservationRate		= Source.ReservationRate,
			Target.EffectiveDate	= Source.EffectiveDate,
			Target.ExpiryDate		= Source.ExpiryDate,
			Target.ModifiedTime	= Source.ModifiedTime,
			Target.ModifiedBy		= Source.ModifiedBy,
			Target.OrganizationId	= Source.OrganizationId,
			Target.TenantId		= Source.TenantId,
			Target.IsActive=Source.IsActive;    
			 
				
		MERGE StorageFacilityFeatureMapping AS Target
		USING (select sff.*,sf.id as sfId from @StorageFacilityFeatures sff
		inner join StorageFacility sf on sf.Name=sff.StorageFacilityName and VendorId=@VendorId)	AS Source
		ON Source.StorageFacilityId = Target.StorageFacilityId and Source.StorageFeatureId = Target.StorageFeatureId
    
		-- For Inserts
		WHEN NOT MATCHED BY Target THEN
			insert (StorageFacilityid,StorageFeatureId,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId,IsActive)
			values ( source.SfId,source.StorageFeatureId,source.CreatedTime,source.CreatedBy,source.ModifiedTime,source.ModifiedBy,source.OrganizationId,source.TenantId,Source.IsActive)
			-- For Updates
			WHEN MATCHED THEN UPDATE SET
				Target.StorageFeatureId	= Source.StorageFeatureId,				
				Target.ModifiedTime	= Source.ModifiedTime,
				Target.ModifiedBy		= Source.ModifiedBy,
				Target.OrganizationId	= Source.OrganizationId,
				Target.TenantId		= Source.TenantId,
				Target.IsActive = Source.IsActive;

		 MERGE StorageFacilityInterchange AS TARGET
         USING (select sfi.*,sf.id as sfId from @StorageFacilityInterchanges sfi
         inner join StorageFacility sf on sf.Name=sfi.StorageFacilityName
		 WHERE VendorId=@VendorId)  AS Source
         ON Source.Id= Target.Id --Source.StorageFacilityId = Target.StorageFacilityId and Source.RailRoadName = Target.RailRoadName  and Source.Id= Target.Id
    
        -- For Inserts
         WHEN NOT MATCHED BY Target THEN
         insert (StorageFacilityid,RailRoadId,RailRoadName,MarkCode,GrossRailRoadCapacity,UnitId,CreatedTime,CreatedBy,ModifiedTime,
                  ModifiedBy,OrganizationId,TenantId,IsActive)
         values ( source.SfId,source.RailRoadId,source.RailRoadName,source.MarkCode,source.GrossRailRoadCapacity,source.UnitId,
                  source.CreatedTime,source.CreatedBy,source.ModifiedTime,source.ModifiedBy,source.OrganizationId,source.TenantId,Source.IsActive)
        
		-- For Updates
        WHEN MATCHED THEN UPDATE SET
           Target.RailRoadId = Source.RailRoadId,      
           Target.RailRoadName = Source.RailRoadName,
           Target.MarkCode = Source.MarkCode,
           Target.GrossRailRoadCapacity = Source.GrossRailRoadCapacity,
		   Target.UnitId = Source.UnitId,
           Target.ModifiedTime = Source.ModifiedTime,
           Target.ModifiedBy = Source.ModifiedBy,
           Target.OrganizationId = Source.OrganizationId,
           Target.TenantId = Source.TenantId,
		   Target.IsActive = Source.IsActive;

       MERGE StorageFacilityInterchangeLocation AS Target
       USING (select sfil.*,sfi.id as sfiId from @StorageFacilityInterchangeLocations sfil                 
          inner join StorageFacilityInterchange sfi on sfi.RailRoadId=sfil.RailRoadId  and sfi.IsActive=1
       inner join StorageFacility sf on sf.id=sfi.StorageFacilityid and sf.[Name] = sfil.StorageFacilityName  and sf.IsActive=1
	   WHERE sf.VendorId=@VendorId)  AS Source
       ON  Source.Id= Target.Id --Source.InterchangeId = Target.InterchangeId and Source.Id= Target.Id --and Source.SPLC = Target.SPLC  and Source.Id= Target.Id
    
       -- For Inserts
       WHEN NOT MATCHED BY Target THEN
       insert (InterchangeId,CountryId,StateId,City,SPLC,Lat,Long,Description,R260,FSAC,CreatedTime,CreatedBy,ModifiedTime,
       ModifiedBy,OrganizationId,TenantId,IsActive)
       values (source.SfiId,source.CountryId,source.StateId,source.City,source.SPLC,source.Lat,source.Long,source.Description,source.R260,source.FSAC,
              source.CreatedTime,source.CreatedBy,source.ModifiedTime,source.ModifiedBy,source.OrganizationId,source.TenantId,Source.IsActive)
      
	  -- For Updates
      WHEN MATCHED THEN UPDATE SET
          Target.CountryId = Source.CountryId,        
          Target.StateId = Source.StateId,
          Target.City = Source.City,
          Target.SPLC = Source.SPLC,
          Target.Lat = Source.Lat,
          Target.Long = Source.Long,
          Target.Description = Source.Description,
		  Target.R260 = Source.R260,
		  Target.FSAC = Source.FSAC,
          Target.ModifiedTime = Source.ModifiedTime,
          Target.ModifiedBy = Source.ModifiedBy,
          Target.OrganizationId = Source.OrganizationId,
          Target.TenantId = Source.TenantId,
		  Target.IsActive = Source.IsActive;
		COMMIT TRAN
	END	
END TRY
	BEGIN CATCH
		  ROLLBACK TRAN
		  SELECT 
			@ERRORMESSAGE = ERROR_MESSAGE(), 
			@ERRORSEVERITY = ERROR_SEVERITY(),
			@ERRORNUMBER = ERROR_NUMBER(),
			@ERRORPROCEDURE = ERROR_PROCEDURE(),
			@ERRORLINE = ERROR_LINE(),
			@ERRORSTATE = ERROR_STATE();

			 SET @PARAMS = 'Parameter 1:'+ CAST(@vendorId AS varchar(10));
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