CREATE TABLE [cis_delta].[communications] (
    [address_number]       NUMERIC (18)  NULL,
    [contact_number]       NUMERIC (18)  NULL,
    [device]               VARCHAR (2)   NOT NULL,
    [ex_directory]         VARCHAR (1)   NOT NULL,
    [dialling_code]        VARCHAR (5)   NULL,
    [std_code]             VARCHAR (8)   NULL,
    [number]               VARCHAR (128) NOT NULL,
    [extension]            VARCHAR (10)  NULL,
    [notes]                VARCHAR (MAX) NULL,
    [cli_number]           VARCHAR (28)  NULL,
    [amended_by]           VARCHAR (14)  NOT NULL,
    [amended_on]           DATETIME      NOT NULL,
    [communication_number] NUMERIC (18)  NOT NULL,
    [valid_from]           DATETIME      NULL,
    [valid_to]             DATETIME      NULL,
    [is_active]            VARCHAR (1)   NOT NULL,
    [mail]                 VARCHAR (1)   NOT NULL,
    [device_default]       VARCHAR (1)   NOT NULL,
    [preferred_method]     VARCHAR (1)   NOT NULL,
    [archive]              VARCHAR (1)   NULL
);

