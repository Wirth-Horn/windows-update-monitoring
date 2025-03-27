### register scheduled task to run the update monitoring script every 12 hours and at startup
# Define the trigger and Action
$Trigger = @(
    $(New-ScheduledTaskTrigger -AtStartup),
	$(New-ScheduledTaskTrigger -Daily -At 1am),
	$(New-ScheduledTaskTrigger -Daily -At 1pm)
)
$Action = New-ScheduledTaskAction -Execute "PowerShell" -WorkingDirectory "C:\update_monitoring\" -Argument '-Command ".\win-update-metrics.ps1"'
 
# security context - System account
$Principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount
 
# Create a scheduled task in Windows PowerShell
Register-ScheduledTask -TaskName "Windows Update Monitoring" -Trigger $Trigger -Action $Action -Principal $Principal