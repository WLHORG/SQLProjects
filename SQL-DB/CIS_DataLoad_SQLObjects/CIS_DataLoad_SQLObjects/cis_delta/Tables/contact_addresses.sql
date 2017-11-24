CREATE TABLE [cis_delta].[contact_addresses] (
    [address_link_number] NUMERIC (18) NOT NULL,
    [address_number]      NUMERIC (18) NOT NULL,
    [contact_number]      NUMERIC (18) NOT NULL,
    [historical]          VARCHAR (1)  NOT NULL,
    [valid_from]          DATETIME     NULL,
    [valid_to]            DATETIME     NULL,
    [amended_by]          VARCHAR (14) NOT NULL,
    [amended_on]          DATETIME     NOT NULL
);

