CREATE TABLE [cis].[banks] (
    [sort_code]   VARCHAR (6)   NOT NULL,
    [bank]        VARCHAR (30)  NULL,
    [branch_name] VARCHAR (30)  NOT NULL,
    [address]     VARCHAR (200) NULL,
    [town]        VARCHAR (35)  NULL,
    [county]      VARCHAR (35)  NULL,
    [postcode]    VARCHAR (10)  NULL,
    [amended_by]  VARCHAR (14)  NOT NULL,
    [amended_on]  DATETIME      NOT NULL
);

