CREATE TABLE [cis].[mailing_template_paragraphs] (
    [mailing_template]    VARCHAR (4)  NOT NULL,
    [paragraph_number]    NUMERIC (18) NOT NULL,
    [sequence_number]     NUMERIC (18) NOT NULL,
    [paragraph_desc]      VARCHAR (30) NOT NULL,
    [bookmark_name]       VARCHAR (30) NOT NULL,
    [mandatory]           VARCHAR (1)  NOT NULL,
    [paragraph_condition] VARCHAR (4)  NOT NULL,
    [control_value]       VARCHAR (20) NULL,
    [amended_by]          VARCHAR (14) NOT NULL,
    [amended_on]          DATETIME     NOT NULL,
    [control_value2]      VARCHAR (20) NULL
);

