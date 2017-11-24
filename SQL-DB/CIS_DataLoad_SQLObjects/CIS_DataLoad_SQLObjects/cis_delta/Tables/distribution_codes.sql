CREATE TABLE [cis_delta].[distribution_codes] (
    [distribution_code]      VARCHAR (10) NOT NULL,
    [distribution_code_desc] VARCHAR (30) NOT NULL,
    [analysis_account]       VARCHAR (16) NULL,
    [amended_by]             VARCHAR (14) NOT NULL,
    [amended_on]             DATETIME     NOT NULL,
    [history_only]           VARCHAR (1)  NOT NULL
);

