CREATE TABLE [cis_delta].[geographical_regions] (
    [geographical_region_type] VARCHAR (4)  NOT NULL,
    [geographical_region]      VARCHAR (10) NOT NULL,
    [organisation_number]      NUMERIC (18) NULL,
    [amended_by]               VARCHAR (14) NOT NULL,
    [amended_on]               DATETIME     NOT NULL,
    [geographical_region_desc] VARCHAR (60) NULL
);

