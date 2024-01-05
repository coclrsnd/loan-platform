CREATE TYPE [dbo].[ContractSFFeatureMappingUDT] AS TABLE(
	[ContractId] [bigint] NOT NULL,
	[StorageFeatureId] [bigint] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL
)
GO