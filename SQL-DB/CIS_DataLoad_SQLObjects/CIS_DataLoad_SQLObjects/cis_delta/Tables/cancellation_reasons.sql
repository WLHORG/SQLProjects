CREATE TABLE [cis_delta].[cancellation_reasons] (
    [cancellation_reason]      VARCHAR (4)  NOT NULL,
    [cancellation_reason_desc] VARCHAR (30) NOT NULL,
    [status]                   VARCHAR (4)  NULL,
    [amended_by]               VARCHAR (14) NOT NULL,
    [amended_on]               DATETIME     NOT NULL,
    [history_only]             VARCHAR (1)  NOT NULL
);

