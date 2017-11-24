CREATE TABLE [cis].[contact_links] (
    [contact_number_1]    NUMERIC (18) NOT NULL,
    [contact_number_2]    NUMERIC (18) NOT NULL,
    [relationship]        VARCHAR (4)  NOT NULL,
    [valid_from]          DATETIME     NULL,
    [valid_to]            DATETIME     NULL,
    [historical]          VARCHAR (1)  NULL,
    [notes]               VARCHAR (1)  NULL,
    [amended_by]          VARCHAR (14) NOT NULL,
    [amended_on]          DATETIME     NOT NULL,
    [relationship_status] VARCHAR (4)  NULL
);

