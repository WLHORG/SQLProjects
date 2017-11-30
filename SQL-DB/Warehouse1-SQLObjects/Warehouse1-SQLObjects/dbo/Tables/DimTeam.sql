CREATE TABLE [dbo].[DimTeam] (
    [PK_ID]                 INT          IDENTITY (1, 1) NOT NULL,
    [cost_centre_team]      NVARCHAR (1) NULL,
    [cost_centre_team_desc] VARCHAR (60) NULL,
    [DW_LoadDate]           DATETIME     NULL,
    CONSTRAINT [PK_DimTeam] PRIMARY KEY CLUSTERED ([PK_ID] ASC)
);

