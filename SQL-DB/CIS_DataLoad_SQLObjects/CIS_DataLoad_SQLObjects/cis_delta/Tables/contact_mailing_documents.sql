CREATE TABLE [cis_delta].[contact_mailing_documents] (
    [mailing_document_number]  NUMERIC (18)    NOT NULL,
    [mailing_template]         VARCHAR (4)     NOT NULL,
    [selected_paragraphs]      VARCHAR (80)    NULL,
    [contact_number]           NUMERIC (18)    NOT NULL,
    [address_number]           NUMERIC (18)    NOT NULL,
    [batch_number]             NUMERIC (18)    NULL,
    [transaction_number]       NUMERIC (18)    NULL,
    [order_number]             NUMERIC (18)    NULL,
    [gaye_pledge_number]       NUMERIC (18)    NULL,
    [declaration_number]       NUMERIC (18)    NULL,
    [document_text]            VARBINARY (MAX) NULL,
    [created_by]               VARCHAR (14)    NOT NULL,
    [created_on]               DATETIME        NOT NULL,
    [fulfillment_number]       NUMERIC (18)    NULL,
    [mailing]                  VARCHAR (15)    NOT NULL,
    [new_contact]              VARCHAR (1)     NOT NULL,
    [earliest_fulfilment_date] DATETIME        NULL
);

