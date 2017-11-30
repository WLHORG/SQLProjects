CREATE TABLE [cis].[data_sources] (
    [data_source]           VARCHAR (4)  NOT NULL,
    [data_source_desc]      VARCHAR (30) NOT NULL,
    [maintenance_available] VARCHAR (1)  NOT NULL,
    [amended_by]            VARCHAR (14) NOT NULL,
    [amended_on]            DATETIME     NOT NULL
);

