CREATE TABLE [cis_delta].[amendment_history] (
    [operation]              VARCHAR (6)     NOT NULL,
    [operation_date]         DATETIME        NOT NULL,
    [table_name]             VARCHAR (30)    NOT NULL,
    [logname]                VARCHAR (14)    NOT NULL,
    [data_values]            VARBINARY (MAX) NOT NULL,
    [select_1]               INT             NULL,
    [select_2]               INT             NULL,
    [contact_journal_number] INT             NULL
);

