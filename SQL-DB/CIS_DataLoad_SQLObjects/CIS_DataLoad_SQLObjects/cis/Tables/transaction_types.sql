﻿CREATE TABLE [cis].[transaction_types] (
    [transaction_type]      VARCHAR (3)  NOT NULL,
    [transaction_type_desc] VARCHAR (30) NOT NULL,
    [transaction_sign]      VARCHAR (1)  NOT NULL,
    [negatives_allowed]     VARCHAR (1)  NOT NULL,
    [amended_by]            VARCHAR (14) NOT NULL,
    [amended_on]            DATETIME     NOT NULL
);

