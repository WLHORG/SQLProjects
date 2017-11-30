CREATE TABLE [custom].[ApplicationPackages](
	[ApplicationPackageID] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationID] [int] NULL,
	[PackageID] [int] NULL,
	[ExecutionOrder] [int] NULL,
	[FailApplicationOnPackageFailure] [bit] NULL,
	[isEnabled] [bit] NULL,
	[Channel] [int] NULL,
 CONSTRAINT [PK_ApplicationPackages] PRIMARY KEY CLUSTERED 
(
	[ApplicationPackageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UX_custom_ApplicationPackages_PackageId_Plus] UNIQUE NONCLUSTERED 
(
	[ApplicationID] ASC,
	[PackageID] ASC,
	[ExecutionOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [custom].[ApplicationPackages] ADD  CONSTRAINT [DF_ApplicationPackages_isEnabled]  DEFAULT ((1)) FOR [isEnabled]