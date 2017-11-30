CREATE TABLE [cis].[contact_external_links] (
    [contact_number]     NUMERIC (18) NOT NULL,
    [data_source]        VARCHAR (4)  NOT NULL,
    [external_reference] VARCHAR (20) NOT NULL,
    [amended_by]         VARCHAR (14) NOT NULL,
    [amended_on]         DATETIME     NOT NULL
);

