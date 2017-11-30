CREATE TABLE [cis_delta].[statuses] (
    [status]          VARCHAR (4)   NOT NULL,
    [status_desc]     VARCHAR (30)  NOT NULL,
    [amended_by]      VARCHAR (14)  NOT NULL,
    [amended_on]      DATETIME      NOT NULL,
    [reason_required] VARCHAR (1)   NOT NULL,
    [contact_group]   VARCHAR (4)   NULL,
    [ownership_group] VARCHAR (4)   NULL,
    [rgb_value]       NUMERIC (18)  NULL,
    [activity_group]  VARCHAR (4)   NULL,
    [status_message]  VARCHAR (128) NULL
);

