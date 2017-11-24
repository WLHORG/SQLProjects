CREATE TABLE [cis].[contact_positions] (
    [contact_number]          NUMERIC (18) NOT NULL,
    [organisation_number]     NUMERIC (18) NOT NULL,
    [address_number]          NUMERIC (18) NOT NULL,
    [position]                VARCHAR (80) NULL,
    [mail]                    VARCHAR (1)  NOT NULL,
    [current]                 VARCHAR (1)  NOT NULL,
    [started]                 DATETIME     NULL,
    [finished]                DATETIME     NULL,
    [position_location]       VARCHAR (80) NULL,
    [amended_by]              VARCHAR (14) NOT NULL,
    [amended_on]              DATETIME     NOT NULL,
    [contact_position_number] NUMERIC (18) NOT NULL,
    [position_function]       VARCHAR (4)  NULL,
    [position_seniority]      VARCHAR (4)  NULL,
    [single_position]         VARCHAR (1)  NULL
);

