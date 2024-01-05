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