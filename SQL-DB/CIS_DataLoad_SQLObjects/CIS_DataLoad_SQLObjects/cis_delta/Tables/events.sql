﻿CREATE TABLE [cis_delta].[events] (
    [event_number]                NUMERIC (18)   NOT NULL,
    [event_desc]                  VARCHAR (60)   NOT NULL,
    [venue]                       VARCHAR (4)    NOT NULL,
    [venue_reference]             VARCHAR (16)   NULL,
    [venue_confirmed]             DATETIME       NULL,
    [venue_confirmed_by]          VARCHAR (14)   NULL,
    [branch]                      VARCHAR (4)    NULL,
    [start_date]                  DATETIME       NOT NULL,
    [external]                    VARCHAR (1)    NOT NULL,
    [attendees_checked]           DATETIME       NULL,
    [evaluations_processed]       DATETIME       NULL,
    [cancellation_reason]         VARCHAR (4)    NULL,
    [cancelled_on]                DATETIME       NULL,
    [cancelled_by]                VARCHAR (14)   NULL,
    [booking]                     VARCHAR (1)    NOT NULL,
    [bookings_close]              DATETIME       NULL,
    [multi_session]               VARCHAR (1)    NOT NULL,
    [free_of_charge]              VARCHAR (1)    NOT NULL,
    [next_session_number]         NUMERIC (18)   NOT NULL,
    [next_booking_number]         NUMERIC (18)   NOT NULL,
    [next_option_number]          NUMERIC (18)   NOT NULL,
    [source]                      VARCHAR (12)   NULL,
    [amended_on]                  DATETIME       NOT NULL,
    [amended_by]                  VARCHAR (14)   NOT NULL,
    [qp_form_type]                NUMERIC (18)   NULL,
    [qp_link_number]              NUMERIC (18)   NULL,
    [template]                    VARCHAR (1)    NULL,
    [move_session_dates]          VARCHAR (1)    NULL,
    [master_action]               NUMERIC (18)   NULL,
    [event_reference]             VARCHAR (30)   NULL,
    [candidate_numbering_method]  VARCHAR (1)    NOT NULL,
    [first_candidate_number]      NUMERIC (18)   NOT NULL,
    [candidate_number_block_size] NUMERIC (18)   NOT NULL,
    [eligibility_check_required]  VARCHAR (1)    NOT NULL,
    [eligibility_check_text]      VARCHAR (80)   NULL,
    [deferred_booking_act]        VARCHAR (6)    NULL,
    [deferred_booking_act_value]  VARCHAR (4)    NULL,
    [rejected_booking_act]        VARCHAR (6)    NULL,
    [rejected_booking_act_value]  VARCHAR (4)    NULL,
    [department]                  VARCHAR (4)    NULL,
    [event_status]                VARCHAR (4)    NULL,
    [charge_for_waiting]          VARCHAR (1)    NOT NULL,
    [waiting_list_control_method] VARCHAR (1)    NOT NULL,
    [event_group]                 VARCHAR (4)    NOT NULL,
    [long_description]            VARCHAR (200)  NULL,
    [event_class]                 VARCHAR (20)   NULL,
    [activity_group]              VARCHAR (4)    NULL,
    [relationship_group]          VARCHAR (4)    NULL,
    [target_income]               NUMERIC (9, 2) NULL,
    [sponsored_costs]             NUMERIC (9, 2) NULL,
    [sponsorship_income]          NUMERIC (9, 2) NULL,
    [donation_income]             NUMERIC (9, 2) NULL,
    [booking_income]              NUMERIC (9, 2) NULL,
    [other_income]                NUMERIC (9, 2) NULL,
    [total_income]                NUMERIC (9, 2) NULL,
    [total_costs]                 NUMERIC (9, 2) NULL,
    [total_expenditure]           NUMERIC (9, 2) NULL,
    [return_on_investment]        NUMERIC (9, 2) NULL,
    [delegate_contribution]       NUMERIC (9, 2) NULL,
    [gift_aid_declaration_count]  NUMERIC (18)   NULL,
    [gift_aid_declaration_value]  NUMERIC (9, 2) NULL,
    [financial_last_calculated]   DATETIME       NULL,
    [balance_booking_fee]         NUMERIC (9, 2) NULL,
    [balance_booking_due]         DATETIME       NULL,
    [minimum_sponsorship_amount]  NUMERIC (9, 2) NULL,
    [sponsorship_due]             DATETIME       NULL,
    [pledged_amount_due]          DATETIME       NULL,
    [sponsorship_last_calculated] DATETIME       NULL,
    [sponsorship_product]         VARCHAR (20)   NULL,
    [sponsorship_rate]            VARCHAR (4)    NULL,
    [number_of_bookings]          NUMERIC (18)   NULL,
    [name_attendees]              VARCHAR (1)    NULL,
    [event_pricing_matrix]        VARCHAR (4)    NULL,
    [web_publish]                 VARCHAR (1)    NULL,
    [admin_email_address]         VARCHAR (128)  NULL
);

