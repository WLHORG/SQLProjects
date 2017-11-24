CREATE TABLE [cis].[contact_categories] (
    [contact_number] NUMERIC (18)   NOT NULL,
    [activity]       VARCHAR (6)    NOT NULL,
    [activity_value] VARCHAR (4)    NOT NULL,
    [quantity]       NUMERIC (9, 2) NULL,
    [source]         VARCHAR (10)   NOT NULL,
    [valid_from]     DATETIME       NOT NULL,
    [valid_to]       DATETIME       NOT NULL,
    [amended_by]     VARCHAR (14)   NOT NULL,
    [amended_on]     DATETIME       NOT NULL,
    [notes]          VARCHAR (MAX)  NULL,
    [activity_date]  DATETIME       NULL
);

