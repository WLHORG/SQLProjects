CREATE TABLE [dbo].[Fundraising] (
    [PK_ID]               INT        IDENTITY (1, 1) NOT NULL,
    [FK_Date]             INT        NOT NULL,
    [FK_Activity]         INT        NOT NULL,
    [FK_Team]             INT        NOT NULL,
    [FK_Channel]          INT        NOT NULL,
    [FK_Product]          INT        NOT NULL,
    [FK_PayMethod]        INT        NOT NULL,
    [FK_Contact]          INT        NOT NULL,
    [FK_Address]          INT        NOT NULL,
    [FK_FundRegion]       INT        NOT NULL,
    [FK_ContactRegion]    INT        NOT NULL,
    [FK_Organisation]     INT        NOT NULL,
    [FK_TranOrigin]       INT        NOT NULL,
    [FK_TranType]         INT        NOT NULL,
    [FK_Rate]             INT        NOT NULL,
    [FK_Orders]           INT        NOT NULL,
    [FK_Restriction]      INT        NOT NULL,
    [FK_Source]           INT        NOT NULL,
    [Amount]              FLOAT (53) NOT NULL,
    [VAT]                 FLOAT (53) NULL,
    [Quantity]            INT        NULL,
    [GiftAid]             FLOAT (53) NULL,
    [WkLotteryActiveLine] INT        NULL,
    [DateLoad]            DATETIME   NULL,
    CONSTRAINT [PK_Fundraising_1] PRIMARY KEY NONCLUSTERED ([PK_ID] ASC),
    CONSTRAINT [FK_Fundraising_DimActivity] FOREIGN KEY ([FK_Activity]) REFERENCES [dbo].[DimActivity] ([PK_ID]),
    CONSTRAINT [FK_Fundraising_DimAddresses] FOREIGN KEY ([FK_Address]) REFERENCES [dbo].[DimAddresses] ([PK_ID]),
    CONSTRAINT [FK_Fundraising_DimChannel] FOREIGN KEY ([FK_Channel]) REFERENCES [dbo].[DimChannel] ([PK_ID]),
    CONSTRAINT [FK_Fundraising_DimDate] FOREIGN KEY ([FK_Date]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_Fundraising_DimOrder] FOREIGN KEY ([FK_Orders]) REFERENCES [dbo].[DimOrder] ([PK_ID]),
    CONSTRAINT [FK_Fundraising_DimOrganisation] FOREIGN KEY ([FK_Organisation]) REFERENCES [dbo].[DimOrganisation] ([PK_ID]),
    CONSTRAINT [FK_Fundraising_DimPayMethod] FOREIGN KEY ([FK_PayMethod]) REFERENCES [dbo].[DimPaymethod] ([PK_ID]),
    CONSTRAINT [FK_Fundraising_DimProducts] FOREIGN KEY ([FK_Product]) REFERENCES [dbo].[DimProducts] ([PK_ID]),
    CONSTRAINT [FK_Fundraising_DimRate] FOREIGN KEY ([FK_Rate]) REFERENCES [dbo].[DimRate] ([PK_ID]),
    CONSTRAINT [FK_Fundraising_DimRegion_Contact] FOREIGN KEY ([FK_ContactRegion]) REFERENCES [dbo].[DimRegion] ([PK_ID]),
    CONSTRAINT [FK_Fundraising_DimRegion_Fund] FOREIGN KEY ([FK_FundRegion]) REFERENCES [dbo].[DimRegion] ([PK_ID]),
    CONSTRAINT [FK_Fundraising_DimRestriction] FOREIGN KEY ([FK_Restriction]) REFERENCES [dbo].[DimRestriction] ([PK_ID]),
    CONSTRAINT [FK_Fundraising_DimSource] FOREIGN KEY ([FK_Source]) REFERENCES [dbo].[DimSource] ([PK_ID]),
    CONSTRAINT [FK_Fundraising_DimTeam] FOREIGN KEY ([FK_Team]) REFERENCES [dbo].[DimTeam] ([PK_ID]),
    CONSTRAINT [FK_Fundraising_DimTranOrigin] FOREIGN KEY ([FK_TranOrigin]) REFERENCES [dbo].[DimTranOrigin] ([PK_ID]),
    CONSTRAINT [FK_Fundraising_DimTranType] FOREIGN KEY ([FK_TranType]) REFERENCES [dbo].[DimTranType] ([PK_ID])
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-Fundraising]
    ON [dbo].[Fundraising]([FK_Date] DESC);


GO
CREATE NONCLUSTERED INDEX [IX_Activity]
    ON [dbo].[Fundraising]([FK_Activity] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Address]
    ON [dbo].[Fundraising]([FK_Address] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Channel]
    ON [dbo].[Fundraising]([FK_Channel] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Contact]
    ON [dbo].[Fundraising]([FK_Contact] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ContactRegion]
    ON [dbo].[Fundraising]([FK_ContactRegion] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_FundRegion]
    ON [dbo].[Fundraising]([FK_FundRegion] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Orders]
    ON [dbo].[Fundraising]([FK_Orders] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Organisation]
    ON [dbo].[Fundraising]([FK_Organisation] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_PayMethod]
    ON [dbo].[Fundraising]([FK_PayMethod] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Product]
    ON [dbo].[Fundraising]([FK_Product] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Rate]
    ON [dbo].[Fundraising]([FK_Rate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Restriction]
    ON [dbo].[Fundraising]([FK_Restriction] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Source]
    ON [dbo].[Fundraising]([FK_Source] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Team]
    ON [dbo].[Fundraising]([FK_Team] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TranOrigin]
    ON [dbo].[Fundraising]([FK_TranOrigin] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TranType]
    ON [dbo].[Fundraising]([FK_TranType] ASC);

