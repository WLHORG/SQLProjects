CREATE TABLE [cis_delta].[delegate_activities] (
    [delegate_activity_number] NUMERIC (18)   NOT NULL,
    [event_delegate_number]    NUMERIC (18)   NOT NULL,
    [activity]                 VARCHAR (6)    NOT NULL,
    [activity_value]           VARCHAR (4)    NOT NULL,
    [quantity]                 NUMERIC (9, 2) NULL,
    [source]                   VARCHAR (10)   NOT NULL,
    [valid_from]               DATETIME       NOT NULL,
    [valid_to]                 DATETIME       NOT NULL,
    [activity_date]            DATETIME       NULL,
    [notes]                    VARCHAR (MAX)  NULL,
    [amended_by]               VARCHAR (14)   NULL,
    [amended_on]               DATETIME       NULL
);

