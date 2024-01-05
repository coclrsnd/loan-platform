CREATE PROCEDURE [dbo].[SP_GetStorageOrderDetails]  
 @CustomerId NVARCHAR(100) = null,
 @VendorId NVARCHAR(100) = null,   
 @StorageFacilityId NVARCHAR(100)=null,  
 @Rider NVARCHAR(100)=NULL,  
 @EffectiveDate NVARCHAR(100)=null,  
 @ExpiryDate NVARCHAR(100)=null, 
 @CurrencyId SMALLINT = null,  
 @SwitchInMin DECIMAL =null,  
 @SwitchInMax DECIMAL =null,  
 @SwitchOutMin DECIMAL =null,  
 @SwitchOutMax DECIMAL =null,  
 @StorageFeatureIds NVARCHAR(100) = null , 
 @CurrentRole NVARCHAR(100) = null,
 @OrganizationId BIGINT=null
AS  
BEGIN  
   SET NOCOUNT ON;    
     
   DECLARE @SQL NVARCHAR(MAX) = N''  
   DECLARE @Where NVARCHAR(MAX) = N' WHERE 1=1 '
   DECLARE @Select NVARCHAR(MAX) = N''
   DECLARE @StorageOrderRibbonSelect NVARCHAR(MAX) = N'' 
   DECLARE @ActiveStorageOrderCheck NVARCHAR(MAX) = N'' 
   DECLARE @ContractRateCondition NVARCHAR(MAX) = N''
			IF @CustomerId <> '0'  
            Begin  
             SET @Where = @Where + ' AND C.CustomerId =' + CAST(@CustomerId AS NVARCHAR(10))   
            End

            IF @VendorId <> '0' 
            Begin  
             SET @Where = @Where + ' AND V.Id =' + CAST(@VendorId AS NVARCHAR(10))   
            End  
  
           IF @StorageFacilityId <> '0'            
            Begin  
                SET @Where = @Where + ' AND ' + 'SF.Id =' + CAST(@StorageFacilityId AS NVARCHAR(10))        
            End  
   
  
			IF @Rider IS NOT NULL   
            Begin  
                SET @Where = @Where + ' AND ' + 'C.Rider LIKE ''%' + @Rider + '%'''          
            End  
  
  
			IF @EffectiveDate IS NOT NULL   
            Begin  
                SET @Where = @Where + ' AND ' + 'convert(VARCHAR(10),Convert(DATE,C.EffectiveDate)) >= ''' + convert(VARCHAR(10),Convert(DATE,@EffectiveDate)) + ''''      
            End  
  
			IF @ExpiryDate IS NOT NULL  
            Begin  
                SET @Where = @Where + ' AND ' + 'convert(VARCHAR(10),Convert(DATE,C.ExpiryDate)) <= ''' + convert(VARCHAR(10),Convert(DATE,@ExpiryDate)) + ''''      
            End    
  
       
  
			IF @CurrencyId IS NOT NULL AND @CurrencyId  <> '0'
            Begin  
                SET @Where = @Where + ' AND ' + 'C.CurrencyId = ' + CAST(@CurrencyId AS NVARCHAR(10))  
            End   
  
			IF @SwitchInMin IS NOT NULL    
            Begin  
                SET @Where = @Where + ' AND ' + 'CR.SwitchIn >= ' + CAST(@SwitchInMin AS NVARCHAR(10))  
            End   
  
			IF @SwitchInMax IS NOT NULL AND @SwitchInMax <> '0' 
            Begin  
                SET @Where = @Where + ' AND ' + 'CR.SwitchIn <= ' + CAST(@SwitchInMax AS NVARCHAR(10))  
            End  
  
			IF @SwitchOutMin IS NOT NULL  
            Begin  
                SET @Where = @Where + ' AND ' + 'CR.SwitchOut >= ' + CAST(@SwitchOutMin AS NVARCHAR(10))  
            End  
  
			IF @SwitchOutMax IS NOT NULL AND @SwitchOutMax <> '0'  
            Begin  
                SET @Where = @Where + ' AND ' + 'CR.SwitchOut <= ' + CAST(@SwitchOutMax AS NVARCHAR(10))  
            End 

			--IF @StorageFeatureIds IS NOT NULL  
            --Begin  
            --    SET @Where = @Where + ' AND ' + 'CSFM.StorageFeatureId in  (' + @StorageFeatureIds + ')'  
            --End

			IF @CurrentRole  like '%vendor%'
            BEGIN
				SET @ContractRateCondition = ' AND ((C.IsFlatRateContract = 1 AND CR.RateTypeId = 2) OR (C.IsFlatRateContract = 0 AND CR.RateTypeId = 3)) '
            END
            ELSE
            BEGIN
				SET @ContractRateCondition = ' AND ((C.IsFlatRateContract = 1 AND CR.RateTypeId = 1) OR (C.IsFlatRateContract = 0 AND CR.RateTypeId = 3)) '
            END
			
   SET @ActiveStorageOrderCheck = ' CONVERT(VARCHAR(10),CONVERT(DATE,C.EffectiveDate))<=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) AND CONVERT(VARCHAR(10),CONVERT(DATE,C.ExpiryDate))>=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) '

   IF @StorageFeatureIds IS NOT NULL
	BEGIN
		SET @SELECT = 'DECLARE @FeatureContracts Table (ContractId bigint)
		Insert INTO @FeatureContracts
			SELECT 
				DISTINCT ContractId 
			FROM 
				ContractSFFeatureMapping CSFM
			INNER JOIN 
				fn_SplitStringToTable('''+@StorageFeatureIds+''','','') SPLT 
			ON
				SPLT.SplittedVal=CSFM.StorageFeatureId AND IsActive=1'
	END

   SET @Select = @Select + '  
             SELECT 
				DISTINCT C.id, O.Name AS CustomerName,
				C.Rider,V.Organization AS VendorName, SF.Name AS StorgeFacilityName,
				C.EffectiveDate ,C.ExpiryDate AS ExpiryDate ,C.TotalCars,  
				''N'' AS Hazmat,CR.SwitchIn,CR.SwitchOut  
			FROM 
				Contract C  
			LEFT JOIN 
				ContractRate CR 
			ON
				CR.ContractId=C.Id AND CR.IsActive=1'+@ContractRateCondition+ '
			INNER JOIN 
				vendor V 
			ON 
				C.VendorId = V.Id '

   IF @StorageFeatureIds IS NOT NULL
	BEGIN
		SET @Select = @Select + ' inner join @FeatureContracts FC on FC.ContractId = C.Id'
		--SET @Where = @Where + ' AND ' + 'c.Id  IN (SELECT DISTINCT ContractId FROM ContractSFFeatureMapping WHERE StorageFeatureId IN (SELECT SplittedVal from fn_SplitStringToTable('''+@StorageFeatureIds+''','','')) AND IsActive=1)' 				
	END

   SET @StorageOrderRibbonSelect = ' 
  SELECT CR.DailyStorageRate AS DailyStorageRate,C.Id AS ContractId,C.CarsStored AS CarsStored
   ,CASE WHEN '+@ActiveStorageOrderCheck+' THEN 1 ELSE 0 END AS Active, 
  CASE WHEN '+@ActiveStorageOrderCheck+' THEN TotalCars ELSE 0 END AS  TotalCars,
  SUM(
									CASE 
									WHEN
									(DATEDIFF(day, CRCM.ArrivalDate,
									CASE
										WHEN (CRCM.DepartureDate  IS NOT NULL) THEN CRCM.DepartureDate
									ELSE GETDATE() END)) >=0 THEN 
									(ISNULL((DATEDIFF(day, CRCM.ArrivalDate,
									CASE
										WHEN (CRCM.DepartureDate  IS NOT NULL) THEN CRCM.DepartureDate
									ELSE GETDATE() END)+1) *CR.DailyStorageRate,0)) ELSE 0 END) AS TotalAmount,
									SUM(
									CASE WHEN DATEDIFF(day, (CRCM.ArrivalDate),
									CASE
										WHEN ((CRCM.DepartureDate)  IS NOT NULL) THEN (CRCM.DepartureDate)
									ELSE GETDATE() END)>=0 THEN 1 ELSE 0 END) AS AvailableCars
                                    ,SUM(
									CASE WHEN DATEDIFF(day, (CRCM.ArrivalDate),
									CASE
										WHEN ((CRCM.DepartureDate)  IS NOT NULL) THEN (CRCM.DepartureDate)
									ELSE GETDATE() END)>=0 THEN 1 ELSE 0 END) *CR.DailyStorageRate*DAY(EOMONTH(GETDATE()))  AS AVGMonthly,
   CASE WHEN CONVERT(VARCHAR(10),CONVERT(DATE,C.EffectiveDate)) < CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) AND CONVERT(VARCHAR(10),CONVERT(DATE,C.ExpiryDate)) < CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) THEN 1 ELSE 0 END AS ExpiredOrders
   FROM Contract C LEFT JOIN ContractRate CR ON CR.ContractId = C.Id AND CR.IsActive=1 ' 
   
   IF @CurrentRole  like '%vendor%' 
   BEGIN
   SET @Select=@Select + ' AND V.OrganizationId =' + CAST(ISNULL(@OrganizationId,0) AS NVARCHAR(max)) 
   SET @StorageOrderRibbonSelect = @StorageOrderRibbonSelect + @ContractRateCondition +' INNER JOIN vendor V ON C.VendorId = V.Id  AND V.OrganizationId = '+ CAST(ISNULL(@OrganizationId,0) AS NVARCHAR(max))
   END
   ELSE
   BEGIN
   SET @StorageOrderRibbonSelect = @StorageOrderRibbonSelect +@ContractRateCondition+' INNER JOIN vendor V ON C.VendorId = V.Id '
   END

   SET @Select =@Select + ' INNER JOIN Customers CUS ON CUS.Id=C.CustomerId '

    SET  @StorageOrderRibbonSelect = @StorageOrderRibbonSelect +' INNER JOIN Customers CUS ON CUS.Id=C.CustomerId '

	IF @CurrentRole  like '%customer%' 
   BEGIN
   SET @Select=@Select + ' AND CUS.OrganizationId =' + CAST(ISNULL(@OrganizationId,0) AS NVARCHAR(max))
   SET @StorageOrderRibbonSelect = @StorageOrderRibbonSelect + ' AND CUS.OrganizationId =' + CAST(ISNULL(@OrganizationId,0) AS NVARCHAR(max)) 
   END
  

   SET @StorageOrderRibbonSelect = @StorageOrderRibbonSelect + '
   INNER JOIN StorageFacility SF ON C.StorageFacilityId = SF.Id '
   --LEFT JOIN ContractSFFeatureMapping CSFM ON C.id = CSFM.ContractId  
   --LEFT JOIN StorageFeature SFF ON CSFM.StorageFeatureId =SFF.Id '

   SET @Select =@Select + '
   INNER JOIN StorageFacility SF ON C.StorageFacilityId = SF.Id  
   INNER JOIN Organization O ON O.Id=CUS.OrganizationId
   LEFT JOIN ContractSFFeatureMapping CSFM ON C.id = CSFM.ContractId  
   LEFT JOIN StorageFeature SFF ON CSFM.StorageFeatureId =SFF.Id'    
    
  SET @SQL = @Select + @Where  

  SET  @StorageOrderRibbonSelect =  @StorageOrderRibbonSelect + ' 
  LEFT JOIN 
    ContractRailCarMapping CRCM 
  ON 
    CRCM.ContractId=C.Id AND'+@ActiveStorageOrderCheck+' 
  AND 
    CRCM.ArrivalDate IS NOT NULL  
  AND 
    CONVERT(VARCHAR(10),CONVERT(DATE,CRCM.ArrivalDate)) <= CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) 
  AND 
    (CRCM.DepartureDate IS NULL OR CONVERT(VARCHAR(10),CONVERT(DATE,CRCM.DepartureDate)) >= CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())))'

   SET @SQL = @SQL + ' SELECT ISNULL(COUNT(*),0) AS TotalStorageOrders,ISNULL(SUM(storageOrders.TotalCars),0) AS TotalCars, ISNULL(SUM(storageOrders.AvailableCars),0) AS CarsStored,
	ISNULL(SUM(storageOrders.TotalAmount),0) AS TotalAmount,ISNULL(SUM(storageOrders.AVGMonthly),0) AS AVGMonthly,ISNULL(SUM(storageOrders.Active),0) AS Active,ISNULL(SUM(storageOrders.ExpiredOrders),0) AS ExpiredOrders
	FROM ( ' + @StorageOrderRibbonSelect + @Where +' GROUP BY C.Id,C.CarsStored,C.TotalCars,C.ExpiryDate,CR.DailyStorageRate,C.EffectiveDate ' + ' ) AS StorageOrders'
	
   EXECUTE sp_executesql @sql  
  
END