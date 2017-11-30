CREATE TABLE [custom].[PackageAudit](
	[PackageAuditKey] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationRunID] [int] NULL,
	[PackageName] [sysname] NOT NULL,
	[RunBy] [sysname] NOT NULL,
	[LastRunDT] [date] NOT NULL,
	[LineageTMST] [datetime] NOT NULL,
	[CompleteTMST] [datetime] NULL,
	[CompletionMessage] [varchar](512) NULL,
 CONSTRAINT [PK_SSISAudit] PRIMARY KEY CLUSTERED 
(
	[PackageAuditKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [custom].[PackageAudit] ADD  CONSTRAINT [DF_custom_PackageAudit_RunBy]  DEFAULT (suser_sname()) FOR [RunBy]
GO
ALTER TABLE [custom].[PackageAudit] ADD  CONSTRAINT [DF_custom_PackageAudit_LastRunDT]  DEFAULT (getdate()) FOR [LastRunDT]
GO
ALTER TABLE [custom].[PackageAudit] ADD  CONSTRAINT [DF_custom_PackageAudit_LineageTMST]  DEFAULT (getdate()) FOR [LineageTMST]