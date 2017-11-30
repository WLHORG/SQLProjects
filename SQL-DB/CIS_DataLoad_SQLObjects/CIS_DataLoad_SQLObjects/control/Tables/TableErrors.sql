CREATE TABLE [control].[TableErrors] (
    [id]        INT           IDENTITY (1, 1) NOT NULL,
    [TableName] VARCHAR (50)  NULL,
    [LoadDate]  DATETIME      NULL,
    [ErrNum]    INT           NULL,
    [ErrLne]    INT           NULL,
    [ErrMsg]    VARCHAR (MAX) NULL
);

