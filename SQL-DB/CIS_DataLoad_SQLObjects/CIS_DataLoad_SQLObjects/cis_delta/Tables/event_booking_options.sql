CREATE TABLE [cis_delta].[event_booking_options] (
    [event_number]       NUMERIC (18)  NOT NULL,
    [option_number]      NUMERIC (18)  NOT NULL,
    [option_desc]        VARCHAR (40)  NOT NULL,
    [pick_sessions]      VARCHAR (1)   NOT NULL,
    [number_of_sessions] NUMERIC (18)  NOT NULL,
    [deduct_from_event]  VARCHAR (1)   NOT NULL,
    [maximum_bookings]   NUMERIC (18)  NOT NULL,
    [product]            VARCHAR (20)  NOT NULL,
    [rate]               VARCHAR (4)   NOT NULL,
    [amended_by]         VARCHAR (14)  NOT NULL,
    [amended_on]         DATETIME      NOT NULL,
    [long_description]   VARCHAR (200) NULL
);

