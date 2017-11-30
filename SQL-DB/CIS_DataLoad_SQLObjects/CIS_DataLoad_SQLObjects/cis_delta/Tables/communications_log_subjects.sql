CREATE TABLE [cis_delta].[communications_log_subjects] (
    [communications_log_number] NUMERIC (18)   NOT NULL,
    [topic]                     VARCHAR (6)    NOT NULL,
    [sub_topic]                 VARCHAR (4)    NOT NULL,
    [primary]                   VARCHAR (1)    NOT NULL,
    [quantity]                  NUMERIC (9, 2) NULL,
    [amended_on]                DATETIME       NOT NULL,
    [amended_by]                VARCHAR (14)   NOT NULL
);

