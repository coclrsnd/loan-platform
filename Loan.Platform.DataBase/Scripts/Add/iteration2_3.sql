BEGIN TRANSACTION
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_CreateOrUpdateOpportunity]
	@Opportunity OpportunityUDT READONLY,
	@OpportunityRailcarDetails OpportunityRailcarDetailsUDT READONLY,
	@OpportunityAttachments OpportunityAttachmentsUDT READONLY
AS
BEGIN
	DECLARE @OpportunityName VARCHAR(100);	
	DECLARE @VendorId BIGINT;
	DECLARE @CustomerId BIGINT;
	DECLARE @Count BIGINT;

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

			SELECT @VendorId=VendorId, @CustomerId=CustomerId FROM @Opportunity
			SELECT @VendorName=org.[Name] FROM Organization org INNER JOIN Vendor ven ON org.Id=ven.OrganizationId WHERE ven.Id=@VendorId
			SELECT @CustomerName=org.[Name] FROM Organization org INNER JOIN Customers cust ON org.Id=cust.OrganizationId WHERE cust.Id=@CustomerId
			
			SET @OpportunityName= @VendorName + ' - ' + @CustomerName + ' - '+CAST(DATEPART(YYYY,GETDATE()) AS VARCHAR)+ ' - INPROCESS';
	
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
			SELECT @VendorId=VendorId, @CustomerId=CustomerId FROM @Opportunity
			SELECT @Count=COUNT(*) FROM Opportunity WHERE VendorId=@VendorId AND CustomerId=@CustomerId AND BookingStatus=3 AND YEAR(CreatedTime)=YEAR(GETDATE())			

			IF @BookingStatusId = 3
			BEGIN 		
				SET @OpportunityName= REPLACE(@OpportunityName,'INPROCESS',CAST(@Count + 1 AS varchar)+' - SUBMITTED')
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

CREATE OR ALTER PROCEDURE [dbo].[SP_GetOpportunityDetailsById]
@OpportunityId BIGINT
AS
BEGIN
		--Counting TotalNoApproxSpaces and TotalNoReservedSpaces
		DECLARE @TotalNoApproxSpaces BIGINT
		DECLARE @TotalNoReservedSpaces BIGINT
		SELECT @TotalNoApproxSpaces=SUM(ExpectedNumberOfCars) OVER()  FROM OpportunityRailcarDetails WHERE OpportunityID=@OpportunityId AND IsActive=1
		SELECT @TotalNoReservedSpaces=SUM(ReservedSpaces) OVER()  FROM OpportunityReservedSpaces WHERE OpportunityID=@OpportunityId AND IsActive=1
		
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
			@TotalNoApproxSpaces AS TotalNoApproxSpaces,
			@TotalNoReservedSpaces AS TotalNoReservedSpaces,
			OrganizationId
		FROM 
			Opportunity OP
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

COMMIT TRANSACTION