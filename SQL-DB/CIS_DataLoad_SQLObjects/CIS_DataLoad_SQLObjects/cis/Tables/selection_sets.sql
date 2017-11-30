CREATE TABLE [cis].[selection_sets] (
    [selection_set]      NUMERIC (18)  NOT NULL,
    [user_name]          VARCHAR (14)  NOT NULL,
    [department]         VARCHAR (4)   NULL,
    [selection_set_desc] VARCHAR (40)  NOT NULL,
    [number_in_set]      NUMERIC (18)  NOT NULL,
    [selection_group]    VARCHAR (4)   NOT NULL,
    [custom_data]        VARCHAR (1)   NULL,
    [attribute_captions] VARCHAR (255) NULL,
    [show_owner]         VARCHAR (1)   NULL,
    [show_position]      VARCHAR (1)   NULL,
    [check_box_captions] VARCHAR (90)  NULL,
    [source]             VARCHAR (10)  NULL
);

