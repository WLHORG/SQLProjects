CREATE TABLE [cis].[countries] (
    [country]      VARCHAR (4)  NOT NULL,
    [country_desc] VARCHAR (30) NOT NULL,
    [uk]           VARCHAR (1)  NOT NULL,
    [region]       VARCHAR (6)  NOT NULL,
    [amended_by]   VARCHAR (14) NOT NULL,
    [amended_on]   DATETIME     NOT NULL
);

