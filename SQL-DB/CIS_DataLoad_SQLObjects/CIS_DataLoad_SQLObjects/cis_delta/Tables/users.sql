CREATE TABLE [cis_delta].[users] (
    [logname]              VARCHAR (14)  NOT NULL,
    [department]           VARCHAR (4)   NOT NULL,
    [printer]              VARCHAR (14)  NULL,
    [label_style]          VARCHAR (14)  NULL,
    [amended_on]           DATETIME      NOT NULL,
    [amended_by]           VARCHAR (14)  NOT NULL,
    [menu_item]            VARCHAR (4)   NULL,
    [access_level]         VARCHAR (1)   NOT NULL,
    [full_name]            VARCHAR (50)  NULL,
    [position]             VARCHAR (50)  NULL,
    [personal_db]          VARCHAR (255) NULL,
    [contact_number]       NUMERIC (18)  NULL,
    [organisation_number]  NUMERIC (18)  NULL,
    [email_login]          VARCHAR (64)  NULL,
    [remote_user]          VARCHAR (1)   NULL,
    [access_control_group] VARCHAR (4)   NULL,
    [ownership_group]      VARCHAR (4)   NULL,
    [history_only]         VARCHAR (1)   NOT NULL,
    [network_logname]      VARCHAR (64)  NULL,
    [email_password]       VARCHAR (30)  NULL
);

