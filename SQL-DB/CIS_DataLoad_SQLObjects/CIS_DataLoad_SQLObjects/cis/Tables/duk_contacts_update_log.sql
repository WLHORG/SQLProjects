CREATE TABLE [cis].[duk_contacts_update_log] (
    [contact_number] NUMERIC (38)  NOT NULL,
    [source]         VARCHAR (10)  NOT NULL,
    [amended_by]     VARCHAR (14)  NOT NULL,
    [amended_on]     DATETIME2 (7) NOT NULL,
    [new_source]     VARCHAR (10)  NULL
);

