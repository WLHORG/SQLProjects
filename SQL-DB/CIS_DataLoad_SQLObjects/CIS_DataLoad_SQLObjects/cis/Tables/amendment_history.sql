CREATE TABLE [cis].[amendment_history] (
    [operation]              VARCHAR (6)   NOT NULL,
    [operation_date]         DATETIME      NOT NULL,
    [table_name]             VARCHAR (30)  NOT NULL,
    [logname]                VARCHAR (14)  NOT NULL,
    [data_values]            VARCHAR (MAX) NULL,
    [select_1]               NUMERIC (18)  NULL,
    [select_2]               NUMERIC (18)  NULL,
    [contact_journal_number] NUMERIC (18)  NULL
);

