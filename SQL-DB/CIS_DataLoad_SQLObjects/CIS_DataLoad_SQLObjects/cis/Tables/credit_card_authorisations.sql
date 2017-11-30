CREATE TABLE [cis].[credit_card_authorisations] (
    [authorisation_number]           NUMERIC (18)   NOT NULL,
    [batch_number]                   NUMERIC (18)   NULL,
    [transaction_number]             NUMERIC (18)   NULL,
    [authorisation_type]             VARCHAR (1)    NOT NULL,
    [authorised_on]                  DATETIME       NOT NULL,
    [authorisation_code]             VARCHAR (10)   NULL,
    [authorisation_response_code]    VARCHAR (2)    NULL,
    [authorisation_response_message] VARCHAR (255)  NULL,
    [authorised_amount]              NUMERIC (9, 2) NOT NULL,
    [address_verification_result]    VARCHAR (11)   NULL,
    [address_verification_message]   VARCHAR (80)   NULL,
    [csc_result_code]                VARCHAR (11)   NULL,
    [csc_result_message]             VARCHAR (80)   NULL,
    [authorised_transaction_number]  NUMERIC (18)   NULL,
    [authorised_text_id]             VARCHAR (50)   NULL
);

