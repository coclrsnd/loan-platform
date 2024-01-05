CREATE TYPE [dbo].[OpportunityUDT] AS TABLE(
	[Id] [bigint] NULL,
	[Name] [nvarchar](max) NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[BookingStatus] [bigint] NOT NULL,
	[AgreementPath] [nvarchar](max) NULL,
	[VendorId] [bigint] NOT NULL,
	[CustomerId] [bigint] NOT NULL,
	[FacilityId] [bigint] NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL
)