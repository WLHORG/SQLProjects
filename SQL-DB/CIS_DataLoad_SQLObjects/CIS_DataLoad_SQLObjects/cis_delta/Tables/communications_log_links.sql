CREATE TABLE [cis_delta].[communications_log_links] (
    [communications_log_number] NUMERIC (18) NOT NULL,
    [contact_number]            NUMERIC (18) NOT NULL,
    [address_number]            NUMERIC (18) NULL,
    [link_type]                 VARCHAR (1)  NOT NULL,
    [processed]                 VARCHAR (1)  NOT NULL,
    [notified]                  VARCHAR (1)  NOT NULL
);

