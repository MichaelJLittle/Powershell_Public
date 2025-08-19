



$ResourceLog = "C:\ResourceLog.txt"  # This line and the next few just define our log file and where it should be if it doesn't exist 

if(-not(test-path $ResourceLog) ) { 

New-Item -ItemType File -Path "C:\ResourceLog.txt" -Force

}

while($True) { 

$Date = get-date -Format "yyyy-MM-dd HH:mm:ss"
$CpuStatus = (Get-Counter -Counter "\Processor(_Total)\% Processor Time").CounterSamples.CookedValue
# We grab the date inside of the loop to keep it gresh, and the Cpustatus variable is used just to grab that .cookedvalue percentage 


Add-Content  -Path $Resourcelog -Value "Your CPU usage is currently at $CpuStatus % as of $Date" 
#All we do then is update the log that we created earlier with our $CpuStatus cooked.value number,and the date. The while($True) loop just keeps it all updated
Start-Sleep -Seconds 60 


}
