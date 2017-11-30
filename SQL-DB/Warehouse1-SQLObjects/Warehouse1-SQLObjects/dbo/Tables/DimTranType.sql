CREATE TABLE [dbo].[DimTranType] (
    [PK_ID]                 INT          IDENTITY (1, 1) NOT NULL,
    [transaction_type]      VARCHAR (3)  NOT NULL,
    [transaction_type_desc] VARCHAR (30) NOT NULL,
    [transaction_sign]      VARCHAR (1)  NOT NULL,
    [negatives_allowed]     VARCHAR (1)  NOT NULL,
    [DW_LoadDate]           DATETIME     NULL,
    CONSTRAINT [PK_DimTranType] PRIMARY KEY CLUSTERED ([PK_ID] ASC)
);

