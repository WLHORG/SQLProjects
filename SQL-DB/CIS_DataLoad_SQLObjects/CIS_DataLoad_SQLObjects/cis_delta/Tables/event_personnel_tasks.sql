CREATE TABLE [cis_delta].[event_personnel_tasks] (
    [event_personnel_number]      NUMERIC (18)  NULL,
    [personnel_task]              VARCHAR (4)   NOT NULL,
    [amended_by]                  VARCHAR (14)  NOT NULL,
    [amended_on]                  DATETIME      NOT NULL,
    [event_personnel_task_number] NUMERIC (18)  NOT NULL,
    [start_date]                  DATETIME      NULL,
    [start_time]                  VARCHAR (5)   NULL,
    [end_date]                    DATETIME      NULL,
    [end_time]                    VARCHAR (5)   NULL,
    [notes]                       VARCHAR (MAX) NULL,
    [event_number]                NUMERIC (18)  NULL,
    [external_task_id]            VARCHAR (256) NULL
);

