CREATE TABLE [cis].[venues] (
    [venue]               VARCHAR (4)   NOT NULL,
    [venue_desc]          VARCHAR (30)  NOT NULL,
    [contact_number]      NUMERIC (18)  NULL,
    [organisation_number] NUMERIC (18)  NULL,
    [address_number]      NUMERIC (18)  NULL,
    [amended_by]          VARCHAR (14)  NOT NULL,
    [amended_on]          DATETIME      NOT NULL,
    [location]            VARCHAR (255) NULL,
    [venue_capacity]      NUMERIC (18)  NULL
);

