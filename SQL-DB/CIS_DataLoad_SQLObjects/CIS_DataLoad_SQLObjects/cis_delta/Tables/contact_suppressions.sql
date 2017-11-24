CREATE TABLE [cis_delta].[contact_suppressions] (
    [contact_number]      NUMERIC (18)  NOT NULL,
    [mailing_suppression] VARCHAR (4)   NOT NULL,
    [valid_from]          DATETIME      NOT NULL,
    [valid_to]            DATETIME      NOT NULL,
    [amended_by]          VARCHAR (14)  NOT NULL,
    [amended_on]          DATETIME      NOT NULL,
    [notes]               VARCHAR (MAX) NULL,
    [source]              VARCHAR (10)  NULL
);

