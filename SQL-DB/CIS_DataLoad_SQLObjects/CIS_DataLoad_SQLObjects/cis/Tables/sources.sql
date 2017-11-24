CREATE TABLE [cis].[sources] (
    [source]                  VARCHAR (10)   NOT NULL,
    [source_desc]             VARCHAR (60)   NOT NULL,
    [incentive_trigger_level] NUMERIC (9, 2) NOT NULL,
    [thank_you_letter]        VARCHAR (15)   NOT NULL,
    [incentive_scheme]        VARCHAR (4)    NULL,
    [history_only]            VARCHAR (1)    NOT NULL,
    [distribution_code]       VARCHAR (10)   NULL,
    [discount_percentage]     NUMERIC (5, 2) NULL,
    [amended_by]              VARCHAR (14)   NOT NULL,
    [amended_on]              DATETIME       NOT NULL,
    [source_number]           NUMERIC (18)   NOT NULL
);

