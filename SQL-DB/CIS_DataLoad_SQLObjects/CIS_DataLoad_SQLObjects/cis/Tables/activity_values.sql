CREATE TABLE [cis].[activity_values] (
    [activity]            VARCHAR (6)  NOT NULL,
    [activity_value]      VARCHAR (4)  NOT NULL,
    [activity_value_desc] VARCHAR (60) NOT NULL,
    [amended_by]          VARCHAR (14) NOT NULL,
    [amended_on]          DATETIME     NOT NULL,
    [rgb_value]           NUMERIC (18) NULL
);

