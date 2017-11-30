CREATE TABLE [cis].[duk_comms_log_update_log] (
    [contact_number]            NUMERIC (38)  NOT NULL,
    [communications_log_number] NUMERIC (38)  NOT NULL,
    [source]                    VARCHAR (10)  NULL,
    [created_by]                VARCHAR (14)  NOT NULL,
    [dated]                     DATETIME2 (7) NOT NULL,
    [new_source]                VARCHAR (10)  NULL
);

