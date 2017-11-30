CREATE TABLE [cis].[mailings] (
    [mailing]          VARCHAR (15)  NOT NULL,
    [mailing_desc]     VARCHAR (100) NOT NULL,
    [department]       VARCHAR (4)   NOT NULL,
    [history_only]     VARCHAR (1)   NOT NULL,
    [amended_by]       VARCHAR (14)  NOT NULL,
    [amended_on]       DATETIME      NOT NULL,
    [marketing]        VARCHAR (1)   NOT NULL,
    [direction]        VARCHAR (1)   NOT NULL,
    [mailing_template] VARCHAR (4)   NULL,
    [notes]            VARCHAR (MAX) NULL,
    [mailing_due]      DATETIME      NULL
);

