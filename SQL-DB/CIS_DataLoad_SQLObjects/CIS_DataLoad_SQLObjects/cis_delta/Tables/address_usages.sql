CREATE TABLE [cis_delta].[address_usages] (
    [address_usage]      VARCHAR (4)   NOT NULL,
    [address_usage_desc] VARCHAR (30)  NOT NULL,
    [amended_by]         VARCHAR (14)  NOT NULL,
    [amended_on]         DATETIME      NOT NULL,
    [notes_mandatory]    VARCHAR (MAX) NOT NULL
);

