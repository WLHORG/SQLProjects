CREATE TABLE [control].[LastTableUpdate] (
    [id]                  INT           IDENTITY (1, 1) NOT NULL,
    [TableName]           NVARCHAR (50) NOT NULL,
    [MaxTransactionDate]  DATETIME      NULL,
    [MaxBusKeyID]         INT           NULL,
    [BusKeyColumn]        NVARCHAR (50) NULL,
    [MAXBatch_Number]     INT           NULL,
    [MAXTransaction_ID]   INT           NULL,
    [MAXLine_ID]          INT           NULL,
    [FullExtract]         INT           CONSTRAINT [DF_LastTableUpdate_FullExtract] DEFAULT ((0)) NULL,
    [LastExtractRowCount] INT           NULL,
    [LastExtractedDate]   DATETIME      NULL
);

