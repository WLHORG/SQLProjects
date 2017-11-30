CREATE TABLE [cis].[batch_types] (
    [batch_type]           VARCHAR (2)  NOT NULL,
    [batch_type_desc]      VARCHAR (30) NOT NULL,
    [default_bank_account] VARCHAR (4)  NULL,
    [amended_by]           VARCHAR (14) NOT NULL,
    [amended_on]           DATETIME     NOT NULL,
    [print_cheque_list]    VARCHAR (1)  NULL
);

