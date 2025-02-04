﻿CREATE Type [dbo].[VendorUDT] AS Table(
	[Id] [bigint] NULL,
	[ContactPersonName] [nvarchar](100) NULL,
	[PrimaryContactNo] [nvarchar](max) NULL,
	[SecondaryContactNo] [nvarchar](max) NULL,
	[Organization] [nvarchar](250) NULL,
	[Address] [nvarchar](1000) NULL,
	[ZipCode] [nvarchar](12) NULL,
	[City] [nvarchar](max) NULL,
	[StateId] [bigint] NULL,
	[CountryId] [bigint] NULL,
	[RegionId] [bigint] NULL,
	[PercentageMargin] [decimal](18, 2) NULL,
	[EffectiveDate] [datetime2](7) NULL,
	[ExpiryDate] [datetime2](7) NULL,
	[PrimaryContactEmail] [nvarchar](max) NULL,
	[SecondaryContactEmail] [nvarchar](max) NULL,
	[Website] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedTime] [datetime2](7) NULL,
	[CreatedBy] [bigint] NULL,
	[ModifiedTime] [datetime2](7) NULL,
	[ModifiedBy] [bigint] NULL,
	[OrganizationId] [bigint] NULL,
	[TenantId] [bigint] NULL)