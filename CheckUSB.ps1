
#Step one is to define the path we want to use to log our stuff. We define the Date variable to allow us to know when this directory is made
$Date = Get-Date -Format "yyyy-MM-dd"
$UsbLog = "C:\Users\mike\Desktop\UsbLog_$Date" 


#if this path doesn't exist then we make it. 
if(-not(Test-Path $UsbLog) ) {
New-Item -ItemType Directory -Path $UsbLog -Force
}

#here we need to create the actual text file
$UsbChangeLog = "$UsbLog\USBChanges.txt"
if(-not(Test-Path $UsbChangeLog) ) {
New-Item -ItemType File -Path $UsbChangeLog -Force
}

#here we are specifcally querying for USB drives. we put htis to $usbChangeLog. 

while($true) { 

# We loop this part to keep it running , can have it start during Startup in task scheduler

    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $UsbChangeLog -Value "`n[$TimeStamp] USB Scan Started" 
    # Get USB volumes and append them to the log
    Get-Volume | Where-Object DriveType -eq 2 | Select-Object DriveLetter, DriveType | Out-String | Add-Content -Path $UsbChangeLog 
    Write-Host "Scan completed at $TimeStamp"
    Start-Sleep -Seconds 60
    }
