GO

/****** Object:  UserDefinedTableType [dbo].[OpportunityAttachmentsUDT]    Script Date: 09-10-2022 10:15:25 ******/
CREATE TYPE [dbo].[OpportunityAttachmentsUDT] AS TABLE(
	[Id] [bigint] NULL,
	[OpportunityId] [bigint] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Path] [nvarchar](max) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL,
	[Size] [nvarchar](max) NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL
)
GO


