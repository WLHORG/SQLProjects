CREATE TABLE [cis_delta].[status_history] (
    [contact_number]   NUMERIC (18) NOT NULL,
    [status]           VARCHAR (4)  NULL,
    [status_reason]    VARCHAR (80) NULL,
    [valid_to]         DATETIME     NOT NULL,
    [amended_by]       VARCHAR (14) NOT NULL,
    [amended_on]       DATETIME     NOT NULL,
    [response_channel] VARCHAR (4)  NULL
);

