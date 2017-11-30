CREATE TABLE [cis_delta].[declaration_tax_claim_lines] (
    [claim_number]                   INT            NOT NULL,
    [cd_number]                      INT            NOT NULL,
    [declaration_or_covenant_number] VARCHAR (1)    NOT NULL,
    [batch_number]                   INT            NOT NULL,
    [transaction_number]             INT            NOT NULL,
    [line_number]                    INT            NOT NULL,
    [net_amount]                     NUMERIC (9, 2) NOT NULL,
    [amount_claimed]                 NUMERIC (9, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([batch_number] ASC, [transaction_number] ASC, [line_number] ASC, [declaration_or_covenant_number] ASC)
);

