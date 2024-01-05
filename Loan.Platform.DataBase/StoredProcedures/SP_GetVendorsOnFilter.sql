CREATE PROCEDURE [dbo].[SP_GetVendorsOnFilter]
@orgName NVARCHAR(100) ='',
@storagefacilityId BIGINT=0,
@interchangeId BIGINT=0,
@countryId BIGINT=0,
@stateId BIGINT=0,
@city NVARCHAR(MAX)=null,
@currentRole NVARCHAR(MAX)='',
@organizationId BIGINT=null
AS
BEGIN
       -- SET NOCOUNT ON added to prevent extra result sets from
       -- interfering with SELECT statements.
       SET NOCOUNT ON;

       DECLARE @QUERY NVARCHAR(MAX);
       DECLARE @WHERECLAUSE NVARCHAR(MAX);
       DECLARE @ORGID BIGINT=-1;
	   DECLARE @CUSTOMERID BIGINT;
	   DECLARE @ONCONDITION NVARCHAR(MAX);
	   DECLARE @CONTRACTRATECONDITION  NVARCHAR(MAX);
       IF(@orgName!='')
       BEGIN
              SET @ORGID= (SELECT 
                               ID
                           FROM 
                               dbo.Organization ORG 
                           WHERE 
                              ISNULL(ORG.IsActive,0)=1 AND 
                              ORG.[Name]=@orgName);

              SET @ORGID=ISNULL(@ORGID,0)
       END

		SET @QUERY='DECLARE 
					@Results TABLE 
						(Vendor NVARCHAR(MAX), VendorOrgId BIGINT, VendorId BIGINT, StorageFacilityName NVARCHAR(MAX),StorageFacilityId BIGINT,
						InterchangeName NVARCHAR(MAX), Location NVARCHAR(MAX))
					INSERT INTO 
						@results 
						(Vendor,VendorOrgId,VendorId,StorageFacilityName,StorageFacilityId,InterchangeName,Location)
					SELECT 
						O.Name AS Vendor,O.Id AS OrganizationId,V.Id AS VendorId,SF.[Name] AS StorageFacilityName, 
						SF.Id AS StorageFacilityId, SFI.MarkCode, 
						SFIL.City + (CASE WHEN SFIL.[StateId] IS NULL THEN '''' ELSE ''- '' + S.Name END) AS [Location]
					FROM
						Vendor V
					INNER JOIN 
						Organization O 
					ON
						O.Id=V.OrganizationId AND
						V.IsActive=1 AND
						O.IsActive=1
					INNER JOIN 
						StorageFacility SF
					ON
						SF.VendorId=V.Id AND 
						SF.IsActive=1
					INNER JOIN 
						StorageFacilityInterchange SFI 
					ON
						SFI.StorageFacilityId=SF.Id AND
						SFI.IsActive=1
					INNER JOIN 
						StorageFacilityInterchangeLocation SFIL 
					ON
						SFIL.InterchangeId=SFI.Id AND
						SFIL.IsActive=1
					LEFT JOIN 
						[State] S 
					ON
						S.Id=SFIL.StateId ';		

		IF(@city!='' AND LEN(@city)>0)
              BEGIN
                     SET @QUERY=@QUERY+' INNER JOIN
                           dbo.fn_SplitStringToTable('''+@city+''','','') SPLT
                     ON
                           V.City=SPLT.SplittedVal ';
              END

		IF (@CurrentRole='customer')
		BEGIN
			SELECT @CUSTOMERID=Id FROM Customers WHERE OrganizationId=@OrganizationId
			SET @QUERY=@QUERY+' 
							INNER JOIN CONTRACT C
							ON C.VENDORID=V.ID AND C.CUSTOMERID=' + +CAST(ISNULL(@CUSTOMERID,0) AS NVARCHAR(MAX))
			SET @ONCONDITION=' RES.StorageFacilityId=c.StorageFacilityId AND C.CUSTOMERID=' + +CAST(ISNULL(@CUSTOMERID,0) AS NVARCHAR(MAX))
		END
		ELSE
		BEGIN
			SET @ONCONDITION=' RES.StorageFacilityId=c.StorageFacilityId'
		END
	   	
		IF (@CurrentRole='vendor' )
		BEGIN
			SET @WHERECLAUSE=' WHERE 1=0';
			SET @CONTRACTRATECONDITION = ' AND ((C.IsFlatRateContract = 1 AND CR.RateTypeId = 2) OR (C.IsFlatRateContract = 0 AND CR.RateTypeId = 3))'
		END
		ELSE
		BEGIN
			SET @WHERECLAUSE=' WHERE 1=1';
			SET @CONTRACTRATECONDITION = ' AND ((C.IsFlatRateContract = 1 AND CR.RateTypeId = 1) OR (C.IsFlatRateContract = 0 AND CR.RateTypeId = 3))'
		END
       IF(@CountryId>0)
       BEGIN
              SET @WHERECLAUSE=@WHERECLAUSE+' AND V.CountryId='+CAST(@CountryId AS NVARCHAR(MAX));
       END

       IF(@StateId>0)
       BEGIN
                SET @WHERECLAUSE=@WHERECLAUSE+' AND V.StateId='+CAST(@StateId AS NVARCHAR(MAX));
       END

       --IF(isnull(@city,0)!=0)
       --BEGIN
       --       SET @WHERECLAUSE=@WHERECLAUSE+' AND V.City='+@city;
       --END

       IF(@ORGID>=0)
       BEGIN
                SET @WHERECLAUSE=@WHERECLAUSE+' AND V.OrganizationId='+CAST(@ORGID AS NVARCHAR(MAX));
       END
       IF(@storagefacilityId>0)
       BEGIN
                SET @WHERECLAUSE=@WHERECLAUSE+' AND SF.Id='+CAST(@storagefacilityId AS NVARCHAR(MAX));
       END

       IF(@interchangeId>0)
       BEGIN
                 SET @WHERECLAUSE=@WHERECLAUSE+' AND SFI.RailRoadId='+CAST(@interchangeId AS NVARCHAR(MAX));
       END

       SET @QUERY= @QUERY+ ' '+ @WHERECLAUSE;
       --print @QUERY

       SET @Query = @QUERY + ' (
								SELECT 
									     RES.*
									,ISNULL(C.TotalCars,0) As TotalCars
									,ISNULL(C.CarsStored,0) AS  CarsStored
									,SUM(
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
									ISNULL(SUM(
									
									CASE WHEN DATEDIFF(day, (CRCM.ArrivalDate),
									CASE
										WHEN ((CRCM.DepartureDate)  IS NOT NULL) THEN (CRCM.DepartureDate)
									ELSE GETDATE() END)>=0 THEN 1 ELSE 0 END) *CR.DailyStorageRate*DAY(EOMONTH(GETDATE())),0)  AS AVGMonthly,
									ISNULL(SUM(
									
									CASE WHEN DATEDIFF(day, (CRCM.ArrivalDate),
									CASE
										WHEN ((CRCM.DepartureDate)  IS NOT NULL) THEN (CRCM.DepartureDate)
									ELSE GETDATE() END)>=0 THEN 1 ELSE 0 END),0) AS AvailableCars
									,SUM (CASE
										WHEN CRCM.LEId = 1 THEN 1
									ELSE 0
									END) AS LoadedCars
									,SUM (CASE
										WHEN CRCM.LEId in (2,3) THEN 1
									ELSE 0
									END) AS EmptyCars,
									[Locations] = STUFF(
													(SELECT DISTINCT '', '' + CHRSLT.[Location]
														FROM @results CHRSLT
														WHERE CHRSLT.VendorId=RES.VendorId and CHRSLT.StorageFacilityId=RES.StorageFacilityId 
													FOR XML PATH(''''),type).
													value(''.'',''VARCHAR(MAX)''),1, 2, ''''),
									[Interchanges] = STUFF(
													(SELECT DISTINCT '', '' + CHRSLT.[InterchangeName]
														FROM @results CHRSLT
														WHERE CHRSLT.VendorId=RES.VendorId and CHRSLT.StorageFacilityId=RES.StorageFacilityId 
													FOR XML PATH(''''),type).
													value(''.'',''VARCHAR(MAX)''),1, 2, '''')
								FROM 
									(
										SELECT 
											DISTINCT Vendor, StorageFacilityId,VendorId,StorageFacilityName
										FROM 
											@results
									) RES 
								LEFT JOIN
									Contract C 
								ON' + @ONCONDITION + ' AND CONVERT(VARCHAR(10),CONVERT(DATE,C.EffectiveDate))<=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) AND CONVERT(VARCHAR(10),CONVERT(DATE,C.ExpiryDate))>=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) LEFT JOIN 
									[dbo].[ContractRailCarMapping] CRCM
								ON
								CRCM.ContractId = C.Id AND (CRCM.ArrivalDate IS NOT NULL  
								AND CONVERT(VARCHAR(10),CONVERT(DATE,CRCM.ArrivalDate))<=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE()))) AND ( CRCM.DepartureDate IS NULL OR CONVERT(VARCHAR(10),CONVERT(DATE,CRCM.DepartureDate))>=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE()))) 
								LEFT JOIN ContractRate CR ON CR.ContractId = C.Id AND CR.IsActive=1 '+@CONTRACTRATECONDITION+' 
								GROUP BY C.Id,RES.Vendor, RES.StorageFacilityId,RES.VendorId,RES.StorageFacilityName,C.TotalCars,C.CarsStored,CR.DailyStorageRate
								);

								SELECT 
									Result.Vendor,RESULT.VendorId,RESULT.StorageFacilityId,RESULT.StorageFacilityName
									FROM @results RESULT
									GROUP BY RESULT.VendorId,RESULT.StorageFacilityId,RESULT.StorageFacilityName,Result.Vendor;';		
	
       EXEC (@QUERY);  
END