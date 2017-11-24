CREATE TABLE [dbo].[DimChannel] (
    [PK_ID]        INT          IDENTITY (1, 1) NOT NULL,
    [Channel]      NVARCHAR (1) NULL,
    [Channel_desc] VARCHAR (60) NULL,
    [DW_LoadDate]  DATETIME     NULL,
    CONSTRAINT [PK_DimChannel] PRIMARY KEY CLUSTERED ([PK_ID] ASC)
);

