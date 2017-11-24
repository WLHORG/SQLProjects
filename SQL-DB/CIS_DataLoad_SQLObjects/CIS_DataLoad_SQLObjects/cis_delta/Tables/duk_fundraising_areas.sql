CREATE TABLE [cis_delta].[duk_fundraising_areas] (
    [rf_area]      VARCHAR (10) NOT NULL,
    [rf_area_desc] VARCHAR (80) NOT NULL,
    [amended_by]   VARCHAR (14) NOT NULL,
    [amended_on]   DATETIME     NOT NULL,
    PRIMARY KEY CLUSTERED ([rf_area] ASC)
);

