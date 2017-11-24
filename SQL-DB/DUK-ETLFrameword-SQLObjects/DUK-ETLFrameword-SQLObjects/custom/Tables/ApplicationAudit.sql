CREATE TABLE [custom].[ApplicationAudit](
	[AppAuditKey] [int] IDENTITY(1,1) NOT NULL,
	[ApplicationName] [nvarchar](130) NOT NULL,
	[RunBy] [sysname] NOT NULL,
	[LastRunDT] [date] NOT NULL,
	[StartTMST] [datetime] NOT NULL,
	[CompleteTMST] [datetime] NULL,
	[CompletionMessage] [varchar](512) NULL,
	[isRunning] [bit] NULL,
 CONSTRAINT [PK_AppAuditKey] PRIMARY KEY CLUSTERED 
(
	[AppAuditKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [custom].[ApplicationAudit] ADD  CONSTRAINT [DF_custom_ApplicationAudit_RunBy]  DEFAULT (suser_sname()) FOR [RunBy]
GO
ALTER TABLE [custom].[ApplicationAudit] ADD  CONSTRAINT [DF_custom_ApplicationAudit_LastRunDT]  DEFAULT (getdate()) FOR [LastRunDT]
GO
ALTER TABLE [custom].[ApplicationAudit] ADD  CONSTRAINT [DF_custom_ApplicationAudit_LineageTMST]  DEFAULT (getdate()) FOR [StartTMST]
GO
ALTER TABLE [custom].[ApplicationAudit] ADD  CONSTRAINT [DF_ApplicationAudit_isRunning]  DEFAULT ((0)) FOR [isRunning]