CREATE TABLE [dbo].[DimAddressLinks] (
    [PK_ID]           INT         IDENTITY (1, 1) NOT NULL,
    [isDefault]       VARCHAR (1) NOT NULL,
    [address_usage]   VARCHAR (4) NULL,
    [FK_contact]      INT         NULL,
    [FK_Organisation] INT         NULL,
    [FK_Addresses]    INT         NULL,
    [historical]      VARCHAR (1) NULL,
    [valid_from]      DATETIME    NULL,
    [valid_to]        DATETIME    NULL,
    [DW_LoadDate]     DATETIME    NOT NULL,
    CONSTRAINT [PK_DimAddressLinks] PRIMARY KEY CLUSTERED ([PK_ID] ASC),
    CONSTRAINT [FK_DimAddressLinks_DimAddresses] FOREIGN KEY ([FK_Addresses]) REFERENCES [dbo].[DimAddresses] ([PK_ID]),
    CONSTRAINT [FK_DimAddressLinks_DimContact] FOREIGN KEY ([FK_contact]) REFERENCES [dbo].[DimContact] ([PK_ID]),
    CONSTRAINT [FK_DimAddressLinks_DimOrganisation] FOREIGN KEY ([FK_Organisation]) REFERENCES [dbo].[DimOrganisation] ([PK_ID])
);

