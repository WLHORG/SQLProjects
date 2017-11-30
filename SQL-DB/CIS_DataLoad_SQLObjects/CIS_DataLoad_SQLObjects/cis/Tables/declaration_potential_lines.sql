CREATE TABLE [cis].[declaration_potential_lines] (
    [cd_number]                      NUMERIC (18)   NOT NULL,
    [declaration_or_covenant_number] VARCHAR (1)    NOT NULL,
    [contact_number]                 NUMERIC (18)   NOT NULL,
    [batch_number]                   NUMERIC (18)   NOT NULL,
    [transaction_number]             NUMERIC (18)   NOT NULL,
    [line_number]                    NUMERIC (18)   NOT NULL,
    [net_amount]                     NUMERIC (9, 2) NOT NULL,
    [amount_claimed]                 NUMERIC (9, 2) NOT NULL
);

