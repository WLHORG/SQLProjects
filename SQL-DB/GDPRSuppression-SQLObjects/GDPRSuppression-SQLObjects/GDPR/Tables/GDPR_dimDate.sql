﻿CREATE TABLE [GDPR].[GDPR_dimDate](
	[Date] [datetime] NOT NULL,
	[FullDateUK] [varchar](10) NULL,
	[DaySuffix] [varchar](4) NULL,
	[DayName] [varchar](9) NOT NULL,
	[DayOfWeekUK] [int] NULL,
	[DayOfWeekInMonth] [int] NULL,
	[DayOfWeekInYear] [int] NULL,
	[DayOfQuarter] [int] NULL,
	[DayOfYear] [int] NULL,
	[WeekOfMonth] [int] NULL,
	[WeekOfQuarter] [int] NULL,
	[WeekOfYear] [int] NULL,
	[Month] [int] NULL,
	[MonthName] [varchar](9) NULL,
	[MonthOfQuarter] [int] NULL,
	[Quarter] [int] NULL,
	[QuarterName] [varchar](9) NULL,
	[Year] [int] NULL,
	[YearName] [varchar](7) NULL,
	[MonthYear] [varchar](50) NULL,
	[MMYYYY] [varchar](6) NULL,
	[FirstDayOfMonth] [date] NULL,
	[LastDayOfMonth] [date] NULL,
	[FirstDayOfQuarter] [date] NULL,
	[LastDayOfQuarter] [date] NULL,
	[FirstDayOfYear] [date] NULL,
	[LastDayOfYear] [date] NULL,
	[IsWeekday] [bit] NULL,
	[IsHolidayUK] [bit] NULL,
	[HolidayUK] [varchar](50) NULL,
 CONSTRAINT [PK_GDPR_dimDate] PRIMARY KEY CLUSTERED 
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]