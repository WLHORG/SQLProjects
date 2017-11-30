CREATE TABLE [cis].[gaye_pledge_payment_history] (
    [gaye_pledge_number] NUMERIC (18)   NOT NULL,
    [batch_number]       NUMERIC (18)   NOT NULL,
    [transaction_number] NUMERIC (18)   NOT NULL,
    [donor_amount]       NUMERIC (9, 2) NULL,
    [employer_amount]    NUMERIC (9, 2) NULL,
    [government_amount]  NUMERIC (9, 2) NULL,
    [admin_fee_amount]   NUMERIC (9, 2) NULL,
    [payment_number]     NUMERIC (18)   NOT NULL
);

