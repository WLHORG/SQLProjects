CREATE TABLE [cis].[communication_usages] (
    [communication_usage]      VARCHAR (4)  NOT NULL,
    [communication_usage_desc] VARCHAR (30) NOT NULL,
    [amended_by]               VARCHAR (14) NOT NULL,
    [amended_on]               DATETIME     NOT NULL,
    [notes_mandatory]          VARCHAR (1)  NOT NULL
);

