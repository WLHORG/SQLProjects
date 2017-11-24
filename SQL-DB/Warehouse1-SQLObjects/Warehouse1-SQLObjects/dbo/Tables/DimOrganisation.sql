CREATE TABLE [dbo].[DimOrganisation] (
    [PK_ID]            INT          IDENTITY (1, 1) NOT NULL,
    [name]             VARCHAR (50) NOT NULL,
    [label_name]       VARCHAR (80) NOT NULL,
    [CISContactNumber] INT          NULL,
    [salutation]       VARCHAR (80) NULL,
    [source]           VARCHAR (10) NOT NULL,
    [source_date]      DATETIME     NOT NULL,
    [status]           VARCHAR (4)  NOT NULL,
    [status_date]      DATETIME     NOT NULL,
    [status_reason]    VARCHAR (80) NOT NULL,
    [contact_type]     VARCHAR (1)  NOT NULL,
    [ownership_group]  VARCHAR (4)  NULL,
    [branch]           VARCHAR (4)  NOT NULL,
    [DW_LoadDate]      DATETIME     NULL,
    CONSTRAINT [PK_DimOrganisation] PRIMARY KEY CLUSTERED ([PK_ID] ASC)
);

