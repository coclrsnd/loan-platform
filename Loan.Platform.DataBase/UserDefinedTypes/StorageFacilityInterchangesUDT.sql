Create Type [dbo].[StorageFacilityInterchangesUDT] as Table(	
[StorageFacilityId] [bigint] NULL,
	[StorageFacilityName] [nvarchar](100) NULL,
	[Id] [bigint] NULL,
	[RailRoadId] [bigint] NULL,
	[RailRoadName] [nvarchar](max) NULL,
	[MarkCode] [nvarchar](max) NULL,
	[GrossRailRoadCapacity] decimal(18,2) NULL,
	[UnitId] [bigint] NULL,
	[CreatedTime] [datetime2](7) NULL,
	[CreatedBy] [bigint] NULL,
	[ModifiedTime] [datetime2](7) NULL,
	[ModifiedBy] [bigint] NULL,
	[OrganizationId] [bigint] NULL,
	[TenantId] [bigint] NULL,
	[IsActive] [bit] NULL
)