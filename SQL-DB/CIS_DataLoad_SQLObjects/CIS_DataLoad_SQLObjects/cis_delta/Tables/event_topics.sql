CREATE TABLE [cis_delta].[event_topics] (
    [event_number] NUMERIC (18)   NOT NULL,
    [topic]        VARCHAR (6)    NOT NULL,
    [sub_topic]    VARCHAR (4)    NOT NULL,
    [quantity]     NUMERIC (9, 2) NULL,
    [amended_by]   VARCHAR (14)   NOT NULL,
    [amended_on]   DATETIME       NOT NULL,
    [notes]        VARCHAR (MAX)  NULL
);

