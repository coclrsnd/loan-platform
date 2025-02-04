CREATE OR ALTER PROCEDURE [dbo].[SP_SearchFacility] @isMulticityEnable BIT = 1,
                                          @origin            NVARCHAR(100) =NULL,
                                          @destination       NVARCHAR(100) =NULL,
                                          @railroads         NVARCHAR(max) =NULL,
                                          @region            INT = NULL,
										  @expiryDate        NVARCHAR(max) =NULL,
                                          @effectiveDate     NVARCHAR(max) =NULL,
                                          @dailyRate         INT = NULL,
                                          @switchingFee      INT = NULL,
                                          @features          NVARCHAR(max) =NULL,
                                          @range             INT = NULL,
                                          @splcs             NVARCHAR(max) =NULL,
										  @splcMilesMap      SPLCMileUDT READONLY
AS
/*--------------- Stored Procedure execution---------------*/
  -- EXEC [dbo].[sp_SearchFacility] 0,NULL,NULL,NULL, @splcs ='43216000,43216001',@effectiveDate='2022-06-14 18:50:19.823',@expiryDate='2023-06-14 18:50:19.823',@features=N'3,4,1',@dailyRate=15,@switchingFee=4,@region=1
  --exec sp_SearchFacility @isMulticityEnable=0,@origin=N'Melfort, SK',@destination=N'Vancouver, WA',@railroads=N'CN',@region=Null,@expiryDate='2022-06-14 18:50:19.823',@dailyRate=15,@effectiveDate='2022-06-14 18:50:19.823',@switchingFee=4,@features=N'3,4,1'
/*---------------------------------------------------------*/
  /*
  Name:[sp_SearchFacility]
  Purpose: Search Storage facilities to be displayed on map.
  Ref: API request from RL
  History:
  Modified - Amit Jain to include all the filter Criatiria.
  */
  BEGIN
      SET nocount ON
      SET ansi_warnings ON
      SET ansi_padding ON
      SET ansi_nulls ON
      SET arithabort ON
      SET quoted_identifier ON
      SET ansi_null_dflt_on ON
      SET concat_null_yields_null ON

      --Parameters used for error handling
      DECLARE @ERRORNUMBER    INT,
              @ERRORMESSAGE   VARCHAR(MAX),
              @ERRORSEVERITY  INT,
              @ERRORSTATE     INT,
              @ERRORLINE      INT,
              @ERRORPROCEDURE VARCHAR(200),
              @PARAMS         VARCHAR(Max),
              @MESSAGE        NVARCHAR(max);

      BEGIN try
          DECLARE @WhereClause NVARCHAR(2000)
          DECLARE @Query NVARCHAR(max)
          DECLARE @WhereClauseFeatures NVARCHAR(2000)
		  Declare @WhereClauseDate nVarchar(1000)

          DECLARE @name VARCHAR(50)

		   CREATE TABLE #tmpsplcmiles
            (
			splc nvarchar(max),
               miles       NVARCHAR(256)
			)

          SET @WhereClause =''
          SET @WhereClauseFeatures = ''
		  Set @WhereClauseDate = ''

          IF @region IS NOT NULL
            BEGIN
                SET @WhereClause = @WhereClause + ' And  RegionID = '
                                   + Str(@region)
            END
		  
		  IF @railroads <> ''
            BEGIN
                SET @WhereClause = @WhereClause + ' And  markCode = '
                                   +'''' + @railroads  + '''' 
            END

          IF @dailyRate IS NOT NULL
            BEGIN
                SET @WhereClause = @WhereClause + ' And  DailyRate < '
                                   + Str(@dailyRate)
            END

          IF @switchingFee IS NOT NULL
            BEGIN
                SET @WhereClause = @WhereClause + ' And  SwitchingRate < '
                                   + Str(@switchingFee)
          END

		 IF exists(select 1 from @splcMilesMap)
		  BEGIN
				insert into #tmpsplcmiles
				select * from @splcMilesMap
				SET @WhereClause = @WhereClause + ' And splc IN (select SPLC FROM #tmpsplcmiles) '
		  END

          IF @features IS NOT NULL AND @features <> ''
            BEGIN
                SET @WhereClauseFeatures = 'And  (1=0 '

                DECLARE db_cursor CURSOR FOR
                  SELECT item
                  FROM   dbo.Fnsplit(@features, ',')

                OPEN db_cursor

                FETCH next FROM db_cursor INTO @name

                WHILE @@FETCH_STATUS = 0
                  BEGIN
                      SET @WhereClauseFeatures = @WhereClauseFeatures + ' or '''
                                                 + Trim(Str(@name))
                                                 +
                      ''' IN (SELECT item FROM dbo.fnSplit(FeatureID , '','')) '

                      FETCH next FROM db_cursor INTO @name
                  END

                SET @WhereClauseFeatures = @WhereClauseFeatures + ')'

                --Set @WhereClause = @WhereClause + ' And ''' + trim(str(@features)) + ''' IN (SELECT item FROM dbo.fnSplit(FeatureID , '','')) ' 
                CLOSE db_cursor

                DEALLOCATE db_cursor
            END


		--IF @effectiveDate is not null and @expiryDate is not null
		--	Begin
		--		Set @WhereClauseDate = ' AND ((effectivedate   between ''' + @effectiveDate + ''' and ''' + @expiryDate + ''')'
		--		Set @WhereClauseDate = @WhereClauseDate + ' or (expirydate   between ''' + @effectiveDate + ''' and ''' + @expiryDate + '''))'
		--	End

			IF @effectiveDate is not null and @expiryDate is not null
			Begin

				Set @WhereClauseDate = ' AND ((''' + @effectiveDate  + ''' between effectiveDate  and expiryDate )'
				Set @WhereClauseDate = @WhereClauseDate + ' or (''' + @expiryDate  + ''' between effectiveDate  and  expiryDate ))'
			End

			
		  CREATE TABLE #tmpstoragefacility
            (
               storagefacilityid INT,
			   interchange       NVARCHAR(256),
			   markCode			 NVARCHAR(256),
               splc              NVARCHAR(16),
               NAME              NVARCHAR(256),
               description       NVARCHAR(512),
               lat               NVARCHAR(256),
               long              NVARCHAR(256),
               availablecars     INT,
               capacity          INT,
               city              NVARCHAR(128),
               statecode         NVARCHAR(8),
               rating            FLOAT,
               dailyrate         DECIMAL(18, 2),
               featurelist       NVARCHAR(MAX),
               effectivedate     DATETIME,
               expirydate        DATETIME,
               switchingrate     DECIMAL(18, 2),
               regionid          INT,
               featureid         NVARCHAR(MAX),
			   Interchanges		 NVARCHAR(MAX),
			   vendorid			 INT,
			   currencycode		 NVARCHAR(MAX)
            )

          INSERT INTO #tmpstoragefacility
          SELECT distinct SF.id,
				 INTER.[RailRoadName] AS Interchange,
				 INTER.MarkCode,
                 IL.splc,
                 SF.[name],
                 SF.[description],
                 SF.lat,
                 SF.long,
                 SF.availablecars,
                 SF.capacity,
                 SF.city,
                 S.code                   AS StateCode,
                 SF.rating,
                 SFR.dailystoragerate AS DailyRate,
                 Isnull(Stuff((SELECT ', ' + COALESCE(SFT.[name], '')
                               FROM   [storagefacilityfeaturemapping] SFM
                                      INNER JOIN [storagefeature] SFT
                                              ON SFT.id = SFM.storagefeatureid
                               WHERE  SFM.storagefacilityid = SF.id
                               FOR xml path(''), type).value('.[1]',
                        'NVARCHAR(MAX)'),
                        1,
                        1, ''),
                 'Not Assigned Yet')      AS FeatureList,
                 SF.effectivedate,
                 SF.expirydate,
                 SFR.switchingrate,
                 SF.regionid,
                 Isnull(Stuff((SELECT ',' + COALESCE(Trim(Str(SFT.id)), '')
                               FROM   [storagefacilityfeaturemapping] SFM
                                      INNER JOIN [storagefeature] SFT
                                              ON SFT.id = SFM.storagefeatureid
                               WHERE  SFM.storagefacilityid = SF.id
                               FOR xml path(''), type).value('.[1]',
                        'NVARCHAR(MAX)'),
                        1,
                        1, ''),
                 NULL)                    AS FeatureID,
			Isnull(Stuff((SELECT distinct ', ' + COALESCE(INTER.MarkCode, '')
                               FROM   [StorageFacilityInterchange] INTER
                                      INNER JOIN [storagefeature] SFT
                                              ON INTER.storagefacilityid = SF.id
                               WHERE  INTER.storagefacilityid = SF.id
                               FOR xml path(''), type).value('.[1]',
                        'NVARCHAR(MAX)'),
                        1,
                        1, ''),
                 'Not Assigned Yet') AS Interchanges,
				 SF.VendorId,
				 CUR.Code as CurrencyCode
          FROM   [dbo].[storagefacility] SF
                 LEFT JOIN [storagefacilityrate] SFR
                        ON SFR.storagefacilityid = SF.id 
				 LEFT JOIN [Currency] CUR
						ON  SFR.CurrencyId=CUR.Id
                 LEFT JOIN [state] S
                        ON SF.stateid = S.id
                 LEFT JOIN [StorageFacilityInterchange] INTER
                        ON INTER.storagefacilityid = SF.id
                 LEFT JOIN [StorageFacilityInterchangeLocation] IL
                        ON IL.interchangeid = INTER.id
		 WHERE SF.IsActive = 1 AND SFR.IsActive = 1 AND INTER.IsActive = 1 AND IL.IsActive = 1
	
		  SET @Query = 'Select storagefacilityid AS Id, * from (select t.*,
             row_number() over (partition by storagefacilityid order by storagefacilityid) as seqnum
      from #tmpStorageFacility t where 1=1 '++ @WhereClause + @WhereClauseFeatures + @WhereClauseDate+'
     ) t
where seqnum = 1 '--+ @WhereClause + @WhereClauseFeatures + @WhereClauseDate

          --SET @Query = 'Select distinct storagefacilityid AS Id, * from #tmpStorageFacility Where 1=1 '
          --             + @WhereClause + @WhereClauseFeatures + @WhereClauseDate
		
		  Print @Query
		  EXECUTE Sp_executesql  @Query
		  
 

      END try

      BEGIN catch
          SELECT @ERRORMESSAGE = Error_message(),
                 @ERRORSEVERITY = Error_severity(),
                 @ERRORNUMBER = Error_number(),
                 @ERRORPROCEDURE = Error_procedure(),
                 @ERRORLINE = Error_line(),
                 @ERRORSTATE = Error_state();

          SET @PARAMS = 'Parameter 1:'
                        + Cast(@isMulticityEnable AS VARCHAR(10));
          SET @MESSAGE = 'ERROR NUMBER:'
                         + Cast(@ERRORNUMBER AS VARCHAR(5))
                         + Char(13) + 'PROCEDURE NAME:' + @ERRORPROCEDURE
                         + Char(13) + 'PROCEDURE LINE:'
                         + Cast(@ERRORLINE AS VARCHAR(5)) + Char(13)
                         + 'ERROR MESSAGE:' + @ERRORMESSAGE + Char(13)
                         + 'PARAMETERS:' + @PARAMS + Char(13);

          INSERT INTO [dbo].[DB_Errors]
          VALUES      (Suser_sname(),
                       @MESSAGE,
                       Getdate());

          

          -- return the error inside the CATCH block
          RAISERROR(@MESSAGE,@ERRORSEVERITY,@ERRORSTATE);
      END catch
  END