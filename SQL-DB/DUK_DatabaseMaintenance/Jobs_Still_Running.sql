/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2012 (11.0.6020)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2012
    Target Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [msdb]
GO

/****** Object:  Job [job_DiabetesDWH_Report_Failed_& Running_SQL_Agent_Jobs]    Script Date: 25/01/2018 14:31:10 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 25/01/2018 14:31:10 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'job_DiabetesDWH_Report_Failed_& Running_SQL_Agent_Jobs', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'DataTeam', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [1 Identify and Report on Failing SQL Agent Jobs]    Script Date: 25/01/2018 14:31:10 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'1 Identify and Report on Failing SQL Agent Jobs', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use msdb


begin
if object_id(''tempdb..#tempjobs'') is not null
drop table #tempjobs
end

create table #tempjobs (
[job name] nvarchar(150),
[last_run_outcome] nvarchar(10),
[last_outcome_message] nvarchar(max),
[last_run_date] nvarchar(20) )

insert into #tempjobs

select sysjobs.name as [job name]
, sysjobservers.last_run_outcome
, sysjobservers.last_outcome_message
, sysjobservers.last_run_date --sysjobschedules.next_run_date
from sysjobs as sysjobs
inner join sysjobservers as sysjobservers on sysjobservers.job_id = sysjobs.job_id
--where last_outcome_message like ''%failed%''
where sysjobservers.last_run_outcome not in (1,5)
and cast(cast(sysjobservers.last_run_date as char(8)) as datetime) between dateadd(d,-1,getdate()) and getdate()

if exists (select * from #tempjobs)
begin

declare @xml nvarchar(max)
declare @body nvarchar(max)

set @xml = cast(( select [job name] as ''td'',''''
					, [last_run_outcome] as ''td'',''''
					, [last_outcome_message] as ''td'',''''
					, [last_run_date] as ''td''
from  #tempjobs 
order by [job name]
for xml path(''tr''), elements ) as nvarchar(max))

set @body =''<html><body><h3>failed jobs</h3>
<table border = 1> 
<tr>
<th> job name </th> <th> last run outcome </th> <th> last outcome message </th> <th> last run date </th></tr>''    
 
set @body = @body + @xml +''</table></body></html>''

declare @subjectserver nvarchar(255)
select @subjectserver = (select @@servername)+'' - failed sqlagent jobs today''
exec msdb.dbo.sp_send_dbmail	       
                                        @profile_name = ''diabetesdwh'',
									    @recipients = ''DataTeamMembers@diabetes.org.uk;Rob.Mitchell@diabetes.org.uk;Daniela.Dunn@diabetes.org.uk;nathan.porter@diabetes.org.uk'',
										@subject = @subjectserver,
										@body = @body,
									    @body_format = ''html''


drop table #tempjobs
end

', 
		@database_name=N'msdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [2 Identify and Report on Running SQL Agent Jobs]    Script Date: 25/01/2018 14:31:10 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'2 Identify and Report on Running SQL Agent Jobs', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use msdb;

declare @currentsession as int
select @currentsession = max(session_id)
from msdb.dbo.syssessions;

if object_id(''tempdb..#runningjobs '') is not null drop table #runningjobs;

select sj.name as [job_name]
   , sja.session_id
   , sj.job_id
   , sja.run_requested_date
   , sja.run_requested_source
   , sja.queued_date
   , sja.start_execution_date
   , sja.last_executed_step_id
   , sja.last_executed_step_date
   , sja.stop_execution_date
   , sja.job_history_id
   , sja.next_scheduled_run_date
into #runningjobs
from msdb.dbo.sysjobactivity as sja
inner join msdb.dbo.sysjobs as sj on sja.job_id = sj.job_id
where sja.start_execution_date is not null
and sja.stop_execution_date is null
and sja.session_id = @currentSession
and sj.job_id <>''DFEDD787-2AD1-41B5-945A-6AAB8FFE850B'' --This is the ID of the "job_DiabetesDWH_Report_Failed_& Running_SQL_Agent_Jobs"

if exists (select * 
			from #runningjobs)
begin

declare @xml nvarchar(max)
declare @body nvarchar(max)

set @xml = cast(( select job_name as ''td'',''''
, session_id as ''td'',''''
, job_id as ''td'',''''
, run_requested_date as ''td'',''''
, run_requested_source as ''td'',''''
, queued_date as ''td'',''''
, start_execution_date as ''td'',''''
, last_executed_step_id as ''td'',''''
, last_executed_step_date as ''td'',''''
, stop_execution_date as ''td'',''''
, job_history_id as ''td'',''''
, next_scheduled_run_date as ''td''
from  #runningjobs
order by start_execution_date 
for xml path(''tr''), elements ) as nvarchar(max))

set @body =''<html><body><h3>running jobs</h3>
<table border = 1> 
<tr>
<th> job_name </th> 
<th> session_id </th> 
<th> job_id </th> 
<th> run_requested_date </th> 
<th> run_requested_source </th> 
<th> queued_date </th> 
<th> last_executed_step_id </th> 
<th> start_execution_date </th> 
<th> last_executed_step_date </th> 
<th> stop_execution_date </th> 
<th> job_history_id </th> 
<th> next_scheduled_run_date </th> 
</tr>''    

set @body = @body + @xml +''</table></body></html>''

declare @subjectserver nvarchar(255)
select @subjectserver = (select @@servername)+'' - sqlagent jobs still running today''
exec msdb.dbo.sp_send_dbmail	       
@profile_name = ''diabetesdwh'',
@recipients = ''DataTeamMembers@diabetes.org.uk;Rob.Mitchell@diabetes.org.uk;Daniela.Dunn@diabetes.org.uk;Nathan.Porter@diabetes.org.uk'',
@subject = @subjectserver,
@body = @body,
@body_format = ''html''

drop table  #runningjobs
end
', 
		@database_name=N'msdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'1 Daily Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150126, 
		@active_end_date=99991231, 
		@active_start_time=80100, 
		@active_end_time=90101, 
		@schedule_uid=N'b87ea746-edf7-4982-b5bd-b159c14a16a1'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


