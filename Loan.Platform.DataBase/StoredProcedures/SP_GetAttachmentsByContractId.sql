
CREATE PROCEDURE [dbo].[SP_GetAttachmentsByContractId]  
@ContractId int  
     AS  
        BEGIN  
 select Distinct CAM.Id, CAM.Name,CAM.Path,CONCAT_WS(' ',U.FirstName, U.LastName) As CreatedBy,CAM.CreatedTime,CAM.ContractId
 from ContractAttachmentMapping CAM
  LEFT JOIN [User] U on U.Id = CAM.CreatedBy
   where CAM.ContractId = @ContractId
   ORDER BY CAM.CreatedTime DESC
   
  END  