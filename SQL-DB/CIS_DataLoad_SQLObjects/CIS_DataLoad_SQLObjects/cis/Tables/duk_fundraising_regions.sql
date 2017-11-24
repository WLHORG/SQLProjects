CREATE TABLE [cis].[duk_fundraising_regions] (
    [fund_region]      NVARCHAR (10) NOT NULL,
    [fund_region_desc] NVARCHAR (80) NOT NULL,
    [region]           NVARCHAR (1)  NOT NULL,
    [amended_by]       NVARCHAR (14) NOT NULL,
    [amended_on]       DATETIME      NOT NULL,
    PRIMARY KEY CLUSTERED ([fund_region] ASC)
);

