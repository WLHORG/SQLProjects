CREATE TABLE [cis_delta].[addresses] (
    [address_number]        NUMERIC (18)  NOT NULL,
    [address_type]          VARCHAR (1)   NOT NULL,
    [house_name]            VARCHAR (60)  NULL,
    [address]               VARCHAR (200) NOT NULL,
    [town]                  VARCHAR (35)  NOT NULL,
    [county]                VARCHAR (35)  NULL,
    [country]               VARCHAR (4)   NOT NULL,
    [postcode]              VARCHAR (10)  NULL,
    [sortcode]              VARCHAR (5)   NULL,
    [mosaic_code]           VARCHAR (4)   NULL,
    [paf]                   VARCHAR (4)   NULL,
    [branch]                VARCHAR (4)   NULL,
    [amended_by]            VARCHAR (14)  NOT NULL,
    [amended_on]            DATETIME      NOT NULL,
    [address_line1]         VARCHAR (80)  NULL,
    [address_line2]         VARCHAR (80)  NULL,
    [address_line3]         VARCHAR (80)  NULL,
    [address_line4]         VARCHAR (80)  NULL,
    [building_number]       VARCHAR (12)  NULL,
    [delivery_point_suffix] VARCHAR (2)   NULL,
    CONSTRAINT [PK_addresses] PRIMARY KEY CLUSTERED ([address_number] ASC)
);

