Create Type [dbo].[StorageFacilityFeaturesUDT] as Table(	
	[StorageFacilityId] [bigint]  NULL,
	[StorageFacilityName] [nvarchar](100)  NULL,
	[StorageFeatureId] [bigint]  NULL,
	[CreatedTime] [datetime2](7)  NULL,
	[CreatedBy] [bigint]  NULL,
	[ModifiedTime] [datetime2](7)  NULL,
	[ModifiedBy] [bigint]  NULL,
	[OrganizationId] [bigint]  NULL,
	[TenantId] [bigint]  NULL,
	[IsActive] [bit] NULL)