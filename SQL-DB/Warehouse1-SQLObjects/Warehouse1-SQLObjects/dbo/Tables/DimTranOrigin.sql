CREATE TABLE [dbo].[DimTranOrigin] (
    [PK_ID]                   INT          IDENTITY (1, 1) NOT NULL,
    [transaction_origin]      VARCHAR (10) NOT NULL,
    [transaction_origin_desc] VARCHAR (60) NOT NULL,
    [DW_LoadDate]             DATETIME     NULL,
    CONSTRAINT [PK_DimTranOrigin] PRIMARY KEY CLUSTERED ([PK_ID] ASC)
);

