CREATE TABLE [cis_delta].[principal_users] (
    [contact_number]        NUMERIC (18)  NOT NULL,
    [principal_user]        VARCHAR (14)  NOT NULL,
    [principal_user_reason] VARCHAR (250) NULL,
    [amended_by]            VARCHAR (14)  NOT NULL,
    [amended_on]            DATETIME      NOT NULL
);

