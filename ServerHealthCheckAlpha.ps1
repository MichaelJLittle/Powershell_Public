$ServerLog = "C:\ServerLog.txt" 

if(-not(Test-Path $ServerLog ) ) { 

New-Item -ItemType File -Path $Serverlog -Force

} 


$LastBoot = (Get-ComputerInfo).OsLastBootupTime

$Currentuser = (Get-ComputerInfo).OsRegistereduser

$OSTime = (Get-ComputerInfo).OsLocalDateTime

$Date = Get-Date -Format "yyyy-MM-dd HH:mm:ss" 

$CpuStatus = (Get-Counter -Counter "\Processor(_Total)\% Processor Time").CounterSamples.CookedValue

$CPUCheck =  Get-Process | Sort-Object CPU -Descending | Select-Object -First 5

$DFGCheck = Test-NetConnection 192.168.1.1 | Select-Object  PingSucceeded 
$PingCheck = Test-NetConnection 8.8.8.8 | Select-Object PingSucceeded 



Add-Content  -Path $ServerLog -Value "Your CPU usage is currently at $CpuStatus % as of $Date" 


Add-Content -Value "The Last boot time is $LastBoot. The Current user logged in is $CurrentUser. The time on the server is $OSTime. The actual time is $Date" -Path $ServerLog

Add-Content -Value "Network Check Results: $DFGCheck.  Google Pings $PingCheck " -Path $ServerLog


