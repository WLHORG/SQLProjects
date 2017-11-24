CREATE TABLE [cis].[legacy_bequests] (
    [legacy_number]              INT            NOT NULL,
    [bequest_number]             INT            NOT NULL,
    [bequest_description]        VARCHAR (50)   NULL,
    [bequest_type]               VARCHAR (4)    NULL,
    [bequest_sub_type]           VARCHAR (4)    NULL,
    [bequest_status]             VARCHAR (4)    NULL,
    [expected_value]             NUMERIC (9, 2) NULL,
    [estimated_outstanding]      NUMERIC (9, 2) NULL,
    [estimate]                   CHAR (1)       NOT NULL,
    [product]                    VARCHAR (20)   NOT NULL,
    [rate]                       VARCHAR (4)    NOT NULL,
    [amended_by]                 VARCHAR (14)   NOT NULL,
    [amended_on]                 DATETIME       NOT NULL,
    [expected_fraction_quantity] INT            NULL,
    [expected_fraction_division] INT            NULL,
    [condition_met_date]         DATETIME       NULL,
    [distribution_code]          VARCHAR (10)   NULL,
    [notes]                      VARCHAR (MAX)  NULL,
    PRIMARY KEY CLUSTERED ([legacy_number] ASC, [bequest_number] ASC)
);

