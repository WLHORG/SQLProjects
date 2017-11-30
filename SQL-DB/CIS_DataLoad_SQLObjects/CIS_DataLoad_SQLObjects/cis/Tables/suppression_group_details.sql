CREATE TABLE [cis].[suppression_group_details] (
    [suppression_group]   VARCHAR (4)  NOT NULL,
    [mailing_suppression] VARCHAR (4)  NOT NULL,
    [sequence_number]     NUMERIC (18) NOT NULL,
    [amended_by]          VARCHAR (14) NOT NULL,
    [amended_on]          DATETIME     NOT NULL
);

