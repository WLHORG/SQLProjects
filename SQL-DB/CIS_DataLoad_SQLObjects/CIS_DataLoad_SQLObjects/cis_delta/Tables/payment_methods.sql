CREATE TABLE [cis_delta].[payment_methods] (
    [payment_method]      VARCHAR (4)  NOT NULL,
    [payment_method_desc] VARCHAR (30) NOT NULL,
    [payment_frequency]   VARCHAR (1)  NULL,
    [amended_by]          VARCHAR (14) NOT NULL,
    [amended_on]          DATETIME     NOT NULL
);

