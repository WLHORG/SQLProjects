CREATE TABLE [cis].[contact_actions] (
    [action_number]  NUMERIC (18) NOT NULL,
    [contact_number] NUMERIC (18) NOT NULL,
    [type]           VARCHAR (1)  NOT NULL,
    [notified]       VARCHAR (1)  NULL,
    [amended_by]     VARCHAR (14) NOT NULL,
    [amended_on]     DATETIME     NOT NULL
);

