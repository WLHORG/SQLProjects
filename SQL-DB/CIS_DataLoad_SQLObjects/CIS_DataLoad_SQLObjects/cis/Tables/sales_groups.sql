CREATE TABLE [cis].[sales_groups] (
    [sales_group]                    VARCHAR (6)    NOT NULL,
    [sales_group_desc]               VARCHAR (30)   NOT NULL,
    [depreciation_start_unit]        VARCHAR (1)    NULL,
    [depreciation_start_quantity]    NUMERIC (18)   NULL,
    [depreciation_interval_unit]     VARCHAR (1)    NULL,
    [depreciation_interval_quantity] NUMERIC (18)   NULL,
    [percentage_depreciation]        NUMERIC (4, 2) NULL,
    [last_revaluation_date]          DATETIME       NULL,
    [amended_by]                     VARCHAR (14)   NOT NULL,
    [amended_on]                     DATETIME       NOT NULL
);

