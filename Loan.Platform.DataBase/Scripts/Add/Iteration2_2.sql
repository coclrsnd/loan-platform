BEGIN TRANSACTION
GO

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

PRINT 'SP_StorageFacilityActivityReport Updated successfully';
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_CreateOrUpdateOpportunity]
	@Opportunity OpportunityUDT READONLY,
	@OpportunityRailcarDetails OpportunityRailcarDetailsUDT READONLY,
	@OpportunityAttachments OpportunityAttachmentsUDT READONLY
AS
BEGIN
	DECLARE @OpportunityName VARCHAR(100);	
	DECLARE @VendorId BIGINT;
	DECLARE @CustomerId BIGINT;
	DECLARE @Count BIGINT;

	--Parameters used for error handling
	DECLARE @ERRORNUMBER INT,
			@ERRORMESSAGE VARCHAR(500),
			@ERRORSEVERITY INT,
			@ERRORSTATE INT,
			@ERRORLINE INT,
			@ERRORPROCEDURE VARCHAR(200),
			@PARAMS VARCHAR(500),
			@MESSAGE NVARCHAR(MAX);

	BEGIN TRY 				

		DECLARE @OpportunityId BIGINT;	
		IF NOT EXISTS(SELECT 1 FROM  @Opportunity UDOPNT INNER JOIN Opportunity OPNT ON UDOPNT.Id = OPNT.Id)
		BEGIN
		
			DECLARE @VendorName VARCHAR(100);
			DECLARE @CustomerName VARCHAR(100);

			SELECT @VendorId=VendorId, @CustomerId=CustomerId FROM @Opportunity
			SELECT @VendorName=org.[Name] FROM Organization org INNER JOIN Vendor ven ON org.Id=ven.OrganizationId WHERE ven.Id=@VendorId
			SELECT @CustomerName=org.[Name] FROM Organization org INNER JOIN Customers cust ON org.Id=cust.OrganizationId WHERE org.Id=@CustomerId
			
			SET @OpportunityName= @VendorName + ' - ' + @CustomerName + ' - '+CAST(DATEPART(YYYY,GETDATE()) AS VARCHAR)+ ' - INPROCESS';
	
			-- Save Opportunity
		    INSERT INTO dbo.[Opportunity] ([Name],StartDate,EndDate,BookingStatus,AgreementPath,VendorId
				,CustomerId,FacilityId,IsActive,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId)
			SELECT @OpportunityName,StartDate,EndDate,BookingStatus,AgreementPath,VendorId,CustomerId,FacilityId			,IsActive
				,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId
			FROM @Opportunity
	
	        SELECT @OpportunityId=SCOPE_IDENTITY();
	
			-- Save OpportunityRailCarDetails
			INSERT INTO dbo.[OpportunityRailcarDetails](OpportunityID,ExpectedNumberOfCars,LEId,Commodity,IsHazmat,CarType,RailcarIds,
				IsActive,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId)
			SELECT @OpportunityId,ExpectedNumberOfCars,LEId,Commodity,IsHazmat,CarType,RailcarIds,IsActive,CreatedTime,CreatedBy
	            ,ModifiedTime,ModifiedBy,OrganizationId,TenantId
			FROM @OpportunityRailcarDetails

			-- Save OpportunityAttachments
			INSERT INTO OpportunityAttachments (OpportunityId,[Name],[Path],IsActive,CreatedTime,CreatedBy,ModifiedTime
				,ModifiedBy,OrganizationId,TenantId,Size,CreatedDate)
			SELECT @OpportunityId,[Name],[Path],IsActive,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId,Size,CreatedDate
			FROM @OpportunityAttachments
	
		END
		ELSE
		BEGIN

			SET @OpportunityId  = (SELECT Id FROM @Opportunity)
			DECLARE @BookingStatusId INT
			SELECT TOP 1 @BookingStatusId=BookingStatus FROM @Opportunity

			SELECT TOP 1 @OpportunityName=Name FROM Opportunity WHERE Id=@OpportunityId
			SELECT @VendorId=VendorId, @CustomerId=CustomerId FROM @Opportunity
			SELECT @Count=COUNT(*) FROM Opportunity WHERE VendorId=@VendorId AND CustomerId=@CustomerId AND BookingStatus=3 AND YEAR(CreatedTime)=YEAR(GETDATE())			

			IF @BookingStatusId = 3
			BEGIN 		
				SET @OpportunityName= REPLACE(@OpportunityName,'INPROCESS',CAST(@Count + 1 AS varchar)+' - SUBMITTED')
			END
	
			--Update Opportunity
			UPDATE dbo.[Opportunity]
			SET	
				Name=@OpportunityName,
				StartDate=UDTOPNT.StartDate,
				EndDate=UDTOPNT.EndDate,
				BookingStatus=UDTOPNT.BookingStatus,
				AgreementPath=UDTOPNT.AgreementPath,
				VendorId=UDTOPNT.VendorId,
				CustomerId=UDTOPNT.CustomerId,
				FacilityId=UDTOPNT.FacilityId,
				IsActive=UDTOPNT.IsActive,
				ModifiedTime=UDTOPNT.ModifiedTime,
				ModifiedBy=UDTOPNT.ModifiedBy,
				OrganizationId=UDTOPNT.OrganizationId,
				TenantId=UDTOPNT.TenantId
			FROM dbo.[Opportunity] OPNT
			INNER JOIN @Opportunity UDTOPNT ON OPNT.Id=UDTOPNT.Id;
	
			--Update or Add OpportunityRailCarDetails
			MERGE 
				OpportunityRailcarDetails AS Target
			USING 
				@OpportunityRailcarDetails AS Source
			ON 
				Source.Id = Target.Id AND Source.OpportunityID = Target.OpportunityID
			
			WHEN NOT MATCHED BY Target THEN
				INSERT (OpportunityID,ExpectedNumberOfCars,LEId,Commodity,IsHazmat,CarType,RailcarIds,IsActive
						,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy,OrganizationId,TenantId)
				VALUES (@OpportunityId,Source.ExpectedNumberOfCars,Source.LEId,Source.Commodity,Source.IsHazmat,Source.CarType,Source.RailcarIds,
				Source.IsActive,Source.CreatedTime,Source.CreatedBy,Source.ModifiedTime,Source.ModifiedBy,Source.OrganizationId,Source.TenantId)
			
			WHEN MATCHED THEN UPDATE SET
				Target.LEId=Source.LEId,		
				Target.Commodity=Source.Commodity,	
				Target.ExpectedNumberOfCars=Source.ExpectedNumberOfCars,
				Target.RailcarIds=Source.RailcarIds,
				Target.IsHazmat=Source.IsHazmat,	
				Target.CarType=Source.CarType,	
				Target.IsActive=Source.IsActive,
				Target.ModifiedTime=Source.ModifiedTime,
				Target.ModifiedBy=Source.ModifiedBy,
				Target.OrganizationId=Source.OrganizationId,
				Target.TenantId =Source.TenantId;


			--Update or Add OpportunityAttachments
			MERGE 
				OpportunityAttachments AS Target
			USING 
				@OpportunityAttachments AS Source
			ON 
				Source.Id = Target.Id AND Source.OpportunityID = Target.OpportunityID
			
			WHEN NOT MATCHED BY Target THEN
				INSERT (OpportunityId,[Name],[Path],IsActive,CreatedTime,CreatedBy,ModifiedTime
				,ModifiedBy,OrganizationId,TenantId,Size,CreatedDate)
				VALUES (Source.OpportunityId,Source.[Name],Source.[Path],Source.IsActive,Source.CreatedTime,Source.CreatedBy,Source.ModifiedTime
				,Source.ModifiedBy,Source.OrganizationId,Source.TenantId,Source.Size,Source.CreatedDate)
			
			WHEN MATCHED THEN UPDATE SET
				Target.[Name]=Source.[Name],
				Target.[Path]=Source.[Path],
				Target.IsActive=Source.IsActive,
				Target.ModifiedTime=Source.ModifiedTime,
				Target.ModifiedBy=Source.ModifiedBy,
				Target.OrganizationId=Source.OrganizationId,
				Target.TenantId	=Source.TenantId;			
	END
	SELECT @OpportunityId
	END TRY
	BEGIN CATCH
		 SELECT 
				@ERRORMESSAGE = ERROR_MESSAGE(), 
				@ERRORSEVERITY = ERROR_SEVERITY(),
				@ERRORNUMBER = ERROR_NUMBER(),
				@ERRORPROCEDURE = ERROR_PROCEDURE(),
				@ERRORLINE = ERROR_LINE(),
				@ERRORSTATE = ERROR_STATE();
	
				 SET @PARAMS = 'Parameter 1:'+ CAST(@OpportunityId AS varchar(10));
				 SET @MESSAGE = 'ERROR NUMBER:' + CAST(@ERRORNUMBER AS VARCHAR(5)) + CHAR(13)
							   +'PROCEDURE NAME:'+ @ERRORPROCEDURE + CHAR(13)
							   +'PROCEDURE LINE:'+ CAST(@ERRORLINE AS VARCHAR(5)) + CHAR(13)
							   +'ERROR MESSAGE:'+ @ERRORMESSAGE + CHAR(13)
							   +'PARAMETERS:'+@PARAMS + CHAR(13);
	 
			--INSERT INTO [dbo].[DB_Errors]
			--  VALUES  (SUSER_SNAME(), @MESSAGE, GETDATE());
	
			-- return the error inside the CATCH block
			RAISERROR(@MESSAGE, @ERRORSEVERITY, @ERRORSTATE);
	END CATCH
END
GO

PRINT '[usp_CreateOrUpdateOpportunity] Updated Successfully';
GO


CREATE OR ALTER PROCEDURE [dbo].[SP_GetOpportunityOrderSummaryDetails]
@OpportunityId BIGINT
AS
BEGIN
	
	Declare @StorageFacilityId BIGINT;
	SELECT @StorageFacilityId = FacilityId FROM Opportunity WHERE id = @OpportunityId

	SELECT TOP(1) SF.Name,SFI.MarkCode
		FROM StorageFacility SF 
			INNER JOIN StorageFacilityInterchange SFI ON SF.Id=SFI.StorageFacilityId 
		WHERE SF.Id = @StorageFacilityId
	
	SELECT ReservedSpaces, ExpirationDate, EffectiveDate
		FROM OpportunityReservedSpaces 
		WHERE OpportunityId=@OpportunityId

END
GO

PRINT '[SP_GetOpportunityOrderSummaryDetails] Updated Successfully';
GO

IF EXISTS(SELECT 1 from NotificationEvent where Name = 'OpportunityOrderPlaced')
BEGIN
UPDATE MailConfiguration SET Subject='Your Railcar Lounge Storage Order Booking has been received!',
Body = '<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
	<tbody>
	<tr>
		<td style="border-bottom:5px solid #709ce9; background:#1a335f">
			<span style="display:block;font-size:22px;padding:10px">
			<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>
			</span>
		</td>
	</tr>
	<tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			<br />
			{customerName}
			<br />
			Woo hoo! We’re happy to let you know that we’ve received your storage order booking.
			<br /><br />
			Your order details can be found below:
			<br />
			Order Number: {orderNo}
			<br />
			Order Date: {orderDate}
			<br /><br />
			Please find the copy of your order summary attached for your reference. A representative from Railcar Lounge™ will contact you with the storage order booking details.
			<br />
		</td>
	</tr>
	  <tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			If you wish to contact us regarding your order, please reach out to
			<a style="color: #0d6efd;" href="mailto:rclsupport@standardrail.com?Subject=Railcar Lounge: ">
				rclsupport@standardrail.com
			</a> <br /> <br />
		</td>
	</tr>
	<tr>
		<td>
		Thank you for placing your order!<br>
		<br /><br />  Best Regards,<br /> 
Railcar Lounge™ Team
<br /> <br /> 
		<span style="color:#555555;font-weight:normal;font-family:Tahoma,Geneva,sans-serif">Railcar Lounge</span><br><br><br>
		</td>
	</tr>
    <tr bgcolor="#ffffff">
    <td style="font-family:Tahoma,Helvetica,sans-serif;border-top:1px solid #ccc;border-bottom:1px solid #ccc;color:#333333;text-align:center;font-size:14px;padding:15px 0;text-align:center">
         This is an auto generated mail. Please do not reply
      <br></td>
  </tr>
  <tr>
  	<td>
  		<br><br>
  	</td>
  </tr>
</tbody></table>'
WHERE NotificationEventId=(SELECT Id FROM NotificationEvent WHERE Name='OpportunityOrderPlaced' )
END
GO

IF NOT EXISTS(SELECT 1 FROM NotificationEvent WHERE NAME = 'OpportunityOrderPlaced')
BEGIN
INSERT INTO NotificationEvent
( [Name]
      ,[Description]
      ,[PeriodEnd]
      ,[PeriodStart]
      ,[IsActive]
      ,[CreatedTime]
      ,[CreatedBy]
      ,[ModifiedTime]
      ,[ModifiedBy]
      ,[OrganizationId]
      ,[TenantId])
VALUES
('OpportunityOrderPlaced'
      ,'OpportunityOrderPlaced'
      ,DEFAULT
      ,DEFAULT
      ,1
      ,GETDATE()
      ,1
      ,GETDATE()
      ,1
      ,0
      ,1)


	  INSERT INTO [MailConfiguration] (
	  NotificationEventId
	  ,Subject
      ,Body
      ,PeriodEnd
      ,PeriodStart
      ,IsActive
      ,CreatedTime
      ,CreatedBy
      ,ModifiedTime
      ,ModifiedBy
      ,OrganizationId
      ,TenantId)
values
(@@IDENTITY,'Your Railcar Lounge Storage Order Booking has been received!', 
'<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
	<tbody>
	<tr>
		<td style="border-bottom:5px solid #709ce9; background:#1a335f">
			<span style="display:block;font-size:22px;padding:10px">
			<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>
			</span>
		</td>
	</tr>
	<tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			<br />
			{customerName}
			<br />
			Woo hoo! We’re happy to let you know that we’ve received your storage order booking.
			<br /><br />
			Your order details can be found below:
			<br />
			Order Number: {orderNo}
			<br />
			Order Date: {orderDate}
			<br /><br />
			Please find the copy of your order summary attached for your reference. A representative from Railcar Lounge™ will contact you with the storage order booking details.
			<br />
		</td>
	</tr>
	  <tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			If you wish to contact us regarding your order, please reach out to
			<a style="color: #0d6efd;" href="mailto:rclsupport@standardrail.com?Subject=Railcar Lounge: ">
				rclsupport@standardrail.com
			</a> <br /> <br />
		</td>
	</tr>
	<tr>
		<td>
		Thank you for placing your order!<br>
		<br /><br />  Best Regards,<br /> 
Railcar Lounge™ Team
<br /> <br /> 
		<span style="color:#555555;font-weight:normal;font-family:Tahoma,Geneva,sans-serif">Railcar Lounge</span><br><br><br>
		</td>
	</tr>
    <tr bgcolor="#ffffff">
    <td style="font-family:Tahoma,Helvetica,sans-serif;border-top:1px solid #ccc;border-bottom:1px solid #ccc;color:#333333;text-align:center;font-size:14px;padding:15px 0;text-align:center">
         This is an auto generated mail. Please do not reply
      <br></td>
  </tr>
  <tr>
  	<td>
  		<br><br>
  	</td>
  </tr>
</tbody></table>',
DEFAULT,DEFAULT,1,GETDATE(),1,GETDATE(),1,0,1)
END
GO

IF EXISTS(SELECT Name from NotificationEvent where Name = 'VendorOpportunityOrderPlaced')
BEGIN
UPDATE MailConfiguration SET Body = '<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
			<tbody>
			<tr>
				<td style="border-bottom:5px solid #709ce9; background:#1a335f">
					<span style="display:block;font-size:22px;padding:10px">
					<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>
					</span>
				</td>
			</tr>
			<tr>
				<td style="font-family:Tahoma,Geneva,sans-serif">
					<br />
					Hello {vendorName},
					<br />
					<br />
					Woo hoo! We’re happy to let you know that you’ve received a booking on your storage facility.
					<br /><br />
					Storage order booking details can be found below:
					<br />
					Order Number: {orderNo}
					<br />
					Order Date: {orderDate}
					<br /><br />
					Please find a copy of the customer order summary attached for your reference. A representative from Railcar Lounge™ will contact you with the storage order booking details.
					<br />
				</td>
			</tr>
			  <tr>
				<td style="font-family:Tahoma,Geneva,sans-serif">
					If you wish to contact us regarding the customer order, please reach out to
					<a style="color: #0d6efd;" href="mailto:rclsupport@standardrail.com?Subject=Railcar Lounge: ">
						rclsupport@standardrail.com
					</a> <br /> <br />
				</td>
			</tr>
			<tr>
				<td>
				Thank you for choosing Railcar Lounge™ for your storage facility needs!
				<br /><br />  Best Regards,<br /> 
		Railcar Lounge™ Team
		<br /> <br /> 
				</td>
			</tr>
		    <tr bgcolor="#ffffff">
		    <td style="font-family:Tahoma,Helvetica,sans-serif;border-top:1px solid #ccc;border-bottom:1px solid #ccc;color:#333333;text-align:center;font-size:14px;padding:15px 0;text-align:center">
		         This is an auto generated mail. Please do not reply
		      <br></td>
		  </tr>
		  <tr>
		  	<td>
		  		<br><br>
		  	</td>
		  </tr>
		</tbody></table>'
WHERE NotificationEventId=(SELECT Id FROM NotificationEvent WHERE Name='VendorOpportunityOrderPlaced' )
END
GO

IF NOT EXISTS(SELECT 1 FROM NotificationEvent WHERE NAME = 'VendorOpportunityOrderPlaced')
BEGIN

	INSERT INTO NotificationEvent
	(
		[Name],
		[Description],
		[PeriodEnd],
		[PeriodStart],
		[IsActive],
		[CreatedTime],
		[CreatedBy],
		[ModifiedTime],
		[ModifiedBy],
		[OrganizationId],
		[TenantId]
	)
	VALUES
	(
		'VendorOpportunityOrderPlaced',
		'VendorOpportunityOrderPlaced',
		DEFAULT,
		DEFAULT,
		1,
		GETDATE(),
		1,
		GETDATE(),
		1,
		0,
		1
	)

	INSERT INTO [MailConfiguration] 
	(
		NotificationEventId,
		Subject,
		Body,
		PeriodEnd,
		PeriodStart,
		IsActive,
		CreatedTime,
		CreatedBy,
		ModifiedTime,
		ModifiedBy,
		OrganizationId,
		TenantId
	)
	VALUES
	(
		@@IDENTITY,
		'You have received a booking on your storage facility', 
		'<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
			<tbody>
			<tr>
				<td style="border-bottom:5px solid #709ce9; background:#1a335f">
					<span style="display:block;font-size:22px;padding:10px">
					<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>
					</span>
				</td>
			</tr>
			<tr>
				<td style="font-family:Tahoma,Geneva,sans-serif">
					<br />
					Hello {vendorName},
					<br />
					<br />
					Woo hoo! We’re happy to let you know that you’ve received a booking on your storage facility.
					<br /><br />
					Storage order booking details can be found below:
					<br />
					Order Number: {orderNo}
					<br />
					Order Date: {orderDate}
					<br /><br />
					Please find a copy of the customer order summary attached for your reference. A representative from Railcar Lounge™ will contact you with the storage order booking details.
					<br />
				</td>
			</tr>
			  <tr>
				<td style="font-family:Tahoma,Geneva,sans-serif">
					If you wish to contact us regarding the customer order, please reach out to
					<a style="color: #0d6efd;" href="mailto:rclsupport@standardrail.com?Subject=Railcar Lounge: ">
						rclsupport@standardrail.com
					</a> <br /> <br />
				</td>
			</tr>
			<tr>
				<td>
				Thank you for choosing Railcar Lounge™ for your storage facility needs!
				<br /><br />  Best Regards,<br /> 
		Railcar Lounge™ Team
		<br /> <br /> 
				</td>
			</tr>
		    <tr bgcolor="#ffffff">
		    <td style="font-family:Tahoma,Helvetica,sans-serif;border-top:1px solid #ccc;border-bottom:1px solid #ccc;color:#333333;text-align:center;font-size:14px;padding:15px 0;text-align:center">
		         This is an auto generated mail. Please do not reply
		      <br></td>
		  </tr>
		  <tr>
		  	<td>
		  		<br><br>
		  	</td>
		  </tr>
		</tbody></table>',
		DEFAULT,
		DEFAULT,
		1,
		GETDATE(),
		1,
		GETDATE(),
		1,
		0,
		1
	)

END
GO

IF EXISTS(SELECT 1 from NotificationEvent where Name = 'StorageOpportunity')
BEGIN
UPDATE MailConfiguration SET Subject='Railcar Lounge: New Booking Received!'
WHERE NotificationEventId=(SELECT Id FROM NotificationEvent WHERE Name='StorageOpportunity' )
END
GO

IF NOT EXISTS(SELECT 1 FROM NotificationEvent WHERE NAME = 'StorageOpportunity')
BEGIN
INSERT INTO NotificationEvent
( [Name]
      ,[Description]
      ,[PeriodEnd]
      ,[PeriodStart]
      ,[IsActive]
      ,[CreatedTime]
      ,[CreatedBy]
      ,[ModifiedTime]
      ,[ModifiedBy]
      ,[OrganizationId]
      ,[TenantId])
VALUES
('StorageOpportunity'
      ,'StorageOpportunity'
      ,DEFAULT
      ,DEFAULT
      ,1
      ,GETDATE()
      ,1
      ,GETDATE()
      ,1
      ,0
      ,1)


	  INSERT INTO [MailConfiguration] (
	  NotificationEventId
	  ,Subject
      ,Body
      ,PeriodEnd
      ,PeriodStart
      ,IsActive
      ,CreatedTime
      ,CreatedBy
      ,ModifiedTime
      ,ModifiedBy
      ,OrganizationId
      ,TenantId)
values
(@@IDENTITY,'Railcar Lounge: New Booking Received!', 
'<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">  
<tbody>   <tr>    <td style="border-bottom:5px solid #709ce9; background:#1a335f">     
<span style="display:block;font-size:22px;padding:10px">    
<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>     
</span>    
</td>   </tr>   <tr>    <td>     <br>     Hello,     <br><br>    </td>   </tr>   <tr>    <td style="font-family:Tahoma,Geneva,sans-serif">     
<strong>Booking ID: </strong> {bookingID}     <br />     <br />     {userEmail} from {organizationName} has submitted a new order for Storage Facility at {storageFacility}.     
<br /><br />    </td>   </tr>     <tr>    <td style="font-family:Tahoma,Geneva,sans-serif">         
</td>   </tr>   <tr>    <td>    Thanks,<br>    
<span style="color:#555555;font-weight:normal;font-family:Tahoma,Geneva,sans-serif">Railcar Lounge</span><br><br><br>    
</td>   </tr>      <tr bgcolor="#ffffff">      
<td style="font-family:Tahoma,Helvetica,sans-serif;border-top:1px solid #ccc;border-bottom:1px solid #ccc;color:#333333;text-align:center;font-size:14px;padding:15px 0;text-align:center">
This is an auto generated mail. Please do not reply        
<br></td>    </tr>    <tr>     <td>      <br><br>     </td>    </tr>  </tbody></table>
',
DEFAULT,DEFAULT,1,GETDATE(),1,GETDATE(),1,0,1)
END
GO

COMMIT TRANSACTION