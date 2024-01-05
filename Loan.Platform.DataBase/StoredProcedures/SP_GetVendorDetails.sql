/*--------------- Stored Procedure execution---------------*/
-- EXEC [dbo].[SP_GetVendorDetails] 1
/*---------------------------------------------------------*/
/*
Name:[sp_GetVendorDetails]
Purpose: Get full vendor details based by Id
Ref: API request from RL
*/
CREATE PROCEDURE [dbo].[SP_GetVendorDetails]
@vendorId BIGINT
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
BEGIN TRY 

		/* Vendor Detail. */
		SELECT 
			VD.Id, VD.ContactPersonName,PrimaryContactNo,SecondaryContactNo,ORG.[Name] AS Organization,ZipCode,City,
			StateId,CountryId,EffectiveDate,
			ExpiryDate,PrimaryContactEmail,SecondaryContactEmail,Website,VD.[Description],VD.CreatedTime,VD.CreatedBy,
			VD.ModifiedTime,VD.ModifiedBy,OrganizationId,VD.TenantId,VD.[Address],VD.PercentageMargin,VD.RegionId
		FROM 
			Vendor VD
		INNER JOIN
			Organization ORG
		ON
			ORG.ID=VD.OrganizationId
		WHERE 
			VD.Id=@vendorId and 
			VD.IsActive=1;
		
		/* Storage Facility Detail. */
		SELECT
			Id, [Name],Lat,Long,Capacity,AvailableCars,Rating,[Address],PrimaryContactNumber,SecondaryContactNumber,
			PrimaryEmail,SecondaryEmail,ZipCode,City,StateId,CountryId,VendorId,RegionId,EffectiveDate,ExpiryDate,SPLC,[Priority],[Description],[Mark],
			CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId
		FROM
			StorageFacility 
		WHERE
			VendorId=@vendorId AND 
			IsActive=1;

		/* Storage Facility Rate Detail. */
		SELECT 
			SFRTE.Id,sf.Id as StorageFacilityId,SFRTE.CurrencyId,SFRTE.DailyStorageRate,SFRTE.SwitchIn,SFRTE.SwitchOut,
			SFRTE.SwitchingRate,SFRTE.SpecialSwitchingRate,SFRTE.CherryPickingRate,
			SFRTE.ReservationRate,SFRTE.EffectiveDate,SFRTE.ExpiryDate,SFRTE.CreatedTime,SFRTE.CreatedBy,SFRTE.ModifiedTime,SFRTE.ModifiedBy,
			SFRTE.OrganizationId,SFRTE.TenantId,SFRTE.HazmatSwitchInRate,SFRTE.HazmatSwitchOutRate,SFRTE.LoadedSwitchInRate,SFRTE.LoadedSwitchOutRate
		FROM
			StorageFacility AS SF
		INNER JOIN
			StorageFacilityRate AS SFRTE on SFRTE.StorageFacilityId=SF.Id
		WHERE
			SF.VendorId=@vendorId AND 
			SF.IsActive=1 AND 
			SFRTE.IsActive=1;

		/* Storage Features Detail */
		SELECT 
			SF.Id,SFF.StorageFeatureId,SFF.StorageFacilityid,SFF.CreatedTime,SFF.CreatedBy,SFF.ModifiedTime,SFF.ModifiedBy,
			SFF.OrganizationId,SFF.TenantId
		FROM
			StorageFacilityFeatureMapping AS SFF
		INNER JOIN
			StorageFacility AS SF 
		ON
			SF.Id=SFF.StoragefacilityId
		WHERE
			SF.VendorId=@VendorId AND 
			SF.IsActive=1 AND 
			SFF.IsActive=1;

		/* Storage Facility Interchange */
		SELECT 
			SFI.Id as InterChangeId,SF.Id as StorageFacilityId,SFI.RailRoadId,SFI.RailRoadName,SFI.MarkCode,SFI.GrossRailRoadCapacity,
			SFI.CreatedTime,SFI.CreatedBy,SFI.ModifiedTime,SFI.ModifiedBy,SFI.OrganizationId,SFI.TenantId,SFI.StorageFacilityId,SFI.UnitId
		FROM 
			StorageFacilityInterchange AS SFI
		INNER JOIN
			StorageFacility AS SF 
		ON 
			SF.Id=SFI.StorageFacilityId 
		WHERE
			SF.VendorId=@VendorId AND
			SFI.IsActive=1 AND
			SF.IsActive=1;

		/* Storage Facility Interchange Location */
        SELECT 
			SFINTCH.Id AS InterchangeId,SFINTLOC.CountryId, SFINTLOC.StateId,SFINTLOC.City,SFINTLOC.SPLC,SFINTLOC.Lat,SFINTLOC.Long,SFINTLOC.[Description],
			SFINTLOC.R260,SFINTLOC.FSAC,
			SFINTCH.CreatedTime,SFINTCH.CreatedBy,SFINTCH.ModifiedTime,SFINTCH.ModifiedBy,SFINTCH.OrganizationId,SFINTCH.TenantId,
			SFINTCH.StorageFacilityId,SFINTCH.RailRoadId,SFINTLOC.Id
		FROM 
			StorageFacilityInterchangeLocation AS SFINTLOC
		INNER JOIN 
			StorageFacilityInterchange SFINTCH 
		ON 
			SFINTLOC.InterchangeId=SFINTCH.Id AND SFINTCH.RailRoadId=SFINTCH.RailRoadId
        INNER JOIN 
			StorageFacility SF 
		ON 
			SF.Id=SFINTCH.StorageFacilityId 
		WHERE
			SF.VendorId=@VendorId AND
			SFINTLOC.IsActive=1 AND
			SFINTCH.IsActive=1 AND
			SF.IsActive=1;
			
	
END TRY
	BEGIN CATCH
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