CREATE TABLE [dbo].[DimContactRel] (
    [PK_ID]             INT          IDENTITY (1, 1) NOT NULL,
    [FK_Contact1]       INT          NULL,
    [FK_Contact2]       INT          NULL,
    [FK_Organisation1]  INT          NULL,
    [FK_Organisation2]  INT          NULL,
    [relationship]      VARCHAR (50) NULL,
    [relationship_desc] VARCHAR (50) NULL,
    [historical]        VARCHAR (50) NULL,
    [valid_from]        DATETIME     NULL,
    [valid_to]          DATETIME     NULL,
    [DW_LoadDate]       DATETIME     NULL,
    CONSTRAINT [PK_DimContactRel] PRIMARY KEY CLUSTERED ([PK_ID] ASC),
    CONSTRAINT [FK_DimContactRel_DimOrganisation1] FOREIGN KEY ([FK_Organisation1]) REFERENCES [dbo].[DimOrganisation] ([PK_ID]),
    CONSTRAINT [FK_DimContactRel_DimOrganisation2] FOREIGN KEY ([FK_Organisation2]) REFERENCES [dbo].[DimOrganisation] ([PK_ID])
);

