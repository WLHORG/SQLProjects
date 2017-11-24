CREATE TABLE [cis_delta].[maintenance_attributes] (
    [attribute_name]        VARCHAR (32)   NOT NULL,
    [attribute_name_desc]   VARCHAR (50)   NULL,
    [table_name]            VARCHAR (32)   NOT NULL,
    [type]                  VARCHAR (4)    NULL,
    [entry_length]          NUMERIC (18)   NULL,
    [case]                  VARCHAR (1)    NULL,
    [nulls_invalid]         VARCHAR (1)    NOT NULL,
    [minimum_value]         VARCHAR (30)   NULL,
    [maximum_value]         VARCHAR (30)   NULL,
    [domain_values]         VARCHAR (80)   NULL,
    [pattern]               VARCHAR (30)   NULL,
    [validation_table]      VARCHAR (32)   NULL,
    [validation_attribute]  VARCHAR (32)   NULL,
    [restriction_attribute] VARCHAR (32)   NULL,
    [maintenance]           VARCHAR (1)    NOT NULL,
    [primary_key]           VARCHAR (1)    NULL,
    [sequence_number]       NUMERIC (18)   NULL,
    [attribute_notes]       VARCHAR (1000) NULL
);

