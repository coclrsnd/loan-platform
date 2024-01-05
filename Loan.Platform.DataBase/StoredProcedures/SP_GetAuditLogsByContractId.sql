CREATE PROCEDURE [dbo].[SP_GetAuditLogsByContractId]  
@ContractId int  
     AS  
        BEGIN  
 SELECT Distinct AL.Id, AL.LogMessage As Description,AL.CreatedTime,CONCAT_WS(' ',U.FirstName, U.LastName) As CreatedBy,ALE.Name AS Action
 FROM AuditLogs AL
 INNER JOIN AuditLogEvent ALE on AL.EventId = ALE.Id
 LEFT JOIN [User] U on U.Id = AL.CreatedBy
   WHERE AL.EntityId = @ContractId
   ORDER BY AL.CreatedTime DESC
  END  
GO


