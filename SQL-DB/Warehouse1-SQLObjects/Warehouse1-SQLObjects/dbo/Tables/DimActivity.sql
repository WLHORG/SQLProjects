CREATE TABLE [dbo].[DimActivity] (
    [PK_ID]                     INT          IDENTITY (1, 1) NOT NULL,
    [cost_centre_activity]      NVARCHAR (2) NULL,
    [cost_centre_activity_desc] VARCHAR (60) NULL,
    [DW_LoadDate]               DATETIME     NULL,
    CONSTRAINT [PK_DimActivity] PRIMARY KEY CLUSTERED ([PK_ID] ASC)
);

