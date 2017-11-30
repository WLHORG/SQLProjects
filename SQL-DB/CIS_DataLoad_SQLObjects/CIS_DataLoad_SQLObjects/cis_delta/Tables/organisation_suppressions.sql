CREATE TABLE [cis_delta].[organisation_suppressions] (
    [organisation_number] NUMERIC (18)   NOT NULL,
    [mailing_suppression] VARCHAR (4)    NOT NULL,
    [valid_from]          DATETIME       NOT NULL,
    [valid_to]            DATETIME       NOT NULL,
    [notes]               VARCHAR (2000) NULL,
    [amended_by]          VARCHAR (14)   NOT NULL,
    [amended_on]          DATETIME       NOT NULL
);

