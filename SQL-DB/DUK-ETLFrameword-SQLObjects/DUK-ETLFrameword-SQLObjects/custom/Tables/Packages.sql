CREATE TABLE [custom].[Packages](
	[PackageID] [int] IDENTITY(1,1) NOT NULL,
	[PackageName] [nvarchar](130) NULL,
	[ProjectName] [nvarchar](260) NULL,
	[FolderName] [nvarchar](260) NULL,
	[TableName] [nvarchar](50) NULL,
	[TableNotes] [nvarchar](2000) NULL,
	[PackageGroup] [nvarchar](10) NULL,
 CONSTRAINT [UX_custom_Packages_PackageName_Plus] UNIQUE NONCLUSTERED 
(
	[PackageName] ASC,
	[ProjectName] ASC,
	[FolderName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]