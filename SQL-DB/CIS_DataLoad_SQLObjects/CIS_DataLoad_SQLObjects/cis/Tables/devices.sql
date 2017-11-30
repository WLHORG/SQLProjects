CREATE TABLE [cis].[devices] (
    [device]          VARCHAR (2)  NOT NULL,
    [device_desc]     VARCHAR (30) NOT NULL,
    [email]           VARCHAR (1)  NULL,
    [amended_by]      VARCHAR (14) NOT NULL,
    [amended_on]      DATETIME     NOT NULL,
    [auto_email]      VARCHAR (1)  NULL,
    [www_address]     VARCHAR (1)  NOT NULL,
    [sequence_number] NUMERIC (18) NOT NULL
);

