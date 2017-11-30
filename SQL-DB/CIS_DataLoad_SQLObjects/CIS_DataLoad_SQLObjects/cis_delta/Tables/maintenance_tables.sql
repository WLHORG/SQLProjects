CREATE TABLE [cis_delta].[maintenance_tables] (
    [table_name]          VARCHAR (32)   NOT NULL,
    [table_name_desc]     VARCHAR (50)   NULL,
    [selection_attribute] VARCHAR (32)   NULL,
    [application_name]    VARCHAR (4)    NOT NULL,
    [table_amended_by]    VARCHAR (14)   NULL,
    [table_amended_on]    DATETIME       NULL,
    [maintenance_group]   VARCHAR (4)    NULL,
    [table_desc]          VARCHAR (200)  NULL,
    [table_notes]         VARCHAR (2000) NULL,
    [default_notes]       VARCHAR (2000) NULL,
    [maintenance_area]    VARCHAR (4)    NULL,
    [sequence_number]     NUMERIC (18)   NULL
);

