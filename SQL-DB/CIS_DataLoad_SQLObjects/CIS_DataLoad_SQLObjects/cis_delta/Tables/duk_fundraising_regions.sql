CREATE TABLE [cis_delta].[duk_fundraising_regions] (
    [fund_region]      VARCHAR (10) NOT NULL,
    [fund_region_desc] VARCHAR (80) NOT NULL,
    [region]           VARCHAR (1)  NOT NULL,
    [amended_by]       VARCHAR (14) NOT NULL,
    [amended_on]       DATETIME     NOT NULL,
    PRIMARY KEY CLUSTERED ([fund_region] ASC)
);

