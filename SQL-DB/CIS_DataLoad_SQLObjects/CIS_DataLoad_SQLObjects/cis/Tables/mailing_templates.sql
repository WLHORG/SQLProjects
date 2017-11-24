CREATE TABLE [cis].[mailing_templates] (
    [mailing_template]       VARCHAR (4)  NOT NULL,
    [mailing_template_desc]  VARCHAR (30) NOT NULL,
    [standard_document]      VARCHAR (10) NOT NULL,
    [edit_access_level]      VARCHAR (1)  NOT NULL,
    [paragraph_access_level] VARCHAR (1)  NOT NULL,
    [explicit_selection]     VARCHAR (1)  NOT NULL,
    [warning_suppressions]   VARCHAR (50) NULL,
    [exclusion_suppressions] VARCHAR (50) NULL,
    [amended_by]             VARCHAR (14) NOT NULL,
    [amended_on]             DATETIME     NOT NULL,
    [printer_number]         NUMERIC (18) NOT NULL
);

