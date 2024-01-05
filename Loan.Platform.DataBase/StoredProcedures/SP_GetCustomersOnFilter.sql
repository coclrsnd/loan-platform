CREATE PROCEDURE [dbo].[SP_GetCustomersOnFilter]
	@countryId BIGINT,
	@stateId BIGINT,
	@city NVARCHAR(MAX),
	@orgName NVARCHAR(100),
	@pageNumber INT = 1,
    @pageSize INT = 10,
	@sortByColumn NVARCHAR(100),
	@sortBy NVARCHAR(100),
	@currentRole NVARCHAR(MAX),
	@organizationId BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;

	DECLARE @QUERY NVARCHAR(MAX);
	DECLARE @WHERECLAUSE NVARCHAR(MAX);
	DECLARE @ORDERBYCLAUSE NVARCHAR(MAX);
	DECLARE @GROUPBYCLAUSE NVARCHAR(MAX);
	DECLARE @RIBBONCALCULATION NVARCHAR(MAX);
	DECLARE @ORGID BIGINT=-1;
	DECLARE @VendorId BIGINT;

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


	IF(@sortByColumn!='')
	BEGIN
		SET @ORDERBYCLAUSE=' ORDER BY '+@sortByColumn;

		IF(@sortBy!='')
		BEGIN
			SET @ORDERBYCLAUSE=@ORDERBYCLAUSE+ ' ' +@sortBy;
		END
	END

	SET @QUERY='SELECT 
                    CST.Id AS Id,
                    ORG.[Name] AS Organization,
                    CST.PrimaryContactNo AS PrimaryContact,
                    CST.PrimaryContactEmail AS PrimaryEmail,
					CST.ModifiedTime AS ModifiedTime,
					(CASE 
						WHEN (ISNULL(CST.City,'''')!='''' AND ISNULL(ST.[Name],'''')!='''') THEN (CST.City+'', ''+ST.[Name])
						WHEN (ISNULL(CST.City,'''')!='''' AND ISNULL(ST.[Name],'''')='''') THEN (CST.City)
						WHEN (ISNULL(CST.City,'''')='''' AND ISNULL(ST.[Name],'''')!='''') THEN (ST.[Name])
					END) AS [Location]
				FROM
					dbo.Customers CST
				INNER JOIN
					dbo.Organization ORG
				ON
					ORG.ID=CST.OrganizationId
				LEFT JOIN
					dbo.[State] ST
				ON
					ST.Id=CST.StateId 				
			';

			SET @RIBBONCALCULATION = '  SELECT ISNULL(COUNT(*),0) AS TotalStorageOrders,ISNULL(SUM(CustomerRibbon.TotalCars),0) AS TotalContractedSpaces, ISNULL(SUM(CustomerRibbon.AvailableCars),0) AS TotalCarsStored
	FROM (  
  SELECT CT.Id AS ContractId,CT.TotalCars AS TotalCars,
									SUM(
									
									CASE WHEN DATEDIFF(day, (CRCM.ArrivalDate),
									CASE
										WHEN ((CRCM.DepartureDate)  IS NOT NULL) THEN (CRCM.DepartureDate)
									ELSE GETDATE() END)>=0 THEN 1 ELSE 0 END) AS AvailableCars
                                 
   FROM Customers CST ' 

		IF(@currentRole<>'vendor')
		BEGIN
			SET @QUERY=@QUERY + ' LEFT JOIN
                    dbo.[Contract] CT
                ON
                    CT.CustomerId=CST.Id '

				SET @RIBBONCALCULATION = @RIBBONCALCULATION + ' INNER JOIN Contract CT ON CST.Id=CT.CustomerId  AND CONVERT(VARCHAR(10),CONVERT(DATE,CT.EffectiveDate))<=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) AND CONVERT(VARCHAR(10),CONVERT(DATE,CT.ExpiryDate))>=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) '
		END

		IF(@CITY!='' AND LEN(@City)>0)
		BEGIN
			SET @QUERY=@QUERY+' INNER JOIN
				dbo.fn_SplitStringToTable('''+@City+''','','') SPLT
			ON
				CST.City=SPLT.SplittedVal ';

				SET @RIBBONCALCULATION = @RIBBONCALCULATION+' INNER JOIN
				dbo.fn_SplitStringToTable('''+@City+''','','') SPLT
			ON
				CST.City=SPLT.SplittedVal ';
		END

		IF (@CurrentRole='vendor')
		BEGIN
			SELECT @VendorId=Id FROM vendor WHERE OrganizationId=@OrganizationId
			SET @QUERY=@QUERY+' 
							INNER JOIN CONTRACT CT
							ON CT.CUSTOMERID=CST.ID AND CT.VENDORID=' + +CAST(@VendorId AS NVARCHAR(MAX))
			SET @RIBBONCALCULATION = @RIBBONCALCULATION+' 
							INNER JOIN Contract CT ON CST.Id=CT.CustomerId  AND CONVERT(VARCHAR(10),CONVERT(DATE,CT.EffectiveDate))<=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) AND CONVERT(VARCHAR(10),CONVERT(DATE,CT.ExpiryDate))>=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE())) AND CT.VENDORID=' + +CAST(@VendorId AS NVARCHAR(MAX))
		END
	   	
		IF (@CurrentRole='customer' )
		BEGIN
			SET @WHERECLAUSE=' WHERE 1=0';
		END
		ELSE
		BEGIN
			SET @WHERECLAUSE=' WHERE 1=1';
		END

		SET @WHERECLAUSE=@WHERECLAUSE + ' AND
				ISNULL(CST.IsActive,0)=1 AND
				ISNULL(ORG.IsActive,0)=1';

		IF(@ORGID>=0)
		BEGIN
		   SET @WHERECLAUSE=@WHERECLAUSE+' AND CST.OrganizationId='+CAST(@ORGID AS NVARCHAR(MAX));
		END

		IF(@CountryId>0)
		BEGIN
		   SET @WHERECLAUSE=@WHERECLAUSE+' AND CST.CountryId='+CAST(@CountryId AS NVARCHAR(MAX));
		END

		IF(@StateId>0)
		BEGIN
		   SET @WHERECLAUSE=@WHERECLAUSE+' AND CST.StateId='+CAST(@StateId AS NVARCHAR(MAX));
		END

		SET @GROUPBYCLAUSE = 'GROUP BY CST.Id,ORG.[Name],CST.PrimaryContactNo,CST.PrimaryContactEmail,CST.City,ST.[Name],CST.ModifiedTime'
		
		SET @QUERY = 'WITH CustomerCTE AS ( ' + @QUERY +@WHERECLAUSE+' ' + @GROUPBYCLAUSE + ' ) SELECT COUNT(Id) OVER() AS TotalRecords,Id,Organization, PrimaryContact,PrimaryEmail,[Location] FROM CustomerCTE CST '
		
		SET @QUERY= @QUERY +@ORDERBYCLAUSE;

		SET @QUERY=@QUERY+ ' OFFSET '+CONVERT(VARCHAR(20),(@pageNumber-1))+'*'+CONVERT(VARCHAR(100),@PageSize)+' ROWS FETCH NEXT '+CONVERT(VARCHAR(100),@PageSize)+' ROWS ONLY; ';
		
		SET @RIBBONCALCULATION = @RIBBONCALCULATION + 'INNER JOIN
					dbo.Organization ORG
				ON
					ORG.ID=CST.OrganizationId
				LEFT JOIN
					dbo.[State] ST
				ON
					ST.Id=CST.StateId 
   LEFT JOIN ContractRailCarMapping CRCM ON CRCM.ContractId=CT.Id  AND (CRCM.ArrivalDate IS NOT NULL  
   AND CONVERT(VARCHAR(10),CONVERT(DATE,CRCM.ArrivalDate))<=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE()))) AND ( CRCM.DepartureDate IS NULL OR CONVERT(VARCHAR(10),CONVERT(DATE,CRCM.DepartureDate))>=CONVERT(VARCHAR(10),CONVERT(DATE,GETDATE()))) ' + @WHERECLAUSE + '  GROUP BY CT.Id,CT.TotalCars  ) AS CustomerRibbon'

		SET @QUERY = @QUERY + @RIBBONCALCULATION

		EXEC (@QUERY);

END