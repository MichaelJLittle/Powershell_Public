# The point of this script is to auto-restart services if they are not running, and log them in the C: drive. 
#I made this because we had a service that was randomly failing in a production DB server, and we needed it 
#to auto restart itself while we discovered the root cause
$servicelog = "C:\Servicelog.txt"


if(-not($servicelog) ) { 

New-Item -ItemType File -Path $servicelog -Force

}
while ($true) {
$Date  = Get-Date -Format "yyyy-MM-dd HH:mm:ss" 
    # Get service object with basic info
    $ServiceCheck = Get-Service -Name PrintDeviceConfigurationService | Select-Object Status, DisplayName

    # Extract just the 'Status' value, e.g., 'Running' or 'Stopped'
    $ServiceStatus = $ServiceCheck.Status

    # Check if service is stopped
    if ($ServiceStatus -eq 'Stopped') { 
        Start-Service -Name PrintDeviceConfigurationService 
        Write-Host "Service was stopped but now is running"
        Add-Content -Path $servicelog -Value "Attempting Service Restart at $Date" 
    }
    else {
        Add-Content -Path $servicelog -Value "Service is running as of $Date" 
    }

    # Pause before next check
    Start-Sleep -Seconds 1
}


