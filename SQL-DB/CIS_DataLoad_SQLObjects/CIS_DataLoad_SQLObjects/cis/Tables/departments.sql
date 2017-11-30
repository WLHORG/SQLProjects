CREATE TABLE [cis].[departments] (
    [department]                 VARCHAR (4)  NOT NULL,
    [department_desc]            VARCHAR (30) NOT NULL,
    [override_address_ownership] VARCHAR (1)  NOT NULL,
    [amended_by]                 VARCHAR (14) NOT NULL,
    [amended_on]                 DATETIME     NOT NULL
);

