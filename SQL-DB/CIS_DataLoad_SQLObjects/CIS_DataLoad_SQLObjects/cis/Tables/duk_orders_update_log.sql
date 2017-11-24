CREATE TABLE [cis].[duk_orders_update_log] (
    [contact_number] NUMERIC (38)  NOT NULL,
    [order_number]   NUMERIC (38)  NOT NULL,
    [source]         VARCHAR (10)  NULL,
    [created_by]     VARCHAR (14)  NOT NULL,
    [created_on]     DATETIME2 (7) NOT NULL,
    [new_source]     VARCHAR (10)  NULL
);

