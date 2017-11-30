CREATE TABLE [dbo].[DimOrgContacts] (
    [PK_ID]           INT          IDENTITY (1, 1) NOT NULL,
    [FK_Contact]      INT          NULL,
    [FK_Organisation] INT          NULL,
    [role]            VARCHAR (4)  NULL,
    [is_active]       VARCHAR (1)  NULL,
    [RoleValidFrom]   DATETIME     NULL,
    [RoleValidTo]     DATETIME     NULL,
    [position]        VARCHAR (80) NULL,
    [single_position] VARCHAR (1)  NULL,
    [current]         VARCHAR (1)  NOT NULL,
    [PosValidFrom]    DATETIME     NULL,
    [PosValidTo]      DATETIME     NULL,
    [DW_LoadDate]     DATETIME     NULL,
    CONSTRAINT [PK_DimOrgContacts] PRIMARY KEY CLUSTERED ([PK_ID] ASC),
    CONSTRAINT [FK_DimOrgContacts_DimOrganisation] FOREIGN KEY ([FK_Organisation]) REFERENCES [dbo].[DimOrganisation] ([PK_ID])
);

