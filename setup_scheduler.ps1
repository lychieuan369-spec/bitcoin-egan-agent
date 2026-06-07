# Setup Windows Task Scheduler - Run BTC alert every 30 minutes
$TaskName = "BTC_Egan_Alert"
$PythonPath = (Get-Command python).Source
$ScriptPath = "D:\bitcoin_egan_agent\telegram_alert.py"
$LogPath = "D:\bitcoin_egan_agent\alert.log"

# Remove existing task if any
Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false -ErrorAction SilentlyContinue

$Action = New-ScheduledTaskAction `
    -Execute $PythonPath `
    -Argument $ScriptPath `
    -WorkingDirectory "D:\bitcoin_egan_agent"

# Run every 30 minutes
$Triggers = @(
    $(New-ScheduledTaskTrigger -RepetitionInterval (New-TimeSpan -Minutes 30) -Once -At (Get-Date))
)

$Settings = New-ScheduledTaskSettingsSet `
    -ExecutionTimeLimit (New-TimeSpan -Minutes 5) `
    -RestartCount 1 `
    -RestartInterval (New-TimeSpan -Minutes 1) `
    -StartWhenAvailable

Register-ScheduledTask `
    -TaskName $TaskName `
    -Action $Action `
    -Trigger $Triggers `
    -Settings $Settings `
    -RunLevel Highest `
    -Force

Write-Host "Task '$TaskName' registered - runs every 30 minutes"
Write-Host "Check: Task Scheduler > Task Scheduler Library > $TaskName"
