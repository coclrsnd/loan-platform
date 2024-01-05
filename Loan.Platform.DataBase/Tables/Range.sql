/****** Object:  Table [dbo].[Range]    Script Date: 05-09-2022 13:08:13 ******/
CREATE TABLE [dbo].[Range](
	[Id] [smallint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Min] [int] NOT NULL,
	[Max] [int] NOT NULL,
	[DisplayValue] [nvarchar](20) NOT NULL,
	[Category] [nvarchar](20) NOT NULL,
	[Sequence] [int] NOT NULL
)
GO


