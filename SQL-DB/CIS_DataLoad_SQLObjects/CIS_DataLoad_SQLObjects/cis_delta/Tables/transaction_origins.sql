CREATE TABLE [cis_delta].[transaction_origins] (
    [transaction_origin]      VARCHAR (10) NOT NULL,
    [transaction_origin_desc] VARCHAR (60) NOT NULL,
    [history_only]            VARCHAR (1)  NOT NULL,
    [amended_by]              VARCHAR (14) NOT NULL,
    [amended_on]              DATETIME     NOT NULL
);

