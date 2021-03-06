﻿CREATE TABLE [cis_delta].[contact_communication_usages] (
    [contact_number]       NUMERIC (18)  NOT NULL,
    [communication_number] NUMERIC (18)  NOT NULL,
    [communication_usage]  VARCHAR (4)   NOT NULL,
    [notes]                VARCHAR (MAX) NULL,
    [amended_by]           VARCHAR (14)  NOT NULL,
    [amended_on]           DATETIME      NOT NULL
);

