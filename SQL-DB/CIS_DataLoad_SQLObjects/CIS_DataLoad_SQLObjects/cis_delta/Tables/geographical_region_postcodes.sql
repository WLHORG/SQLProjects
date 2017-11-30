CREATE TABLE [cis_delta].[geographical_region_postcodes] (
    [geographical_region_type] VARCHAR (4)  NOT NULL,
    [geographical_region]      VARCHAR (10) NOT NULL,
    [postcode]                 VARCHAR (10) NOT NULL,
    [amended_by]               VARCHAR (14) NOT NULL,
    [amended_on]               DATETIME     NOT NULL
);

