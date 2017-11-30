CREATE TABLE [cis].[payment_frequencies] (
    [payment_frequency]      VARCHAR (1)  NOT NULL,
    [payment_frequency_desc] VARCHAR (30) NOT NULL,
    [frequency]              NUMERIC (18) NOT NULL,
    [amended_by]             VARCHAR (14) NOT NULL,
    [amended_on]             DATETIME     NOT NULL,
    [interval]               NUMERIC (18) NOT NULL,
    [period]                 VARCHAR (1)  NOT NULL
);

