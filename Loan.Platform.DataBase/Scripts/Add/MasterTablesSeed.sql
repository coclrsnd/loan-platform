GO
SET IDENTITY_INSERT [dbo].[Country] ON 
GO
INSERT [dbo].[Country] ([Id], [Name], [Code], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (1, N'United States', N'USA', 1, CAST(N'2022-06-09T12:25:05.3266667' AS DateTime2), 1, CAST(N'2022-06-09T12:25:05.3266667' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[Country] ([Id], [Name], [Code], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (2, N'Canada', N'CAN', 1, CAST(N'2022-06-09T12:25:05.3266667' AS DateTime2), 1, CAST(N'2022-06-09T12:25:05.3266667' AS DateTime2), 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Country] OFF
GO
SET IDENTITY_INSERT [dbo].[Region] ON 
GO
INSERT [dbo].[Region] ([Id], [Name], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (1, N'US Central Region', 1, 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[Region] ([Id], [Name], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (2, N'US Midwest Region', 1, 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[Region] ([Id], [Name], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (3, N'US Northeast Region', 1, 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[Region] ([Id], [Name], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (4, N'US Northwest Region', 1, 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[Region] ([Id], [Name], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (5, N'US Southeast Region', 1, 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[Region] ([Id], [Name], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (6, N'US Southwest Region', 1, 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[Region] ([Id], [Name], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (7, N'Canada Atlantic Region', 2, 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[Region] ([Id], [Name], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (8, N'Canada Ontario Region', 2, 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[Region] ([Id], [Name], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (9, N'Canada Pacific Region', 2, 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[Region] ([Id], [Name], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (10, N'Canada Prairie & Northwest Region', 2, 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[Region] ([Id], [Name], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (11, N'Canada Quebec Region', 2, 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, CAST(N'2022-06-09T01:43:38.8133333' AS DateTime2), 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Region] OFF
GO
SET IDENTITY_INSERT [dbo].[State] ON 
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (1, N'Alabama', N'AL', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (2, N'Alaska', N'AK', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (3, N'Alberta', N'AB', 2, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (4, N'Arizona', N'AZ', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (5, N'Arkansas', N'AR', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (6, N'British Columbia', N'BC', 2, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (7, N'California', N'CA', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (8, N'Colorado', N'CO', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (9, N'Connecticut', N'CT', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (10, N'Delaware', N'DE', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (11, N'Dist. of Columbia', N'DC', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (12, N'Florida', N'FL', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (13, N'Georgia', N'GA', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (14, N'Idaho', N'ID', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (15, N'Illinois', N'IL', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (16, N'Indiana', N'IN', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (17, N'Iowa', N'IA', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (18, N'Kansas', N'KS', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (19, N'Kentucky', N'KY', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (20, N'Louisiana', N'LA', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (21, N'Maine', N'ME', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (22, N'Manitoba', N'MB', 2, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (23, N'Maryland', N'MD', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (24, N'Massachusetts', N'MA', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (25, N'Michigan', N'MI', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (26, N'Minnesota', N'MN', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (27, N'Mississippi', N'MS', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (28, N'Missouri', N'MO', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (29, N'Montana', N'MT', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (30, N'Nebraska', N'NE', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (31, N'Nevada', N'NV', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (32, N'New Brunswick', N'NB', 2, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (33, N'New Hampshire', N'NH', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (34, N'New Jersey', N'NJ', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (35, N'New Mexico', N'NM', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (36, N'New York', N'NY', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (37, N'Newfoundland & Labrador', N'NL', 2, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (38, N'North Carolina', N'NC', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (39, N'North Dakota', N'ND', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (40, N'Northwest Territory', N'NT', 2, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (41, N'Nova Scotia', N'NS', 2, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (42, N'Nunavut', N'NU', 2, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (43, N'Ohio', N'OH', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (44, N'Oklahoma', N'OK', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (45, N'Ontario', N'ON', 2, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (46, N'Oregon', N'OR', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (47, N'Pennsylvania', N'PA', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (48, N'Prince Edward Island', N'PE', 2, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (49, N'Quebec', N'QC', 2, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (50, N'Rhode Island', N'RI', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (51, N'Saskatchewan', N'SK', 2, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (52, N'South Carolina', N'SC', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (53, N'South Dakota', N'SD', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (54, N'Tennessee', N'TN', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (55, N'Texas', N'TX', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (56, N'Utah', N'UT', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (57, N'Vermont', N'VT', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (58, N'Virginia', N'VA', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (59, N'Washington', N'WA', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (60, N'West Virginia', N'WV', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (61, N'Wisconsin', N'WI', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (62, N'Wyoming', N'WY', 1, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[State] ([Id], [Name], [Code], [CountryId], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (63, N'Yukon Territory', N'YT', 2, 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, CAST(N'2022-06-09T15:13:05.8300000' AS DateTime2), 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[State] OFF
GO
SET IDENTITY_INSERT [dbo].[NotificationEvent] ON 
GO
INSERT [dbo].[NotificationEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (1, N'SignUpVerification', N'Email Verification', 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[NotificationEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (2, N'PasswordReset', N'Reset Password', 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[NotificationEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (3, N'Rejected', N'Access Denied', 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[NotificationEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (4, N'Approved', N'Access Approved', 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[NotificationEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (5, N'AlreadySignedUp', N'Already Registered', 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[NotificationEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (6, N'StorageOpportunity', N'Storage Opportunity', 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[NotificationEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (7, N'BookingConfirmation', N'Booking Confirmation', 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[NotificationEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (8, N'ApprovalRequest', N'Approval Request to RCL Support', 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[NotificationEvent] OFF
GO
SET IDENTITY_INSERT [dbo].[MailConfiguration] ON 
GO
INSERT [dbo].[MailConfiguration] ([Id], [NotificationEventId], [Subject], [Body], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (1, 1, N'Welcome to Railcar Lounge! Verify Your Email!', N'<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
	<tbody>
	<tr>
		<td style="border-bottom:5px solid #709ce9; background:#1a335f">
			<span style="display:block;font-size:22px;padding:10px">
			<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>
			</span>
		</td>
	</tr>
	<tr>
		<td>
			<br>
			Hello <strong>{userEmail}</strong>,
		</td>
	</tr>
	<tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			<br />
			Thank you for choosing Railcar Lounge. <br /><br /> After email verification, we will distribute our Master Services Agreement for your review.
			<br /><br />
			Click the below link to verify your email address: 
		</td>
	</tr>
  <tr bgcolor="#ffffff" style="text-align: center;">
    <td align="center" style="font-family:''Roboto'',sans-serif;color:#ffffff; padding:20px 20px 20px 20px;">
  <table cellspacing="0" cellpadding="0">
    <tr>
      <td style="border-radius: 5px; font-size: 20px;
      padding: 8px;" bgcolor="#1a335f">
        <a href="{verifyUrl}" target="_blank" style="border: 1px solid #1a335f;border-radius: 8px; cursor: pointer; font-family: ''Roboto'',sans-serif, Helvetica, Arial, sans-serif;font-size: 15px; color: #ffffff;text-decoration: none;display: inline-block;">
          Verify Email
        </a>
      </td>
    </tr>
  </table>
</td>
  </tr>
	  <tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			For any queries and assistance with Railcar Lounge, please contact 
			<a style="color: #0d6efd;" href="mailto:rclsupport@standardrail.com?Subject=Railcar Lounge: ">
				rclsupport@standardrail.com
			</a> <br /> <br />
		</td>
	</tr>
	<tr>
		<td>
		Thanks,<br>
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
</tbody></table>', 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[MailConfiguration] ([Id], [NotificationEventId], [Subject], [Body], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (2, 2, N'Railcar Lounge: Reset Password!', N'<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
	<tbody>
	<tr>
		<td style="border-bottom:5px solid #709ce9; background:#1a335f">
			<span style="display:block;font-size:22px;padding:10px">
			<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>
			</span>
		</td>
	</tr>
	<tr>
		<td>
			<br>
			Hello <strong>{userEmail}</strong>,
			<br><br>
		</td>
	</tr>
	<tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			Reset your password by clicking on the link below:
		</td>
	</tr>
  <tr bgcolor="#ffffff" style="text-align: center;">
    <td align="center" style="font-family:''Roboto'',sans-serif;color:#ffffff; padding:20px 20px 20px 20px;">
  <table cellspacing="0" cellpadding="0">
    <tr>
      <td style="border-radius: 5px; font-size: 20px;
      padding: 8px;" bgcolor="#1a335f">
        <a href="{resetPasswordURL}" target="_blank" style="border: 1px solid #1a335f;border-radius: 8px; cursor: pointer; font-family: ''Roboto'',sans-serif, Helvetica, Arial, sans-serif;font-size: 15px; color: #ffffff;text-decoration: none;display: inline-block;">
          Reset Password
        </a>
      </td>
    </tr>
  </table>
</td>
  </tr>
	  <tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">If you did not request a password reset, you can safely ignore this email. Only a person with access to your email can reset your account password.
			<br /><br />
			For any queries and assistance with Railcar Lounge, please contact
			<a style="color: #0d6efd;" href="mailto:rclsupport@standardrail.com?Subject=Railcar Lounge: ">
				rclsupport@standardrail.com
			</a> <br /> <br />
		</td>
	</tr>
	<tr>
		<td>
		Thanks,<br>
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
</tbody></table>', 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, CAST(N'2022-07-13T18:32:28.3490093' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[MailConfiguration] ([Id], [NotificationEventId], [Subject], [Body], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (3, 3, N'Railcar Lounge:  Registration Not Approved!', N'<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
	<tbody>
	<tr>
		<td style="border-bottom:5px solid #709ce9; background:#1a335f">
			<span style="display:block;font-size:22px;padding:10px">
			<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>
			</span>
		</td>
	</tr>
	<tr>
		<td>
			<br>
			Hello <strong>{userEmail}</strong>,
			<br><br>
		</td>
	</tr>
	<tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			Thank you for choosing Railcar Lounge.<br /><br />
Your request for registration has not been approved by Railcar Lounge. Your denial case will be reviewed, and a representative from Railcar Lounge will reach out to you to discuss any further action.
		</td>
	</tr>
	  <tr>
		<td style="font-family:Tahoma,Geneva,sans-serif"><br />
			For any queries and assistance with Railcar Lounge, please contact
			<a style="color: #0d6efd;" href="mailto:rclsupport@standardrail.com?Subject=Railcar Lounge: ">
				rclsupport@standardrail.com
			</a> <br /> <br />
		</td>
	</tr>
	<tr>
		<td>
		Thanks,<br>
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
</tbody></table>', 1, CAST(N'2022-07-13T14:13:22.9901673' AS DateTime2), 1, CAST(N'2022-07-13T14:13:22.9901673' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[MailConfiguration] ([Id], [NotificationEventId], [Subject], [Body], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (4, 4, N'Railcar Lounge:  Registration Approved!', N'<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
	<tbody>
	<tr>
		<td style="border-bottom:5px solid #709ce9; background:#1a335f">
			<span style="display:block;font-size:22px;padding:10px">
			<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>
			</span>
		</td>
	</tr>
	<tr>
		<td>
			<br>
			Hello <strong>{userEmail}</strong>,
			<br><br>
		</td>
	</tr>
	<tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			Thank you for choosing Railcar Lounge.
			<br /><br />
			Your registration is approved.<br /><br />
{organizationName} is registered with Railcar Lounge. <br/> <br />
Your login credentials are listed below:
		</td>
	</tr>
	<tr>
		<td>
			<br>
		<table style="color:#555555;font-family:Tahoma,Geneva,sans-serif;font-size:14px;width:70%;border:1px solid #ccc;border-collapse:collapse" cellspacing="1" cellpadding="2" border="1" align="left">
			<tbody><tr>
				<td width="150px">
					<strong>Username</strong>
				</td>
				<td>
					{userEmail}
				</td>
			</tr>
			<tr>
				<td>
					<strong>Password</strong>
				</td>
				<td>
					{password} (system generated)
				</td>
			</tr>
		</tbody></table>
	</td>
	</tr>
	<tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			<br />
			<strong>Note:</strong> Once you log in with the system password, please reset your password.
		</td>
	</tr>

	  <tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			<br />
			For any queries and assistance with Railcar Lounge, please contact
			<a style="color: #0d6efd;" href="mailto:rclsupport@standardrail.com?Subject=Railcar Lounge: ">
				rclsupport@standardrail.com
			</a> <br /> <br />
		</td>
	</tr>
	<tr>
		<td>
		Thanks,<br>
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
</tbody></table>', 1, CAST(N'2022-07-13T14:16:09.0718954' AS DateTime2), 1, CAST(N'2022-07-13T14:16:09.0718954' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[MailConfiguration] ([Id], [NotificationEventId], [Subject], [Body], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (5, 5, N'Railcar Lounge: Email ID Already Registered!', N'<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
	<tbody>
	<tr>
		<td style="border-bottom:5px solid #709ce9; background:#1a335f">
			<span style="display:block;font-size:22px;padding:10px">
			<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>
			</span>
		</td>
	</tr>
	<tr>
		<td>
			<br>
			Hello <strong>{userEmail}</strong>,
			<br><br>
		</td>
	</tr>
	<tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			This email address is already registered with Railcar Lounge.
			<br /><br />
			In case, you have forgot the password, please click the link below:
		</td>
	</tr>
	<tr bgcolor="#ffffff" style="text-align: center;">
        <td align="center" style="font-family:''Roboto'',sans-serif;color:#ffffff; padding:20px 20px 20px 20px;">
			<table cellspacing="0" cellpadding="0">
				<tr>
					<td style="border-radius: 5px; font-size: 20px;
					padding: 8px;" bgcolor="#1a335f">
						<a href="{forgotPassword}" target="_blank" style="border: 1px solid #1a335f;border-radius: 8px; cursor: pointer; font-family: ''Roboto'',sans-serif, Helvetica, Arial, sans-serif;font-size: 15px; color: #ffffff;text-decoration: none;display: inline-block;">
							Forgot Password
						</a>
					</td>
				</tr>
			</table>
		</td>
      </tr>
	  <tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			For any queries and assistance with Railcar Lounge, please contact
			<a style="color: #0d6efd;" href="mailto:rclsupport@standardrail.com?Subject=Railcar Lounge: ">
				rclsupport@standardrail.com
			</a> <br /> <br />
		</td>
	</tr>
	<tr>
		<td>
		Thanks,<br>
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
</tbody></table>', 1, CAST(N'2022-07-13T14:18:18.0970026' AS DateTime2), 1, CAST(N'2022-07-13T14:18:18.0970026' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[MailConfiguration] ([Id], [NotificationEventId], [Subject], [Body], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (6, 6, N'Railcar Lounge: New Booking Received! Opportunity', N'<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
	<tbody>
	<tr>
		<td style="border-bottom:5px solid #709ce9; background:#1a335f">
			<span style="display:block;font-size:22px;padding:10px">
			<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>
			</span>
		</td>
	</tr>
	<tr>
		<td>
			<br>
			Hello,
			<br><br>
		</td>
	</tr>
	<tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
		 <strong>Booking ID: </strong> {bookingID}
			<br />
			<br />
			{userEmail} from {organizationName} has submitted a new order for Storage Facility at {storageFacility}.
			<br /><br />
		</td>
	</tr>
	  <tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			
		</td>
	</tr>
	<tr>
		<td>
		Thanks,<br>
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
</tbody></table>', 1, CAST(N'2022-07-13T14:18:18.0970026' AS DateTime2), 1, CAST(N'2022-07-13T14:18:18.0970026' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[MailConfiguration] ([Id], [NotificationEventId], [Subject], [Body], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (7, 7, N'Railcar Lounge: Booking Confirmation !', N'<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
	<tbody>
	<tr>
		<td style="border-bottom:5px solid #709ce9; background:#1a335f">
			<span style="display:block;font-size:22px;padding:10px">
			<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge"/>
			</span>
		</td>
	</tr>
	<tr>
		<td>
			<br>
			Hello <strong>{userEmail}</strong>,
			<br><br>
		</td>
	</tr>
	<tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			<strong>Booking ID: </strong> {bookingID}
			<br />
			<br />
			Thank you for choosing Railcar Lounge.
			<br /><br />
			We have received your request to book {storageFacility}. A representative from Railcar Lounge will contact you with the booking confirmation details.<br /><br />
		</td>
	</tr>
	  <tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			For any queries and assistance with Railcar Lounge, please contact
			<a style="color: #0d6efd;" href="mailto:rclsupport@standardrail.com?Subject=Railcar Lounge: ">
				rclsupport@standardrail.com
			</a> <br /> <br />
		</td>
	</tr>
	<tr>
		<td>
		Thanks,<br>
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
</tbody></table>', 1, CAST(N'2022-07-13T14:18:18.0970026' AS DateTime2), 1, CAST(N'2022-07-13T14:18:18.0970026' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[MailConfiguration] ([Id], [NotificationEventId], [Subject], [Body], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (8, 8, N'Railcar Lounge: New User Approval Pending!', N'<table width="600" style="color:#555555;border:1px solid #ccc;padding:5px;font-family:Tahoma,Geneva,sans-serif;font-size:14px" cellspacing="0" cellpadding="0" border="0" align="left">
	<tbody>
	<tr>
		<td style="border-bottom:5px solid #709ce9; background:#1a335f">
			<span style="display:block;font-size:22px;padding:10px">
			<img src="https://standardrail.com/wp-content/uploads/2022/05/Railcar-Lounge-White-300x221.png" height="60" alt="Railcar Lounge">
			</span>
		</td>
	</tr>
	<tr>
		<td>
			<br>
			Hello,
			<br><br>
		</td>
	</tr>
	<tr>
		<td style="font-family:Tahoma,Geneva,sans-serif">
			{userEmail} from {companyName} has requested to register with Railcar Lounge.
			Log in to Railcar Lounge to view the request.
			<br>
			<br>
		</td>
	</tr>
	<tr>
		<td>
		Thanks,<br>
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
</tbody></table>', 1, CAST(N'2022-07-13T14:18:18.0970026' AS DateTime2), 1, CAST(N'2022-07-13T14:18:18.0970026' AS DateTime2), 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[MailConfiguration] OFF
GO
SET IDENTITY_INSERT [dbo].[AppFeatures] ON 
GO
INSERT [dbo].[AppFeatures] ([Id], [Name], [Description]) VALUES (1, N'Dashboard', N'Dashboard')
GO
INSERT [dbo].[AppFeatures] ([Id], [Name], [Description]) VALUES (2, N'Storage Order', N'Storage Order')
GO
INSERT [dbo].[AppFeatures] ([Id], [Name], [Description]) VALUES (3, N'Customer', N'Customer')
GO
INSERT [dbo].[AppFeatures] ([Id], [Name], [Description]) VALUES (4, N'Vendor', N'Vendor')
GO
INSERT [dbo].[AppFeatures] ([Id], [Name], [Description]) VALUES (5, N'RailCars', N'RailCars')
GO
INSERT [dbo].[AppFeatures] ([Id], [Name], [Description]) VALUES (6, N'Users', N'Users')
GO
INSERT [dbo].[AppFeatures] ([Id], [Name], [Description]) VALUES (7, N'Onboard Customer', N'Onboard Customer')
GO
INSERT [dbo].[AppFeatures] ([Id], [Name], [Description]) VALUES (8, N'Onboard Vendor', N'Onboard Customer')
GO
INSERT [dbo].[AppFeatures] ([Id], [Name], [Description]) VALUES (9, N'Search Facility', N'Search Facility')
GO
INSERT [dbo].[AppFeatures] ([Id], [Name], [Description]) VALUES (10, N'Reports', N'Reports')
GO
SET IDENTITY_INSERT [dbo].[AppFeatures] OFF
GO
SET IDENTITY_INSERT [dbo].[AuditLogEvent] ON 
GO
INSERT [dbo].[AuditLogEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (1, N'Storage Order Created', N'Storage Order Created', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[AuditLogEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (2, N'Storage Order Updated', N'Storage Order Updated', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[AuditLogEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (3, N'Storage Order Expired', N'Storage Order Expired', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[AuditLogEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (4, N'Rail Car Added', N'Rail Car Added', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[AuditLogEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (5, N'Rail Car Arrived', N'Rail Car Arrived', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[AuditLogEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (6, N'Rail Car Departed', N'Rail Car Departed', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[AuditLogEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (7, N'Notes Added', N'Notes Added', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[AuditLogEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (8, N'Attachment Added', N'Attachment Added', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[AuditLogEvent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (9, N'Rail Car Updated', N'Rail Car Updated', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[AuditLogEvent] OFF
GO
SET IDENTITY_INSERT [dbo].[ContractType] ON 
GO
INSERT [dbo].[ContractType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (1, N'SPOT', NULL, 1, CAST(N'2022-08-07T13:46:57.2581871' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2581871' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ContractType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (2, N'Take-or-pay - Term Based', NULL, 1, CAST(N'2022-08-07T13:46:57.2581691' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2581700' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ContractType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (3, N'Take-or-pay - Arrival Based', NULL, 1, CAST(N'2022-08-07T13:46:57.2581691' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2581700' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[ContractType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (4, N'Reserve', NULL, 1, CAST(N'2022-08-07T13:46:57.2581861' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2581862' AS DateTime2), 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[ContractType] OFF
GO
SET IDENTITY_INSERT [dbo].[Currency] ON 
GO
INSERT [dbo].[Currency] ([Id], [Name], [Code], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (1, N'US Dollars', N'USD', 1, CAST(N'2022-08-07T13:46:57.2581891' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2581892' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[Currency] ([Id], [Name], [Code], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (2, N'Canadian Dollars', N'CAD', 1, CAST(N'2022-08-07T13:46:57.2581904' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2581904' AS DateTime2), 0, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Currency] OFF
GO
SET IDENTITY_INSERT [dbo].[LEContent] ON 
GO
INSERT [dbo].[LEContent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (1, N'Loaded', N'', 1, CAST(N'2022-08-07T13:46:57.2587240' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2587241' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[LEContent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (2, N'Empty', N'', 1, CAST(N'2022-08-07T13:46:57.2587253' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2587254' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[LEContent] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (3, N'Empty Residue', N'', 1, CAST(N'2022-08-07T13:46:57.2587263' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2587264' AS DateTime2), 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[LEContent] OFF
GO
SET IDENTITY_INSERT [dbo].[RailCarType] ON 
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (1, N'A-Equipped box cars', N'Equipped box cars', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (2, N'B-Unequipped box cars', N'Unequipped box cars', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (3, N'C-Covered hopper cars', N'Covered hopper cars', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (4, N'D-Locomotive', N'Locomotive', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (5, N'E-Equipped gondola', N'Equipped gondola', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (6, N'F-Flat cars', N'Flat cars', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (7, N'G-Unequipped gondola', N'Unequipped gondola', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (8, N'H-Unequipped hopper', N'Unequipped hopper', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (9, N'J-Gondola car', N'Gondola car', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (10, N'K-Equipped hopper cars', N'Equipped hopper cars', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (11, N'L-Special type cars', N'Special type cars', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (13, N'P-Conventional intermodal cars', N'Conventional intermodal cars', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (14, N'Q-Lighter weight, low-profile intermodal cars', N'Lighter weight, low-profile intermodal cars', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (15, N'R-Refrigerator cars', N'Refrigerator cars', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (16, N'S-Stack car', N'Stack car', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (17, N'T-Tank cars', N'Tank cars', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (18, N'U-Containers', N'Containers', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (19, N'V-Vehicular flat cars', N'Vehicular flat cars', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[RailCarType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (20, N'Z-Trailers', N'Trailers', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[RailCarType] OFF
GO
SET IDENTITY_INSERT [dbo].[RailRoad] ON 
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (1, N'ANN ARBOR RAILROAD', N'AA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (2, N'AKRON BARBERTON CLUSTER RAILWAY COMPANY', N'AB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (3, N'ALAMEDA BELT LINE', N'ABL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (4, N'ATHENS LINE LLC, THE', N'ABR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (5, N'ALABAMA SOUTHERN RAILROAD', N'ABS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (6, N'ALABAMA WARRIOR RAILWAY LLC.', N'ABWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (7, N'ASHTABULA CARSON & JEFFERSON RAILROAD', N'ACJR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (8, N'ABERDEEN CAROLINA & WESTERN RAILWAY CO', N'ACWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (9, N'ADRIAN & BLISSFIELD RAIL ROAD COMPANY', N'ADBF', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (10, N'ALBANY & EASTERN RAILROAD COMPANY', N'AERC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (11, N'ALABAMA & FLORIDA RAILWAY CO', N'AF', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (12, N'AMADOR FOOTHILLS RAILROAD', N'AFR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (13, N'ALAMO GULF COAST RAILROAD COMPANY', N'AGCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (14, N'ALABAMA & GULF COAST RAILWAY LLC', N'AGR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (15, N'AIKEN RAILWAY COMPANY LLC', N'AIKR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (16, N'ACADIANA RAILWAY COMPANY', N'AKDN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (17, N'ARKANSAS MIDLAND RAILROAD CO INC', N'AKMD', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (18, N'ALABAMA EXPORT RAILROAD, INC', N'ALE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (19, N'ALLENTOWN AND AUBURN RAILROAD', N'ALLN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (20, N'ARKANSAS LOUISIANA & MISSISSIPPI RAILROAD COMPANY', N'ALM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (21, N'ALABAMA RAILROAD, LLC (ALR)', N'ALR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (22, N'ALTON & SOUTHERN RAILWAY COMPANY', N'ALS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (23, N'AIRLAKE TERMINAL RAILWAY COMPANY', N'ALT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (24, N'ARKANSAS AND MISSOURI RAILROAD CO', N'AM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (25, N'AMTRAK-NATIONAL RAILROAD PASSENGER CORPORATION', N'AMTK', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (26, N'AN RAILWAY LLC', N'AN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (27, N'ANGELINA & NECHES RIVER RAILROAD COMPANY', N'ANR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (28, N'ALTEX ENERGY LTD', N'ANRG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (29, N'APPALACHIAN & OHIO RAILROAD INC', N'AO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (30, N'ARKANSAS-OKLAHOMA RAILROAD INC', N'AOK', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (31, N'THE ALIQUIPPA & OHIO RIVER RAILROAD COMPANY', N'AOR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (32, N'APACHE RAILWAY COMPANY', N'APA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (33, N'ALBANY PORT DISTRICT', N'APD', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (34, N'APPANOOSE COUNTY COMMUNITY RAILROAD INC', N'APNC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (35, N'ALBERTA PRAIRIE RAILWAY', N'APR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (36, N'ABERDEEN AND ROCKFISH RAILROAD COMPANY', N'AR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (37, N'ARCADE AND ATTICA RAILROAD CORPORATION', N'ARA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (38, N'ALEXANDER RAILROAD COMPANY', N'ARC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (39, N'ALASKA RAILROAD CORPORATION', N'ARR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (40, N'ARKANSAS SOUTHERN RAILROAD', N'ARS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (41, N'A & R TERMINAL RAILROAD', N'ART', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (42, N'ARIZONA & CALIFORNIA RAILROAD CO', N'ARZC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (43, N'ASHLAND RAILWAY CO', N'ASRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (44, N'AFFTON TERMINAL SERVICES RAILROAD LLC', N'AT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (45, N'ATLANTIC RAILWAYS COMPANY LLC', N'ATL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (46, N'AT & L RAILROAD CO INC', N'ATLT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (47, N'ALABAMA & TENNESSEE RIVER RAILWAY LLC', N'ATN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (48, N'ATLANTIC & WESTERN RAILWAY L P', N'ATW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (49, N'AUTAUGA NORTHERN RAILROAD LLC', N'AUT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (50, N'ALLEGHENY VALLEY RAILROAD COMPANY', N'AVR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (51, N'AG VALLEY RAILROAD LLC', N'AVRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (52, N'AUSTIN WESTERN RAILROAD', N'AWRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (53, N'ADAMS WARNOCK RAILWAY INC.', N'AWRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (54, N'ALGERS WINSLOW AND WESTERN RAILWAY COMPANY', N'AWW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (55, N'ARIZONA CENTRAL RAILROAD INC', N'AZCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (56, N'ARIZONA EASTERN RAILWAY COMPANY', N'AZER', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (57, N'BAYWAY TERMINAL SWITCHING COMPANY LLC', N'BAWT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (58, N'BAY LINE RAILROAD L L C, THE', N'BAYL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (59, N'BUCKINGHAM BRANCH RAILROAD COMPANY', N'BB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (60, N'BOGALUSA BAYOU RAILROAD LLC', N'BBAY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (61, N'BAY COLONY RAILROAD CORPORATION', N'BCLR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (62, N'BAY COAST RAILROAD', N'BCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (63, N'BCR PROPERTIES LTD.', N'BCRM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (64, N'BARRIE-COLLINGWOOD RAILWAY', N'BCRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (65, N'BELVIDERE & DELAWARE RIVER RAILWAY COMPANY INC', N'BDRV', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (66, N'BALLARD TERMINAL RAILROAD CO LLC', N'BDTL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (67, N'BIGHORN DIVIDE & WYOMING RAILROAD INC', N'BDW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (68, N'BEECH MOUNTAIN RAILROAD COMPANY', N'BEEM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (69, N'BIG FOUR TERMINAL RAILROAD LLC', N'BFT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (70, N'BIG SKY RAIL CORP', N'BGS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (71, N'B&H RAIL CORP', N'BH', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (72, N'BHP NEVADA RAILROAD COMPANY', N'BHP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (73, N'BROOKHAVEN RAIL LLC', N'BHR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (74, N'BIRMINGHAM TERMINAL RAILWAY LLC', N'BHRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (75, N'BUCYRUS INDUSTRIAL RAILROAD, LLC', N'BIR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (76, N'BELPRE INDUSTRIAL PARKERSBURG RAILROAD', N'BIP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (77, N'BAJA CALIFORNIA RAILROAD INC', N'BJRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (78, N'BURLINGTON JUNCTION RAILWAY', N'BJRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (79, N'BATTEN KILL RAILROAD INC', N'BKRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (80, N'BLUE MOUNTAIN RAILROAD INC', N'BLMR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (81, N'BLOOMER LINE, THE', N'BLOL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (82, N'BLACKLANDS RAILROAD THE', N'BLR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (83, N'BLUE RIDGE SOUTHERN RAILROAD LLC', N'BLU', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (84, N'BELFAST AND MOOSEHEAD LAKE RAILROAD COMPANY', N'BML', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (85, N'BLACKWELL NORTHERN GATEWAY RAILROAD COMPANY', N'BNG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (86, N'BURLINGTON NORTHERN (MANITOBA) LTD', N'BNML', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (87, N'BNSF RAILWAY COMPANY', N'BNSF', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (88, N'BALTIMORE AND OHIO CHICAGO TERMINAL RAILROAD CO', N'BOCT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (89, N'BORDER PACIFIC RAILROAD CO', N'BOP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (90, N'BUFFALO & PITTSBURGH RAILROAD INC', N'BPRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (91, N'BRANDON RAILROAD LLC', N'BRAN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (92, N'BELT RAILWAY COMPANY OF CHICAGO', N'BRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (93, N'BROWNSVILLE & RIO GRANDE INTERNATIONAL RAILWAY LLC', N'BRG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (94, N'BATTLE RIVER RAILWAY NGC INC', N'BRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (95, N'BLACK RIVER & WESTERN CORPORATION', N'BRW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (96, N'BIRMINGHAM SOUTHERN RR CO', N'BS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (97, N'BI-STATE DEVELOPMENT AGENCY', N'BSDA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (98, N'BUFFALO SOUTHERN RAILROAD INC', N'BSOR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (99, N'BIG SPRING RAIL SYSTEM INC.', N'BSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (100, N'BOSTON SURFACE RAILROAD COMPANY, INC', N'BSRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (101, N'BOONE & SCENIC VALLEY RAILROAD', N'BSVY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (102, N'BOUNDARY TRAIL RAILWAY COMPANY INC.', N'BTR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (103, N'BOISE VALLEY RAILROAD LLC', N'BVRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (104, N'BRANDYWINE VALLEY RAILROAD COMPANY', N'BVRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (105, N'BAUXITE & NORTHERN RAILWAY COMPANY', N'BXN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (106, N'CHESAPEAKE & ALBEMARLE', N'CA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (107, N'COLUMBUS AND GREENVILLE RAILWAY', N'CAGY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (108, N'CAROLINA SOUTHERN RAILROAD COMPANY, THE', N'CALA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (109, N'CAMP CHASE RAILWAY COMPANY LLC', N'CAMY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (110, N'CAPE BRETON & CENTRAL NOVA SCOTIA RAILWAY', N'CBNS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (111, N'COOS BAY RAILROAD OPERATING CO. LLC', N'CBR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (112, N'COLUMBIA BASIN RAILROAD COMPANY INC', N'CBRW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (113, N'COPPER BASIN RAILWAY INC', N'CBRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (114, N'CCET LLC', N'CCET', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (115, N'COLUMBUS & CHATTAHOOCHEE RAILROAD INC', N'CCH', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (116, N'CHATTOOGA & CHICKAMAUGA RAILWAY CO', N'CCKY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (117, N'CORPUS CHRISTI TERMINAL RAILROAD INC', N'CCPN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (118, N'CAMP CHASE INDUSTRIAL RAILROAD CORPORATION', N'CCRA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (119, N'CLEVELAND COMMERCIAL RAILROAD COMPANY LLC', N'CCRL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (120, N'CENTRAL CALIFORNIA TRACTION COMPANY', N'CCT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (121, N'CHICAGO-CHEMUNG RAILROAD CORP', N'CCUO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (122, N'CENTRAL INDIANA & WESTERN RAILROAD CO INC', N'CEIW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (123, N'CENTRAL MANITOBA RAILWAY INC', N'CEMR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (124, N'CENTRAL RAILROAD COMPANY OF INDIANAPOLIS', N'CERA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (125, N'CICERO CENTRAL RAILROAD L.L.C.', N'CERR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (126, N'CAPE FEAR RAILWAYS INC', N'CF', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (127, N'CHICAGO FT WAYNE & EASTERN A DIVISION OF CENTRAL RAILROAD OF INDIANAPOLIS INC', N'CFE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (128, N'C F LANAUDIERE INC', N'CFL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (129, N'CALIFORNIA NORTHERN RAILROAD COMPANY LP', N'CFNR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (130, N'SARTIGAN RAILWAY/CHEMIN DE FER SARTIGAN', N'CFS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (131, N'CANEY FORK AND WESTERN RR', N'CFWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (132, N'CG RAILWAY INC', N'CGR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (133, N'CHATTAHOOCHEE BAY RAILROAD INC', N'CHAT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (134, N'CLEVELAND HARBOR BELT RAILROAD LLC', N'CHB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (135, N'CHESTNUT RIDGE RAILWAY COMPANY', N'CHR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (136, N'CHARLOTTE SOUTHERN RAILROAD COMPANY', N'CHS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (137, N'CEDAR RAPIDS & IOWA CITY RAILWAY COMPANY', N'CIC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (138, N'CENTRAL RAILROAD OF INDIANA', N'CIND', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (139, N'CITY OF ROCHELLE ILLINOIS', N'CIR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (140, N'CHATTAHOOCHEE INDUSTRIAL RAILROAD', N'CIRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (141, N'CENTRAL ILLINOIS RAILROAD COMPANY', N'CIRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (142, N'CHICAGO JUNCTION RAILWAY COMPANY LLC', N'CJR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (143, N'CHESAPEAKE AND INDIANA RAILROAD COMPANY INC', N'CKIN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (144, N'COLUMBIA & COWLITZ RAILWAY LLC', N'CLC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (145, N'CHESSIE LOGISTICS CO. LLC', N'CLCY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (146, N'CAROLINA COASTAL RAILWAY INC', N'CLNA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (147, N'CLARENDON AND PITTSFORD RAILROAD COMPANY, THE', N'CLP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (148, N'CENTRAL MONTANA RAIL INC', N'CM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (149, N'MADISON RAILROAD (A DIV OF CITY OF MADISON PORT AUTHORITY)', N'CMPA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (150, N'CENTRAL MAINE & QUEBEC RAILWAY', N'CMQ', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (151, N'CENTRAL MIDLAND RAILWAY COMPANY', N'CMR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (152, N'CAPE MAY SEASHORE LINES', N'CMSL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (153, N'CANADIAN NATIONAL RAILWAYS', N'CN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (154, N'CN AQUATRAIN', N'CNAT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (155, N'C & NC RAILROAD CORPORATION', N'CNUR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (156, N'CENTRAL NEW YORK RAILROAD CORPORATION', N'CNYK', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (157, N'CENTRAL NEW ENGLAND RAILROAD CO INC', N'CNZR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (158, N'CONECUH VALLEY RAILWAY LLC', N'COEH', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (159, N'CRAB ORCHARD & EGYPTIAN RAILWAY A DIVISION OF PROGRESSIVE RAIL IN', N'COER', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (160, N'CITY OF PRINEVILLE RAILWAY', N'COP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (161, N'CENTRAL OREGON & PACIFIC RAILROAD INC', N'CORP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (162, N'COLUMBIA & READING RAILWAY CO', N'CORY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (163, N'CAROLINA PIEDMONT DIVISION SOUTH CAROLINA CENTRAL RAILROAD COMPANY INC', N'CPDR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (164, N'COOPERSVILLE AND MARNE RAILWAY COMPANY', N'CPMY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (165, N'CATERPARROTT RAILNET LLC', N'CPR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (166, N'CHICAGO RAIL & PORT LLC', N'CPRL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (167, N'CANADIAN PACIFIC RAILWAY', N'CPRS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (168, N'CINCINNATI RAILWAY COMPANY', N'CRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (169, N'CHICAGO RAIL LINK', N'CRL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (170, N'CASCADE AND COLUMBIA RIVER RAILROAD COMPANY', N'CSCD', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (171, N'C & S RAILROAD CORPORATION', N'CSKR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (172, N'CONNECTICUT SOUTHERN RAILROAD INC', N'CSO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (173, N'CHICAGO, ST. PAUL & PACIFIC RAILROAD, LLC', N'CSP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (174, N'CAMDEN & SOUTHERN RAILROAD INC', N'CSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (175, N'CHICAGO SOUTHSHORE & SOUTH BEND RAILROAD', N'CSS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (176, N'CSX TRANSPORTATION', N'CSXT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (177, N'COLUMBIA TERMINAL', N'CT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (178, N'CHICAGO TERMINAL RAILROAD', N'CTM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (179, N'CANTON RAILROAD COMPANY', N'CTN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (180, N'CLINTON TERMINAL RAILROAD COMPANY', N'CTR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (181, N'CLOQUET TERMINAL RAILROAD COMPANY INC', N'CTRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (182, N'CARLTON TRAIL RAILWAY COMPANY', N'CTRW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (183, N'CENTRAL TEXAS & COLORADO RIVER RAILWAY LLC', N'CTXR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (184, N'COLUMBUS & OHIO RAILROAD COMPANY', N'CUOH', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (185, N'CLACKAMAS VALLEY RAILWAY LLC', N'CVLY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (186, N'CIMARRON VALLEY RAILROAD L C', N'CVR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (187, N'PROGRESSIVE RAIL INC D/B/A CANNON VALLEY RAILROAD COMPANY', N'CVRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (188, N'CADDO VALLEY RAILROAD COMPANY', N'CVYR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (189, N'COLORADO & WYOMING RWY CO', N'CW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (190, N'CENTRAL WASHINGTON RAILROAD COMPANY', N'CWA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (191, N'CALDWELL COUNTY RAILROAD COMPANY', N'CWCY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (192, N'CWRR INC', N'CWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (193, N'CLEVELAND WORKS RAILWAY COMPANY', N'CWRO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (194, N'COMMONWEALTH RAILWAY INC', N'CWRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (195, N'CWW LLC', N'CWW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (196, N'COLORADO PACIFIC RAILROAD', N'CXR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (197, N'CARRIZO GORGE RAILWAY INC', N'CZRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (198, N'D & I RAILROAD COMPANY', N'DAIR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (199, N'DAKOTA SHORT LINE', N'DAKS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (200, N'DALLAS TERMINAL RAILWAY', N'DALT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (201, N'DELRAY CONNECTING RAILROAD COMPANY', N'DC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (202, N'DECATUR CENTRAL RAILROAD INC.', N'DCC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (203, N'DETROIT CONNECTING RAILROAD COMPANY', N'DCON', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (204, N'DELMARVA CENTRAL RAILROAD COMPANY', N'DCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (205, N'DUBOIS COUNTY RAILROAD', N'DCRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (206, N'DOVER AND DELAWARE RIVER RAILROAD, LLC', N'DD', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (207, N'DALLAS GARLAND & NORTHEASTERN RAILROAD INC', N'DGNO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (208, N'DURBIN & GREENBRIER VALLEY RAILROAD INC', N'DGVR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (209, N'DAVENPORT INDUSTRIAL RAILROAD, LLC', N'DIR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (210, N'DELAWARE-LACKAWANNA RAILROAD CO INC', N'DL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (211, N'DEPEW LANCASTER & WESTERN RAILROAD CO INC', N'DLWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (212, N'DANSVILLE AND MOUNT MORRIS RAILROAD COMPANY, THE', N'DMM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (213, N'DAKOTA MISSOURI VALLEY & WESTERN RAILROAD INC', N'DMVW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (214, N'DAKOTA NORTHERN RAILROAD INC', N'DN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (215, N'DEQUEEN & EASTERN RAILROAD LLC', N'DQE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (216, N'DARDANELLE & RUSSELLVILLE RAILROAD COMPANY', N'DR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (217, N'DECATUR & EASTERN ILLINOIS RAILROAD LLC', N'DREI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (218, N'DENVER ROCK ISLAND RAILROAD', N'DRIR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (219, N'DOVER & ROCKAWAY RIVER RAILROAD', N'DRRV', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (220, N'DRAKE SWITCHING COMPANY LLC', N'DSC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (221, N'DAKOTA SOUTHERN RAILWAY COMPANY', N'DSRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (222, N'DELTA SOUTHERN RAILROAD COMPANY', N'DSRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (223, N'DECATUR JUNCTION RAILWAY COMPANY', N'DT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (224, N'DUTCHTOWN SOUTHERN RAILROAD, LLC', N'DUSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (225, N'DELAWARE VALLEY RAILWAY COMPANY INC', N'DV', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (226, N'DEVCO RY (CAPE BRETON DEVELOPMENT CORP)', N'DVR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (227, N'DELTA VALLEY & SOUTHERN RAILWAY COMPANY', N'DVS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (228, N'EAST CAMDEN & HIGHLAND RR CO', N'EACH', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (229, N'EASTERN ALABAMA RAILWAY', N'EARY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (230, N'EASTERN BERKS GATEWAY RAILROAD COMPANY', N'EBG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (231, N'EAST BROOKFIELD & SPENCER RAILROAD LLC', N'EBSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (232, N'EAST BROAD TOP CONNECTING RAILROAD', N'EBTC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (233, N'ECORAIL INC', N'ECO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (234, N'EAST CHATTANOOGA BELT RAILWAY COMPANY', N'ECTB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (235, N'EASTSIDE COMMUNITY RAIL LLC', N'ECYR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (236, N'EL DORADO AND WESSON RAILWAY COMPANY', N'EDW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (237, N'ELLIS & EASTERN COMPANY', N'EE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (238, N'EAST ERIE COMMERCIAL RAILROAD', N'EEC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (239, N'EFFINGHAM RAILROAD COMPANY', N'EFRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (240, N'EASTERN IDAHO RAILROAD LLC', N'EIRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (241, N'EAST JERSEY RAILROAD AND TERMINAL COMPANY', N'EJR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (242, N'ELWOOD JOLIET & SOUTHERN RAILROAD L.L.C', N'EJSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (243, N'ELK RIVER RAILROAD INC', N'ELKR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (244, N'ESCANABA AND LAKE SUPERIOR RAILROAD COMPANY', N'ELS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (245, N'EAST MAHANOY & HAZELTON RAILROAD COMPANY', N'EMHR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (246, N'EASTERN MAINE RAILWAY COMPANY', N'EMRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (247, N'E & N RAILWAY COMPANY (1998) LTD', N'ENR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (248, N'EAST CHICAGO RAIL TERMINAL, LLC', N'ERRT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (249, N'EAST PENN RAILROAD LLC', N'ESPN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (250, N'ESSEX TERMINAL RAILWAY COMPANY, THE', N'ETL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (251, N'EAST TENNESSEE RAILWAY L P', N'ETRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (252, N'EVERETT RAILROAD', N'EV', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (253, N'EVANSVILLE WESTERN RAILWAY INC', N'EVWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (254, N'ELKHART & WESTERN RAILROAD CO', N'EWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (255, N'ELIZABETHTOWN INDUSTRIAL RAILROAD LLC', N'EZR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (256, N'FULTON COUNTY RAILROAD INC', N'FC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (257, N'COMPANIA DE FERROCARRILES CHIAPAS MAYAB SA DE CV', N'FCCM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (258, N'FLORIDA CENTRAL RAILROAD CO', N'FCEN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (259, N'FULTON COUNTY RAILWAY LLC', N'FCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (260, N'FIRST COAST RAILROAD INC', N'FCRD', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (261, N'FLORIDA EAST COAST RAILWAY LLC', N'FEC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (262, N'FLORIDA GULF & ATLANTIC RAILROAD, LLC', N'FGA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (263, N'FINGER LAKES RAILWAY CORP', N'FGLK', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (264, N'FLATS INDUSTRIAL RAILROAD COMPANY', N'FIR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (265, N'FERROCARRIL DEL ISTMO DE TEHUANTEPEC, S.A. DE C.V.', N'FIT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (266, N'FLORIDA MIDLAND RAILROAD CO INC', N'FMID', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (267, N'FORTY MILE RAILROAD INC.', N'FMR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (268, N'FARMRAIL CORPORATION', N'FMRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (269, N'FLORIDA NORTHERN RAILROAD COMPANY INC', N'FNOR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (270, N'FORDYCE AND PRINCETON RAILROAD CO', N'FP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (271, N'FALLS ROAD RAILROAD CO INC', N'FRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (272, N'FORE RIVER TRANSPORTATION CORPORATION', N'FRVT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (273, N'FORT SMITH RAILROAD CO', N'FSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (274, N'FERROSUR S A DE C V', N'FSRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (275, N'FLORIDA WEST COAST RAILROAD INC', N'FWCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (276, N'FORT WORTH & DALLAS BELT RAILROAD', N'FWDB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (277, N'ILMORE & WESTERN RAILWAY', N'FWRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (278, N'FORT WORTH & WESTERN RAILROAD', N'FWWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (279, N'FERROCARRIL MEXICANO S A DE C V', N'FXE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (280, N'GEORGIA CENTRAL RAILWAY L P', N'GC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (281, N'GEORGES CREEK RAILWAY', N'GCK', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (282, N'GARDEN CITY WESTERN RAILWAY COMPANY, THE', N'GCW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (283, N'GRAND ELK RAILROAD LLC.', N'GDLK', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (284, N'GETTYSBURG & NORTHERN RAILROAD CO', N'GET', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (285, N'GODERICH-EXETER RAILWAY COMPANY LTD', N'GEXR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (286, N'GRAND FORKS RAILWAY COMPANY', N'GFR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (287, N'GEORGIA & FLORIDA RAILWAY LLC', N'GFRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (288, N'GOLDEN ISLES TERMINAL RAILROAD INC', N'GITM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (289, N'GREAT LAKES CENTRAL RAILROAD', N'GLC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (290, N'GREAT LAKES TERMINAL RAILROAD, LLC', N'GLTR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (291, N'GEORGIA MIDLAND RAILROAD INC', N'GMR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (292, N'GREEN MOUNTAIN RAILROAD CORPORATION', N'GMRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (293, N'GRAINBELT CORPORATION', N'GNBC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (294, N'GNP RLY INC.', N'GNPR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (295, N'GEORGIA NORTHEASTERN RAILROAD CO', N'GNRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (296, N'GEAUX GEAUX RAILROAD LLC', N'GOGR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (297, N'GOOSE LAKE RAILWAY LLC', N'GOOS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (298, N'GRAND RAPIDS EASTERN RAILROAD INC', N'GR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (299, N'GARDENDALE RAILROAD INC', N'GRD', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (300, N'GREENVILLE & WESTERN RAILWAY COMPANY LLC', N'GRLW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (301, N'GREAT NORTHWEST RAILROAD LLC', N'GRNW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (302, N'GEORGETOWN RAILROAD COMPANY', N'GRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (303, N'THE GREAT LAKE PORT CORPORATION D/B/A THE GRAND RIVER RAILWAY', N'GRRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (304, N'GARY RAILWAY COMPANY', N'GRW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (305, N'GREAT WALTON RAILROAD CO, THE', N'GRWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (306, N'GRENADA RAILROAD LLC D/B/A GRENADA RAILWAY', N'GRYR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (307, N'GEORGIA SOUTHERN RAILWAY CO.', N'GS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (308, N'GULF & SHIP ISLAND RAILROAD LLC', N'GSI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (309, N'GREAT SMOKEY MOUNTAINS RAILWAY INC', N'GSM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (310, N'GREAT SANDHILLS RAILWAY LTD.', N'GSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (311, N'GEORGIA SOUTHWESTERN RAILROAD INC', N'GSWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (312, N'GREAT RIVER RAILROAD', N'GTR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (313, N'GOLDEN TRIANGLE RAILROAD LLC', N'GTRA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (314, N'GRAFTON AND UPTON RAILROAD COMPANY', N'GU', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (315, N'GALVESTON RAILROAD LP', N'GVSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (316, N'GREAT WESTERN RAILWAY OF COLORADO LLC', N'GWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (317, N'GEORGIA WOODLANDS RAILROAD CO', N'GWRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (318, N'GREAT WESTERN RAILWAY LTD', N'GWRS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (319, N'GATEWAY EASTERN RAILWAY COMPANY', N'GWWE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (320, N'HILTON & ALBANY RAILOAD INC.', N'HAL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (321, N'HAMPTON & BRANCHVILLE RAILROAD COMPANY', N'HB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (322, N'HUDSON BAY RAILWAY COMPANY', N'HBRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (323, N'HURON CENTRAL RAILWAY INC', N'HCRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (324, N'HOLLIS & EASTERN R R CO', N'HE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (325, N'HURON AND EASTERN RAILWAY COMPANY INC', N'HESR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (326, N'HAINESPORT INDUSTRIAL RAILROAD LLC', N'HIRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (327, N'HERRIN RAILROAD, LLC', N'HIRW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (328, N'HAMPTON RAILWAY INC', N'HLSC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (329, N'HUNTSVILLE & MADISON COUNTY RAILROAD AUTHORITY', N'HMCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (330, N'HUTCHINSON AND NORTHERN RAILWAY COMPANY, THE', N'HN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (331, N'HENDERSON OVERTON BRANCH', N'HOB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (332, N'HEART OF GEORGIA RAILROAD INC', N'HOG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (333, N'HOOSIER SOUTHERN RAILROAD', N'HOS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (334, N'HIGH POINT THOMASVILLE & DENTON RAILROAD COMPANY', N'HPTD', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (335, N'HERITAGE RAILROAD CORP', N'HR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (336, N'HONDO RAILWAY LLC', N'HRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (337, N'HOUSATONIC RAILROAD COMPANY INC', N'HRRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (338, N'HARTWELL RAILROAD COMPANY', N'HRT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (339, N'HAINESPORT SECONDARY LLC', N'HSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (340, N'HARDIN SOUTHERN RAILROAD INC', N'HSRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (341, N'HEART OF TEXAS RAILROAD LP', N'HTR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (342, N'IOWA INTERSTATE RAILROAD LTD', N'IAIS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (343, N'IOWA NORTHERN RAILROAD', N'IANR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (344, N'IOWA NORTHWESTERN RAILROAD', N'IANW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (345, N'IOWA RIVER RAILROAD INC', N'IARR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (346, N'IOWA TRACTION RAILWAY COMPANY', N'IATR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (347, N'IOWA & MIDDLETOWN RAILWAY LLC', N'IAMR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (348, N'INTERNATIONAL BRIDGE AND TERMINAL COMPANY, THE', N'IBT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (349, N'INDIAN CREEK RAILROAD COMPANY', N'ICRK', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (350, N'INDIANA EASTERN RAILROAD LLC', N'IERR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (351, N'INDIANA HARBOR BELT RAILROAD COMPANY', N'IHB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (352, N'ILLINOIS WESTERN RAILROAD COMPANY', N'ILW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (353, N'ITAWAMBA MISSISSIPPIAN RAILROAD LLC', N'IMR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (354, N'ILLINOIS & MIDLAND RAILROAD INC', N'IMRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (355, N'INDIANA NORTHEASTERN RAILROAD COMPANY INC', N'IN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (356, N'IDAHO NORTHERN & PACIFIC RAILROAD COMPANY', N'INPR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (357, N'INDIANA RAIL ROAD CORPORATION', N'INRD', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (358, N'INDIANA & OHIO RAILWAY COMPANY', N'IORY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (359, N'ILLINOIS RAILWAY LLC', N'IR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (360, N'IOWA SOUTHERN RAILROAD COMPANY', N'ISR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (361, N'INDIANA SOUTHERN RAILROAD COMPANY INC', N'ISRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (362, N'IOWA SOUTHERN RAILWAY COMPANY', N'ISRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (363, N'INDIANA SOUTHWESTERN RAILWAY CO', N'ISW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (364, N'ITHACA CENTRAL RAILROAD LLC', N'ITHR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (365, N'JACKSON & LANSING RAILROAD COMPANY', N'JAIL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (366, N'J K LINE INC', N'JKL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (367, N'JUNIATA VALLEY RAILROAD COMPANY', N'JVRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (368, N'JACKSONVILLE PORT TERMINAL RAILROAD L.L.C.', N'JXPT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (369, N'KAW RIVER RAILROAD', N'KAW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (370, N'KANKAKEE BEAVERVILLE AND SOUTHERN RAILROAD COMPANY', N'KBSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (371, N'KANSAS CITY SOUTHERN RAILWAY COMPANY', N'KCS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (372, N'KANSAS CITY SOUTHERN DE MEXICO S DE R L DE C V', N'KCSM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (373, N'KANSAS CITY TRANSPORTATION CO LLC', N'KCTL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (374, N'KETTLE FALLS INTERNATIONAL RAILWAY LLC', N'KFR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (375, N'KINGMAN TERMINAL RAILROAD LLC', N'KGTR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (376, N'KISKI JUNCTION RAILROAD', N'KJR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (377, N'KEOKUK JUNCTION RAILWAY', N'KJRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (378, N'KNOX & KANE RAILROAD COMPANY', N'KKRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (379, N'KLAMATH NORTHERN RAILWAY COMPANY', N'KNOR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (380, N'KANAWHA RIVER RAILROAD L.L.C.', N'KNWA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (381, N'KANSAS & OKLAHOMA RAILROAD LLC', N'KO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (382, N'KELOWNA PACIFIC RAILWAY LTD', N'KPR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (383, N'KASGRO RAIL LINES', N'KRL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (384, N'KIAMICHI RAILROAD COMPANY LLC', N'KRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (385, N'KATAHDIN RAILCAR SERVICES LLC ', N'KRS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (386, N'KINSTON & SNOW HILL RAILROAD CO. INC.', N'KSH', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (387, N'KOSCIUSKO SOUTHWESTERN RAILWAY', N'KSRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (388, N'KENTUCKY AND TENNESSEE RAILWAY', N'KT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (389, N'KENDALLVILLE TERMINAL RAILWAY CO', N'KTR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (390, N'KWT RAILWAY INC', N'KWT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (391, N'KNOXVILLE & HOLSTON RIVER RAILROAD CO INC', N'KXHR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (392, N'KYLE RAILROAD COMPANY', N'KYLE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (393, N'LOS ANGELES JUNCTION RAILWAY COMPANY', N'LAJ', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (394, N'LIVONIA AVON & LAKEVILLE RAILROAD CORPORATION', N'LAL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (395, N'LOUISIANA SOUTHERN RAILROAD', N'LAS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (396, N'LOWVILLE AND BEAVER RIVER RAILROAD COMPANY THE', N'LBR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (397, N'LUBBOCK & WESTERN RAILWAY L.L.C.', N'LBWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (398, N'LANCASTER & CHESTER RAILROAD LLC.', N'LC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (399, N'LAKE COUNTY RAILROAD', N'LCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (400, N'LONG CREEK RAILROAD COMPANY INC', N'LCRI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (401, N'LOUISIANA & DELTA RAILROAD INC', N'LDRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (402, N'LOGANSPORT & EEL RIVER SHORT-LINE CO INC', N'LER', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (403, N'LINEA COAHUILA DURANGO SA DE CV', N'LFCD', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (404, N'LONG ISLAND RAILROAD COMPANY', N'LI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (405, N'LEWIS & CLARK RAILWAY CO', N'LINC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (406, N'LOUISVILLE & INDIANA RAILROAD COMPANY', N'LIRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (407, N'LAPEER INDUSTRIAL RAILROAD COMPANY', N'LIRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (408, N'LITTLE KANAWHA RIVER RAIL INC', N'LKRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (409, N'LEAVENWORTH, LAWRENCE & GALVESTON DBA BALDWIN CITY & SOUTHERN', N'LLG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (410, N'LAKE LINE RAILROAD INC.', N'LLR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (411, N'LAKE MICHIGAN AND INDIANA RAILROAD COMPANY', N'LMIC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (412, N'LAST MOUNTAIN RAILWAY', N'LMR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (413, N'LOUISVILLE NEW ALBANY & CORYDON RAILROAD', N'LNAL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (414, N'LANDISVILLE TERMINAL & TRANSFER COMPANY', N'LNVT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (415, N'LOUISIANA AND NORTH WEST RAILROAD COMPANY, THE', N'LNW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (416, N'LONGVIEW, PORTLAND & NORTHERN RAILWAY COMPANY', N'LPN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (417, N'LOUISVILLE RIVERPORT AUTHORITY RAILROAD', N'LRA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (418, N'LITTLE ROCK PORT RAILROAD', N'LRPA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (419, N'LAURINBURG AND SOUTHERN RAILROAD COMPANY', N'LRS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (420, N'LITTLE ROCK & WESTERN RAILWAY L P', N'LRWN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (421, N'LEHIGH RAILWAY LLC.', N'LRWY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (422, N'LRY LLC.', N'LRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (423, N'LUZERNE AND SUSQUEHANNA RAILWAY COMPANY', N'LS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (424, N'LAKE SUPERIOR & ISHPEMING RAILROAD COMPANY', N'LSI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (425, N'LAKE STATE RAILWAY COMPANY', N'LSRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (426, N'LAKE TERMINAL RAILROAD COMPANY, THE', N'LT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (427, N'LANDISVILLE RAILROAD LLC', N'LVR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (428, N'LEHIGH VALLEY RAIL MANAGEMENT LLC - BETHLEHEM DIVISION', N'LVRB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (429, N'LEHIGH VALLEY RAIL MANAGEMENT LLC - JOHNSTOWN DIVISION', N'LVRJ', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (430, N'LYCOMING VALLEY RAILROAD COMPANY', N'LVRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (431, N'LONGVIEW SWITCHING COMPANY', N'LVSW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (432, N'LOUISVILLE AND WADLEY RAILWAY COMPANY', N'LW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (433, N'LUXAPALILA VALLEY RAILROAD INC', N'LXVR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (434, N'MAGMA ARIZONA RAILROAD COMPANY', N'MAA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (435, N'MICHIGAN AIR-LINE RAILWAY CO', N'MAL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (436, N'MANNING RAIL INC', N'MAN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (437, N'MANATEE COUNTY PORT AUTHORITY', N'MAUP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (438, N'MAUMEE & WESTERN RAILROAD CORPORATION', N'MAW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (439, N'MASSACHUSETTS COASTAL RAILROAD LLC', N'MC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (440, N'MASSACHUSETTS CENTRAL RAILROAD CORPORATION', N'MCER', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (441, N'MCLAUGHLIN LINE RAILROAD', N'MCLR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (442, N'MCCLOUD RAILWAY COMPANY', N'MCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (443, N'MOSCOW CAMDEN & SAN AUGUSTINE RAILROAD', N'MCSA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (444, N'C&J RAILROAD COMPANY D/B/A MISSISSIPPI DELTA RAILROAD', N'MD', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (445, N'MARYLAND AND DELAWARE RAILROAD COMPANY', N'MDDE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (446, N'MERIDIAN SOUTHERN RAILWAY LLC', N'MDS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (447, N'MINNESOTA DAKOTA & WESTERN RAILWAY COMPANY', N'MDW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (448, N'MORRISTOWN & ERIE RAILWAY INC', N'ME', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (449, N'MODESTO AND EMPIRE TRACTION COMPANY', N'MET', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (450, N'MUNICIPALITY OF EAST TROY WISCONSIN', N'METW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (451, N'MG RAIL INC', N'MGRI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (452, N'MT HOOD RAILROAD CO', N'MH', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (453, N'MOHALL CENTRAL RAILROAD INC', N'MHC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (454, N'MOHAWK ADIRONDACK & NORTHERN RAILROAD CORP', N'MHWA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (455, N'MIDDLETOWN & HUMMELSTOWN RAILROAD COMPANY', N'MIDH', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (456, N'MANUFACTURERS JUNCTION RAILWAY COMPANY', N'MJ', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (457, N'MARYLAND MIDLAND RAILWAY INC', N'MMID', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (458, N'MID-MICHIGAN RAILROAD INC', N'MMRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (459, N'MISSION MOUNTAIN RAILROAD', N'MMT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (460, N'MISSOURI & NORTHERN ARKANSAS RAILROAD COMPANY INC', N'MNA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (461, N'M&B RAILROAD LLC', N'MNBR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (462, N'MOTIVE RAIL INC D/B/A MISSOURI NORTH CENTRAL RAILROAD', N'MNC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (463, N'MIDDLETOWN & NEW JERSEY RAILWAY LLC', N'MNJ', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (464, N'MINNESOTA NORTHERN RAILROAD INC', N'MNN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (465, N'MINNESOTA COMMERCIAL RAILWAY CO', N'MNNR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (466, N'MAINE NORTHERN RAILWAY COMPANY', N'MNR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (467, N'MINNESOTA PRAIRIE LINE INC', N'MPLI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (468, N'MARQUETTE RAIL LLC', N'MQT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (469, N'MINERAL RANGE INC.', N'MRA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (470, N'MOHALL RAILROAD INC', N'MRI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (471, N'MONTANA RAIL LINK INC', N'MRL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (472, N'MICHIGAN SHORE RAILROAD INC', N'MS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (473, N'MISSISSIPPI CENTRAL RAILROAD COMPANY', N'MSCI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (474, N'MISSISSIPPI EXPORT RAILROAD COMPANY', N'MSE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (475, N'BALLARD TERMINAL RAILROAD COMPANY LLC D/B/A MEEKER SOUTHERN RAILROAD', N'MSN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (476, N'MICHIGAN SOUTHERN RAILROAD CO INC', N'MSO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (477, N'MISSISSIPPI SOUTHERN RAILROAD', N'MSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (478, N'MISSISSIPPIAN RAILWAY COOPERATIVE INC', N'MSRW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (479, N'MASSENA TERMINAL RAILROAD COMPANY, THE', N'MSTR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (480, N'MISSISSIPPI & SKUNA VALLEY RAILROAD LLC', N'MSV', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (481, N'MISSISSIPPI TENNESSEE RAILROAD LLC', N'MTNR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (482, N'MAHONING VALLEY RAILWAY COMPANY, THE', N'MVRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (483, N'MT VERNON TERMINAL RAILWAY INC', N'MVT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (484, N'NAUGATUCK RAILROAD COMPANY INC', N'NAUG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (485, N'NITTANY & BALD EAGLE RAILROAD CO', N'NBER', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (486, N'NEW BRUNSWICK SOUTHERN RAILWAY COMPANY LIMITED', N'NBSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (487, N'NEW CASTLE INDUSTRIAL RAILROAD', N'NCIR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (488, N'NORTH CAROLINA PORTS RAILWAY COMMISSION', N'NCPR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (489, N'NEBRASKA CENTRAL RAILROAD COMPANY', N'NCRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (490, N'NC RAILROAD INC', N'NCRL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (491, N'NCSR LLC. D/B/A NEW CASTLE SOUTHERN RAILROAD', N'NCS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (492, N'NORTH CAROLINA & VIRGINIA RAILROAD CO INC', N'NCVA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (493, N'NASH COUNTY RAILROAD CORP', N'NCYR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (494, N'N D C RAILROAD COMPANY', N'NDCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (495, N'NEW ENGLAND CENTRAL RAILROAD INC', N'NECR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (496, N'NEW ENGLAND SOUTHERN RAILROAD CO INC', N'NEGS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (497, N'NASHVILLE AND EASTERN RAILROAD CORP', N'NERR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (498, N'NORTHEAST TEXAS CONNECTOR LLC', N'NET', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (499, N'THE NELSON AND FT. SHEPPARD RAILWAY CORPORATION', N'NFTS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (500, N'NEW HAMPSHIRE CENTRAL RAILROAD INC', N'NHCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (501, N'NEW HAMPSHIRE NORTHCOAST CORP', N'NHN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (502, N'NEW HOPE & IVYLAND RAILROAD', N'NHRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (503, N'NEW HAMPSHIRE AND VERMONT RAILROAD COMPANY', N'NHVT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (504, N'NEW JERSEY RAIL CARRIER LLC', N'NJRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (505, N'N J TRANSIT RAIL OPERATIONS – COMMUTER CARRIER', N'NJRT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (506, N'NEW JERSEY SEASHORE LINES INC.', N'NJSL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (507, N'NEBRASKA KANSAS & COLORADO RAILNET INC', N'NKCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (508, N'NORTH LOUISIANA & ARKANSAS RAILROAD', N'NLA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (509, N'NORTHERN LINES RAILWAY LLC', N'NLR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (510, N'NORTHERN LIGHTS RAIL LTD.', N'NLRL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (511, N'NEW MEXICO GATEWAY RAILROAD LLC', N'NMGR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (512, N'NEBRASKA NORTHWESTERN RAILROAD INC.', N'NNW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (513, N'NEW ORLEANS & GULF COAST RAILWAY COMPANY INC', N'NOGC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (514, N'NORTHWESTERN OKLAHOMA RAILROAD COMPANY', N'NOKL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (515, N'NEW ORLEANS PUBLIC BELT RAILROAD', N'NOPB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (516, N'NORTHERN OHIO & WESTERN RAILWAY LTD', N'NOW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (517, N'NORFOLK & PORTSMOUTH BELT LINE RAILROAD COMPANY', N'NPB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (518, N'NORTHERN PLAINS RAILROAD INC', N'NPR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (519, N'NORFOLK SOUTHERN RAILWAY COMPANY (NORFOLK SOUTHERN)', N'NS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (520, N'NORTH SHORE RAILROAD CO', N'NSHR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (521, N'NEWBURGH & SOUTH SHORE RAILROAD COMPANY', N'NSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (522, N'NIMISHILLEN & TUSCARAWAS LLC', N'NTRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (523, N'NATCHEZ RAILWAY INC.', N'NTZR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (524, N'NAPA VALLEY RAILROAD CO', N'NVRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (525, N'NORTHWESTERN PACIFIC RAILROAD COMPANY', N'NWP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (526, N'NASHVILLE & WESTERN RAILROAD CORP', N'NWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (527, N'NEW YORK & ATLANTIC RAILWAY COMPANY', N'NYA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (528, N'NEW YORK & GREENWOOD LAKE RAILWAY', N'NYGL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (529, N'NEW YORK & LAKE ERIE RAILROAD', N'NYLE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (530, N'NEW YORK NEW JERSEY RAIL LLC', N'NYNJ', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (531, N'NEW YORK & OGDENSBURG RAILWAY COMPANY INC', N'NYOG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (532, N'NEW YORK SUSQUEHANNA AND WESTERN RAILWAY CORP', N'NYSW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (533, N'OLD AUGUSTA RAILROAD LLC', N'OAR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (534, N'GIO RAILWAYS CORPORATION DBA ORANGEVILLE BRAMPTON RAILWAY', N'OBRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (535, N'OIL CREEK & TITUSVILLE LINES', N'OCTL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (536, N'OREGON EASTERN RAILROAD', N'OERR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (537, N'OHIO CENTRAL RAILROAD CO', N'OHCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (538, N'OHI-RAIL CORPORATION', N'OHIC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (539, N'OHIO TERMINAL RAILWAY COMPANY', N'OHIO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (540, N'OHIO & PENNSYLVANIA RAILROAD COMPANY', N'OHPA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (541, N'OWEGO & HARFORD RAILWAY INC', N'OHRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (542, N'OREGON INDEPENDENCE RAILROAD, LLC', N'OIRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (543, N'OKANAGAN VALLEY RAILWAY COMPANY', N'OKAN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (544, N'OMAHA LINCOLN AND BEATRICE RAILWAY COMPANY', N'OLB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (545, N'ONTARIO L`ORIGNAL RAILWAY INC', N'OLO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (546, N'ONTARIO MIDLAND RAILROAD CORPORATION', N'OMID', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (547, N'ONTARIO CENTRAL RAILROAD CORPORATION', N'ONCT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (548, N'ONTARIO NORTHLAND RAILWAY (ONTARIO NORTHLAND TRANS COMMISSION)', N'ONT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (549, N'OREGON PACIFIC & EASTERN RAILWAY COMPANY', N'OPE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (550, N'OREGON PACIFIC RAILROAD CO', N'OPR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (551, N'ORANGE PORT TERMINAL RAILWAY', N'OPT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (552, N'OGEECHEE RAILROAD COMPANY', N'ORC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (553, N'ONTARIO SOUTHLAND RAILWAY INC', N'OS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (554, N'INDIANA EASTERN RAILROAD LLC D/B/A OHIO SOUTH CENTRAL RAILROAD', N'OSCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (555, N'OHIO SOUTHERN RAILROAD CO', N'OSRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (556, N'OWENSVILLE TERMINAL CO INC', N'OTCO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (557, N'OAKLAND TERMINAL RAILROAD COMPANY', N'OTR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (558, N'OTTERTAIL VALLEY RAILROAD CO INC', N'OTVR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (559, N'OUACHITA RAILROAD', N'OUCH', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (560, N'OHIO VALLEY RAILROAD COMPANY', N'OVR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (561, N'OZARK VALLEY RAILROAD INC', N'OVRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (562, N'OLYMPIA & BELMORE RAILROAD INC.', N'OYLO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (563, N'PADUCAH & LOUISVILLE RAILWAY', N'PAL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (564, N'PITTSBURGH ALLEGHENY & MCKEES ROCKS RR CO', N'PAM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (565, N'PAN AM SOUTHERN LLC.', N'PAS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (566, N'PATAPSCO & BACK RIVERS RAILROAD COMPANY', N'PBR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (567, N'PORT BIENVILLE RAILROAD', N'PBVR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (568, N'PALOUSE RIVER & COULEE CITY RAILROAD LLC', N'PCC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (569, N'POINT COMFORT & NORTHERN RAILWAY COMPANY', N'PCN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (570, N'PEE DEE RIVER RAILROAD CORP', N'PDRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (571, N'PROGRESSIVE RAIL INC', N'PGR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (572, N'PACIFIC HARBOR LINE INC', N'PHL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (573, N'PORT HARBOR RAILROAD INC', N'PHRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (574, N'PADUCAH & ILLINOIS RAILROAD COMPANY', N'PI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (575, N'PICKENS RAILWAY COMPANY', N'PICK', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (576, N'PERU INDUSTRIAL RAILROAD LLC', N'PIR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (577, N'PORT JERSEY RAILROAD CO', N'PJR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (578, N'PICKENS RAILWAY COMPANY', N'PKHP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (579, N'PENNSYLVANIA NORTHEASTERN RAILROAD LLC', N'PN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (580, N'PANHANDLE NORTHERN RAILROAD COMPANY', N'PNR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (581, N'PIEDMONT AND NORTHERN RAILROAD LLC', N'PNRW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (582, N'PRESCOTT AND NORTHWESTERN RAILROAD COMPANY', N'PNW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (583, N'PORTLAND & WESTERN RAILROAD INC', N'PNWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (584, N'THE PITTSBURGH & OHIO CENTRAL RAILROAD COMPANY', N'POHC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (585, N'PORT OF TILLAMOOK BAY RAILROAD', N'POTB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (586, N'PEND OREILLE VALLEY RAILROAD (PORT OF PEND OREILLE)', N'POVA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (587, N'SOUTH CAROLINA DIVISION OF PUBLIC RAILWAYS D/B/A PALMETTO RAILWAY', N'PR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (588, N'PORT RAIL INC.', N'PRI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (589, N'PEARL RIVER VALLEY RAILROAD COMPANY', N'PRV', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (590, N'PIONEER INDUSTRIAL RAILWAY CO', N'PRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (591, N'THE PUGET SOUND & PACIFIC RAILROAD COMPANY A DIVISION OF THE ARIZONA & CALIFORNIA RAILROAD CO LP', N'PSAP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (592, N'PYCO INDUSTRIES INC', N'PSC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (593, N'PENNSYLVANIA & SOUTHERN RAILWAY LLC', N'PSCC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (594, N'PENNSYLVANIA SOUTHWESTERN RAILROAD INC', N'PSWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (595, N'PENINSULA TERMINAL COMPANY', N'PT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (596, N'PLAINVIEW TERMINAL COMPANY', N'PTC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (597, N'PORT TERMINAL RAILROAD ASSOCIATION', N'PTRA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (598, N'PORTLAND TERMINAL RAILROAD COMPANY', N'PTRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (599, N'PORTLAND VANCOUVER JUNCTION RAILROAD LLC', N'PVJR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (600, N'PIONEER VALLEY RAILROAD COMPANY', N'PVRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (601, N'PECOS VALLEY PERMIAN RAILROAD LLC DBA PECOS VALLEY SOUTHERN RAILW', N'PVS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (602, N'PROVIDENCE AND WORCESTER RAILROAD COMPANY', N'PW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (603, N'QUEBEC GATINEAU RAILWAY INC', N'QGRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (604, N'QUEBEC NORTH SHORE AND LABRADOR RAILWAY COMPANY', N'QNSL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (605, N'QUINCY RAILROAD COMPANY', N'QRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (606, N'RARUS RAILWAY COMPANY', N'RARW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (607, N'READING BLUE MOUNTAIN & NORTHERN RAILROAD COMPANY', N'RBMN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (608, N'R BULT RAIL LINES CORP', N'RBRM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (609, N'RAPID CITY PIERRE & EASTERN RAILROAD INC.', N'RCPE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (610, N'RED COAT ROAD & RAIL LTD', N'RCRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (611, N'RARITAN CENTRAL RAILWAY LLC', N'RCRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (612, N'CHICAGO, ROCK ISLAND & PACIFIC RAILROAD, LLC DBA ROCK   ISLAND RAIL', N'RI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (613, N'RJ CORMAN RAILROAD COMPANY/CHILDERSBURG LINE, LLC', N'RJAL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (614, N'R J CORMAN RAILROAD COMPANY/CENTRAL KENTUCKY LINES', N'RJCC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (615, N'RJ CORMAN RAILROAD COMPANY/TEXAS LINES LLC', N'RJCD', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (616, N'R J CORMAN RAILROAD COMPANY/TENNESSEE TERMINAL LLC', N'RJCK', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (617, N'R J CORMAN RAILROAD COMPANY/CLEVELAND LINE', N'RJCL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (618, N'R J CORMAN RAILROAD COMPANY/MEMPHIS LINE', N'RJCM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (619, N'R J CORMAN RAILROAD COMPANY/ALLENTOWN LINES INC', N'RJCN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (620, N'R J CORMAN RAILROAD COMPANY/PENNSYLVANIA LINES INC', N'RJCP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (621, N'R J CORMAN RAILROAD CORPORATION/BARDSTOWN LINE', N'RJCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (622, N'RJ CORMAN RAILROAD CO/CAROLINA LINES LLC', N'RJCS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (623, N'R J CORMAN RAILROAD COMPANY/WV LINE', N'RJCV', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (624, N'R J CORMAN RAILROAD COMPANY/WESTERN OHIO LINE', N'RJCW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (625, N'RUTLAND LINE INC', N'RL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (626, N'RAILINK SOUTHERN ONTARIO', N'RLHH', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (627, N'RAILINK OTTAWA VALLEY', N'RLK', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (628, N'ROCKY MOUNTAIN RAILCAR AND RAILROAD INC', N'RMRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (629, N'RIPLEY & NEW ALBANY RAILROAD COMPANY', N'RNA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (630, N'RUSK PALESTINE & PACIFIC RAILROAD LLC', N'RPP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (631, N'RICHMOND PACIFIC RAILROAD CORPORATION', N'RPRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (632, N'REDMONT RAILWAY COMPANY INC', N'RRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (633, N'ROCK & RAIL INC', N'RRRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (634, N'RED RIVER VALLEY & WESTERN RAILROAD CO', N'RRVW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (635, N'ROBERVAL AND SAGUENAY RAILWAY COMPANY, THE', N'RS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (636, N'RSL RAILROAD LLC', N'RSL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (637, N'RAILROAD SWITCHING SERVICE OF MISSOURI INC', N'RSM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (638, N'RED SPRINGS & NORTHERN RAILROAD CO', N'RSNR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (639, N'RICEBORO SOUTHERN RAILWAY LLC', N'RSOR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (640, N'ROSCOE SNYDER & PACIFIC RAILWAY COMPANY', N'RSP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (641, N'ROCHESTER & SOUTHERN RAILROAD INC', N'RSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (642, N'ROCKDALE SANDOW & SOUTHERN RAILROAD COMPANY', N'RSS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (643, N'RIVERPORT RAILROAD LLC', N'RVPR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (644, N'RIO VALLEY SWITCHING COMPANY', N'RVSC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (645, N'ROGUE VALLEY TERMINAL RAILROAD CORPORATION', N'RVT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (646, N'RINGNECK AND WESTERN RAILROAD', N'RWRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (647, N'RYAL, LLC', N'RYAL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (648, N'SAN ANTONIO CENTRAL RAILROAD LLC', N'SAC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (649, N'SANDERSVILLE RAILROAD COMPANY', N'SAN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (650, N'SAVANNAH PORT TERMINAL RAILROAD INC', N'SAPT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (651, N'SACRAMENTO VALLEY RAILROAD', N'SAV', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (652, N'SAVAGE BINGHAM & GARFIELD RAILROAD COMPANY', N'SBG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (653, N'STERLING BELT LINE RAILWAY', N'SBLN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (654, N'STOURBRIDGE RAILROAD COMPANY', N'SBRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (655, N'SOUTH BRANCH VALLEY RAIL ROAD', N'SBVR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (656, N'SANTA CRUZ AND MONTEREY BAY RAILWAY COMPANY', N'SC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (657, N'SANTA CRUZ BIG TREES & PACIFIC RAILWAY CO', N'SCBG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (658, N'SOUTH CHICAGO & INDIANA HARBOR RAILWAY COMPANY', N'SCIH', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (659, N'SYDNEY COAL RAILWAY', N'SCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (660, N'SOUTH CAROLINA CENTRAL RAILROAD CO INC', N'SCRF', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (661, N'SQUAW CREEK SOUTHERN RAILROAD', N'SCS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (662, N'SCTRR LLC', N'SCTR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (663, N'SRC RAILWAY LLC', N'SCWY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (664, N'SOUTH CENTRAL FLORIDA EXPRESS INC', N'SCXF', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (665, N'ST CROIX VALLEY RAILROAD COMPANY', N'SCXY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (666, N'SAVAGE DAVENPORT RAILROAD COMPANY', N'SD', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (667, N'SAN DIEGO & IMPERIAL VALLEY RAILROAD CO INC', N'SDIY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (668, N'SEMO PORT RAILROAD INC', N'SE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (669, N'SIERRA RAILROAD COMPANY', N'SERA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (670, N'SAN FRANCISCO BAY RAILWAY, LLC', N'SFB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (671, N'SOCIETE DU CHEMIN DE FER DE LA GASPESIE', N'SFG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (672, N'SOUTHERN FREIGHT RAILROAD', N'SFR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (673, N'SANTA FE SOUTHERN RAILWAY', N'SFS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (674, N'SEMINOLE GULF RAILWAY L P', N'SGLR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (675, N'SOUTHWEST GULF RAILROAD COMPANY', N'SGR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (676, N'STEELTON & HIGHSPIRE RAILROAD COMPANY', N'SH', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (677, N'SOUTHERN INDIANA RAILWAY INC', N'SIND', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (678, N'SAN JACINTO TRANSPORTATION COMPANY INCORPORATED', N'SJR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (679, N'SAN JOAQUIN VALLEY RAILROAD CO', N'SJVR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (680, N'SOUTH KANSAS & OKLAHOMA RAILROAD INC', N'SKOL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (681, N'SALT LAKE CITY SOUTHERN RAILROAD COMPANY INC', N'SL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (682, N'SOUTH PLAINS LAMESA RAILROAD LTD', N'SLAL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (683, N'SAN LUIS CENTRAL RAILROAD COMPANY', N'SLC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (684, N'S & L RAILROAD LLC', N'SLGG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (685, N'SALT LAKE GARFIELD AND WESTERN RAILWAY COMPANY', N'SLGW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (686, N'ST LAWRENCE & ATLANTIC RAILROAD (QUEBEC) INC', N'SLQ', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (687, N'ST LAWRENCE & ATLANTIC RAILROAD CO', N'SLR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (688, N'SAN LUIS & RIO GRANDE RAILROAD INC', N'SLRG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (689, N'SMS RAIL SERVICE INC', N'SLRS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (690, N'STILLWATER CENTRAL RAILROAD COMPANY LLC', N'SLWC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (691, N'SAINT MARYS RAILROAD COMPANY', N'SM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (692, N'SAN MANUEL ARIZONA RAILROAD COMPANY', N'SMA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (693, N'SISSETON MILBANK RAILROAD', N'SMRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (694, N'SANTA MARIA VALLEY RAILROAD COMPANY', N'SMV', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (695, N'ST MARYS RAILWAY WEST LLC', N'SMW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (696, N'SARATOGA & NORTH CREEK RAILWAY', N'SNC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (697, N'SUNFLOUR RAILROAD INC', N'SNR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (698, N'SMS RAIL LINES OF NEW YORK LLC', N'SNY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (699, N'SOMERSET RAILROAD CORPORATION', N'SOM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (700, N'SOUTHERN RAILS COOPERATIVE LIMITED', N'SORA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (701, N'SOUTH POINT & OHIO RAILROAD, LLC', N'SPO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (702, N'ST. PAUL & PACIFIC RAILROAD LLC', N'SPP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (703, N'SOUTHWIND SHORTLINE RAILROAD COMPANY', N'SPR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (704, N'AN PEDRO VALLEY RAILROAD LLC', N'SPV', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (705, N'SAN PEDRO RAILROAD OPERATING CO LLC D/B/A SAN PEDRO & SOUTHWESTERN RAILROAD COMPANY', N'SPSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (706, N'SEQUATCHIE VALLEY SWITCHING CO, LLC', N'SQSC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (707, N'STRASBURG RAILROAD COMPANY', N'SRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (708, N'SABINE RIVER & NORTHERN RAILROAD COMPANY', N'SRN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (709, N'SOUTHERN RAILROAD COMPANY OF NEW JERSEY', N'SRNJ', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (710, N'SWAN RANCH RAILROAD LLC', N'SRRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (711, N'SOUTHERN RAILWAY OF BRITISH COLUMBIA LTD', N'SRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (712, N'SAND SPRINGS RAILWAY COMPANY', N'SS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (713, N'SOUTHERN SWITCHING COMPANY', N'SSC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (714, N'SPOKANE, SPANGLE & PALOUSE RAILWAY', N'SSP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (715, N'S&S SHORTLINE RAILROAD', N'SSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (716, N'STEWART SOUTHERN RAILWAY INC', N'SSS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (717, N'SPRINGFIELD TERMINAL RAILWAY COMPANY', N'ST', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (718, N'STOCKTON TERMINAL AND EASTERN RAILROAD', N'STE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (719, N'ST MARIES RIVER RAILROAD COMPANY', N'STMA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (720, N'ST. PAUL & PACIFIC NORTHWEST RAILROAD COMPANY, LLC', N'STPP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (721, N'SHAWNEE TERMINAL RAILWAY COMPANY INC', N'STR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (722, N'STEWARTSTOWN RAILROAD CO', N'STRT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (723, N'SANTA TERESA SOUTHERN RAILROAD LLC', N'STS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (724, N'SUNSET RAILWAY COMPANY', N'SUN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (725, N'SAVANNAH & OLD FORT RAILROAD, LLC', N'SVHO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (726, N'SOUTHERN RAILWAY OF VANCOUVER ISLAND LIMITED', N'SVI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (727, N'SHAMOKIN VALLEY RAILROAD COMPANY', N'SVRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (728, N'SOUTHWESTERN RAILROAD COMPANY INC', N'SW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (729, N'SOUTHWEST PENNSYLVANIA RAILROAD COMPANY', N'SWP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (730, N'TERMINAL RAILWAY ALABAMA STATE DOCKS', N'TASD', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (731, N'TRANSDISTRIBUTION BROOKFIELD RAILROAD LLC', N'TBFR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (732, N'THERMAL BELT RAILWAY', N'TBRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (733, N'TEMPLE & CENTRAL TEXAS RAILWAY INC.', N'TC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (734, N'TEXAS CENTRAL BUSINESS LINES CORPORATION', N'TCB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (735, N'TUCSON CORNELIA & GILA BEND RAILROAD COMPANY', N'TCG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (736, N'TRI-CITY RAILROAD COMPANY', N'TCRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (737, N'TEXAS CITY TERMINAL RAILWAY COMPANY', N'TCT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (738, N'TWIN CITIES & WESTERN RAILROAD', N'TCWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (739, N'TFG TRANSPORT LLC', N'TFG', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (740, N'TERMINAL FERROVIARIA DEL VALLE DE MEXICO SA DE CV', N'TFVM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (741, N'TURNERS ISLAND LLC', N'TI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (742, N'TIMBER ROCK RAILROAD LLC', N'TIBR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (743, N'TOLEDO INDUSTRIAL RAILROAD', N'TIR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (744, N'TENNKEN RAILROAD COMPANY INC', N'TKEN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (745, N'MIDWEST RAIL LLC DBA TOLEDO LAKE ERIE AND WESTERN RAILWAY', N'TLE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (746, N'TACOMA MUNCIPAL BELT LINE RAILWAY', N'TMBL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (747, N'TOWANDA AND MONROETON SHIPPERS LIFELINE INC.', N'TMSS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (748, N'TRANSMEX/USA INC', N'TMUS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (749, N'TEXAS & NORTHERN', N'TN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (750, N'TEXAS NORTHEASTERN DIVISION MID-MICHIGAN RAILROAD INC', N'TNER', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (751, N'THREE NOTCH RAILWAY LLC', N'TNHR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (752, N'TEXAS-NEW MEXICO DIVISION (AUSTIN & NORTHWESTERN RAILROAD COMPANY INC)', N'TNMR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (753, N'TRADEPOINT RAIL LLC', N'TPR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (754, N'TOLEDO PEORIA & WESTERN RAILWAY CORPORATION', N'TPW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (755, N'TOMAHAWK RAILWAY L P', N'TR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (756, N'TRONA RAILWAY COMPANY', N'TRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (757, N'TEXAS RAILWAY EXCHANGE LLC', N'TRE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (758, N'TRINIDAD RAILWAY INC', N'TRIN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (759, N'TACOMA RAIL MOUNTAIN DIVISION', N'TRMW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (760, N'THUNDER RAIL LTD', N'TRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (761, N'TERMINAL RAILROAD ASSOCIATION OF ST LOUIS', N'TRRA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (762, N'TRANSDISTRIBUTION RIDGELAND RAILROAD LLC', N'TRRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (763, N'TRILLIUM RAILWAY CO LTD', N'TRRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (764, N'TORCH RIVER RAIL INC.', N'TRV', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (765, N'TEXAS & EASTERN RAILROAD LLC', N'TSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (766, N'TENNESSEE SOUTHERN RAILROAD CO INC', N'TSRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (767, N'TULSA-SAPULPA UNION RAILWAY COMPANY L L C', N'TSU', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (768, N'TRANSKENTUCKY TRANSPORTATION RAILROAD CO INC', N'TTIS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (769, N'TALLEYRAND TERMINAL RAILROAD COMPANY INC', N'TTR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (770, N'TEXAS GONZALES & NORTHERN RAILWAY COMPANY', N'TXGN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (771, N'TEXAS NEW MEXICO RAILWAY L.L.C.', N'TXN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (772, N'TEXAS NORTH WESTERN RAILWAY COMPANY', N'TXNW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (773, N'TEXAS AND OKLAHOMA RAILROAD COMPANY', N'TXOR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (774, N'TEXAS PACIFICO TRANSPORTATION LTD', N'TXPF', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (775, N'TEXAS ROCK CRUSHER RAILWAY COMPANY', N'TXR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (776, N'TYBURN RAILROAD LLC', N'TYBR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (777, N'TAZEWELL & PEORIA RAILROAD INC', N'TZPR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (778, N'UNION COUNTY INDUSTRIAL RAILROAD COMPANY', N'UCIR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (779, N'UTAH CENTRAL RAILWAY COMPANY', N'UCRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (780, N'INDIANA BUSINESS RAILROAD D/B/A UNION CITY TERMINAL RAILROAD', N'UCT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (781, N'UPPER MERION AND PLYMOUTH RAILROAD COMPANY', N'UMP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (782, N'UNION PACIFIC RAILROAD COMPANY', N'UP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (783, N'UNION RAILROAD COMPANY LLC', N'URR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (784, N'U.S. RAIL OF NEW YORK LLC', N'USNY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (785, N'UTAH SOUTHERN RAILROAD COMPANY LLC', N'USR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (786, N'UTAH RAILWAY COMPANY', N'UTAH', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (787, N'VENTURA COUNTY RAILROAD COMPANY', N'VCRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (788, N'VALDOSTA RAILWAY L P', N'VR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (789, N'VAUGHN RAILROAD COMPANY', N'VRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (790, N'VANDALIA RAILROAD COMPANY', N'VRRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (791, N'VICKSBURG SOUTHERN RAILROAD LLC', N'VSOR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (792, N'V AND S RAILWAY INC', N'VSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (793, N'VIRGINIA SOUTHERN RAILROAD DIVISION NORTH CAROLINA & VIRGINIA RAILROAD', N'VSRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (794, N'V&S RAILWAY INC D/B/A TOWNER RAILWAY', N'VST', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (795, N'VERMONT RAILWAY INC', N'VTR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (796, N'VERMILION VALLEY RAILROAD COMPANY INC', N'VVRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (797, N'WASHINGTON COUNTY RAILROAD CORPORATION', N'WACR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (798, N'WABASH CENTRAL RAILROAD CORPORATION', N'WBCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (799, N'WEST BELT RAILWAY LLC', N'WBRW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (800, N'WOLF CREEK RAILROAD LLC', N'WCKR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (801, N'WACCAMAW COASTLINE RAILROAD CO INC', N'WCLR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (802, N'WELLSBORO & CORNING RAILROAD LLC', N'WCOR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (803, N'WYOMING CONNECT RAILROAD LLC', N'WCRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (804, N'WHEELING & LAKE ERIE RAILWAY COMPANY', N'WE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (805, N'WASHINGTON EASTERN RAILROAD, LLC', N'WER', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (806, N'WEST ISLE LINE INC', N'WFS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (807, N'WIREGRASS CENTRAL RAILWAY LLC', N'WGCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (808, N'WALKING HORSE & EASTERN RAILROAD CO INC', N'WHOE', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (809, N'WINDSOR & HANTSPORT RAILWAY CO', N'WHRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (810, N'WALKING HORSE RAILROAD, LLC', N'WHRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (811, N'WASHINGTON & IDAHO RAILWAY INC', N'WIR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (812, N'WISCONSIN RAPIDS RAILROAD, LLC', N'WIRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (813, N'WESTERN KENTUCKY RAILWAY LLC', N'WKRL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (814, N'WEST MICHIGAN RAILROAD CO', N'WMI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (815, N'PROGRESSIVE RAIL INC D/B/A WISCONSIN NORTHERN RAILROAD', N'WN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (816, N'KANAWHA RAIL CORP', N'WNFR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (817, N'WESTERN NEW YORK & PENNSYLVANIA RAILROAD LLC', N'WNYP', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (818, N'WILLAMETTE & PACIFIC RAILROAD INC', N'WPRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (819, N'WHEATLAND RAIL INC', N'WRI', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (820, N'WRL LLC', N'WRL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (821, N'WESTERN RAILROAD COMPANY', N'WRRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (822, N'WESTERN RAIL SWITCHING INC', N'WRS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (823, N'WISCONSIN & SOUTHERN RAILROAD LLC', N'WSOR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (824, N'WARREN & SALINE RIVER RAILROAD COMPANY', N'WSR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (825, N'WINAMAC SOUTHERN RAILWAY COMPANY', N'WSRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (826, N'WINSTON-SALEM SOUTHBOUND RAILWAY COMPANY (CSX TRANSPORTATION)', N'WSS', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (827, N'WICHITA TERMINAL ASSOCIATION', N'WTA', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (828, N'WESTERN TRANSPORTATION CO', N'WTCO', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (829, N'WICHITA TILLMAN & JACKSON RAILWAY COMPANY INC', N'WTJR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (830, N'WEST TEXAS AND LUBBOCK RAILWAY COMPANY', N'WTLC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (831, N'WEST TENNESSEE RAILROAD CORP', N'WTNN', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (832, N'WARREN & TRUMBULL RAILROAD COMPANY, THE', N'WTRM', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (833, N'WILMINGTON TERMINAL RAILROAD INC', N'WTRY', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (834, N'WALLOWA UNION RAILROAD AUTHORITY', N'WURR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (835, N'WEST VIRGINIA CENTRAL RAILROAD', N'WVC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (836, N'WILLAMETTE VALLEY RAILWAY COMPANY INC', N'WVR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (837, N'WINCHESTER AND WESTERN RAILROAD COMPANY', N'WW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (838, N'WESTERN WASHINGTON RAILROAD LLC', N'WWR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (839, N'WILMINGTON & WESTERN RAILWAY CORP', N'WWRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (840, N'WYE TRANSPORTATION CO', N'WYEC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (841, N'YOUNGSTOWN & AUSTINTOWN RAILROAD CO', N'YARR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (842, N'YOUNGSTOWN BELT RAILROAD COMPANY, THE', N'YB', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (843, N'YCR CORP', N'YCR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (844, N'YORK RAILWAY COMPANY', N'YRC', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (845, N'YELM ROY PRAIRIE LINE', N'YRPL', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (846, N'YOUNGSTOWN & SOUTHEASTERN RAILROAD COMPANY INC', N'YSRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (847, N'YELLOWSTONE VALLEY RAILROAD LLC', N'YSVR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (848, N'YADKIN VALLEY RAILROAD COMPANY', N'YVRR', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (849, N'YAKIMA VALLEY TRANSPORTATION COMPANY', N'YVT', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[RailRoad] ([Id], [Name], [MarkCode], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (850, N'YREKA WESTERN RAILROAD COMPANY', N'YW', 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, CAST(N'2022-08-07T14:20:29.7833333' AS DateTime2), 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[RailRoad] OFF
GO
SET IDENTITY_INSERT [dbo].[StorageFeature] ON 
GO
INSERT [dbo].[StorageFeature] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (1, N'Hazmat Cars', N'Hazmat Cars', 1, CAST(N'2022-08-07T13:46:57.2581966' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2581967' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[StorageFeature] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (2, N'Loaded Cars', N'Loaded Cars', 1, CAST(N'2022-08-07T13:46:57.2581977' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2581977' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[StorageFeature] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (3, N'Cherrypicking', N'Cherrypicking', 1, CAST(N'2022-08-07T13:46:57.2581994' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2581995' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[StorageFeature] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (4, N'Secured Facility', N'Secured Facility', 1, CAST(N'2022-08-07T13:46:57.2582003' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2582003' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[StorageFeature] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (5, N'Scrapping', N'Scrapping', 1, CAST(N'2022-08-07T13:46:57.2582011' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2582012' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[StorageFeature] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (6, N'Repair', N'Repair', 1, CAST(N'2022-08-07T13:46:57.2582021' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2582022' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[StorageFeature] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (7, N'Mechanical', N'Mechanical', 1, CAST(N'2022-08-07T13:46:57.2582036' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2582037' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[StorageFeature] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (8, N'Cleaning', N'Cleaning', 1, CAST(N'2022-08-07T13:46:57.2582046' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2582078' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[StorageFeature] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (9, N'Recertification', N'Recertification', 1, CAST(N'2022-08-07T13:46:57.2582126' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2582127' AS DateTime2), 1, 1, 1)
GO
INSERT [dbo].[StorageFeature] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (10, N'Stripe Aligning', N'Stripe Aligning', 1, CAST(N'2022-08-07T13:46:57.2582146' AS DateTime2), 1, CAST(N'2022-08-07T13:46:57.2582146' AS DateTime2), 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[StorageFeature] OFF
GO
GO
SET IDENTITY_INSERT [dbo].[UserRoleAppFeatureMapping] ON 
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (1, 1, 1, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (2, 1, 2, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (3, 1, 3, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (4, 1, 4, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (5, 1, 5, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (6, 1, 6, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (7, 1, 7, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (8, 1, 8, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (9, 1, 9, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (10, 1, 10, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (11, 2, 1, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (12, 2, 2, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (13, 2, 3, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (14, 2, 4, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (15, 2, 5, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (16, 2, 6, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (17, 2, 7, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (18, 2, 8, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (19, 2, 9, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (20, 2, 10, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (21, 3, 1, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (22, 3, 2, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (23, 3, 4, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (24, 3, 5, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (25, 3, 7, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (26, 3, 9, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (27, 3, 10, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (28, 4, 1, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (29, 4, 2, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (30, 4, 3, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (31, 4, 5, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (32, 4, 8, 1)
GO
INSERT [dbo].[UserRoleAppFeatureMapping] ([Id], [RoleId], [FeatureId], [IsActive]) VALUES (33, 4, 10, 1)
GO
SET IDENTITY_INSERT [dbo].[UserRoleAppFeatureMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRoles] ON 
GO
INSERT [dbo].[UserRoles] ([Id], [Name], [Description], [IsActive]) VALUES (1, N'SuperAdmin', N'SuperAdmin', 1)
GO
INSERT [dbo].[UserRoles] ([Id], [Name], [Description], [IsActive]) VALUES (2, N'Admin', N'Admin', 1)
GO
INSERT [dbo].[UserRoles] ([Id], [Name], [Description], [IsActive]) VALUES (3, N'Customer', N'Customer', 1)
GO
INSERT [dbo].[UserRoles] ([Id], [Name], [Description], [IsActive]) VALUES (4, N'Vendor', N'Vendor', 1)
GO
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
GO
SET IDENTITY_INSERT [dbo].[UserStatus] ON 
GO
INSERT [dbo].[UserStatus] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (1, N'Pending', N'Email verification pending by user.', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[UserStatus] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (2, N'Verified', N'Email verified by user.', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[UserStatus] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (3, N'Rejected', N'Signup rejected.', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[UserStatus] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (4, N'Approved', N'Signup approved.', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[UserStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[UserType] ON 
GO
INSERT [dbo].[UserType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (1, N'Vendor', N'Vendor access application user.', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
INSERT [dbo].[UserType] ([Id], [Name], [Description], [IsActive], [CreatedTime], [CreatedBy], [ModifiedTime], [ModifiedBy], [OrganizationId], [TenantId]) VALUES (2, N'Customer', N'Customer access application user.', 1, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 0, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[UserType] OFF
GO
SET IDENTITY_INSERT [dbo].[Range] ON 
GO
INSERT INTO [dbo].[Range] ([Id], [Min], [Max], [DisplayValue], [Category], [Sequence]) VALUES (1,0,50,'< 50','SwitchIn',1)
GO
INSERT INTO [dbo].[Range] ([Id], [Min], [Max], [DisplayValue], [Category], [Sequence]) VALUES (2,0,100,'< 100','SwitchIn',2)
GO
INSERT INTO [dbo].[Range] ([Id], [Min], [Max], [DisplayValue], [Category], [Sequence]) VALUES (3,0,150,'< 150','SwitchIn',3)
GO
INSERT INTO [dbo].[Range] ([Id], [Min], [Max], [DisplayValue], [Category], [Sequence]) VALUES (4,0,200,'< 200','SwitchIn',4)
GO
INSERT INTO [dbo].[Range] ([Id], [Min], [Max], [DisplayValue], [Category], [Sequence]) VALUES (5,0,50,'< 50','SwitchOut',1)
GO
INSERT INTO [dbo].[Range] ([Id], [Min], [Max], [DisplayValue], [Category], [Sequence]) VALUES (6,0,100,'< 100','SwitchOut',2)
GO
INSERT INTO [dbo].[Range] ([Id], [Min], [Max], [DisplayValue], [Category], [Sequence]) VALUES (7,0,150,'< 150','SwitchOut',3)
GO
INSERT INTO [dbo].[Range] ([Id], [Min], [Max], [DisplayValue], [Category], [Sequence]) VALUES (8,0,200,'< 200','SwitchOut',4)
GO
SET IDENTITY_INSERT [dbo].[Range] OFF
GO