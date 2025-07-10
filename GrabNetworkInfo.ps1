$DateString = Get-Date -Format "yyyy-MM-dd"


#this is for specifying a date for when our file is made. 


$NetInfoLog =  "C:\NetInfo_$DateString.txt" 
# Create folder if it doesn't exist
if (-not (Test-Path -Path $NetInfoLog)) {
    New-Item -ItemType File -Path $NetInfoLog -Force
    }

Get-NetIPConfiguration -Detailed | Out-File -FilePath $NetInfoLog -Force 

Start-Process notepad.exe $NetInfolog
