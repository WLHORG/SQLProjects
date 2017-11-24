CREATE TABLE [cis].[duk_fund_region_hierarchy] (
    [branch]      NVARCHAR (4)  NOT NULL,
    [rf_area]     NVARCHAR (10) NOT NULL,
    [fund_region] NVARCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([branch] ASC)
);

