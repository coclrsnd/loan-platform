CREATE TYPE [dbo].[OpportunityRailcarDetailsUDT] AS TABLE(
	[Id] [bigint] NULL,
	[OpportunityID] [bigint] NOT NULL,
	[ExpectedNumberOfCars] [bigint] NULL,
	[LEId] [bigint] NOT NULL,
	[Commodity] [nvarchar](max) NULL,
	[IsHazmat] [bit] NOT NULL,
	[CarType] [bigint] NOT NULL,
	[RailcarIds] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL
)