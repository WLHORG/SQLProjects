CREATE TABLE [dbo].[DimRestriction] (
    [PK_ID]       INT           IDENTITY (1, 1) NOT NULL,
    [Code]        VARCHAR (50)  NULL,
    [Description] VARCHAR (255) NULL,
    [DW_LoadDate] DATETIME      NULL,
    CONSTRAINT [PK_DimRestriction] PRIMARY KEY CLUSTERED ([PK_ID] ASC)
);

