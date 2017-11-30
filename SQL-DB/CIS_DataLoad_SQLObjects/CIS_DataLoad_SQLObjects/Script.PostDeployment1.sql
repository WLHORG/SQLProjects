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
USE [DiabetesDWH]
GO
SET IDENTITY_INSERT [control].[LastTableUpdate] ON 

GO
INSERT [control].[LastTableUpdate] ([id], [TableName], [MaxTransactionDate], [MaxBusKeyID], [BusKeyColumn], [MAXBatch_Number], [MAXTransaction_ID], [MAXLine_ID], [FullExtract], [LastExtractRowCount], [LastExtractedDate]) VALUES (1, N'financial_history', NULL, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [control].[LastTableUpdate] ([id], [TableName], [MaxTransactionDate], [MaxBusKeyID], [BusKeyColumn], [MAXBatch_Number], [MAXTransaction_ID], [MAXLine_ID], [FullExtract], [LastExtractRowCount], [LastExtractedDate]) VALUES (2, N'financial_history_details', NULL, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [control].[LastTableUpdate] ([id], [TableName], [MaxTransactionDate], [MaxBusKeyID], [BusKeyColumn], [MAXBatch_Number], [MAXTransaction_ID], [MAXLine_ID], [FullExtract], [LastExtractRowCount], [LastExtractedDate]) VALUES (3, N'contacts', NULL, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [control].[LastTableUpdate] ([id], [TableName], [MaxTransactionDate], [MaxBusKeyID], [BusKeyColumn], [MAXBatch_Number], [MAXTransaction_ID], [MAXLine_ID], [FullExtract], [LastExtractRowCount], [LastExtractedDate]) VALUES (4, N'batch_transactions', NULL, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [control].[LastTableUpdate] ([id], [TableName], [MaxTransactionDate], [MaxBusKeyID], [BusKeyColumn], [MAXBatch_Number], [MAXTransaction_ID], [MAXLine_ID], [FullExtract], [LastExtractRowCount], [LastExtractedDate]) VALUES (5, N'batch_transaction_analysis', NULL, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [control].[LastTableUpdate] ([id], [TableName], [MaxTransactionDate], [MaxBusKeyID], [BusKeyColumn], [MAXBatch_Number], [MAXTransaction_ID], [MAXLine_ID], [FullExtract], [LastExtractRowCount], [LastExtractedDate]) VALUES (6, N'order_payment_history', NULL, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [control].[LastTableUpdate] ([id], [TableName], [MaxTransactionDate], [MaxBusKeyID], [BusKeyColumn], [MAXBatch_Number], [MAXTransaction_ID], [MAXLine_ID], [FullExtract], [LastExtractRowCount], [LastExtractedDate]) VALUES (7, N'order_payment_schedule', NULL, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [control].[LastTableUpdate] ([id], [TableName], [MaxTransactionDate], [MaxBusKeyID], [BusKeyColumn], [MAXBatch_Number], [MAXTransaction_ID], [MAXLine_ID], [FullExtract], [LastExtractRowCount], [LastExtractedDate]) VALUES (8, N'communications_log_subjects', NULL, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [control].[LastTableUpdate] ([id], [TableName], [MaxTransactionDate], [MaxBusKeyID], [BusKeyColumn], [MAXBatch_Number], [MAXTransaction_ID], [MAXLine_ID], [FullExtract], [LastExtractRowCount], [LastExtractedDate]) VALUES (9, N'contact_mailings', NULL, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [control].[LastTableUpdate] ([id], [TableName], [MaxTransactionDate], [MaxBusKeyID], [BusKeyColumn], [MAXBatch_Number], [MAXTransaction_ID], [MAXLine_ID], [FullExtract], [LastExtractRowCount], [LastExtractedDate]) VALUES (10, N'communications_log', NULL, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [control].[LastTableUpdate] ([id], [TableName], [MaxTransactionDate], [MaxBusKeyID], [BusKeyColumn], [MAXBatch_Number], [MAXTransaction_ID], [MAXLine_ID], [FullExtract], [LastExtractRowCount], [LastExtractedDate]) VALUES (11, N'communications_log_links', NULL, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [control].[LastTableUpdate] ([id], [TableName], [MaxTransactionDate], [MaxBusKeyID], [BusKeyColumn], [MAXBatch_Number], [MAXTransaction_ID], [MAXLine_ID], [FullExtract], [LastExtractRowCount], [LastExtractedDate]) VALUES (12, N'selected_contacts', NULL, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
INSERT [control].[LastTableUpdate] ([id], [TableName], [MaxTransactionDate], [MaxBusKeyID], [BusKeyColumn], [MAXBatch_Number], [MAXTransaction_ID], [MAXLine_ID], [FullExtract], [LastExtractRowCount], [LastExtractedDate]) VALUES (13, N'declaration_tax_claim_lines', NULL, 0, NULL, 0, NULL, NULL, 1, NULL, NULL)
GO
SET IDENTITY_INSERT [control].[LastTableUpdate] OFF
GO
