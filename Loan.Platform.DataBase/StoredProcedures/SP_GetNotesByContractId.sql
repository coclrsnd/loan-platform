
CREATE PROCEDURE [dbo].[SP_GetNotesByContractId]  
@ContractId int  
     AS  
        BEGIN  
 select Distinct CNM.Id, CNM.Description,CNM.CreatedTime,CONCAT_WS(' ',U.FirstName, U.LastName) As CreatedBy,CNM.ContractId
 from ContractNoteMapping CNM
 LEFT JOIN [User] U on U.Id = CNM.CreatedBy
   where CNM.ContractId = @ContractId
   
  END  