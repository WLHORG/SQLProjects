CREATE TABLE [cis].[dba_notes] (
    [master]    NUMERIC (18)  NOT NULL,
    [duplicate] NUMERIC (18)  NOT NULL,
    [notes]     VARCHAR (MAX) NULL,
    [merged_on] DATETIME      NOT NULL
);

