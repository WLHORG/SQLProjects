/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2012 (11.0.6594)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [DBATools]
GO
/****** Object:  StoredProcedure [dbo].[usp_Start_And_Wait_For_Job]    Script Date: 25/01/2018 14:13:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Start_And_Wait_For_Job]
(
       @jobName SYSNAME
)
AS
 
SET NOCOUNT ON
 
DECLARE       @jobID UNIQUEIDENTIFIER,
       @maxID INT,
       @status INT,
       @rc INT
 
IF @jobName IS NULL
      BEGIN
            RAISERROR('Parameter @jobName have no value.', 16, 1)
            RETURN -100
      END
 
SELECT @jobID = job_id
FROM   msdb..sysjobs
WHERE name = @jobName
 
IF @@ERROR <> 0
      BEGIN
            RAISERROR('Error when returning jobID for job %s.', 18, 1, @jobName)
            RETURN -110
      END
 
IF @jobID IS NULL
      BEGIN
            RAISERROR('Job %s does not exist.', 16, 1, @jobName)
            RETURN -120
      END
 
SELECT @maxID = MAX(instance_id)
FROM   msdb..sysjobhistory
WHERE job_id = @jobID
       AND step_id = 0
 
IF @@ERROR <> 0
      BEGIN
            RAISERROR('Error when reading history for job %s.', 18, 1, @jobName)
            RETURN -130
     END
 
SET    @maxID = COALESCE(@maxID, -1)
 
EXEC   @rc = msdb..sp_start_job @job_name = @jobName
 
IF @@ERROR <> 0 OR @rc <> 0
      BEGIN
            RAISERROR('Job %s did not start.', 18, 1, @jobName)
            RETURN -140
      END
 
WHILE (SELECT MAX(instance_id) FROM msdb..sysjobhistory WHERE job_id = @jobID AND step_id = 0) = @maxID
      WAITFOR DELAY '00:00:01'
 
SELECT @maxID = MAX(instance_id)
FROM   msdb..sysjobhistory
WHERE job_id = @jobID
       AND step_id = 0
 
IF @@ERROR <> 0
      BEGIN
            RAISERROR('Error when reading history for job %s.', 18, 1, @jobName)
            RETURN -150
      END
 
SELECT @status = run_status
FROM   msdb..sysjobhistory
WHERE instance_id = @maxID
 
IF @@ERROR <> 0
      BEGIN
            RAISERROR('Error when reading status for job %s.', 18, 1, @jobName)
            RETURN -160
      END
 
IF @status <> 1
      BEGIN
            RAISERROR('Job %s returned with an error.', 16, 1, @jobName)
            RETURN -170
      END
 
RETURN 0