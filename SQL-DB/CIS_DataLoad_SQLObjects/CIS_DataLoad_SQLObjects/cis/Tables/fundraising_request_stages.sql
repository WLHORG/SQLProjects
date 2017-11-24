CREATE TABLE [cis].[fundraising_request_stages] (
    [fundraising_request_stage]      VARCHAR (4)  NOT NULL,
    [fundraising_request_stage_desc] VARCHAR (30) NOT NULL,
    [amended_by]                     VARCHAR (14) NOT NULL,
    [amended_on]                     DATETIME     NOT NULL
);

