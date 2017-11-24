CREATE TABLE [cis].[fundraising_request_targets] (
    [fundraising_request_number] NUMERIC (18)   NOT NULL,
    [previous_target_amount]     NUMERIC (9, 2) NOT NULL,
    [target_amount]              NUMERIC (9, 2) NOT NULL,
    [change_reason]              VARCHAR (30)   NOT NULL,
    [changed_by]                 VARCHAR (14)   NOT NULL,
    [changed_on]                 DATETIME       NOT NULL
);

