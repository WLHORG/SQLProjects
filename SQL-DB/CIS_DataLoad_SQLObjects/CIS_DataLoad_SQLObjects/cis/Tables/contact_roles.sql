CREATE TABLE [cis].[contact_roles] (
    [contact_number]      NUMERIC (18) NOT NULL,
    [organisation_number] NUMERIC (18) NOT NULL,
    [role]                VARCHAR (4)  NOT NULL,
    [valid_from]          DATETIME     NULL,
    [valid_to]            DATETIME     NULL,
    [is_active]           VARCHAR (1)  NULL,
    [amended_by]          VARCHAR (14) NOT NULL,
    [amended_on]          DATETIME     NOT NULL,
    [contact_role_number] NUMERIC (18) NOT NULL
);

