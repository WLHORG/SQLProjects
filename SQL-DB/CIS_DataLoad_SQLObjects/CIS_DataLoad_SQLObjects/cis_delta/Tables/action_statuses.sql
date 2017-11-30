CREATE TABLE [cis_delta].[action_statuses] (
    [action_status]      VARCHAR (4)  NOT NULL,
    [action_status_desc] VARCHAR (50) NOT NULL,
    [amended_by]         VARCHAR (14) NOT NULL,
    [amended_on]         DATETIME     NOT NULL
);

