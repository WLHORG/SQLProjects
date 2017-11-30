﻿CREATE TABLE [cis_delta].[actions] (
    [action_number]      NUMERIC (18)   NOT NULL,
    [master_action]      NUMERIC (18)   NOT NULL,
    [action_level]       NUMERIC (18)   NOT NULL,
    [sequence_number]    NUMERIC (18)   NOT NULL,
    [action_desc]        VARCHAR (50)   NOT NULL,
    [action_text]        VARCHAR (2000) NOT NULL,
    [action_priority]    VARCHAR (4)    NOT NULL,
    [action_status]      VARCHAR (4)    NOT NULL,
    [document_class]     VARCHAR (4)    NOT NULL,
    [created_by]         VARCHAR (14)   NOT NULL,
    [created_on]         DATETIME       NOT NULL,
    [duration_days]      NUMERIC (18)   NULL,
    [duration_hours]     NUMERIC (18)   NULL,
    [duration_minutes]   NUMERIC (18)   NULL,
    [deadline]           DATETIME       NULL,
    [scheduled_on]       DATETIME       NULL,
    [completed_on]       DATETIME       NULL,
    [repeat_count]       NUMERIC (18)   NULL,
    [delayed_activation] VARCHAR (1)    NULL,
    [actioner_setting]   VARCHAR (1)    NULL,
    [manager_setting]    VARCHAR (1)    NULL,
    [amended_by]         VARCHAR (14)   NOT NULL,
    [amended_on]         DATETIME       NOT NULL
);

