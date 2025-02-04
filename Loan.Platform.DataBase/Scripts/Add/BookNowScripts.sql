IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name like 'SP_GetOpportunityDetailsById')
BEGIN
	DROP PROC SP_GetOpportunityDetailsById
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name like 'usp_CreateOrUpdateOpportunity')
BEGIN
	DROP PROC usp_CreateOrUpdateOpportunity
END
GO

/****** Object:  Table [dbo].[OpportunityReservedSpaces]    Script Date: 10-10-2022 13:43:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpportunityReservedSpaces]') AND type in (N'U'))
DROP TABLE [dbo].[OpportunityReservedSpaces]
GO
/****** Object:  Table [dbo].[OpportunityRailcarDetails]    Script Date: 10-10-2022 13:43:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpportunityRailcarDetails]') AND type in (N'U'))
DROP TABLE [dbo].[OpportunityRailcarDetails]
GO
/****** Object:  Table [dbo].[OpportunityFeatures]    Script Date: 10-10-2022 13:43:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpportunityFeatures]') AND type in (N'U'))
DROP TABLE [dbo].[OpportunityFeatures]
GO
/****** Object:  Table [dbo].[OpportunityAttachments]    Script Date: 10-10-2022 13:43:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OpportunityAttachments]') AND type in (N'U'))
DROP TABLE [dbo].[OpportunityAttachments]
GO
/****** Object:  Table [dbo].[Opportunity]    Script Date: 10-10-2022 13:43:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Opportunity]') AND type in (N'U'))
DROP TABLE [dbo].[Opportunity]
GO

IF  EXISTS (SELECT * FROM sys.types WHERE name like 'OpportunityRailcarDetailsUDT')
BEGIN
	DROP TYPE OpportunityRailcarDetailsUDT
END
GO
IF  EXISTS (SELECT * FROM sys.types WHERE name like 'OpportunityAttachmentsUDT')
BEGIN
	DROP TYPE OpportunityAttachmentsUDT
END
GO
IF  EXISTS (SELECT * FROM sys.types WHERE name like 'OpportunityFeaturesUDT')
BEGIN
	DROP TYPE OpportunityFeaturesUDT
END
GO
IF  EXISTS (SELECT * FROM sys.types WHERE name like 'OpportunityUDT')
BEGIN
	DROP TYPE OpportunityUDT
END
GO
/****** Object:  UserDefinedTableType [dbo].[OpportunityAttachmentsUDT]    Script Date: 10-10-2022 13:43:12 ******/
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
/****** Object:  UserDefinedTableType [dbo].[OpportunityFeaturesUDT]    Script Date: 10-10-2022 13:43:12 ******/
CREATE TYPE [dbo].[OpportunityFeaturesUDT] AS TABLE(
	[Id] [bigint] NULL,
	[OpportunityId] [bigint] NOT NULL,
	[FeatureId] [bigint] NOT NULL,
	[Comments] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[OpportunityRailcarDetailsUDT]    Script Date: 10-10-2022 13:43:12 ******/
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
GO
/****** Object:  UserDefinedTableType [dbo].[OpportunityUDT]    Script Date: 10-10-2022 13:43:12 ******/
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
GO
/****** Object:  Table [dbo].[Opportunity]    Script Date: 10-10-2022 13:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Opportunity](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
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
	[TenantId] [bigint] NOT NULL,
 CONSTRAINT [PK_Opportunity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpportunityAttachments]    Script Date: 10-10-2022 13:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpportunityAttachments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OpportunityId] [bigint] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Path] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL,
	[Size] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NULL,
 CONSTRAINT [PK_OpportunityAttachments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpportunityFeatures]    Script Date: 10-10-2022 13:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpportunityFeatures](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OpportunityId] [bigint] NOT NULL,
	[FeatureId] [bigint] NOT NULL,
	[Comments] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL,
 CONSTRAINT [PK_OpportunityFeatures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpportunityRailcarDetails]    Script Date: 10-10-2022 13:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpportunityRailcarDetails](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
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
	[TenantId] [bigint] NOT NULL,
 CONSTRAINT [PK_OpportunityRailcarDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OpportunityReservedSpaces]    Script Date: 10-10-2022 13:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpportunityReservedSpaces](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OpportunityId] [bigint] NOT NULL,
	[ReservedSpaces] [bigint] NOT NULL,
	[EffectiveDate] [datetime2](7) NOT NULL,
	[ExpirationDate] [datetime2](7) NOT NULL,
	[IsActive] [bit] NULL,
	[CreatedTime] [datetime2](7) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedTime] [datetime2](7) NOT NULL,
	[ModifiedBy] [bigint] NOT NULL,
	[OrganizationId] [bigint] NOT NULL,
	[TenantId] [bigint] NOT NULL,
 CONSTRAINT [PK_OpportunityReservedSpaces] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetOpportunityDetailsById]    Script Date: 10-10-2022 13:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[SP_GetOpportunityDetailsById]
@OpportunityId BIGINT
AS
BEGIN
		--Opportunity Record
		SELECT DISTINCT
			OP.Id,
			[Name],
			StartDate,
			EndDate,
			BookingStatus,
			AgreementPath,
			VendorId,
			CustomerId,
			FacilityId,
			SUM(ORCD.ExpectedNumberOfCars) OVER() AS TotalNoApproxSpaces,
			SUM(ORS.ReservedSpaces) OVER() AS TotalNoReservedSpaces
		FROM 
			Opportunity OP
		LEFT JOIN 
			OpportunityRailcarDetails ORCD 
			ON OP.Id=ORCD.OpportunityID AND ORCD.IsActive=1
		LEFT JOIN 
			OpportunityReservedSpaces ORS
			ON OP.Id=ORS.OpportunityID AND ORCD.IsActive=1
		WHERE
			OP.ID=@OpportunityId

		--OpportunityRailcar Records
		SELECT 
			ORCD.Id,
			OpportunityId,
			ExpectedNumberOfCars,
			LEId,
			LE.[Name] AS LandE,
			Commodity,
			IsHazmat,
			CarType,
			RailcarIds,
			RCT.[Name] AS CarTypeName

		FROM 
			[dbo].[OpportunityRailcarDetails] ORCD
		LEFT JOIN 
			LEContent LE ON ORCD.LEId=LE.Id
		LEFT JOIN
			RailCarType RCT ON RCT.Id=ORCD.CarType
		WHERE
			OpportunityID=@OpportunityId AND ORCD.IsActive=1

		--OpportunityAttachments Records
		SELECT 
			Id,
			OpportunityId,
			[Name],
			[Path],
			IsActive,
			Size,
			CreatedDate
		FROM 
			[dbo].[OpportunityAttachments]			
		WHERE
			OpportunityID=@OpportunityId AND IsActive=1
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CreateOrUpdateOpportunity]    Script Date: 10-10-2022 13:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[usp_CreateOrUpdateOpportunity]
	@Opportunity OpportunityUDT READONLY,
	@OpportunityRailcarDetails OpportunityRailcarDetailsUDT READONLY,
	@OpportunityAttachments OpportunityAttachmentsUDT READONLY
AS
BEGIN
	
	
	DECLARE @OpportunityName VARCHAR(100);

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
			DECLARE @VendorId BIGINT;
			DECLARE @CustomerId BIGINT;
			DECLARE @Count BIGINT;

			SELECT @VendorId=VendorId FROM @Opportunity
			SELECT @CustomerId=CustomerId FROM @Opportunity
			SELECT @VendorName=org.[Name] FROM Organization org INNER JOIN Vendor ven ON org.Id=ven.OrganizationId WHERE ven.Id=@VendorId
			SELECT @CustomerName=org.[Name] FROM Organization org INNER JOIN Customers cust ON org.Id=cust.OrganizationId WHERE org.Id=@CustomerId
			SELECT @Count=COUNT(*) FROM Opportunity WHERE VendorId=@VendorId AND CustomerId=@CustomerId
			
			SET @OpportunityName= @VendorName + '-' + @CustomerName + ' '+CAST(DATEPART(YYYY,GETDATE()) AS VARCHAR)+ '-' + CAST(@Count+1 AS varchar);
	
			-- Save Opportunit
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

			IF @BookingStatusId = 3
			BEGIN 
				SET @OpportunityName=@OpportunityName+'-SUBMITTED'			
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
