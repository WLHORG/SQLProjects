CREATE TABLE [cis].[duk_cont_categories_update_log] (
    [contact_number] NUMERIC (38)  NOT NULL,
    [activity]       VARCHAR (6)   NOT NULL,
    [activity_value] VARCHAR (4)   NOT NULL,
    [source]         VARCHAR (10)  NOT NULL,
    [amended_by]     VARCHAR (14)  NOT NULL,
    [amended_on]     DATETIME2 (7) NOT NULL,
    [new_source]     VARCHAR (10)  NULL
);

