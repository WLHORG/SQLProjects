CREATE TABLE [cis].[session_bookings] (
    [event_number]   NUMERIC (18) NOT NULL,
    [booking_number] NUMERIC (18) NOT NULL,
    [session_number] NUMERIC (18) NOT NULL,
    [quantity]       NUMERIC (18) NULL,
    [amended_by]     VARCHAR (14) NOT NULL,
    [amended_on]     DATETIME     NOT NULL
);

