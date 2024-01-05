--[dbo].[SP_StorageFacilityActivityReport] 27,1,'2022-08-01','2022-09-30'

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
                                CONCAT_WS(', ',NULLIF(CUS.[Address], '') , NULLIF(CUS.City,'') , NULLIF(S.Name,'') , NULLIF(CTRY.NAME,'')) AS OrgAddress,
								@FromDate as ReportFromDate,
                                @ToDate as ReportToDate,
                                C.Rider as [Order],
                                SF.[Name] AS FacilityName,
                                CONCAT_WS(', ',NULLIF(SF.[Address], ''), NULLIF(SF.City,''), NULLIF(SSF.Name,''), NULLIF(CTRYSF.NAME,'')) AS FacilityAddress,
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


