CREATE TABLE [cis_delta].[mailing_suppressions] (
    [mailing_suppression]      VARCHAR (4)   NOT NULL,
    [mailing_suppression_desc] VARCHAR (30)  NOT NULL,
    [amended_by]               VARCHAR (14)  NOT NULL,
    [amended_on]               DATETIME      NOT NULL,
    [notes]                    VARCHAR (MAX) NULL
);

