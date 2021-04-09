param(
    [Parameter(Position=0)]
    [switch]$CreateTask,
    [Parameter(Position=1)]
    [switch]$DisableTask,
    [Parameter(Position=2)]
    [switch]$PrintAllTasks,
    [Parameter(Position=3)]
    [switch]$EnableTask,
    [Parameter(Position=4)]
    [string]$TaskName,
    [Parameter(Position=5)]
    [string]$PathToExeForShedulerTask,
    [Parameter(Position=6)]
    [int]$RunTaskEveryMinute = 1,
    [Parameter(Position=7)]
    [int]$MaxPrint = 10

)
<#
.Synopsis
   Get all Task Sheduler Tasks
.DESCRIPTION
   Print all Tasks From Task Sheduler
#>
function Create-Task
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([string])]
    Param
    (
        # Task name
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
        [string]$TaskName,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,Position=1)]
        # Path to executable
        [string]$PathToExe,
        # Repeat time of the task in task sheduler
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true,Position=2)]
        [int]$RunEveryMinute = 1
    )

    Begin
    {
        #Optional Validation Function At This Point Before Run
        #& D:\learning\My-Task-For-Task-Sheduler.ps1
    }
    Process
    {
        $Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-file $PathToExe"
        $Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes $RunEveryMinute)
        $Settings = New-ScheduledTaskSettingsSet -ThrottleLimit 10
        $Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings
        $resp = Register-ScheduledTask -TaskName "$TaskName" -InputObject $Task 
    }
    End
    {
        Write-Host "End Of Execution:"
        $resp | Format-List
    }
}
<#
.Synopsis
   enable or disable task from task sheduler
.DESCRIPTION
   name and action params
.EXAMPLE
   Change-TaskStatus -Name $Name -Action [switch] ([switch] in enable,disable)
#>
function Change-TaskStatus
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # task name
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
        $TaskName,
        # action on task - disable,enable
        [switch]$Enable,
        [Switch]$Disable
    )

    Begin
    {
        $Task = Get-ScheduledTask -TaskName $TaskName
    }
    Process
    {
        if($Task -ne $null -and $Disable.IsPresent -eq $true){
            if($Disable.Equals($true)){Disable-ScheduledTask -TaskName $TaskName}
        }
        elseif($Task -ne $null -and $Enable.IsPresent -eq $true){
            if($Enable.Equals($true)){Disable-ScheduledTask -TaskName $TaskName}
        }
    }
    End
    {
        $Task | Format-List
    }
}
<#
.Synopsis
   Get all Task Sheduler Tasks
.DESCRIPTION
   Print all Tasks From Task Sheduler
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Get-AllTasks
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # max rows print
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
        [int]$MaxPrint = 10
    )

    Begin
    {
        $tasks = Get-ScheduledTask | ForEach-Object {"\$($_.TaskName)" | Out-String}
        $sb = New-Object System.Text.StringBuilder
    }
    Process
    {
        cls
        Write-Host "Sheduled Tasks:"
        if($tasks -ne $null){
            $(for ($i = 0; $i -lt $MaxPrint; $i++){$tasks[$i]})
        }
    }
    End
    {
        Write-Host "Runned With MaxPrint:$MaxPrint"
    }
}

#Script Start
if($CreateTask.IsPresent -and $CreateTask.Equals($true)){
    Create-Task -TaskName $TaskName -PathToExe $PathToExeForShedulerTask -RunEveryMinute $RunTaskEveryMinute
}
elseif($PrintAllTasks.IsPresent -and $PrintAllTasks.Equals($true)){
    Get-AllTasks -MaxPrint $MaxPrint
}
elseif($EnableTask.IsPresent -and $EnableTask.Equals($true) -or $DisableTask.IsPresent -and $DisableTask.Equals($true)){
    Change-TaskStatus -TaskName $TaskName -Enable:$EnableTask -Disable:$DisableTask
}

