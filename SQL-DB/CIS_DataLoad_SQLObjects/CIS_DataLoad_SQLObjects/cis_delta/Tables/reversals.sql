CREATE TABLE [cis_delta].[reversals] (
    [batch_number]           NUMERIC (18) NULL,
    [transaction_number]     NUMERIC (18) NULL,
    [line_number]            NUMERIC (18) NULL,
    [was_batch_number]       NUMERIC (18) NULL,
    [was_transaction_number] NUMERIC (18) NULL,
    [was_line_number]        NUMERIC (18) NULL,
    [was_oph_status]         VARCHAR (1)  NULL
);

