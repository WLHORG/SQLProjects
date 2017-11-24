CREATE PROCEDURE [cis].[usp_Merge_orders]
AS 
BEGIN

BEGIN TRY
    BEGIN TRANSACTION;

--Synchronize the target table with
--refreshed data from source table
MERGE cis.orders AS t
USING cis_delta.orders AS s 
ON (t.[contact_number] = s.[contact_number]) 
--When records are matched, update 
--the records if there is any change
WHEN NOT MATCHED BY TARGET 
    THEN INSERT(
		[order_number]
      ,[order_type]
      ,[contact_number]
      ,[address_number]
      ,[order_date]
      ,[order_term]
      ,[order_term_units]
      ,[renewal_date]
      ,[expiry_date]
      ,[payment_method]
      ,[payment_frequency]
      ,[frequency_amount]
      ,[amount]
      ,[balance]
      ,[arrears]
      ,[in_advance]
      ,[renewal_amount]
      ,[last_payment]
      ,[last_payment_date]
      ,[next_payment_due]
      ,[bankers_order]
      ,[direct_debit]
      ,[covenant]
      ,[credit_card]
      ,[detail_lines]
      ,[next_detail_line]
      ,[payment_number]
      ,[number_of_reminders]
      ,[cancellation_reason]
      ,[cancelled_on]
      ,[cancelled_by]
      ,[reason_for_despatch]
      ,[branch]
      ,[membership_type]
      ,[source]
      ,[their_reference]
      ,[amended_by]
      ,[amended_on]
      ,[renewal_pending]
      ,[gift_membership]
      ,[one_year_gift]
      ,[future_cancellation_date]
      ,[future_cancellation_reason]
      ,[sales_contact_number]
      ,[sales_group]
      ,[reprint]
      ,[renewal_change_reason]
      ,[renewal_changed_by]
      ,[renewal_changed_on]
      ,[renewal_change_value]
      ,[reset_order_term]
      ,[cancellation_source]
      ,[future_cancellation_source]
      ,[provisional]
      ,[giver_contact_number]
      ,[created_by]
      ,[created_on]
      ,[confirmed_on]
      ,[first_amount]
      ,[payment_schedule_amended_on]
      ,[claim_day]
      ,[eligible_for_gift_aid]
      ,[pack_to_member]
      ,[one_off_payment]
      ,[start_month]
	) 
	
VALUES(

	   s.[order_number]
      ,s.[order_type]
      ,s.[contact_number]
      ,s.[address_number]
      ,s.[order_date]
      ,s.[order_term]
      ,s.[order_term_units]
      ,s.[renewal_date]
      ,s.[expiry_date]
      ,s.[payment_method]
      ,s.[payment_frequency]
      ,s.[frequency_amount]
      ,s.[amount]
      ,s.[balance]
      ,s.[arrears]
      ,s.[in_advance]
      ,s.[renewal_amount]
      ,s.[last_payment]
      ,s.[last_payment_date]
      ,s.[next_payment_due]
      ,s.[bankers_order]
      ,s.[direct_debit]
      ,s.[covenant]
      ,s.[credit_card]
      ,s.[detail_lines]
      ,s.[next_detail_line]
      ,s.[payment_number]
      ,s.[number_of_reminders]
      ,s.[cancellation_reason]
      ,s.[cancelled_on]
      ,s.[cancelled_by]
      ,s.[reason_for_despatch]
      ,s.[branch]
      ,s.[membership_type]
      ,s.[source]
      ,s.[their_reference]
      ,s.[amended_by]
      ,s.[amended_on]
      ,s.[renewal_pending]
      ,s.[gift_membership]
      ,s.[one_year_gift]
      ,s.[future_cancellation_date]
      ,s.[future_cancellation_reason]
      ,s.[sales_contact_number]
      ,s.[sales_group]
      ,s.[reprint]
      ,s.[renewal_change_reason]
      ,s.[renewal_changed_by]
      ,s.[renewal_changed_on]
      ,s.[renewal_change_value]
      ,s.[reset_order_term]
      ,s.[cancellation_source]
      ,s.[future_cancellation_source]
      ,s.[provisional]
      ,s.[giver_contact_number]
      ,s.[created_by]
      ,s.[created_on]
      ,s.[confirmed_on]
      ,s.[first_amount]
      ,s.[payment_schedule_amended_on]
      ,s.[claim_day]
      ,s.[eligible_for_gift_aid]
      ,s.[pack_to_member]
      ,s.[one_off_payment]
      ,s.[start_month])
WHEN MATCHED 
    THEN UPDATE SET
		


	 t.[order_number] = s.[order_number]
      ,t.[order_type] = s.[order_type]
      ,t.[contact_number] = s.[contact_number]
      ,t.[address_number] = s.[address_number]
      ,t.[order_date] = s.[order_date]
      ,t.[order_term] = s.[order_term]
      ,t.[order_term_units] = s.[order_term_units]
      ,t.[renewal_date] = s.[renewal_date]
      ,t.[expiry_date] = s.[expiry_date]
      ,t.[payment_method] = s.[payment_method]
      ,t.[payment_frequency] = s.[payment_method]
      ,t.[frequency_amount] = s.[frequency_amount]
      ,t.[amount] = s.[amount]
      ,t.[balance] = s.[balance]
      ,t.[arrears] = s.[arrears]
      ,t.[in_advance] = s.[in_advance]
      ,t.[renewal_amount] = s.[renewal_amount]
      ,t.[last_payment] = s.[last_payment]
      ,t.[last_payment_date] = s.[last_payment_date]
      ,t.[next_payment_due] = s.[next_payment_due]
      ,t.[bankers_order] = s.[bankers_order]
      ,t.[direct_debit] = s.[direct_debit]
      ,t.[covenant] = s.[covenant]
      ,t.[credit_card] = s.[credit_card]
      ,t.[detail_lines] = s.[detail_lines]
      ,t.[next_detail_line] = s.[next_detail_line]
      ,t.[payment_number] = s.[payment_number]
      ,t.[number_of_reminders] = s.[number_of_reminders]
      ,t.[cancellation_reason] = s.[cancellation_reason]
      ,t.[cancelled_on] = s.[cancelled_on]
      ,t.[cancelled_by] = s.[cancelled_by]
      ,t.[reason_for_despatch] = s.[reason_for_despatch]
      ,t.[branch] = s.[branch]
      ,t.[membership_type] = s.[membership_type]
      ,t.[source] = s.[source]
      ,t.[their_reference] = s.[their_reference]
      ,t.[amended_by] = s.[amended_by]
      ,t.[amended_on] = s.[amended_on]
      ,t.[renewal_pending] = s.[renewal_pending]
      ,t.[gift_membership] = s.[gift_membership]
      ,t.[one_year_gift] = s.[one_year_gift]
      ,t.[future_cancellation_date] = s.[future_cancellation_date]
      ,t.[future_cancellation_reason] = s.[future_cancellation_reason]
      ,t.[sales_contact_number] = s.[sales_contact_number]
      ,t.[sales_group] = s.[sales_group]
      ,t.[reprint] = s.[reprint]
      ,t.[renewal_change_reason] = s.[renewal_change_reason]
      ,t.[renewal_changed_by] = s.[renewal_changed_by]
      ,t.[renewal_changed_on] = s.[renewal_changed_on]
      ,t.[renewal_change_value] = s.[renewal_change_value]
      ,t.[reset_order_term] = s.[reset_order_term]
      ,t.[cancellation_source] = s.[cancellation_source]
      ,t.[future_cancellation_source] = s.[future_cancellation_source]
      ,t.[provisional] = s.[provisional]
      ,t.[giver_contact_number] = s.[giver_contact_number]
      ,t.[created_by] = s.[created_by]
      ,t.[created_on] = s.[created_on]
      ,t.[confirmed_on] = s.[confirmed_on]
      ,t.[first_amount] = s.[first_amount]
      ,t.[payment_schedule_amended_on] = s.[payment_schedule_amended_on]
      ,t.[claim_day] = s.[claim_day]
      ,t.[eligible_for_gift_aid] = s.[eligible_for_gift_aid]
      ,t.[pack_to_member] = s.[pack_to_member]
      ,t.[one_off_payment] = s.[one_off_payment]
      ,t.[start_month] = s.[start_month]
	



	  ; 
	  		 COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    IF @@TRANCOUNT > 0
    ROLLBACK TRANSACTION;
 
    DECLARE @ErrorNumber INT = ERROR_NUMBER();
    DECLARE @ErrorLine INT = ERROR_LINE();
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
    DECLARE @ErrorState INT = ERROR_STATE();
 

	INSERT INTO [control].[TableErrors]

	SELECT 'cis.orders' as TableName, getdate() as LoadDate, 
     CAST(@ErrorNumber AS VARCHAR(10)) as ErrNum,  CAST(@ErrorLine AS VARCHAR(10)) as ErrLne, 
	 CAST(@ErrorMessage as VARCHAR(MAX)) as ErrMsg;
 
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH

	END
	
	
