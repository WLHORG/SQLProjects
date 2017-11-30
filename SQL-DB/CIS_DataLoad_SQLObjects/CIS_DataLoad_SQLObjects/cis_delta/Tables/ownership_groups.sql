CREATE TABLE [cis_delta].[ownership_groups] (
    [ownership_group]              VARCHAR (4)   NOT NULL,
    [ownership_group_desc]         VARCHAR (30)  NOT NULL,
    [principal_department]         VARCHAR (4)   NOT NULL,
    [read_access_text]             VARCHAR (250) NULL,
    [view_access_text]             VARCHAR (250) NULL,
    [notes]                        VARCHAR (250) NULL,
    [amended_by]                   VARCHAR (14)  NOT NULL,
    [amended_on]                   DATETIME      NOT NULL,
    [principal_department_logname] VARCHAR (14)  NULL
);

