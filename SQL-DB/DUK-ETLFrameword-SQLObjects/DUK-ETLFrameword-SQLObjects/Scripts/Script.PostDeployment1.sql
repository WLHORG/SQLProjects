/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/


/****** Object:  StoredProcedure [custom].[execute_catalog_parent_package]    Script Date: 24/11/2017 15:41:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

USE [SSISDB]
GO

SET IDENTITY_INSERT [custom].[ApplicationPackages] ON
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (1, 1, 1, NULL, 0, 1, 1)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (14, 1, 2, NULL, 0, 1, 2)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (15, 1, 4, NULL, 0, 1, 3)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (16, 1, 5, NULL, 0, 1, 4)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (17, 1, 6, NULL, 0, 1, 5)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (18, 1, 7, NULL, 0, 1, 6)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (19, 1, 8, NULL, 0, 1, 7)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (20, 1, 9, NULL, 0, 1, 8)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (21, 1, 10, NULL, 0, 1, 1)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (22, 1, 11, NULL, 0, 1, 2)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (23, 1, 12, NULL, 0, 1, 6)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (24, 1, 13, NULL, 0, 1, 4)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (25, 1, 14, NULL, 0, 1, 5)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (26, 1, 15, NULL, 0, 1, 6)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (27, 1, 16, NULL, 0, 1, 7)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (28, 1, 17, NULL, 0, 1, 8)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (29, 1, 18, NULL, 0, 1, 1)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (30, 1, 20, NULL, 0, 1, 2)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (31, 1, 21, NULL, 0, 1, 3)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (32, 1, 22, NULL, 0, 1, 4)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (33, 1, 23, NULL, 0, 1, 5)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (34, 1, 24, NULL, 0, 1, 6)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (35, 1, 25, NULL, 0, 1, 7)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (37, 1, 26, NULL, 0, 1, 8)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (38, 1, 27, NULL, 0, 1, 1)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (39, 1, 30, NULL, 0, 1, 2)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (40, 1, 31, NULL, 0, 1, 3)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (41, 1, 32, NULL, 0, 1, 4)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (42, 1, 33, NULL, 0, 1, 5)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (43, 1, 34, NULL, 0, 1, 6)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (44, 1, 35, NULL, 0, 1, 7)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (45, 1, 36, NULL, 0, 1, 8)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (46, 1, 37, NULL, 0, 1, 1)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (47, 1, 38, NULL, 0, 1, 2)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (48, 1, 39, NULL, 0, 1, 3)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (49, 1, 40, NULL, 0, 1, 4)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (51, 1, 41, NULL, 0, 1, 5)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (52, 1, 42, NULL, 0, 1, 6)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (53, 1, 43, NULL, 0, 1, 7)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (54, 1, 44, NULL, 0, 1, 8)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (56, 1, 45, NULL, 0, 1, 1)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (57, 1, 46, NULL, 0, 1, 2)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (58, 1, 47, NULL, 0, 1, 3)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (59, 1, 48, NULL, 0, 1, 4)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (60, 1, 49, NULL, 0, 1, 5)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (61, 1, 50, NULL, 0, 1, 6)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (62, 1, 51, NULL, 0, 1, 7)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (63, 1, 52, NULL, 0, 1, 8)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (64, 1, 53, NULL, 0, 1, 1)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (65, 1, 54, NULL, 0, 1, 2)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (66, 1, 55, NULL, 0, 1, 3)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (67, 1, 56, NULL, 0, 1, 4)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (68, 1, 57, NULL, 0, 1, 5)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (69, 1, 58, NULL, 0, 1, 6)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (70, 1, 59, NULL, 0, 1, 7)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (71, 1, 60, NULL, 0, 1, 8)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (72, 1, 61, NULL, 0, 1, 1)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (74, 1, 63, NULL, 0, 1, 2)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (75, 1, 64, NULL, 0, 1, 3)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (76, 1, 65, NULL, 0, 1, 1)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (77, 1, 66, NULL, 0, 1, 5)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (78, 1, 73, NULL, 0, 1, 6)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (79, 1, 74, NULL, 0, 1, 7)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (80, 1, 75, NULL, 0, 1, 8)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (81, 1, 76, NULL, 0, 1, 1)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (82, 1, 77, NULL, 0, 1, 2)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (83, 1, 78, NULL, 0, 1, 3)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (84, 1, 79, NULL, 0, 1, 4)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (85, 1, 80, NULL, 0, 1, 5)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (86, 1, 81, NULL, 0, 1, 6)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (87, 1, 82, NULL, 0, 1, 7)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (88, 1, 83, NULL, 0, 1, 8)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (89, 1, 84, NULL, 0, 1, 1)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (91, 1, 85, NULL, 0, 1, 2)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (92, 1, 86, NULL, 0, 1, 3)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (93, 1, 87, NULL, 0, 1, 4)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (132, 1, 112, NULL, 0, 1, 5)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (133, 1, 113, NULL, 0, 1, 6)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (134, 1, 114, NULL, 0, 1, 7)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (135, 1, 115, NULL, 0, 1, 8)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (136, 1, 116, NULL, 0, 1, 1)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (137, 1, 117, NULL, 0, 1, 2)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (138, 1, 118, NULL, 0, 1, 3)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (139, 1, 119, NULL, 0, 1, 4)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (140, 1, 120, NULL, 0, 1, 5)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (141, 1, 121, NULL, 0, 1, 6)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (142, 1, 122, NULL, 0, 1, 7)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (143, 1, 123, NULL, 0, 1, 8)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (144, 1, 124, NULL, 0, 1, 1)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (145, 1, 125, NULL, 0, 1, 2)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (146, 1, 126, NULL, 0, 1, 3)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (147, 1, 127, NULL, 0, 1, 4)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (148, 1, 128, NULL, 0, 1, 5)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (149, 1, 129, NULL, 0, 1, 6)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (150, 1, 130, NULL, 0, 1, 7)
GO

INSERT [custom].[ApplicationPackages] ([ApplicationPackageID], [ApplicationID], [PackageID], [ExecutionOrder], [FailApplicationOnPackageFailure], [isEnabled], [Channel]) VALUES (151, 1, 131, NULL, 0, 1, 8)
GO

SET IDENTITY_INSERT [custom].[ApplicationPackages] OFF
GO

SET IDENTITY_INSERT [custom].[Applications] ON
GO

INSERT [custom].[Applications] ([ApplicationID], [ApplicationName]) VALUES (1, N'CIS DataLoad')
GO

SET IDENTITY_INSERT [custom].[Applications] OFF
GO

SET IDENTITY_INSERT [custom].[Packages] ON
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (1, N'etl_Covenants.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'covenants', N'This table contains a record for each covenant. There may be many covenants for the same order but only one may be current.', N'GIF')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (2, N'etl_Contacts.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contacts', N'This table contains a record for each person with their name and personal details.', N'CON')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (4, N'etl_Declaration_Lines_Unclaimed.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'declaration_lines_unclaimed', N'Stores transactions that are eligible for a tax claim', N'GIF')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (5, N'etl_Declaration_Potential_lines.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'declaration_potential_lines', N'Holds the potential declaration tax claim lines prior to running the tax claim', N'GIF')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (6, N'etl_Declaration_Tax_Claims.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'declaration_tax_claims', N'Stores records of each claim made under the new Gift Aid scheme', N'GIF')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (7, N'etl_Declaration_Tax_Claim_Lines.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'declaration_tax_claim_lines', N'Stores records of each transaction analysis line that has been claimed', N'GIF')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (8, N'etl_Gift_Aid_Declarations.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'gift_aid_declarations', N'Holds records of declarations received', N'GIF')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (9, N'etl_Financial_History_Details.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'financial_history_details', N'This table contains the detailed analysis of each transaction in the Financial History table.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (112, N'etl_contact_positions.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contact_positions', N'This table contains a list for each contact of the positions held by that contact and the organisation at which the position is held.', N'CON')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (113, N'etl_users.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'users', N'Defines the valid system users', N'CON')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (114, N'etl_dba_notes.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'dba_notes', N'This table holds notes on any contact merged with another contact', N'CON')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (115, N'etl_contact_communication_usages.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contact_communication_usages', N'This table contains a list for each contact of any special purpose that a communications record is to be used', N'CON')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (116, N'etl_contact_links.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contact_links', N'This table contains a list for each contact of other contacts who are in some way (business, personal, social) related to that contact.', N'CON')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (117, N'etl_contact_roles.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contact_roles', N'This table contains a list for each contact of the roles fulfilled by that contact for any organisation they work for.', N'CON')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (118, N'etl_status_history.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'status_history', N'This table will contain the history of a contact''s status as it is changed throughout the system', N'CON')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (119, N'etl_contact_categories.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contact_categories
', N'This table contains a list for each contact of the Activity and Activity Value combinations which have been assigned to that contact.', N'CON')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (120, N'etl_contact_suppressions.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contact_suppressions', N'This table contains a list for each contact of the Mailing Suppressions which are applicable to the contact.', N'CON')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (122, N'etl_contact_legacies.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contact_legacies', N'This table holds details of Legacies', N'LEG')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (123, N'etl_legacy_bequest_receipts.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'legacy_bequest_receipts', N'Each receipt of money or goods against a Bequest', N'LEG')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (124, N'etl_ext_tf_report.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'ext_tf_report
', NULL, N'LEG')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (127, N'etl_gaye_payments.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'gaye_payments', N'gaye_payments', N'GAYE')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (128, N'etl_gaye_pledge_payment_history.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'gaye_pledge_payment_history', N'Contains details of all payments made against a Pre Tax Payroll Giving pledge', N'GAYE')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (130, N'etl_fundraising_request_targets.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'fundraising_request_targets', NULL, N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (131, N'etl_legacy_bequests.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'legacy_bequests', NULL, N'LEG')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (121, N'etl_contact_external_links.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contact_external_links
', N'This table holds links between a contact and a related external data source. The external reference contains a unique identifier for the contact in the external system', N'CON')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (125, N'etl_gaye_agencies.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'gaye_agencies', N'You must create the Collection Agencies as organisation records before you can update this table.  You then identify that organisation as a Pre Tax Payroll Giving Collection Agency by making an entry in this table.  The table also enables you to record, for each Agency, whether to post income to the Cash Book.  This data is stored independently for each Agency to accommodate the fact that different Agencies will make payments by different methods.', N'GAYE')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (126, N'etl_gaye_controls.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'gaye_controls', N'This table must be correctly set up if you wish to process Payroll Giving payments.  The table is referenced when creating new pledges via the keyboard to default the analysis of the pledge and by the Payroll Giving Reconciliation routines both for the analysis of new pledges and for the analysis of the various additional elements of a transaction ie.  employers contribution, government contribution, collection agency fees.  The table also holds an automatic Activity Category that will be applied to all records when a pledge is created.  Each of the individual attributes are described in the associated attribute notes', N'GAYE')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (129, N'etl_gaye_pledges.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'gaye_pledges', N'Holds details of  Pre Tax Payroll Giving pledges', N'GAYE')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (10, N'etl_Order_Payment_Schedule.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'order_payment_schedule', N'This table contains payment schedule information for each payment plan.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (11, N'etl_Order_Payment_History.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'order_payment_history', N'This table contains the details of all payments made against an order.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (12, N'etl_Batch_Transactions.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'batch_transactions', N'This table contains the details of each transaction within a batch, identifying the contact, amount and payment details.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (13, N'etl_Batch_Transaction_Analysis.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'batch_transaction_analysis', N'This table contains the detailed analysis of each transaction within a batch.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (14, N'etl_Financial_History.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'financial_history', N'This table contains the history of all transactions made by a contact and subsequent refunds and adjustments.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (15, N'etl_Financial_Links.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'financial_links', N'This table contains Soft-Credit links between payers of Financial Transactions and the Contact that monies were sent on behalf of or in memoriam of. Soft Credit links are created for:- In Memoriam payments: Where a Contact Donates money in memory of another Contact, Contributed payments: Where a Contact has collected donations (usually cheques) from various other Contacts and sent them, and Sent of behalf payments: Where a Contact has collected donations from various other Contacts and sent one payment (usually a cheque) to cover the individual donations and with a list of the Contacts that donated.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (16, N'etl_Order_Details.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'order_details', N'This table contains the despatch and analysis information for each order.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (46, N'etl_event_bookings.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'event_bookings', N'This table contains a record for each booking made against an event.', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (47, N'etl_event_personnel.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'event_personnel', N'This table lists the tutors, presenters taking part in an event or session. ', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (17, N'etl_members.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'members', N'This table contains any number of records for each contact with each record containing the information on a previous period of membership. A contact can only have one current membership which is not cancelled.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (18, N'etl_Invoice_Details.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'invoice_details', N'This table lists the individual invoice lines for each invoice. The record is generated as part of the Credit Sales Maintenance and Stock Allocation Confirmation processes.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (20, N'etl_Invoice_Payment_History.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'invoice_payment_history', N'This table will contain the details of all payments made against an invoice.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (21, N'etl_bankers_orders.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'bankers_orders', N'This table contains the details of all bankers orders for membership subscriptions and donations (including covenanted subscriptions and donations).', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (22, N'etl_batches.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'batches', N'This table contains the control information on any batch.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (23, N'etl_contact_accounts.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contact_accounts', N'This table contains the details of all bank accounts recorded for contacts paying by bankers order or recorded as part of receipts data entry.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (24, N'etl_credit_card_authorisations.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'credit_card_authorisations', N'This table hold details of each on-line credit card authorisation attempt', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (25, N'etl_direct_debits.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'direct_debits', N'This table contains the details of all direct debits for membership subscriptions and donations (including covenanted subscriptions and donations).', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (26, N'etl_duk_new2015_sources.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'duk_new2015_sources', NULL, N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (27, N'etl_duk_sources.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'duk_sources', NULL, N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (30, N'etl_invoices.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'invoices', N'This table lists the invoices generated for a contact. The record is generated as part of the Credit Sales Maintenance and Stock Allocation Confirmation processes.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (31, N'etl_orders.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'orders', N'This table contains standard details of all membership subscriptions, covenants, and other subscriptions.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (33, N'etl_rates.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'rates', N'Linked to a specific Product to indicate the price(s) at which it can be sold.  All prices are on a per item basis', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (34, N'etl_reversals.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'reversals', N'This table identifies the original transaction and analysis line affected by any financial adjustment.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (36, N'etl_duk_bta_update_log.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'duk_bta_update_log', NULL, N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (37, N'etl_duk_comms_log_update_log.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'duk_comms_log_update_log', NULL, N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (38, N'etl_duk_cont_categories_update_log.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'duk_cont_categories_update_log', NULL, N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (39, N'etl_duk_contacts_update_log.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'duk_contacts_update_log', NULL, N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (40, N'etl_duk_fin_hist_reconciliation.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'duk_fin_hist_reconiciliation', NULL, N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (41, N'etl_duk_order_details_update_log.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'duk_order_details_update', NULL, N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (42, N'etl_duk_orders_update_log.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'duk_orders_update_log', NULL, N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (44, N'etl_delegates.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'delegates', N'This table holds a record for each named delegate for an event', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (45, N'etl_event_booking_options.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'event_booking_options', N'This table lists the different options available for an event when making a booking', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (32, N'etl_products.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'products', N'A Product is any item for which an organisation can potentially receive money.  The Product record holds the Nominal Ledger analysis code that will be used to record any income associated with this product.  This table allows you to create and maintain the list of valid products for each of the Companies in the database.  You need to specify a unique code for each Product.  For stock items the intial stock level can be entered manually when you create the product but thereafter can only be adjusted via the appropriate system functions.   If using multiple warehouses a product warehouse record will be automatically created when you add a new product.  Associated with each product code is a list of price codes (Rates) at which the product may be sold.', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (35, N'etl_sources.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'sources', N'Sources are assigned to various data types at the point of data entry  e.g. New  Contacts and Organisations, Communications, Financial Transactions, Activity Categories etc.  A Source Code determines how that that data was generated e.g. as a result of a Marketing Mailing.  Sources are automatically generated by the Campaign Management software when you create each new segment and will be built by combining the Campaign, Appeal and Segment codes (plus a check digit if you have set the appropriate configuration options). You may also update the table directly to create new Source codes.  If you do so you should consider creating a matching Mailing code which is used to track the fact that a Mailing has been sent to a specific Contact or Organisation', N'FIN')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (43, N'etl_delegate_activities.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'delegate_activities', N'This table contains the Activity and Activity Value combinations that have been assigned to a particular event delegate', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (48, N'etl_event_personnel_tasks.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'event_personnel_tasks', N'This table can be used to define multiple tasks that individual Event Personnel may perform if configuration option Allow Event Personnel to have multiple tasks is set.', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (49, N'etl_event_topics.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'event_topics', N'Contains the topics and sub-topics used to classify an event', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (50, N'etl_sessions.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'sessions', N'This table lists the individual sessions which make up an event as part of the programme', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (51, N'etl_events.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'events', N'This table lists the events which are being held at any venue and the start date of the event', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (52, N'etl_session_activities.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'session_activities', N'This table will contain the list of activities which will be used to create contact_category records when a contact is booked onto an event session.', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (53, N'etl_session_bookings.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'session_bookings', N'This table holds a record for each session booked for an event', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (54, N'etl_venues.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'venues', N'Within this table the user will need to set up Venues that the Events are held at.  These can be as accurate or as vague as required therefore they can define a room, a building, a town or a country.  N.B.  At least one Venue will need to be set up, as it is a mandatory field within the Event Header.  Different Venues can now also be applied for each session', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (55, N'etl_organisations.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'organisations', N'This table contains the name of each organisation, branch with which a contact may be associated.', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (56, N'etl_organisation_actions.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'organisation_actions', N'This table holds the links between actions and organisations', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (57, N'etl_organisation_addresses.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'organisation_addresses', N'This table contains a list of all known addresses for an organisation', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (58, N'etl_organisation_address_usages.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'organisation_address_usages', N'This table contains a list for each organisation of any special purpose that an address for that organisation is to be used', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (59, N'etl_organisation_categories.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'organisation_categories', N'This table contains a list for each organisation specifying the Activity and Activity Value combinations which have been assigned to that organisation.', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (60, N'etl_organisation_links.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'organisation_links', N'This table contains a list for each organisation of other organisations which are in some way related with that organisation.', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (61, N'etl_actions.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'actions', N'This table holds the information related to a specific action item', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (63, N'etl_contact_actions.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contact_actions', N'This table holds the links between actions and contacts', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (64, N'etl_fundraising_requests.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'fundraising_requests', N'This table holds information about fundraising requests', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (65, N'etl_selected_contacts.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'selected_contacts', N'This table contains a record of each contact selected as part of a selection set. This table will also contain sets currently being worked on', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (66, N'etl_selection_sets.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'selection_sets', N'This table contains the header record for all groups of saved contacts generated by searches', N'EVT')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (73, N'etl_communications.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'communications', N'This table contains all telephone numbers, fax numbers etc listed to contact individuals or organisations', N'COM')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (74, N'etl_communications_log.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'communications_log', N'This table is available to record each time a contact has been in touch with the client and vice-versa. The table records the type of communication, originator, precis and text of letters etc.', N'COM')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (75, N'etl_communications_log_links.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'communications_log_links', N'This holds the links between a communications_log document and contacts', N'COM')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (76, N'etl_communications_log_subjects.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'communications_log_subjects', N'This table records the topics and sub-topics used to classify a communications log entry', N'COM')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (77, N'etl_contact_mailing_documents.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contact_mailing_documents', N'This table contains the definitions of documents acknowledging transactions', N'MAI')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (78, N'etl_contact_mailings.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contact_mailings', N'This table contains a list for each contact of all mailings sent to the individual and the date the mailing was generated', N'MAI')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (80, N'etl_mailing_history.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'mailing_history', N'This table contains a reference of every time a mailing is sent.', N'MAI')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (82, N'etl_addresses.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'addresses', N'This table contains all addresses of contacts and organisations held on the database.', N'MAI')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (84, N'etl_contact_addresses.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contact_addresses', N'This table contains a list for each contact of the addresses at which they may be reached.', N'MAI')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (86, N'etl_geographical_region_postcodes.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'geographical_region_postcodes', N'Details for each region the postcodes that relate to this region', N'MAI')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (87, N'etl_government_region_postcodes.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'government_region_postcodes', N'This table contains the various postcodes and the government region', N'MAI')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (79, N'etl_mailings.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'mailings', N'Used to identify that a specific mailing has been sent to a contact.  When a mailing is generated via the software, you are required to assign a mailing code.  You can choose an existing mailing code or create a new one, if you enter a new code this table is automatically updated.  Mailing codes are automatically generated by the Campaign Management software when you create each new segment and will be built by combining the Campaign, Appeal and Segment codes (plus a check digit if you have set the appropriate configuration options). You may also update the table directly to create new Mailing codes.  If you do so you should consider creating a matching source code which will be used to track any response to that mailing.  Mailing codes which are to be used for Thank You Letter mailings should be created directly in this table.  They may then be associated with a Source code (used to default the response mailing code from source if the config default_mailing is set to SOURCE or LETTERBREAKORSOURCE) either by directly updating the Sources table or automatically when you assign a thank you letter code to an Appeal or Segment', N'MAI')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (81, N'etl_mailing_template_paragraphs.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'mailing_template_paragraphs', N'You must have created a Mailing Template and Standard Document including bookmarks before you can update this table.  Mailing Template Paragraphs identify specific conditions that must be met in order for the paragraph text to be included in the Mailing Document.  The actual paragraph text is defined in the Standard Document associated with the Mailing Template and specifically identified by a bookmark.', N'MAI')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (83, N'etl_branch_postcodes.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'branch_postcodes', N'This table contains a list for each branch of the outward postcodes which form the area covered by the branch.', N'MAI')
GO

INSERT [custom].[Packages] ([PackageID], [PackageName], [ProjectName], [FolderName], [TableName], [TableNotes], [PackageGroup]) VALUES (85, N'etl_contact_address_usages.dtsx', N'Populate_CIS_Tables', N'DiabetesDWH', N'contact_address_usages', N'This table contains a list for each contact of any special purpose that an address is to be used', N'MAI')
GO

SET IDENTITY_INSERT [custom].[Packages] OFF
GO
