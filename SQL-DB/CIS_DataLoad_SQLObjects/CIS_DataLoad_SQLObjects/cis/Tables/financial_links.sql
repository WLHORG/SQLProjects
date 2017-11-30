CREATE TABLE [cis].[financial_links] (
    [contact_number]       NUMERIC (18) NOT NULL,
    [donor_contact_number] NUMERIC (18) NOT NULL,
    [batch_number]         NUMERIC (18) NOT NULL,
    [transaction_number]   NUMERIC (18) NOT NULL,
    [line_number]          NUMERIC (18) NOT NULL,
    [line_type]            VARCHAR (1)  NOT NULL
);

