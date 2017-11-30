CREATE TABLE [cis].[sub_topics] (
    [topic]              VARCHAR (6)  NOT NULL,
    [sub_topic]          VARCHAR (4)  NOT NULL,
    [sub_topic_desc]     VARCHAR (30) NOT NULL,
    [activity]           VARCHAR (6)  NULL,
    [activity_value]     VARCHAR (4)  NULL,
    [action_number]      NUMERIC (18) NULL,
    [history_only]       VARCHAR (1)  NOT NULL,
    [amended_by]         VARCHAR (14) NOT NULL,
    [amended_on]         DATETIME     NOT NULL,
    [activity_duration]  NUMERIC (18) NULL,
    [set_call_completed] VARCHAR (1)  NULL,
    [call_back_minutes]  NUMERIC (18) NULL
);

