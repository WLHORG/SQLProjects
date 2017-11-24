CREATE TABLE [cis_delta].[branch_postcodes] (
    [branch]           VARCHAR (4)  NOT NULL,
    [outward_postcode] VARCHAR (10) NOT NULL,
    [amended_on]       DATETIME     NOT NULL,
    [amended_by]       VARCHAR (14) NOT NULL
);

