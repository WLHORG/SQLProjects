﻿CREATE TABLE [cis_delta].[membership_types] (
    [membership_type]               VARCHAR (4)   NOT NULL,
    [membership_level]              VARCHAR (1)   NOT NULL,
    [membership_type_desc]          VARCHAR (30)  NOT NULL,
    [set_number_of_members]         VARCHAR (1)   NOT NULL,
    [members_per_order]             NUMERIC (18)  NOT NULL,
    [max_junior_age]                NUMERIC (18)  NULL,
    [voting_rights]                 VARCHAR (1)   NOT NULL,
    [voting_rights_delay]           NUMERIC (18)  NOT NULL,
    [payer_required]                VARCHAR (1)   NOT NULL,
    [activity]                      VARCHAR (6)   NOT NULL,
    [activity_value]                VARCHAR (4)   NOT NULL,
    [mailing_suppression]           VARCHAR (4)   NULL,
    [annual]                        VARCHAR (1)   NOT NULL,
    [suspension_grace]              NUMERIC (18)  NOT NULL,
    [membership_card]               VARCHAR (1)   NOT NULL,
    [membership_card_duration]      NUMERIC (18)  NOT NULL,
    [expiry_text]                   VARCHAR (30)  NULL,
    [subsequent_membership_type]    VARCHAR (4)   NULL,
    [subsequent_trigger]            VARCHAR (1)   NULL,
    [subsequent_trigger_activity]   VARCHAR (6)   NULL,
    [subsequent_trigger_act_value]  VARCHAR (4)   NULL,
    [first_periods_product]         VARCHAR (20)  NOT NULL,
    [first_periods_rate]            VARCHAR (4)   NOT NULL,
    [subsequent_periods_product]    VARCHAR (20)  NOT NULL,
    [subsequent_periods_rate]       VARCHAR (4)   NOT NULL,
    [branch_membership]             VARCHAR (1)   NOT NULL,
    [branch_rate]                   VARCHAR (4)   NULL,
    [amended_by]                    VARCHAR (14)  NOT NULL,
    [amended_on]                    DATETIME      NOT NULL,
    [single_membership]             VARCHAR (1)   NOT NULL,
    [associate_membership_type]     VARCHAR (4)   NULL,
    [cancelled_associate_product]   VARCHAR (20)  NULL,
    [cancelled_associate_rate]      VARCHAR (4)   NULL,
    [max_free_associates]           NUMERIC (18)  NULL,
    [company]                       VARCHAR (4)   NOT NULL,
    [charge_individual_members]     VARCHAR (1)   NOT NULL,
    [recipient_1]                   VARCHAR (1)   NOT NULL,
    [recipient_2]                   VARCHAR (1)   NOT NULL,
    [recipient_3]                   VARCHAR (1)   NOT NULL,
    [relationship]                  VARCHAR (4)   NULL,
    [card_order]                    NUMERIC (18)  NOT NULL,
    [use_position_branch]           VARCHAR (1)   NULL,
    [membership_term]               NUMERIC (18)  NULL,
    [approval_membership]           VARCHAR (1)   NULL,
    [adult_gift_member_eligible_ga] VARCHAR (1)   NOT NULL,
    [fixed_cycle]                   VARCHAR (5)   NULL,
    [allow_as_first_type]           VARCHAR (1)   NOT NULL,
    [rgb_value]                     NUMERIC (18)  NULL,
    [web_publish]                   VARCHAR (1)   NULL,
    [long_description]              VARCHAR (200) NULL
);

