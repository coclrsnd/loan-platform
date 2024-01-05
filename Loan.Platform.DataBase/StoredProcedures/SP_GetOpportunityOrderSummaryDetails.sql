CREATE OR ALTER PROCEDURE [dbo].[SP_GetOpportunityOrderSummaryDetails]
@OpportunityId BIGINT
AS
BEGIN
	
	Declare @StorageFacilityId BIGINT;
	SELECT @StorageFacilityId = FacilityId FROM Opportunity WHERE id = @OpportunityId

	SELECT TOP(1) SF.Name,SFI.MarkCode
		FROM StorageFacility SF 
			INNER JOIN StorageFacilityInterchange SFI ON SF.Id=SFI.StorageFacilityId 
		WHERE SF.Id = @StorageFacilityId
	
	SELECT ReservedSpaces, ExpirationDate, EffectiveDate
		FROM OpportunityReservedSpaces 
		WHERE OpportunityId=@OpportunityId

END