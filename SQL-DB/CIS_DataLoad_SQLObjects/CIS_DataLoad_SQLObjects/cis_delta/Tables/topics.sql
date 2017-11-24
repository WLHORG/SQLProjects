CREATE TABLE [cis_delta].[topics] (
    [topic]        VARCHAR (6)  NOT NULL,
    [topic_desc]   VARCHAR (40) NOT NULL,
    [history_only] VARCHAR (1)  NULL,
    [amended_by]   VARCHAR (14) NOT NULL,
    [amended_on]   DATETIME     NOT NULL
);

