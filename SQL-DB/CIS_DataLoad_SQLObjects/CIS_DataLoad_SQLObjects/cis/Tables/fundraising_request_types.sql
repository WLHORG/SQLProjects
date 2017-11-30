CREATE TABLE [cis].[fundraising_request_types] (
    [fundraising_request_type]      VARCHAR (4)  NOT NULL,
    [fundraising_request_type_desc] VARCHAR (30) NOT NULL,
    [amended_by]                    VARCHAR (14) NOT NULL,
    [amended_on]                    DATETIME     NOT NULL
);

