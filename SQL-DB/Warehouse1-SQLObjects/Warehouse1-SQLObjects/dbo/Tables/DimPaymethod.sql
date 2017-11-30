CREATE TABLE [dbo].[DimPaymethod] (
    [PK_ID]               INT          IDENTITY (1, 1) NOT NULL,
    [payment_method]      VARCHAR (4)  NOT NULL,
    [payment_method_desc] VARCHAR (30) NOT NULL,
    [DW_LoadDate]         DATETIME     NULL,
    CONSTRAINT [PK_DimPaymethod] PRIMARY KEY CLUSTERED ([PK_ID] ASC)
);

