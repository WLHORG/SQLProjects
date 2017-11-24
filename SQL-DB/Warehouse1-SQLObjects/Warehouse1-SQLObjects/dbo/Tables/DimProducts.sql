CREATE TABLE [dbo].[DimProducts] (
    [PK_ID]                 INT          IDENTITY (1, 1) NOT NULL,
    [product]               VARCHAR (50) NOT NULL,
    [product_desc]          VARCHAR (60) NOT NULL,
    [product_vat_category]  VARCHAR (1)  NOT NULL,
    [nominal_account]       VARCHAR (16) NOT NULL,
    [expenditure_group]     VARCHAR (4)  NOT NULL,
    [company]               VARCHAR (4)  NOT NULL,
    [sales_group]           VARCHAR (6)  NOT NULL,
    [donation]              VARCHAR (1)  NOT NULL,
    [course]                VARCHAR (1)  NOT NULL,
    [accommodation]         VARCHAR (1)  NOT NULL,
    [eligible_for_gift_aid] VARCHAR (1)  NOT NULL,
    [history_only]          VARCHAR (1)  NOT NULL,
    [DW_LoadDate]           DATETIME     NULL,
    CONSTRAINT [PK_DimProducts] PRIMARY KEY CLUSTERED ([PK_ID] ASC)
);

