CREATE TABLE [dbo].[DimCommunications] (
    [PK_ID]             INT           IDENTITY (1, 1) NOT NULL,
    [FK_Organisation]   INT           NULL,
    [FK_Contact]        INT           NULL,
    [FK_Address]        INT           NULL,
    [CommsType]         VARCHAR (2)   NOT NULL,
    [direction]         VARCHAR (1)   NOT NULL,
    [dated]             DATETIME      NOT NULL,
    [topic]             VARCHAR (15)  NOT NULL,
    [topic_desc]        VARCHAR (100) NOT NULL,
    [sub_topic]         VARCHAR (4)   NOT NULL,
    [sub_topic_desc]    VARCHAR (30)  NOT NULL,
    [mailing_by]        VARCHAR (14)  NOT NULL,
    [mailing_number]    NUMERIC (18)  NULL,
    [number_in_mailing] NUMERIC (18)  NOT NULL,
    [mailing_filename]  VARCHAR (255) NULL,
    [DW_LoadDate]       DATETIME      NOT NULL,
    CONSTRAINT [PK_DimCommunications] PRIMARY KEY CLUSTERED ([PK_ID] ASC),
    CONSTRAINT [FK_DimCommunications_DimAddresses] FOREIGN KEY ([FK_Address]) REFERENCES [dbo].[DimAddresses] ([PK_ID]),
    CONSTRAINT [FK_DimCommunications_DimContact] FOREIGN KEY ([FK_Contact]) REFERENCES [dbo].[DimContact] ([PK_ID]),
    CONSTRAINT [FK_DimCommunications_DimOrganisation] FOREIGN KEY ([FK_Organisation]) REFERENCES [dbo].[DimOrganisation] ([PK_ID])
);

