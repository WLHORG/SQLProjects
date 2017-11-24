CREATE TABLE [cis_delta].[relationships] (
    [relationship]               VARCHAR (4)  NOT NULL,
    [relationship_desc]          VARCHAR (30) NOT NULL,
    [from_contact_group]         VARCHAR (4)  NULL,
    [to_contact_group]           VARCHAR (4)  NULL,
    [high_profile]               VARCHAR (1)  NULL,
    [parent_relationship]        VARCHAR (4)  NULL,
    [amended_by]                 VARCHAR (14) NOT NULL,
    [amended_on]                 DATETIME     NOT NULL,
    [complimentary_relationship] VARCHAR (4)  NULL
);

