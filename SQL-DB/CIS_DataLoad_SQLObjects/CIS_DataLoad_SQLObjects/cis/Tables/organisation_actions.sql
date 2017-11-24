CREATE TABLE [cis].[organisation_actions] (
    [action_number]       NUMERIC (18) NOT NULL,
    [organisation_number] NUMERIC (18) NOT NULL,
    [type]                VARCHAR (1)  NOT NULL,
    [amended_by]          VARCHAR (14) NOT NULL,
    [amended_on]          DATETIME     NOT NULL
);

