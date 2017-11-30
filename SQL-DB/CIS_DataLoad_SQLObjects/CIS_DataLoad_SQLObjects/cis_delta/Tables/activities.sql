CREATE TABLE [cis_delta].[activities] (
    [activity]       VARCHAR (6)  NOT NULL,
    [activity_desc]  VARCHAR (40) NOT NULL,
    [high_profile]   VARCHAR (1)  NOT NULL,
    [profile_rating] NUMERIC (18) NOT NULL,
    [contact_group]  VARCHAR (4)  NULL,
    [amended_by]     VARCHAR (14) NOT NULL,
    [amended_on]     DATETIME     NOT NULL
);

