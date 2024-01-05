
CREATE PROCEDURE [dbo].[SP_GetRailCarDetails]
 @ContractId Int= null, 
 @CarInitial NVARCHAR(100)= null, 
 @CarNumber NVARCHAR(100)= null, 
 @CarType SmallInt = null,
 @ArrivalDate NVARCHAR(100)=null,
 @DepartureDate NVARCHAR(100)=null,
 @BolDate NVARCHAR(100) = null,
 @LandE SmallInt = null,
 @LEContents NVARCHAR(100)=null,
 @Fleet NVARCHAR(100)=null, 
 @CurrentRole NVARCHAR(100) = null,
 @OrganizationId bigint=null
 
        AS
        BEGIN
			DECLARE @CustomerId BIGINT
			DECLARE @VendorId BIGINT			
			DECLARE @SQL NVARCHAR(MAX) = N''
			DECLARE @Where NVARCHAR(MAX) = N' WHERE 1=1 '
			DECLARE @Select NVARCHAR(MAX) = N''
			DECLARE @Query NVARCHAR(MAX) = N''
			DECLARE @OnCondition NVARCHAR(MAX) = N''
            IF @ContractId IS NOT NULL
            Begin
             SET @Where = @Where +  ' AND CRM.ContractId = ' + CAST(@ContractId AS NVARCHAR )
            End

            IF @CarInitial IS NOT NULL
           Begin
                SET @Where = @Where + ' AND ' + 'RC.CarInitial LIKE ''%' + @CarInitial + '%'''              
		   End

		   IF @CarNumber IS NOT NULL
           Begin          
                SET @Where = @Where + ' AND ' + 'RC.CarNumber LIKE ''%' + @CarNumber + '%'''              
		   End

		   IF @CarType IS NOT NULL AND @CarType  <> '0'
           Begin           
                SET @Where = @Where + ' AND ' + 'RCT.Id = ' + CAST(@CarType AS NVARCHAR(10))            
		   End

		   IF @ArrivalDate IS NOT NULL
           Begin           
                SET @Where = @Where + ' AND ' + 'CONVERT(VARCHAR (10),CONVERT(DATE,CRM.ArrivalDate)) >= ''' + CONVERT(VARCHAR(10),CONVERT(DATE,@ArrivalDate)) + '''' 
		   End

		   IF @DepartureDate IS NOT NULL
           Begin
                SET @Where = @Where + ' AND ' + 'CONVERT(VARCHAR (10),CONVERT(DATE,CRM.DepartureDate)) <= ''' + CONVERT(VARCHAR(10),CONVERT(DATE,@DepartureDate)) + '''' 
		   End

		    IF @BolDate IS NOT NULL
           Begin           
                SET @Where = @Where + ' AND ' + 'CONVERT(VARCHAR (10),CONVERT(DATE,CRM.BolDate)) = ''' + CONVERT(VARCHAR(10),CONVERT(DATE,@BolDate)) + ''''
		   End  
		  
		   IF @LandE IS NOT NULL AND @LandE  <> '0'
           Begin           
                SET @Where = @Where + ' AND ' + 'LE.Id = ' + CAST(@LandE AS NVARCHAR(10))
		   End

		    IF @LEContents IS NOT NULL
           Begin           
                SET @Where = @Where + ' AND ' + 'CRM.LEContents LIKE ''%' + @LEContents + '%''' 
		   End

		    IF @Fleet IS NOT NULL
           Begin          
                SET @Where = @Where + ' AND ' + 'CRM.Fleet LIKE ''%' + @Fleet + '%''' 
		   End
		    
			Set @Select = '
             select 
				Distinct RC.Id, RC.CarInitial, RC.CarNumber , LE.Name AS LEName, LE.Id AS LEId, 
				RCT.Name AS CarTypeName,RCT.Id AS RailCarTypeId, CRM.BolDate, 
				CRM.ArrivalDate,CRM.DepartureDate,CRM.Fleet,CRM.Notes,CRM.LEContents, 
				CRM.Id AS ContractRailCarMappingId, CRM.ContractId,CRM.CreatedTime,
				C.CarsStored,CRM.IsUnderStorage, C.Rider AS StorageOrder, CRM.CustomerId,
				CRM.IsHazmatCar, CHRG.Id AS ChargeId,CHRG.Amount,CHRG.Title,CHRG.[Date] 
			FROM 
				RailCar RC 
			INNER JOIN 
				ContractRailCarMapping CRM 
			ON 
				RC.Id = CRM.RailCarId
			INNER JOIN 
				Contract C 
			ON 
				CRM.ContractId = C.Id '

		SET @Query ='  
		SELECT
			COUNT(DISTINCT RC.RailCarTypeId) AS RailCarTypes,
			COUNT(*) AS CarsStored,
			COUNT(DISTINCT CASE WHEN Fleet !='''' THEN UPPER(ISNULL(Fleet,0)) END)  AS Fleets,
			COUNT(DISTINCT CASE WHEN LEContents !='''' THEN UPPER(ISNULL(LEContents,0)) END) AS Contents,
			ISNULL(SUM (CASE
				WHEN CRM.LEId = 1 THEN 1
			ELSE 0
				END),0)  AS LoadedCars,
			ISNULL(SUM (CASE
				WHEN CRM.LEId in (2,3) THEN 1
			ELSE 0
				END),0) AS EmptyCars
			FROM RailCar AS RC INNER  JOIN ContractRailCarMapping CRM ON RC.Id=CRM.RailCarId
			INNER  JOIN Contract C ON CRM.ContractId = C.Id  AND CONVERT(VARCHAR(10),CONVERT(DATE,C.EffectiveDate))<=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) AND (CRM.ArrivalDate IS NOT NULL  AND CONVERT(VARCHAR(10),CONVERT(DATE,CRM.ArrivalDate))<=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE()))) AND ( CRM.DepartureDate IS NULL OR CONVERT(VARCHAR(10),CONVERT(DATE,CRM.DepartureDate))>=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE()))) AND CONVERT(VARCHAR(10),CONVERT(DATE,C.ExpiryDate))>=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) '

   IF (@CurrentRole like '%vendor%' )
   BEGIN
   SELECT @VendorId=Id FROM Vendor WHERE OrganizationId=@OrganizationId
   SET @Select=@Select + ' AND C.VendorId =' + CAST(ISNULL(@VendorId,0) AS NVARCHAR(MAX))
   SET @Query=@Query + ' AND C.VendorId =' + CAST(ISNULL(@VendorId,0) AS NVARCHAR(MAX))
   END

   IF (@CurrentRole like '%Customer%' )
   BEGIN
   SELECT @CustomerId=Id FROM Customers WHERE OrganizationId=@OrganizationId   
   SET @Select=@Select + ' AND C.CustomerId =' + CAST(ISNULL(@CustomerId,0) AS NVARCHAR(MAX))
   SET @Query=@Query + ' AND C.CustomerId =' + CAST(ISNULL(@CustomerId,0) AS NVARCHAR(MAX))
   END
   
   SET @OnCondition = ' 
	LEFT JOIN 
		LEContent LE 
	ON 
		CRM.LEId = LE.Id
   LEFT JOIN 
		RailCarType RCT 
	ON 
		RC.RailCarTypeId = RCT.Id'

   SET @select = @select + ' 
   LEFT JOIN  
		dbo.ContractRailCarCharges CHRG  
	ON   
		CHRG.ContractRailCarMappingId = CRM.Id  
		AND CHRG.IsActive=1 '  

   SET @Select = @Select + @OnCondition

   SET @Query = @Query + @OnCondition
	
	SET @SQL = @Select + @Where + @Query + @Where 
	 
			 
    EXECUTE sp_executesql @sql			
END			