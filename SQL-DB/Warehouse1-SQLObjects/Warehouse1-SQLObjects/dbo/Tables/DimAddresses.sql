CREATE TABLE [dbo].[DimAddresses] (
    [PK_ID]         INT           IDENTITY (1, 1) NOT NULL,
    [address_type]  VARCHAR (1)   NULL,
    [house_name]    VARCHAR (60)  NULL,
    [address]       VARCHAR (200) NULL,
    [town]          VARCHAR (35)  NULL,
    [county]        VARCHAR (35)  NULL,
    [country]       VARCHAR (4)   NULL,
    [postcode]      VARCHAR (10)  NULL,
    [sortcode]      VARCHAR (5)   NULL,
    [mosaic_code]   VARCHAR (4)   NULL,
    [paf]           VARCHAR (4)   NULL,
    [branch]        VARCHAR (4)   NULL,
    [address_line1] VARCHAR (80)  NULL,
    [address_line2] VARCHAR (80)  NULL,
    [address_line3] VARCHAR (80)  NULL,
    [address_line4] VARCHAR (80)  NULL,
    [DW_LoadDate]   DATETIME      NULL,
    CONSTRAINT [PK_DimAddresses] PRIMARY KEY CLUSTERED ([PK_ID] ASC)
);

