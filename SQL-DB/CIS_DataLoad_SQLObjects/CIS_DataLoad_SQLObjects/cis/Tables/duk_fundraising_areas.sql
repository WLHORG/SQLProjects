CREATE TABLE [cis].[duk_fundraising_areas] (
    [rf_area]      NVARCHAR (10) NOT NULL,
    [rf_area_desc] NVARCHAR (80) NOT NULL,
    [amended_by]   NVARCHAR (14) NOT NULL,
    [amended_on]   DATETIME      NOT NULL,
    PRIMARY KEY CLUSTERED ([rf_area] ASC)
);

