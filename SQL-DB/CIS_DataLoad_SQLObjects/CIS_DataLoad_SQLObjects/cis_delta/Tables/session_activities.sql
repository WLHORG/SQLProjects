CREATE TABLE [cis_delta].[session_activities] (
    [event_number]   NUMERIC (18) NOT NULL,
    [session_number] NUMERIC (18) NOT NULL,
    [activity]       VARCHAR (6)  NOT NULL,
    [activity_value] VARCHAR (4)  NOT NULL,
    [amended_by]     VARCHAR (14) NOT NULL,
    [amended_on]     DATETIME     NOT NULL
);

