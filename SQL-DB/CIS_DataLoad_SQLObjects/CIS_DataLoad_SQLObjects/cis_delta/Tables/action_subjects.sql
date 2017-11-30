CREATE TABLE [cis_delta].[action_subjects] (
    [action_number] NUMERIC (18) NOT NULL,
    [topic]         VARCHAR (6)  NOT NULL,
    [sub_topic]     VARCHAR (4)  NOT NULL,
    [amended_by]    VARCHAR (14) NOT NULL,
    [amended_on]    DATETIME     NOT NULL
);

