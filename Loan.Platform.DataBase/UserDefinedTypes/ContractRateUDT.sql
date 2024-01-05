CREATE TYPE [dbo].[ContractRateUDT] AS TABLE
(
	[Id] [bigint] NULL,
	[ContractId] [bigint] NOT NULL,
	[RateTypeId] [bigint] NOT NULL,
	[SwitchIn] [decimal](18, 2) NULL,
	[SwitchOut] [decimal](18, 2) NULL,
	[SpecialSwitchingRate] [decimal](18, 2) NULL,
	[DailyStorageRate] [decimal](18, 2) NOT NULL,
	[SwitchingRate] [decimal](18, 2) NULL,
	[HazmatSurcharge] [decimal](18, 2) NULL,
	[LoadedSurcharge] [decimal](18, 2) NULL,
	[ReservationRate] [decimal](18, 2) NULL,
	[CherryPickingRate] [decimal](18, 2) NULL,
	[BookingFee] [decimal](18, 2) NULL,
	[ListingFee] [decimal](18, 2) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL
)
