CREATE TABLE [cis_delta].[event_personnel] (
    [session_number]         NUMERIC (18)   NOT NULL,
    [contact_number]         NUMERIC (18)   NOT NULL,
    [address_number]         NUMERIC (18)   NOT NULL,
    [function]               VARCHAR (1)    NULL,
    [confirmed]              DATETIME       NULL,
    [confirmed_by]           VARCHAR (14)   NULL,
    [expenses_received]      DATETIME       NULL,
    [expenses]               NUMERIC (9, 2) NULL,
    [authorised_on]          DATETIME       NULL,
    [authorised_by]          VARCHAR (14)   NULL,
    [task]                   VARCHAR (80)   NULL,
    [start_date]             DATETIME       NOT NULL,
    [end_date]               DATETIME       NOT NULL,
    [start_time]             VARCHAR (5)    NOT NULL,
    [end_time]               VARCHAR (5)    NOT NULL,
    [position]               VARCHAR (30)   NULL,
    [organisation_name]      VARCHAR (80)   NULL,
    [amended_on]             DATETIME       NOT NULL,
    [amended_by]             VARCHAR (14)   NOT NULL,
    [event_personnel_number] NUMERIC (18)   NULL,
    [issue_resources]        VARCHAR (1)    NOT NULL
);

