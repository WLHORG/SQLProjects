﻿CREATE TABLE [cis].[members] (
    [contact_number]               INT          NOT NULL,
    [membership_type]              VARCHAR (4)  NOT NULL,
    [order_number]                 INT          NOT NULL,
    [number_of_members]            INT          NOT NULL,
    [age_override]                 INT          NULL,
    [branch]                       VARCHAR (4)  NOT NULL,
    [joined]                       DATETIME     NOT NULL,
    [branch_member]                CHAR (1)     NOT NULL,
    [applied]                      DATETIME     NULL,
    [accepted]                     DATETIME     NULL,
    [voting_rights]                CHAR (1)     NOT NULL,
    [membership_card_expires]      DATETIME     NULL,
    [cancellation_reason]          VARCHAR (4)  NULL,
    [cancelled_by]                 VARCHAR (14) NULL,
    [cancelled_on]                 DATE         NULL,
    [amended_by]                   VARCHAR (14) NOT NULL,
    [amended_on]                   DATETIME     NOT NULL,
    [address_number]               INT          NOT NULL,
    [source]                       VARCHAR (10) NULL,
    [membership_number]            INT          NOT NULL,
    [member_number]                VARCHAR (9)  NOT NULL,
    [reprint_mship_card]           CHAR (1)     NULL,
    [cancellation_source]          VARCHAR (10) NULL,
    [membership_card_issue_number] INT          NULL,
    [membership_status]            VARCHAR (4)  NULL,
    CONSTRAINT [PK__members__629A974B8324D429] PRIMARY KEY CLUSTERED ([membership_number] ASC)
);

