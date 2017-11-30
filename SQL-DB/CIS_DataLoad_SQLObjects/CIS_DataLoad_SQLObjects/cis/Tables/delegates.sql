CREATE TABLE [cis].[delegates] (
    [event_number]           NUMERIC (18)   NOT NULL,
    [booking_number]         NUMERIC (18)   NOT NULL,
    [contact_number]         NUMERIC (18)   NOT NULL,
    [address_number]         NUMERIC (18)   NOT NULL,
    [attended]               VARCHAR (1)    NOT NULL,
    [position]               VARCHAR (80)   NULL,
    [organisation_name]      VARCHAR (80)   NULL,
    [amended_by]             VARCHAR (14)   NOT NULL,
    [amended_on]             DATETIME       NOT NULL,
    [event_delegate_number]  NUMERIC (18)   NULL,
    [candidate_number]       NUMERIC (18)   NULL,
    [pledged_amount]         NUMERIC (9, 2) NULL,
    [donation_total]         NUMERIC (9, 2) NULL,
    [sponsorship_total]      NUMERIC (9, 2) NULL,
    [booking_payment_amount] NUMERIC (9, 2) NULL,
    [other_payments_total]   NUMERIC (9, 2) NULL
);

