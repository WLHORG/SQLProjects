CREATE TABLE [dbo].[DimOrderDetail] (
    [PK_ID]             INT          IDENTITY (1, 1) NOT NULL,
    [FK_Order]          INT          NULL,
    [detail_number]     INT          NULL,
    [product]           VARCHAR (20) NULL,
    [rate]              VARCHAR (4)  NULL,
    [amount]            FLOAT (53)   NULL,
    [detailline_source] VARCHAR (10) NULL,
    [DW_LoadDate]       DATETIME     NOT NULL,
    CONSTRAINT [PK_DimOrderDetail] PRIMARY KEY CLUSTERED ([PK_ID] ASC),
    CONSTRAINT [FK_DimOrderDetail_DimOrder] FOREIGN KEY ([FK_Order]) REFERENCES [dbo].[DimOrder] ([PK_ID])
);

