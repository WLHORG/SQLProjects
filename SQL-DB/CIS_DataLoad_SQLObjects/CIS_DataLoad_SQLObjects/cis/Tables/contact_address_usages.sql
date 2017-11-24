CREATE TABLE [cis].[contact_address_usages] (
    [address_number] NUMERIC (18)  NOT NULL,
    [contact_number] NUMERIC (18)  NOT NULL,
    [address_usage]  VARCHAR (4)   NOT NULL,
    [notes]          VARCHAR (MAX) NULL,
    [amended_by]     VARCHAR (14)  NOT NULL,
    [amended_on]     DATETIME      NOT NULL
);

