CREATE TABLE [cis].[mailing_history] (
    [mailing]               VARCHAR (15)  NOT NULL,
    [mailing_date]          DATETIME      NOT NULL,
    [mailing_by]            VARCHAR (14)  NOT NULL,
    [number_in_mailing]     NUMERIC (18)  NOT NULL,
    [mailing_number]        NUMERIC (18)  NULL,
    [mailing_filename]      VARCHAR (255) NULL,
    [notes]                 VARCHAR (200) NULL,
    [issue_id]              VARCHAR (15)  NULL,
    [number_emails_bounced] NUMERIC (18)  NULL,
    [number_emails_opened]  NUMERIC (18)  NULL,
    [number_emails_clicked] NUMERIC (18)  NULL
);

