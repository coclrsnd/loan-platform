/****** Object:  Table [dbo].[DB_Errors]    Script Date: 04-07-2022 19:04:01 ******/
CREATE TABLE [dbo].[DB_Errors](
	[ErrorID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](100) NULL,
	[ErrorMessage] [varchar](max) NULL,
	[ErrorDateTime] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


