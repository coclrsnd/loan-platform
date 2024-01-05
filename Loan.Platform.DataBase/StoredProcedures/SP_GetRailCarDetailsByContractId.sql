CREATE PROCEDURE [dbo].[SP_GetRailCarDetailsByContractId]  
@ContractId int  
AS    
BEGIN      
 SELECT   
  Distinct RC.Id, RC.CarInitial, RC.CarNumber , LE.Name as LEName, LE.Id as LEId,     
  RCT.Name as CarTypeName,RCT.Id as RailCarTypeId, CRM.BolDate,     
  CRM.ArrivalDate,CRM.DepartureDate,CRM.Fleet,CRM.Notes,CRM.LEContents,     
  CRM.Id as ContractRailCarMappingId, CRM.ContractId,CRM.CreatedTime,C.CarsStored,CRM.IsUnderStorage, C.Rider as StorageOrder, CRM.CustomerId,  
  CRM.IsHazmatCar,  
  CHRG.Id AS ChargeId,CHRG.Amount,CHRG.Title,CHRG.[Date]  
 FROM  
  RailCar RC   
 INNER JOIN   
  ContractRailCarMapping CRM   
 ON  
  RC.Id = CRM.RailCarId    
 INNER JOIN   
  Contract C   
 ON   
  CRM.ContractId = C.Id    
 LEFT JOIN  
  dbo.ContractRailCarCharges CHRG  
 ON   
  CHRG.ContractRailCarMappingId = CRM.Id  AND CHRG.IsActive=1  
 LEFT JOIN  
  LEContent LE   
 ON   
  CRM.LEId = LE.Id    
 LEFT JOIN  
  RailCarType RCT   
 ON   
  RC.RailCarTypeId = RCT.Id    
 WHERE  
  CRM.ContractId = @ContractId AND  
  RC.IsActive=1;  
       
 END