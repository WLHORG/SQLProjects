CREATE TABLE [cis].[declaration_tax_claims] (
    [claim_number]          NUMERIC (18)   NOT NULL,
    [claim_generated_date]  DATETIME       NULL,
    [amount_claimed]        NUMERIC (9, 2) NOT NULL,
    [claim_tax_year_start]  DATETIME       NOT NULL,
    [calculated_tax_amount] NUMERIC (9, 2) NOT NULL
);

