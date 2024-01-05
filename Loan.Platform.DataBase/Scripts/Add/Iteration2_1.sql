BEGIN TRANSACTION

PRINT 'SP_StorageFacilityActivityReport Updated successfully';
GO
--[dbo].[SP_StorageFacilityActivityReportbackup] 27,1,'2022-08-01','2022-09-30'

CREATE OR ALTER PROCEDURE [dbo].[SP_StorageFacilityActivityReport] --3,1,'2022-08-01','2022-09-30'
@Id BIGINT,
@ContractTypeId BigInt,
@FromDate   NVARCHAR(max) =NULL,
@ToDate     NVARCHAR(max) =NULL
AS  
BEGIN  
                DECLARE @LoadedId BIGINT
                Select @LoadedId = ID from LEContent where Name='Loaded'

                SELECT 
                                C.Id,
                                ORG.[Name] as OrganizationName,
                                CUS.[Address] +', ' + ISNULL(CUS.City,'') +', '+ ISNULL(S.Name,'') +', ' + ISNULL(CTRY.NAME,'') AS OrgAddress,
                                @FromDate as ReportFromDate,
                                @ToDate as ReportToDate,
                                C.Rider as [Order],
                                SF.[Name] AS FacilityName,
                                SF.[Address] +', ' + ISNULL(SF.City,'') +', '+ ISNULL(SSF.Name,'') +', ' + ISNULL(CTRYSF.NAME,'') AS FacilityAddress,
                                GETDATE() as ReportDate,
                                CT.[Name] as ContractType,
                                CURR.Code as Currency,
                                CR.DailyStorageRate,
								C.IsAdvancedSwitchingRatesEnabled,
                                ISNULL(CR.HazmatSurcharge,0) as HazmatSurcharge,
                                ISNULL(CR.LoadedSurcharge,0) as LoadedSurcharge,
                                ISNULL(CR.CherryPickingRate,0) as CherryPickingRate,
                                CR.SwitchIn as SwitchIn,
                                CR.SwitchOut as SwitchOut,
								CR.LoadedSwitchIn as LoadedSwitchIn,
                                CR.LoadedSwitchOut as LoadedSwitchOut,
								CR.HazmatSwitchIn as HazmatSwitchIn,
                                CR.HazmatSwitchOut as HazmatSwitchOut,
                                C.TotalCars as ContractedSpace
                FROM
                                [Contract] C
                INNER JOIN
                                Customers CUS
                ON
                                CUS.Id = C.CustomerId
                INNER JOIN
                                Organization ORG
                ON
                                ORG.Id=CUS.OrganizationId
                INNER JOIN
                                StorageFacility SF
                ON         
                                SF.Id = C.StorageFacilityId
                INNER JOIN
                                ContractType CT
                ON         
                                CT.Id = C.ContractTypeId
                LEFT JOIN
                                State S
                ON
                                S.Id=CUS.StateId
                LEFT JOIN
                                Country CTRY
                ON
                                CTRY.Id=CUS.CountryId
                LEFT JOIN
                                State SSF
                ON
                                SSF.Id=SF.StateId
                LEFT JOIN
                                Country CTRYSF
                ON
                                CTRYSF.Id=SF.CountryId
                LEFT JOIN
                     Currency CURR
                ON CURR.Id = C.CurrencyId
                LEFT JOIN
                                ContractRate CR
                ON
                                CR.ContractId=C.Id and CR.IsActive=1 and (CR.RateTypeId=1 or CR.RateTypeId=3)
                WHERE
                                C.ID=@Id
   
   IF EXISTS(select id from ContractType where Name='SPOT' and Id=@ContractTypeId)
   BEGIN
     
		select *, NoOfDays * TotalDailyRate as TotalDailyAmount into #activityReport from (
        select *, DATEDIFF(DAY,BillingStartDate,BillingEndDate) + 1 as NoOfDays,
        --(DATEDIFF(DAY,BillingStartDate,BillingEndDate) + 1) * DailyStorageRate as TotalDailyAmount 
        CASE WHEN LE='L' 
                        THEN 
                                        CASE WHEN IsHazmatCar=1 
                                                        then DailyStorageRate + isnull(LoadedSurcharge,0) + isnull(HazmatSurcharge,0)
                                                        else DailyStorageRate + isnull(LoadedSurcharge,0)
                                                        end 
                        ELSE 
                                        CASE WHEN IsHazmatCar=1 
                                                        then DailyStorageRate + isnull(HazmatSurcharge,0)
                                                        else DailyStorageRate
                                                        end 
                        END as TotalDailyRate
        from (
                        select c.Id as ContractId, RC.CarInitial, RC.CarNumber,CRCM.IsHazmatCar,                                             
                        CRCM.ArrivalDate,CRCM.DepartureDate,
                        c.Rider, CRCM.railCarid,CRCM.id as RailCarMappingId,
                        CR.DailyStorageRate, CR.HazmatSurcharge, CR.LoadedSurcharge, CRCM.LEContents,
                        CASE WHEN @FromDate >= ArrivalDate then @FromDate else ArrivalDate end as BillingStartDate,
                        Case When DepartureDate IS null Or DepartureDate >=@ToDate then @ToDate else DepartureDate end as BillingEndDate,
                        Case when ArrivalDate between @FromDate and @ToDate 
							THEN 
								CASE WHEN LEId=@LoadedId
								THEN
									CASE WHEN CRCM.IsHazmatCar = 1
									THEN
										CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
										THEN
											ISNULL(CR.LoadedSwitchIn, 0 ) 
										ELSE
											CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
											THEN
												ISNULL(CR.HazmatSwitchIn,0)
											ELSE
												ISNULL(CR.SwitchIn,0)
											END
										END
									ELSE
										CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
										THEN
											ISNULL(CR.LoadedSwitchIn, 0 ) 
										ELSE
											ISNULL(CR.SwitchIn,0)
										END
									END
								ELSE
									CASE WHEN CRCM.IsHazmatCar = 1
									THEN
										CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
										THEN
											ISNULL(CR.HazmatSwitchIn,0)
										ELSE
											ISNULL(CR.SwitchIn,0)
										END
									ELSE
										ISNULL(CR.SwitchIn,0)
									END
								END								
							ELSE 
								0 
							END as SwitchIn,
                        Case when DepartureDate between @FromDate and @ToDate 
						THEN
							CASE WHEN LEId=@LoadedId
							THEN
								CASE WHEN CRCM.IsHazmatCar = 1
								THEN
									CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
									THEN
										ISNULL(CR.LoadedSwitchOut, 0 ) 
									ELSE
										CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
										THEN
											ISNULL(CR.HazmatSwitchOut,0)
										ELSE
											ISNULL(CR.SwitchOut,0)
										END
									END
								ELSE
									CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
									THEN
										ISNULL(CR.LoadedSwitchOut, 0 ) 
									ELSE
										ISNULL(CR.SwitchOut,0)
									END
								END
							ELSE
								CASE WHEN CRCM.IsHazmatCar = 1
								THEN
									CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
									THEN
										ISNULL(CR.HazmatSwitchOut,0)
									ELSE
										ISNULL(CR.SwitchOut,0)
									END
								ELSE
									ISNULL(CR.SwitchOut,0)
								END
							END	
						ELSE 
							0 
						END as SwitchOut,
                        CASE WHEN LEId=@LoadedId then 'L' else 'E' end as LE
                        --,CRCM.isCherryPicked
                        from [Contract] c
                        inner join ContractRailCarMapping CRCM on c.Id=CRCM.ContractId and c.Id=@Id and CRCM.ArrivalDate <= @ToDate and (CRCM.DepartureDate is null or CRCM.DepartureDate>=@FromDate)
                        inner join RailCar RC on RC.Id=CRCM.RailCarId    
                        inner join ContractRate CR on CR.ContractId=c.Id and (CR.RateTypeId=1 or CR.RateTypeId=3) and CR.IsActive=1
                        where c.Id=@Id and CRCM.ArrivalDate is not null and CRCM.ArrivalDate <= @ToDate
                        and (CRCM.DepartureDate is null or CRCM.DepartureDate >=@FromDate)) as result) finalResult  

                        select *, (isnull(SwitchIn,0) + isnull(SwitchOut,0) + isnull(SpecialSwitchingAmount,0)) as TotalSwitchingAmount  from (
                        select ContractId, CarInitial, CarNumber, IsHazmatCar, ArrivalDate, DepartureDate,Rider,
                        LEContents, BillingStartDate, SwitchIn, SwitchOut, LE, NoOfDays,TotalDailyRate, TotalDailyAmount, 
                        sum(isnull(CRCC.Amount,0)) as SpecialSwitchingAmount from #activityReport AR
                        left join ContractRailCarCharges CRCC on AR.RailCarMappingId = CRCC.ContractRailCarMappingId
                        and CRCC.[date] >= @fromDate and CRCC.[date] <= @toDate
                        group by ContractId, CarInitial, CarNumber, IsHazmatCar, ArrivalDate, DepartureDate,Rider,
                        LEContents,BillingStartDate,SwitchIn, SwitchOut,LE, NoOfDays,TotalDailyRate, TotalDailyAmount)res

                        select count(1) as TotalCars, ISNULL(Sum(NoOfDays),0) as TotalDaysOfStorage,
						ISNULL(SUM(CASE WHEN ArrivalDate >=@fromDate and ArrivalDate<=@toDate Then 1 else 0 end),0) As ReceivedStorage,
						ISNULL(SUM(CASE WHEN DepartureDate >=@fromDate and DepartureDate<=@toDate Then 1 else 0 end),0) As ReleasedStorage,
						ISNULL(SUM(CASE WHEN DepartureDate is null or DepartureDate>@toDate Then 1 else 0 end),0) As CarsStored
						from #activityReport AR
                                                                
                        select STRING_AGG([commodity], ', ') as Commodities
                        from (select distinct(LEContents) as commodity 
                                        from #activityReport where LEContents!='' and LEContents is not null) AR 

                        drop table  #activityReport
                                                                
   END
   ELSE IF EXISTS(select id from ContractType where Name='Take-or-pay - Term Based' and Id=@ContractTypeId) --TP
   BEGIN
		select *,  DATEDIFF(DAY,TermStartDate,TermEndDate) + 1 as TermDays,
        DATEDIFF(DAY,BillingStartDate,BillingEndDate) + 1 as NoOfDays 
		into #activityReportTerm from (
                        select c.Id as ContractId, RC.CarInitial,RC.CarNumber,CRCM.IsHazmatCar,
                        CRCM.ArrivalDate,CRCM.DepartureDate,                                                              
                        c.Rider, CRCM.railCarid,CRCM.id as RailCarMappingId, CRCM.LEContents,
                        CASE WHEN @FromDate >= c.EffectiveDate then @FromDate else c.EffectiveDate end as TermStartDate,
                        Case When c.ExpiryDate IS null Or c.ExpiryDate >=@ToDate then @ToDate else Cast(c.ExpiryDate as date) end as TermEndDate,
                        CASE WHEN @FromDate >= ArrivalDate then @FromDate else ArrivalDate end as BillingStartDate,
						Case When DepartureDate IS null Or DepartureDate >=@ToDate then @ToDate else DepartureDate end as BillingEndDate,
                        Case when ArrivalDate between @FromDate and @ToDate 
						THEN 
							CASE WHEN LEId=@LoadedId
							THEN
								CASE WHEN CRCM.IsHazmatCar = 1
								THEN
									CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
									THEN
										ISNULL(CR.LoadedSwitchIn, 0 ) 
									ELSE
										CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
										THEN
											ISNULL(CR.HazmatSwitchIn,0)
										ELSE
											ISNULL(CR.SwitchIn,0)
										END
									END
								ELSE
									CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
									THEN
										ISNULL(CR.LoadedSwitchIn, 0 ) 
									ELSE
										ISNULL(CR.SwitchIn,0)
									END
								END
							ELSE
								CASE WHEN CRCM.IsHazmatCar = 1
								THEN
									CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
									THEN
										ISNULL(CR.HazmatSwitchIn,0)
									ELSE
										ISNULL(CR.SwitchIn,0)
									END
								ELSE
									ISNULL(CR.SwitchIn,0)
								END
							END								
						ELSE 
							0 
						END as SwitchIn,
                        Case when DepartureDate between @FromDate and @ToDate 
						THEN
							CASE WHEN LEId=@LoadedId
							THEN
								CASE WHEN CRCM.IsHazmatCar = 1
								THEN
									CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
									THEN
										ISNULL(CR.LoadedSwitchOut, 0 ) 
									ELSE
										CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
										THEN
											ISNULL(CR.HazmatSwitchOut,0)
										ELSE
											ISNULL(CR.SwitchOut,0)
										END
									END
								ELSE
									CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
									THEN
										ISNULL(CR.LoadedSwitchOut, 0 ) 
									ELSE
										ISNULL(CR.SwitchOut,0)
									END
								END
							ELSE
								CASE WHEN CRCM.IsHazmatCar = 1
								THEN
									CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
									THEN
										ISNULL(CR.HazmatSwitchOut,0)
									ELSE
										ISNULL(CR.SwitchOut,0)
									END
								ELSE
									ISNULL(CR.SwitchOut,0)
								END
							END	
						ELSE 
							0 
						END as SwitchOut,
                        CASE WHEN LEId=@LoadedId then 'L' else 'E' end as LE, c.TotalCars
                        --,CRCM.isCherryPicked
                        from [Contract] c
                        left join ContractRailCarMapping CRCM on c.Id=CRCM.ContractId and c.Id=@Id 
                                        and c.EffectiveDate <= @ToDate and (c.ExpiryDate is null or c.ExpiryDate>=@FromDate)
                        inner join RailCar RC on RC.Id=CRCM.RailCarId
                        inner join ContractRate CR on CR.ContractId=c.Id and (CR.RateTypeId=1 or CR.RateTypeId=3) and CR.IsActive=1
                        where c.Id=@Id and CRCM.ArrivalDate is not null and CRCM.ArrivalDate <= @ToDate
                        and (CRCM.DepartureDate is null or CRCM.DepartureDate >=@FromDate)) as result

        select *, (isnull(SwitchIn,0) + isnull(SwitchOut,0) + isnull(SpecialSwitchingAmount,0)) as TotalSwitchingAmount  from (
        select ContractId, CarInitial, CarNumber, IsHazmatCar, ArrivalDate, DepartureDate,Rider,
        LEContents, BillingStartDate, SwitchIn, SwitchOut, LE, NoOfDays, TermDays,
        sum(isnull(CRCC.Amount,0)) as SpecialSwitchingAmount from #activityReportTerm AR
        left join ContractRailCarCharges CRCC on AR.RailCarMappingId = CRCC.ContractRailCarMappingId
        and CRCC.[date] >= @fromDate and CRCC.[date] <= @toDate
        group by ContractId, CarInitial, CarNumber, IsHazmatCar, ArrivalDate, DepartureDate,Rider,
        LEContents,BillingStartDate,SwitchIn, SwitchOut,LE, NoOfDays,TermDays)res

        select count(1) as TotalCars, ISNULL(Sum(NoOfDays),0) as TotalDaysOfStorage,
		ISNULL(SUM(CASE WHEN ArrivalDate >=@fromDate and ArrivalDate<=@toDate Then 1 else 0 end),0) As ReceivedStorage,
		ISNULL(SUM(CASE WHEN DepartureDate >=@fromDate and DepartureDate<=@toDate Then 1 else 0 end),0) As ReleasedStorage,
		ISNULL(SUM(CASE WHEN DepartureDate is null or DepartureDate>@toDate Then 1 else 0 end),0) As CarsStored
		from #activityReportTerm AR
                                                                
        select STRING_AGG([commodity], ', ') as Commodities
        from (select distinct(LEContents) as commodity 
                        from #activityReportTerm where LEContents!='' and LEContents is not null) AR 

        drop table  #activityReportTerm
   END
   ELSE IF EXISTS(select id from ContractType where Name='Take-or-pay - Arrival Based' and Id=@ContractTypeId) --TP
   BEGIN
		DECLARE @FirstArrivalDate Date
        Select @FirstArrivalDate= MIN(ArrivalDate) from ContractRailCarMapping where ContractId=@Id

        select *, DATEDIFF(DAY,TermStartDate,TermEndDate) + 1 as TermDays,
        DATEDIFF(DAY,BillingStartDate,BillingEndDate) + 1 as NoOfDays into #activityReportArrival from (
        select c.Id as ContractId, RC.CarInitial,RC.CarNumber,CRCM.IsHazmatCar,
        CRCM.ArrivalDate,CRCM.DepartureDate,                                                              
        c.Rider, CRCM.railCarid,CRCM.id as RailCarMappingId, CRCM.LEContents,
        CASE WHEN @FromDate >= @FirstArrivalDate then @FromDate else @FirstArrivalDate end as TermStartDate,
        Case When c.ExpiryDate IS null Or c.ExpiryDate >=@ToDate then @ToDate else Cast(c.ExpiryDate as date) end as TermEndDate,
        CASE WHEN @FromDate >= ArrivalDate then @FromDate else ArrivalDate end as BillingStartDate,
        Case When DepartureDate IS null Or DepartureDate >=@ToDate then @ToDate else DepartureDate end as BillingEndDate,
        Case when ArrivalDate between @FromDate and @ToDate 
		THEN 
			CASE WHEN LEId=@LoadedId
			THEN
				CASE WHEN CRCM.IsHazmatCar = 1
				THEN
					CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
					THEN
						ISNULL(CR.LoadedSwitchIn, 0 ) 
					ELSE
						CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
						THEN
							ISNULL(CR.HazmatSwitchIn,0)
						ELSE
							ISNULL(CR.SwitchIn,0)
						END
					END
				ELSE
					CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
					THEN
						ISNULL(CR.LoadedSwitchIn, 0 ) 
					ELSE
						ISNULL(CR.SwitchIn,0)
					END
				END
			ELSE
				CASE WHEN CRCM.IsHazmatCar = 1
				THEN
					CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
					THEN
						ISNULL(CR.HazmatSwitchIn,0)
					ELSE
						ISNULL(CR.SwitchIn,0)
					END
				ELSE
					ISNULL(CR.SwitchIn,0)
				END
			END								
		ELSE 
			0 
		END as SwitchIn,
        Case WHEN DepartureDate between @FromDate and @ToDate 
		THEN
			CASE WHEN LEId=@LoadedId
			THEN
				CASE WHEN CRCM.IsHazmatCar = 1
				THEN
					CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
					THEN
						ISNULL(CR.LoadedSwitchOut, 0 ) 
					ELSE
						CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
						THEN
							ISNULL(CR.HazmatSwitchOut,0)
						ELSE
							ISNULL(CR.SwitchOut,0)
						END
					END
				ELSE
					CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
					THEN
						ISNULL(CR.LoadedSwitchOut, 0 ) 
					ELSE
						ISNULL(CR.SwitchOut,0)
					END
				END
			ELSE
				CASE WHEN CRCM.IsHazmatCar = 1
				THEN
					CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
					THEN
						ISNULL(CR.HazmatSwitchOut,0)
					ELSE
						ISNULL(CR.SwitchOut,0)
					END
				ELSE
					ISNULL(CR.SwitchOut,0)
				END
			END	
		ELSE 
			0 
		END as SwitchOut,
        CASE WHEN LEId=@LoadedId then 'L' else 'E' end as LE
        --,CRCM.isCherryPicked
        from [Contract] c
        left join ContractRailCarMapping CRCM on c.Id=CRCM.ContractId and c.Id=@Id 
                        and c.EffectiveDate <= @ToDate and (c.ExpiryDate is null or c.ExpiryDate>=@FromDate)
        inner join RailCar RC on RC.Id=CRCM.RailCarId
        inner join ContractRate CR on CR.ContractId=c.Id and (CR.RateTypeId=1 or CR.RateTypeId=3) and CR.IsActive=1
        where c.Id=@Id and CRCM.ArrivalDate is not null and CRCM.ArrivalDate <= @ToDate
        and (CRCM.DepartureDate is null or CRCM.DepartureDate >=@FromDate)) result

        select *, (isnull(SwitchIn,0) + isnull(SwitchOut,0) + isnull(SpecialSwitchingAmount,0)) as TotalSwitchingAmount  from (
        select ContractId, CarInitial, CarNumber, IsHazmatCar, ArrivalDate, DepartureDate,Rider,
        LEContents, BillingStartDate, SwitchIn, SwitchOut, LE, NoOfDays, TermDays,
        sum(isnull(CRCC.Amount,0)) as SpecialSwitchingAmount from #activityReportArrival AR
        left join ContractRailCarCharges CRCC on AR.RailCarMappingId = CRCC.ContractRailCarMappingId
        and CRCC.[date] >= @fromDate and CRCC.[date] <= @toDate
        group by ContractId, CarInitial, CarNumber, IsHazmatCar, ArrivalDate, DepartureDate,Rider,
        LEContents,BillingStartDate,SwitchIn, SwitchOut,LE, NoOfDays, TermDays)res

        select count(1) as TotalCars, ISNULL(Sum(NoOfDays),0) as TotalDaysOfStorage,
		ISNULL(SUM(CASE WHEN ArrivalDate >=@fromDate and ArrivalDate<=@toDate Then 1 else 0 end),0) As ReceivedStorage,
		ISNULL(SUM(CASE WHEN DepartureDate >=@fromDate and DepartureDate<=@toDate Then 1 else 0 end),0) As ReleasedStorage,
		ISNULL(SUM(CASE WHEN DepartureDate is null or DepartureDate>@toDate Then 1 else 0 end),0) As CarsStored
		from #activityReportArrival AR
                                                                
        select STRING_AGG([commodity], ', ') as Commodities
        from (select distinct(LEContents) as commodity 
                        from #activityReportArrival where LEContents!='' and LEContents is not null) AR 

        drop table  #activityReportArrival
   END
   ELSE IF EXISTS(select id from ContractType where Name='Reserve' and Id=@ContractTypeId) --TP
   BEGIN
                                ;
                                WITH dates as (
                                                  SELECT CONVERT(date, @FromDate) as dte
                                                  UNION ALL
                                                  SELECT DATEADD(day, 1, dte)
                                                  FROM dates
                                                  WHERE dte <= @ToDate
                                                )

                                select dte, (select ReservedSpaces from Contract where Id =@Id) - 
                                (select COUNT(1) as ttl from ContractRailCarMapping where ContractId=@Id and ArrivalDate<=dte and (DepartureDate is null or DepartureDate>=dte)) as reservedleft
                                from dates

                                --select COUNT(1) as ttl from  ContractRailCarMapping where ContractId=@Id and ArrivalDate<='2022-08-21' and (DepartureDate is null or DepartureDate>='2022-08-21')

                                select *, DATEDIFF(DAY,BillingStartDate,BillingEndDate) + 1 as NoOfDays, COUNT(1) over() as totalCars from (
                                select RC.CarInitial,RC.CarNumber,CRCM.IsHazmatCar,
                                CASE WHEN LE.Name='loaded' then 'L' else 'E' end as LE,
                                CRCM.ArrivalDate,CRCM.DepartureDate,
                                c.Id, c.Rider, CRCM.railCarid,
                                CASE WHEN @FromDate >= ArrivalDate then @FromDate else ArrivalDate end as BillingStartDate,
                                Case When DepartureDate IS null Or DepartureDate >=@ToDate then @ToDate else DepartureDate end as BillingEndDate,
                                Case when ArrivalDate between @FromDate and @ToDate then CR.SwitchIn else 0 end as SwitchIn,
                                Case when DepartureDate between @FromDate and @ToDate then CR.SwitchOut else 0 end as SwitchOut,
                                CASE WHEN LEId=@LoadedId THEN 1 ELSE 0 END As IsLoaded
                                --,CRCM.isCherryPicked
                                from [Contract] c
                                left join ContractRailCarMapping CRCM on c.Id=CRCM.ContractId and c.Id=@Id and CRCM.ArrivalDate <= @ToDate and (CRCM.DepartureDate is null or CRCM.DepartureDate>=@FromDate)
                                inner join RailCar RC on RC.Id=CRCM.RailCarId
                                inner join LEContent LE on LE.Id=CRCM.LEId
                                inner join ContractRate CR on CR.ContractId=c.Id and (CR.RateTypeId=1 or CR.RateTypeId=3) and CR.IsActive=1
                                where c.Id=@Id) as result group by CarInitial,CarNumber,Id,Rider,RailCarId,BillingEndDate,BillingStartDate,IsLoaded,
                                IsHazmatCar,LE,ArrivalDate,DepartureDate,SwitchIn,SwitchOut --, isCherryPicked
   END
    
END
GO


PRINT 'usp_CreateOrUpdateContract Updated successfully';
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_CreateOrUpdateContract]
@Contract ContractUDT readonly,
@ContractRate ContractRateUDT readonly,
@ContractSFFeatureMapping ContractSFFeatureMappingUDT readonly,
@CurrentRole NVARCHAR(MAX)
AS
BEGIN
	DECLARE @ERRORNUMBER INT,
		@ERRORMESSAGE VARCHAR(500),
		@ERRORSEVERITY INT,
		@ERRORSTATE INT,
		@ERRORLINE INT,
		@ERRORPROCEDURE VARCHAR(200),
		@PARAMS VARCHAR(500),
		@MESSAGE NVARCHAR(MAX),
		@MODIFIEDBY INT,
		@MODIFIEDDATETIME DATETIME,
		@BOOKINGFEE [decimal](18, 2),
		@LISTINGFEE [decimal](18, 2);
BEGIN TRY

		IF(@currentRole='vendor')
			SELECT @BOOKINGFEE = (SELECT PercentageMargin FROM Customers C INNER JOIN @Contract CT ON CT.CustomerId=c.Id)
		ELSE
			SELECT @BOOKINGFEE=BookingFee FROM @ContractRate

		IF(@currentRole='customer')
			SELECT @LISTINGFEE =ListingFee,@BOOKINGFEE=BookingFee FROM @ContractRate
		ELSE
			SELECT @LISTINGFEE=ListingFee FROM @ContractRate


	SELECT
		UDTCR.Id,UDTCR.ContractId,UDTCR.RateTypeId,UDTCR.SwitchIn,UDTCR.SwitchOut,UDTCR.SpecialSwitchingRate,UDTCR.DailyStorageRate,
		UDTCR.SwitchingRate,UDTCR.HazmatSurcharge,UDTCR.LoadedSurcharge,UDTCR.ReservationRate,UDTCR.CherryPickingRate,
		@BOOKINGFEE AS BookingFee,
		@LISTINGFEE AS ListingFee,
		UDTCR.IsActive,UDTCR.CreatedTime,UDTCR.CreatedBy,UDTCR.ModifiedTime,UDTCR.ModifiedBy,
		UDTCR.OrganizationId,UDTCR.TenantId,UDTCR.IsAdvancedHazmatSwitchingEnabled,UDTCR.IsAdvancedLoadedSwitchingEnabled,
		UDTCR.HazmatSwitchIn,UDTCR.HazmatSwitchOut,UDTCR.LoadedSwitchIn,UDTCR.LoadedSwitchOut
	INTO #ContractRateDetails
	FROM @ContractRate UDTCR
	LEFT JOIN dbo.ContractRate CR on UDTCR.Id=CR.Id AND
				UDTCR.ContractId=CR.ContractId AND
				UDTCR.RateTypeId=CR.RateTypeId AND
				UDTCR.SwitchIn=CR.SwitchIn AND
				UDTCR.SwitchOut=CR.SwitchOut AND
				ISNULL(UDTCR.SpecialSwitchingRate ,0) = ISNULL(CR.SpecialSwitchingRate,0) AND
				UDTCR.DailyStorageRate=CR.DailyStorageRate AND
				ISNULL(UDTCR.SwitchingRate ,0) = ISNULL(CR.SwitchingRate ,0) AND
				ISNULL(UDTCR.HazmatSurcharge ,0)=ISNULL(CR.HazmatSurcharge,0) AND
				ISNULL(UDTCR.LoadedSurcharge ,0)=ISNULL(CR.LoadedSurcharge,0) AND
				ISNULL(UDTCR.ReservationRate ,0)=ISNULL(CR.ReservationRate,0) AND
				ISNULL(UDTCR.CherryPickingRate,0)=ISNULL(CR.CherryPickingRate,0) AND
				UDTCR.IsAdvancedLoadedSwitchingEnabled = CR.IsAdvancedLoadedSwitchingEnabled AND
				UDTCR.IsAdvancedHazmatSwitchingEnabled = CR.IsAdvancedHazmatSwitchingEnabled AND
				ISNULL(UDTCR.HazmatSwitchIn ,0) = ISNULL(CR.HazmatSwitchIn ,0) AND
				ISNULL(UDTCR.HazmatSwitchOut ,0) = ISNULL(CR.HazmatSwitchOut ,0) AND
				ISNULL(UDTCR.LoadedSwitchIn ,0) = ISNULL(CR.LoadedSwitchIn ,0) AND
				ISNULL(UDTCR.LoadedSwitchOut ,0) = ISNULL(CR.LoadedSwitchOut ,0) AND
				(ISNULL(UDTCR.BookingFee ,0) = ISNULL(CR.BookingFee ,0) OR @CurrentRole='vendor') AND
				(ISNULL(UDTCR.ListingFee ,0) = ISNULL(CR.ListingFee ,0) OR @currentRole='customer')AND
				UDTCR.IsActive=1 where CR.Id IS NULL ;


	DECLARE @ContractId BIGINT;

	IF NOT EXISTS(SELECT 1 FROM @Contract UDTCR INNER JOIN Contract CR ON UDTCR.Id = CR.Id)
	BEGIN
		-- SAVE CONTRACT DETAIL
		INSERT INTO dbo.[Contract] (VendorId,CustomerId,Rider,StorageFacilityId,EffectiveDate,ExpiryDate,ContractTypeId,
									TotalCars,ReservedSpaces,CurrencyId,[Description],[Location],CarsStored,
									IsFlatRateContract,IsAdvancedSwitchingRatesEnabled,IsActive,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,
									OrganizationId,TenantId)
		SELECT VendorId,CustomerId,Rider,StorageFacilityId,EffectiveDate,ExpiryDate,ContractTypeId,TotalCars,ReservedSpaces,
				CurrencyId,[Description],[Location],CarsStored,IsFlatRateContract,IsAdvancedSwitchingRatesEnabled,IsActive,CreatedTime,CreatedBy,
				ModifiedTime,ModifiedBy,OrganizationId,TenantId
		FROM @Contract

		SELECT @ContractId=SCOPE_IDENTITY();



		-- SAVE CONTRACT RATE DETAIL
		INSERT INTO dbo.[ContractRate] (ContractId,RateTypeId,SwitchIn,SwitchOut,SpecialSwitchingRate,DailyStorageRate,
										SwitchingRate,HazmatSurcharge,LoadedSurcharge,ReservationRate,CherryPickingRate,
										BookingFee,ListingFee,IsActive,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,
										TenantId,IsAdvancedHazmatSwitchingEnabled,IsAdvancedLoadedSwitchingEnabled,
										HazmatSwitchIn,HazmatSwitchOut,LoadedSwitchIn,LoadedSwitchOut )
		SELECT @ContractId,RateTypeId,SwitchIn,SwitchOut,SpecialSwitchingRate,DailyStorageRate,SwitchingRate,HazmatSurcharge,
				LoadedSurcharge,ReservationRate,CherryPickingRate,BookingFee,ListingFee,IsActive,CreatedTime,CreatedBy,
				ModifiedTime,ModifiedBy,OrganizationId,TenantId,IsAdvancedHazmatSwitchingEnabled,IsAdvancedLoadedSwitchingEnabled,
				HazmatSwitchIn,HazmatSwitchOut,LoadedSwitchIn,LoadedSwitchOut
		FROM #ContractRateDetails ;

		INSERT INTO ContractSFFeatureMapping
					(ContractId
					,StorageFeatureId
					,IsActive
					,CreatedTime
					,CreatedBy
					,ModifiedTime
					,ModifiedBy
					,OrganizationId
					,TenantId)
		SELECT
			@ContractId
			,StorageFeatureId
			,IsActive
			,CreatedTime
			,CreatedBy
			,ModifiedTime
			,ModifiedBy
			,OrganizationId
			,TenantId
		FROM
			@ContractSFFeatureMapping
		END
	ELSE
	BEGIN

		SET @ContractId = (SELECT Id FROM @Contract)

		UPDATE dbo.[Contract]
			SET VendorId=UDTCT.VendorId,
				CustomerId=UDTCT.CustomerId,
				Rider=UDTCT.Rider,
				StorageFacilityId=UDTCT.StorageFacilityId,
				EffectiveDate=UDTCT.EffectiveDate,
				ExpiryDate=UDTCT.ExpiryDate,
				ContractTypeId=UDTCT.ContractTypeId,
				TotalCars=UDTCT.TotalCars,
				ReservedSpaces=UDTCT.ReservedSpaces,
				CurrencyId=UDTCT.CurrencyId,
				[Description]=UDTCT.[Description],
				[Location]=UDTCT.[Location],
				CarsStored=UDTCT.CarsStored,
				IsFlatRateContract=UDTCT.IsFlatRateContract,
				IsAdvancedSwitchingRatesEnabled=UDTCT.IsAdvancedSwitchingRatesEnabled,
				IsActive=UDTCT.IsActive,
				ModifiedTime=UDTCT.ModifiedTime,
				ModifiedBy=UDTCT.ModifiedBy,
				OrganizationId=UDTCT.OrganizationId,
				TenantId=UDTCT.TenantId
			FROM dbo.[Contract] CT
			INNER JOIN @Contract UDTCT ON CT.Id=UDTCT.Id;

			UPDATE
				dbo.[ContractRate]
			SET
				IsActive=0
			FROM
				dbo.[ContractRate] CTRT
			INNER JOIN
				#ContractRateDetails UDCTRT
			ON
				CTRT.Id=UDCTRT.Id AND CTRT.ContractId=UDCTRT.ContractId;

			INSERT INTO dbo.[ContractRate] (ContractId,RateTypeId,SwitchIn,SwitchOut,SpecialSwitchingRate,DailyStorageRate,
											SwitchingRate,HazmatSurcharge,LoadedSurcharge,ReservationRate,CherryPickingRate,
											BookingFee,ListingFee,IsActive,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,
											OrganizationId,TenantId,IsAdvancedHazmatSwitchingEnabled,IsAdvancedLoadedSwitchingEnabled,
											HazmatSwitchIn,HazmatSwitchOut,LoadedSwitchIn,LoadedSwitchOut )
			SELECT ContractId,RateTypeId,SwitchIn,SwitchOut,SpecialSwitchingRate,DailyStorageRate,SwitchingRate,HazmatSurcharge,
					LoadedSurcharge,ReservationRate,CherryPickingRate,BookingFee,ListingFee,IsActive,CreatedTime,
					CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId,IsAdvancedHazmatSwitchingEnabled,IsAdvancedLoadedSwitchingEnabled,
					HazmatSwitchIn,HazmatSwitchOut,LoadedSwitchIn,LoadedSwitchOut
			FROM #ContractRateDetails ;

			(SELECT TOP 1 @MODIFIEDBY=ModifiedBy,@MODIFIEDDATETIME=ModifiedTime FROM @ContractRate);

			IF((SELECT COUNT(Id) FROM @ContractRate) <> (SELECT COUNT(Id) FROM #ContractRateDetails))
			BEGIN
				UPDATE dbo.[ContractRate]
				SET
					ModifiedBy=@MODIFIEDBY,
					ModifiedTime= @MODIFIEDDATETIME
				FROM dbo.[ContractRate] CTRT
				LEFT JOIN #ContractRateDetails UDCTRT ON CTRT.Id=UDCTRT.Id
				WHERE UDCTRT.Id IS NULL AND CTRT.ContractId=@ContractId AND CTRT.IsActive=1;
			END

			MERGE ContractSFFeatureMapping AS Target
			USING @ContractSFFeatureMapping AS Source
			ON Source.ContractId = Target.ContractId AND Source.StorageFeatureId = Target.StorageFeatureId

			WHEN NOT MATCHED BY Target THEN
			INSERT (ContractId,
					StorageFeatureId,
					IsActive,
					CreatedTime,
					CreatedBy,
					ModifiedTime,
					ModifiedBy,
					OrganizationId,
					TenantId)
			VALUES (Source.ContractId,
					Source.StorageFeatureId,
					Source.IsActive,
					Source.CreatedTime,
					Source.CreatedBy,
					Source.ModifiedTime,
					Source.ModifiedBy,
					Source.OrganizationId,
					Source.TenantId)

			WHEN MATCHED THEN UPDATE SET
				Target.IsACtive=Source.IsActive,
				Target.ModifiedTime=Source.ModifiedTime,
				Target.ModifiedBy=Source.ModifiedBy,
				Target.OrganizationId=Source.OrganizationId,
				Target.TenantId =Source.TenantId;
		END
		SELECT @ContractId
	END TRY
	BEGIN CATCH
		SELECT
			@ERRORMESSAGE = ERROR_MESSAGE(),
			@ERRORSEVERITY = ERROR_SEVERITY(),
			@ERRORNUMBER = ERROR_NUMBER(),
			@ERRORPROCEDURE = ERROR_PROCEDURE(),
			@ERRORLINE = ERROR_LINE(),
			@ERRORSTATE = ERROR_STATE();

			SET @PARAMS = 'Parameter 1:'+ CAST(@ContractId AS varchar(10));
			SET @MESSAGE = 'ERROR NUMBER:' + CAST(@ERRORNUMBER AS VARCHAR(5)) + CHAR(13)
							+'PROCEDURE NAME:'+ @ERRORPROCEDURE + CHAR(13)
							+'PROCEDURE LINE:'+ CAST(@ERRORLINE AS VARCHAR(5)) + CHAR(13)
							+'ERROR MESSAGE:'+ @ERRORMESSAGE + CHAR(13)
							+'PARAMETERS:'+@PARAMS + CHAR(13);

		--INSERT INTO [dbo].[DB_Errors]
		-- VALUES (SUSER_SNAME(), @MESSAGE, GETDATE());

		-- return the error inside the CATCH block
	RAISERROR(@MESSAGE, @ERRORSEVERITY, @ERRORSTATE);
	END CATCH
END
GO


PRINT 'SP_StorageFacilityActivityReport Updated successfully';
GO

--[dbo].[SP_StorageFacilityActivityReportbackup] 3,1,'2022-08-01','2022-09-30'

CREATE OR ALTER PROCEDURE [dbo].[SP_StorageFacilityActivityReport] 
@Id BIGINT,
@ContractTypeId BigInt,
@FromDate   NVARCHAR(max) =NULL,
@ToDate     NVARCHAR(max) =NULL
AS  
BEGIN  
                DECLARE @LoadedId BIGINT
                Select @LoadedId = ID from LEContent where Name='Loaded'

                SELECT 
                                C.Id,
                                ORG.[Name] as OrganizationName,
                                CUS.[Address] +', ' + ISNULL(CUS.City,'') +', '+ ISNULL(S.Name,'') +', ' + ISNULL(CTRY.NAME,'') AS OrgAddress,
                                @FromDate as ReportFromDate,
                                @ToDate as ReportToDate,
                                C.Rider as [Order],
                                SF.[Name] AS FacilityName,
                                SF.[Address] +', ' + ISNULL(SF.City,'') +', '+ ISNULL(SSF.Name,'') +', ' + ISNULL(CTRYSF.NAME,'') AS FacilityAddress,
                                GETDATE() as ReportDate,
                                CT.[Name] as ContractType,
                                CURR.Code as Currency,
                                CR.DailyStorageRate,
								C.IsAdvancedSwitchingRatesEnabled,
                                ISNULL(CR.HazmatSurcharge,0) as HazmatSurcharge,
                                ISNULL(CR.LoadedSurcharge,0) as LoadedSurcharge,
                                ISNULL(CR.CherryPickingRate,0) as CherryPickingRate,
                                CR.SwitchIn as SwitchIn,
                                CR.SwitchOut as SwitchOut,
								CR.LoadedSwitchIn as LoadedSwitchIn,
                                CR.LoadedSwitchOut as LoadedSwitchOut,
								CR.HazmatSwitchIn as HazmatSwitchIn,
                                CR.HazmatSwitchOut as HazmatSwitchOut,
                                C.TotalCars as ContractedSpace
                FROM
                                [Contract] C
                INNER JOIN
                                Customers CUS
                ON
                                CUS.Id = C.CustomerId
                INNER JOIN
                                Organization ORG
                ON
                                ORG.Id=CUS.OrganizationId
                INNER JOIN
                                StorageFacility SF
                ON         
                                SF.Id = C.StorageFacilityId
                INNER JOIN
                                ContractType CT
                ON         
                                CT.Id = C.ContractTypeId
                LEFT JOIN
                                State S
                ON
                                S.Id=CUS.StateId
                LEFT JOIN
                                Country CTRY
                ON
                                CTRY.Id=CUS.CountryId
                LEFT JOIN
                                State SSF
                ON
                                SSF.Id=SF.StateId
                LEFT JOIN
                                Country CTRYSF
                ON
                                CTRYSF.Id=SF.CountryId
                LEFT JOIN
                     Currency CURR
                ON CURR.Id = C.CurrencyId
                LEFT JOIN
                                ContractRate CR
                ON
                                CR.ContractId=C.Id and CR.IsActive=1 and (CR.RateTypeId=1 or CR.RateTypeId=3)
                WHERE
                                C.ID=@Id
   
   IF EXISTS(select id from ContractType where Name='SPOT' and Id=@ContractTypeId)
   BEGIN
     
		select *, NoOfDays * TotalDailyRate as TotalDailyAmount into #activityReport from (
        select *, DATEDIFF(DAY,BillingStartDate,BillingEndDate) + 1 as NoOfDays,
        --(DATEDIFF(DAY,BillingStartDate,BillingEndDate) + 1) * DailyStorageRate as TotalDailyAmount 
        CASE WHEN LE='L' 
                        THEN 
                                        CASE WHEN IsHazmatCar=1 
                                                        then DailyStorageRate + isnull(LoadedSurcharge,0) + isnull(HazmatSurcharge,0)
                                                        else DailyStorageRate + isnull(LoadedSurcharge,0)
                                                        end 
                        ELSE 
                                        CASE WHEN IsHazmatCar=1 
                                                        then DailyStorageRate + isnull(HazmatSurcharge,0)
                                                        else DailyStorageRate
                                                        end 
                        END as TotalDailyRate
        from (
                        select c.Id as ContractId, RC.CarInitial, RC.CarNumber,CRCM.IsHazmatCar,                                             
                        CRCM.ArrivalDate,CRCM.DepartureDate,
                        c.Rider, CRCM.railCarid,CRCM.id as RailCarMappingId,
                        CR.DailyStorageRate, CR.HazmatSurcharge, CR.LoadedSurcharge, CRCM.LEContents,
                        CASE WHEN @FromDate >= ArrivalDate then @FromDate else ArrivalDate end as BillingStartDate,
                        Case When DepartureDate IS null Or DepartureDate >=@ToDate then @ToDate else DepartureDate end as BillingEndDate,
                        Case when ArrivalDate between @FromDate and @ToDate 
							THEN 
								CASE WHEN LEId=@LoadedId
								THEN
									CASE WHEN CRCM.IsHazmatCar = 1
									THEN
										CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
										THEN
											ISNULL(CR.LoadedSwitchIn, 0 ) 
										ELSE
											CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
											THEN
												ISNULL(CR.HazmatSwitchIn,0)
											ELSE
												ISNULL(CR.SwitchIn,0)
											END
										END
									ELSE
										CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
										THEN
											ISNULL(CR.LoadedSwitchIn, 0 ) 
										ELSE
											ISNULL(CR.SwitchIn,0)
										END
									END
								ELSE
									CASE WHEN CRCM.IsHazmatCar = 1
									THEN
										CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
										THEN
											ISNULL(CR.HazmatSwitchIn,0)
										ELSE
											ISNULL(CR.SwitchIn,0)
										END
									ELSE
										ISNULL(CR.SwitchIn,0)
									END
								END								
							ELSE 
								0 
							END as SwitchIn,
                        Case when DepartureDate between @FromDate and @ToDate 
						THEN
							CASE WHEN LEId=@LoadedId
							THEN
								CASE WHEN CRCM.IsHazmatCar = 1
								THEN
									CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
									THEN
										ISNULL(CR.LoadedSwitchOut, 0 ) 
									ELSE
										CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
										THEN
											ISNULL(CR.HazmatSwitchOut,0)
										ELSE
											ISNULL(CR.SwitchOut,0)
										END
									END
								ELSE
									CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
									THEN
										ISNULL(CR.LoadedSwitchOut, 0 ) 
									ELSE
										ISNULL(CR.SwitchOut,0)
									END
								END
							ELSE
								CASE WHEN CRCM.IsHazmatCar = 1
								THEN
									CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
									THEN
										ISNULL(CR.HazmatSwitchOut,0)
									ELSE
										ISNULL(CR.SwitchOut,0)
									END
								ELSE
									ISNULL(CR.SwitchOut,0)
								END
							END	
						ELSE 
							0 
						END as SwitchOut,
                        CASE WHEN LEId=@LoadedId then 'L' else 'E' end as LE
                        --,CRCM.isCherryPicked
                        from [Contract] c
                        inner join ContractRailCarMapping CRCM on c.Id=CRCM.ContractId and c.Id=@Id and CRCM.ArrivalDate <= @ToDate and (CRCM.DepartureDate is null or CRCM.DepartureDate>=@FromDate)
                        inner join RailCar RC on RC.Id=CRCM.RailCarId    
                        inner join ContractRate CR on CR.ContractId=c.Id and (CR.RateTypeId=1 or CR.RateTypeId=3) and CR.IsActive=1
                        where c.Id=@Id and CRCM.ArrivalDate is not null and CRCM.ArrivalDate <= @ToDate
                        and (CRCM.DepartureDate is null or CRCM.DepartureDate >=@FromDate)) as result) finalResult  

                        select *, (isnull(SwitchIn,0) + isnull(SwitchOut,0) + isnull(SpecialSwitchingAmount,0)) as TotalSwitchingAmount  from (
                        select ContractId, CarInitial, CarNumber, IsHazmatCar, ArrivalDate, DepartureDate,Rider,
                        LEContents, BillingStartDate, SwitchIn, SwitchOut, LE, NoOfDays,TotalDailyRate, TotalDailyAmount, 
                        sum(isnull(CRCC.Amount,0)) as SpecialSwitchingAmount from #activityReport AR
                        left join ContractRailCarCharges CRCC on AR.RailCarMappingId = CRCC.ContractRailCarMappingId
                        and CRCC.[date] >= @fromDate and CRCC.[date] <= @toDate
                        group by ContractId, CarInitial, CarNumber, IsHazmatCar, ArrivalDate, DepartureDate,Rider,
                        LEContents,BillingStartDate,SwitchIn, SwitchOut,LE, NoOfDays,TotalDailyRate, TotalDailyAmount)res

                        select count(1) as TotalCars, ISNULL(Sum(NoOfDays),0) as TotalDaysOfStorage,
						ISNULL(SUM(CASE WHEN ArrivalDate >=@fromDate and ArrivalDate<=@toDate Then 1 else 0 end),0) As ReceivedStorage,
						ISNULL(SUM(CASE WHEN DepartureDate >=@fromDate and DepartureDate<=@toDate Then 1 else 0 end),0) As ReleasedStorage,
						ISNULL(SUM(CASE WHEN DepartureDate is null or DepartureDate>@toDate Then 1 else 0 end),0) As CarsStored
						from #activityReport AR
                                                                
                        select STRING_AGG([commodity], ', ') as Commodities
                        from (select distinct(LEContents) as commodity 
                                        from #activityReport where LEContents!='' and LEContents is not null) AR 

                        drop table  #activityReport
                                                                
   END
   ELSE IF EXISTS(select id from ContractType where Name='Take-or-pay - Term Based' and Id=@ContractTypeId) --TP
   BEGIN
		select *,  DATEDIFF(DAY,TermStartDate,TermEndDate) + 1 as TermDays,
        DATEDIFF(DAY,BillingStartDate,BillingEndDate) + 1 as NoOfDays 
		into #activityReportTerm from (
                        select c.Id as ContractId, RC.CarInitial,RC.CarNumber,CRCM.IsHazmatCar,
                        CRCM.ArrivalDate,CRCM.DepartureDate,                                                              
                        c.Rider, CRCM.railCarid,CRCM.id as RailCarMappingId, CRCM.LEContents,
                        CASE WHEN @FromDate >= c.EffectiveDate then @FromDate else c.EffectiveDate end as TermStartDate,
                        Case When c.ExpiryDate IS null Or c.ExpiryDate >=@ToDate then @ToDate else Cast(c.ExpiryDate as date) end as TermEndDate,
                        CASE WHEN @FromDate >= ArrivalDate then @FromDate else ArrivalDate end as BillingStartDate,
						Case When DepartureDate IS null Or DepartureDate >=@ToDate then @ToDate else DepartureDate end as BillingEndDate,
                        Case when ArrivalDate between @FromDate and @ToDate 
						THEN 
							CASE WHEN LEId=@LoadedId
							THEN
								CASE WHEN CRCM.IsHazmatCar = 1
								THEN
									CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
									THEN
										ISNULL(CR.LoadedSwitchIn, 0 ) 
									ELSE
										CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
										THEN
											ISNULL(CR.HazmatSwitchIn,0)
										ELSE
											ISNULL(CR.SwitchIn,0)
										END
									END
								ELSE
									CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
									THEN
										ISNULL(CR.LoadedSwitchIn, 0 ) 
									ELSE
										ISNULL(CR.SwitchIn,0)
									END
								END
							ELSE
								CASE WHEN CRCM.IsHazmatCar = 1
								THEN
									CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
									THEN
										ISNULL(CR.HazmatSwitchIn,0)
									ELSE
										ISNULL(CR.SwitchIn,0)
									END
								ELSE
									ISNULL(CR.SwitchIn,0)
								END
							END								
						ELSE 
							0 
						END as SwitchIn,
                        Case when DepartureDate between @FromDate and @ToDate 
						THEN
							CASE WHEN LEId=@LoadedId
							THEN
								CASE WHEN CRCM.IsHazmatCar = 1
								THEN
									CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
									THEN
										ISNULL(CR.LoadedSwitchOut, 0 ) 
									ELSE
										CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
										THEN
											ISNULL(CR.HazmatSwitchOut,0)
										ELSE
											ISNULL(CR.SwitchOut,0)
										END
									END
								ELSE
									CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
									THEN
										ISNULL(CR.LoadedSwitchOut, 0 ) 
									ELSE
										ISNULL(CR.SwitchOut,0)
									END
								END
							ELSE
								CASE WHEN CRCM.IsHazmatCar = 1
								THEN
									CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
									THEN
										ISNULL(CR.HazmatSwitchOut,0)
									ELSE
										ISNULL(CR.SwitchOut,0)
									END
								ELSE
									ISNULL(CR.SwitchOut,0)
								END
							END	
						ELSE 
							0 
						END as SwitchOut,
                        CASE WHEN LEId=@LoadedId then 'L' else 'E' end as LE, c.TotalCars
                        --,CRCM.isCherryPicked
                        from [Contract] c
                        left join ContractRailCarMapping CRCM on c.Id=CRCM.ContractId and c.Id=@Id 
                                        and c.EffectiveDate <= @ToDate and (c.ExpiryDate is null or c.ExpiryDate>=@FromDate)
                        inner join RailCar RC on RC.Id=CRCM.RailCarId
                        inner join ContractRate CR on CR.ContractId=c.Id and (CR.RateTypeId=1 or CR.RateTypeId=3) and CR.IsActive=1
                        where c.Id=@Id and CRCM.ArrivalDate is not null and CRCM.ArrivalDate <= @ToDate
                        and (CRCM.DepartureDate is null or CRCM.DepartureDate >=@FromDate)) as result

        select *, (isnull(SwitchIn,0) + isnull(SwitchOut,0) + isnull(SpecialSwitchingAmount,0)) as TotalSwitchingAmount  from (
        select ContractId, CarInitial, CarNumber, IsHazmatCar, ArrivalDate, DepartureDate,Rider,
        LEContents, BillingStartDate, SwitchIn, SwitchOut, LE, NoOfDays, TermDays,
        sum(isnull(CRCC.Amount,0)) as SpecialSwitchingAmount from #activityReportTerm AR
        left join ContractRailCarCharges CRCC on AR.RailCarMappingId = CRCC.ContractRailCarMappingId
        and CRCC.[date] >= @fromDate and CRCC.[date] <= @toDate
        group by ContractId, CarInitial, CarNumber, IsHazmatCar, ArrivalDate, DepartureDate,Rider,
        LEContents,BillingStartDate,SwitchIn, SwitchOut,LE, NoOfDays,TermDays)res

        select count(1) as TotalCars, ISNULL(Sum(NoOfDays),0) as TotalDaysOfStorage,
		ISNULL(SUM(CASE WHEN ArrivalDate >=@fromDate and ArrivalDate<=@toDate Then 1 else 0 end),0) As ReceivedStorage,
		ISNULL(SUM(CASE WHEN DepartureDate >=@fromDate and DepartureDate<=@toDate Then 1 else 0 end),0) As ReleasedStorage,
		ISNULL(SUM(CASE WHEN DepartureDate is null or DepartureDate>@toDate Then 1 else 0 end),0) As CarsStored
		from #activityReportTerm AR
                                                                
        select STRING_AGG([commodity], ', ') as Commodities
        from (select distinct(LEContents) as commodity 
                        from #activityReportTerm where LEContents!='' and LEContents is not null) AR 

        drop table  #activityReportTerm
   END
   ELSE IF EXISTS(select id from ContractType where Name='Take-or-pay - Arrival Based' and Id=@ContractTypeId) --TP
   BEGIN
		DECLARE @FirstArrivalDate Date
        Select @FirstArrivalDate= MIN(ArrivalDate) from ContractRailCarMapping where ContractId=@Id

        select *, DATEDIFF(DAY,TermStartDate,TermEndDate) + 1 as TermDays,
        DATEDIFF(DAY,BillingStartDate,BillingEndDate) + 1 as NoOfDays into #activityReportArrival from (
        select c.Id as ContractId, RC.CarInitial,RC.CarNumber,CRCM.IsHazmatCar,
        CRCM.ArrivalDate,CRCM.DepartureDate,                                                              
        c.Rider, CRCM.railCarid,CRCM.id as RailCarMappingId, CRCM.LEContents,
        CASE WHEN @FromDate >= @FirstArrivalDate then @FromDate else @FirstArrivalDate end as TermStartDate,
        Case When c.ExpiryDate IS null Or c.ExpiryDate >=@ToDate then @ToDate else Cast(c.ExpiryDate as date) end as TermEndDate,
        CASE WHEN @FromDate >= ArrivalDate then @FromDate else ArrivalDate end as BillingStartDate,
        Case When DepartureDate IS null Or DepartureDate >=@ToDate then @ToDate else DepartureDate end as BillingEndDate,
        Case when ArrivalDate between @FromDate and @ToDate 
		THEN 
			CASE WHEN LEId=@LoadedId
			THEN
				CASE WHEN CRCM.IsHazmatCar = 1
				THEN
					CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
					THEN
						ISNULL(CR.LoadedSwitchIn, 0 ) 
					ELSE
						CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
						THEN
							ISNULL(CR.HazmatSwitchIn,0)
						ELSE
							ISNULL(CR.SwitchIn,0)
						END
					END
				ELSE
					CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
					THEN
						ISNULL(CR.LoadedSwitchIn, 0 ) 
					ELSE
						ISNULL(CR.SwitchIn,0)
					END
				END
			ELSE
				CASE WHEN CRCM.IsHazmatCar = 1
				THEN
					CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
					THEN
						ISNULL(CR.HazmatSwitchIn,0)
					ELSE
						ISNULL(CR.SwitchIn,0)
					END
				ELSE
					ISNULL(CR.SwitchIn,0)
				END
			END								
		ELSE 
			0 
		END as SwitchIn,
        Case WHEN DepartureDate between @FromDate and @ToDate 
		THEN
			CASE WHEN LEId=@LoadedId
			THEN
				CASE WHEN CRCM.IsHazmatCar = 1
				THEN
					CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
					THEN
						ISNULL(CR.LoadedSwitchOut, 0 ) 
					ELSE
						CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
						THEN
							ISNULL(CR.HazmatSwitchOut,0)
						ELSE
							ISNULL(CR.SwitchOut,0)
						END
					END
				ELSE
					CASE WHEN CR.IsAdvancedLoadedSwitchingEnabled = 1
					THEN
						ISNULL(CR.LoadedSwitchOut, 0 ) 
					ELSE
						ISNULL(CR.SwitchOut,0)
					END
				END
			ELSE
				CASE WHEN CRCM.IsHazmatCar = 1
				THEN
					CASE WHEN CR.IsAdvancedHazmatSwitchingEnabled = 1
					THEN
						ISNULL(CR.HazmatSwitchOut,0)
					ELSE
						ISNULL(CR.SwitchOut,0)
					END
				ELSE
					ISNULL(CR.SwitchOut,0)
				END
			END	
		ELSE 
			0 
		END as SwitchOut,
        CASE WHEN LEId=@LoadedId then 'L' else 'E' end as LE
        --,CRCM.isCherryPicked
        from [Contract] c
        left join ContractRailCarMapping CRCM on c.Id=CRCM.ContractId and c.Id=@Id 
                        and c.EffectiveDate <= @ToDate and (c.ExpiryDate is null or c.ExpiryDate>=@FromDate)
        inner join RailCar RC on RC.Id=CRCM.RailCarId
        inner join ContractRate CR on CR.ContractId=c.Id and (CR.RateTypeId=1 or CR.RateTypeId=3) and CR.IsActive=1
        where c.Id=@Id and CRCM.ArrivalDate is not null and CRCM.ArrivalDate <= @ToDate
        and (CRCM.DepartureDate is null or CRCM.DepartureDate >=@FromDate)) result

        select *, (isnull(SwitchIn,0) + isnull(SwitchOut,0) + isnull(SpecialSwitchingAmount,0)) as TotalSwitchingAmount  from (
        select ContractId, CarInitial, CarNumber, IsHazmatCar, ArrivalDate, DepartureDate,Rider,
        LEContents, BillingStartDate, SwitchIn, SwitchOut, LE, NoOfDays, TermDays,
        sum(isnull(CRCC.Amount,0)) as SpecialSwitchingAmount from #activityReportArrival AR
        left join ContractRailCarCharges CRCC on AR.RailCarMappingId = CRCC.ContractRailCarMappingId
        and CRCC.[date] >= @fromDate and CRCC.[date] <= @toDate
        group by ContractId, CarInitial, CarNumber, IsHazmatCar, ArrivalDate, DepartureDate,Rider,
        LEContents,BillingStartDate,SwitchIn, SwitchOut,LE, NoOfDays, TermDays)res

        select count(1) as TotalCars, ISNULL(Sum(NoOfDays),0) as TotalDaysOfStorage,
		ISNULL(SUM(CASE WHEN ArrivalDate >=@fromDate and ArrivalDate<=@toDate Then 1 else 0 end),0) As ReceivedStorage,
		ISNULL(SUM(CASE WHEN DepartureDate >=@fromDate and DepartureDate<=@toDate Then 1 else 0 end),0) As ReleasedStorage,
		ISNULL(SUM(CASE WHEN DepartureDate is null or DepartureDate>@toDate Then 1 else 0 end),0) As CarsStored
		from #activityReportArrival AR
                                                                
        select STRING_AGG([commodity], ', ') as Commodities
        from (select distinct(LEContents) as commodity 
                        from #activityReportArrival where LEContents!='' and LEContents is not null) AR 

        drop table  #activityReportArrival
   END
   ELSE IF EXISTS(select id from ContractType where Name='Reserve' and Id=@ContractTypeId) --TP
   BEGIN
                                ;
                                WITH dates as (
                                                  SELECT CONVERT(date, @FromDate) as dte
                                                  UNION ALL
                                                  SELECT DATEADD(day, 1, dte)
                                                  FROM dates
                                                  WHERE dte <= @ToDate
                                                )

                                select dte, (select ReservedSpaces from Contract where Id =@Id) - 
                                (select COUNT(1) as ttl from ContractRailCarMapping where ContractId=@Id and ArrivalDate<=dte and (DepartureDate is null or DepartureDate>=dte)) as reservedleft
                                from dates

                                --select COUNT(1) as ttl from  ContractRailCarMapping where ContractId=@Id and ArrivalDate<='2022-08-21' and (DepartureDate is null or DepartureDate>='2022-08-21')

                                select *, DATEDIFF(DAY,BillingStartDate,BillingEndDate) + 1 as NoOfDays, COUNT(1) over() as totalCars from (
                                select RC.CarInitial,RC.CarNumber,CRCM.IsHazmatCar,
                                CASE WHEN LE.Name='loaded' then 'L' else 'E' end as LE,
                                CRCM.ArrivalDate,CRCM.DepartureDate,
                                c.Id, c.Rider, CRCM.railCarid,
                                CASE WHEN @FromDate >= ArrivalDate then @FromDate else ArrivalDate end as BillingStartDate,
                                Case When DepartureDate IS null Or DepartureDate >=@ToDate then @ToDate else DepartureDate end as BillingEndDate,
                                Case when ArrivalDate between @FromDate and @ToDate then CR.SwitchIn else 0 end as SwitchIn,
                                Case when DepartureDate between @FromDate and @ToDate then CR.SwitchOut else 0 end as SwitchOut,
                                CASE WHEN LEId=@LoadedId THEN 1 ELSE 0 END As IsLoaded
                                --,CRCM.isCherryPicked
                                from [Contract] c
                                left join ContractRailCarMapping CRCM on c.Id=CRCM.ContractId and c.Id=@Id and CRCM.ArrivalDate <= @ToDate and (CRCM.DepartureDate is null or CRCM.DepartureDate>=@FromDate)
                                inner join RailCar RC on RC.Id=CRCM.RailCarId
                                inner join LEContent LE on LE.Id=CRCM.LEId
                                inner join ContractRate CR on CR.ContractId=c.Id and (CR.RateTypeId=1 or CR.RateTypeId=3) and CR.IsActive=1
                                where c.Id=@Id) as result group by CarInitial,CarNumber,Id,Rider,RailCarId,BillingEndDate,BillingStartDate,IsLoaded,
                                IsHazmatCar,LE,ArrivalDate,DepartureDate,SwitchIn,SwitchOut --, isCherryPicked
   END
    
END
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_GetOpportunityOrderSummaryDetails]
@OpportunityId BIGINT
AS
BEGIN
	
	Declare @StorageFacilityId BIGINT;
	SELECT @StorageFacilityId = FacilityId FROM Opportunity WHERE id = @OpportunityId

	SELECT TOP(1) SF.Name,SFI.MarkCode,SFR.DailyStorageRate,CR.Code 
		FROM StorageFacility SF 
			INNER JOIN StorageFacilityInterchange SFI ON SF.Id=SFI.StorageFacilityId 
			INNER JOIN StorageFacilityRate SFR ON SFI.StorageFacilityId=SFR.StorageFacilityId
			INNER JOIN Currency CR ON SFR.CurrencyId = CR.Id
		WHERE SF.Id = @StorageFacilityId
	
	SELECT ReservedSpaces, ExpirationDate, EffectiveDate
		FROM OpportunityReservedSpaces 
		WHERE OpportunityId=@OpportunityId

	SELECT SFT.NAME AS Features
		FROM StorageFeature SFT 
			INNER JOIN OpportunityFeatures OFT ON SFT.Id = OFT.FeatureId 
		WHERE OFT.OpportunityId = @OpportunityId

END
GO

PRINT '[SP_GetOpportunityOrderSummaryDetails] Updated Successfully';
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_GetOpportunityDetailsById]
@OpportunityId BIGINT
AS
BEGIN
		--Counting TotalNoApproxSpaces and TotalNoReservedSpaces
		DECLARE @TotalNoApproxSpaces BIGINT
		DECLARE @TotalNoReservedSpaces BIGINT
		SELECT @TotalNoApproxSpaces=SUM(ExpectedNumberOfCars) OVER()  FROM OpportunityRailcarDetails WHERE OpportunityID=@OpportunityId AND IsActive=1
		SELECT @TotalNoReservedSpaces=SUM(ReservedSpaces) OVER()  FROM OpportunityReservedSpaces WHERE OpportunityID=@OpportunityId AND IsActive=1
		
		--Opportunity Record
		SELECT DISTINCT
			OP.Id,
			[Name],
			StartDate,
			EndDate,
			BookingStatus,
			AgreementPath,
			VendorId,
			CustomerId,
			FacilityId,
			@TotalNoApproxSpaces AS TotalNoApproxSpaces,
			@TotalNoReservedSpaces AS TotalNoReservedSpaces
		FROM 
			Opportunity OP
		WHERE
			OP.ID=@OpportunityId

		--OpportunityRailcar Records
		SELECT 
			ORCD.Id,
			OpportunityId,
			ExpectedNumberOfCars,
			LEId,
			LE.[Name] AS LandE,
			Commodity,
			IsHazmat,
			CarType,
			RailcarIds,
			RCT.[Name] AS CarTypeName

		FROM 
			[dbo].[OpportunityRailcarDetails] ORCD
		LEFT JOIN 
			LEContent LE ON ORCD.LEId=LE.Id
		LEFT JOIN
			RailCarType RCT ON RCT.Id=ORCD.CarType
		WHERE
			OpportunityID=@OpportunityId AND ORCD.IsActive=1

		--OpportunityAttachments Records
		SELECT 
			Id,
			OpportunityId,
			[Name],
			[Path],
			IsActive,
			Size,
			CreatedDate
		FROM 
			[dbo].[OpportunityAttachments]			
		WHERE
			OpportunityID=@OpportunityId AND IsActive=1
END
GO

PRINT '[SP_GetOpportunityDetailsById] Updated Successfully';
GO

COMMIT TRANSACTION