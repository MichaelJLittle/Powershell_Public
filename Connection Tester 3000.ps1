$ConnectionFolder = "C:\Users\MichaelLittle\Desktop\ConnectionLog"


# Make sure the folder exists
if (-not (Test-Path $ConnectionFolder)) {
    New-Item -ItemType Directory -Path $ConnectionFolder -Force
}





while($true) {

$GetDate = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$ConnectionResults = "$ConnectionFolder\Connectionresults_$GetDate.txt"
# Log timestamp
"Test Run: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" | Out-File -FilePath $ConnectionResults -Append

# Localhost test
"=== Localhost Test ===" | Out-File $ConnectionResults -Append
Test-Connection -Count 1 127.0.0.1 | Out-File $ConnectionResults -Append

# Internet tests
"=== Internet Tests ===" | Out-File $ConnectionResults -Append
Test-Connection -Count 4 google.com, homedepot.com | Out-File $ConnectionResults -Append

# Extra target
"Sending test to chatgpt.com" | Out-File $ConnectionResults -Append
Test-Connection -Count 1 TB-NMS | Out-File $ConnectionResults -Append

# Open the results
Start-Process notepad.exe $ConnectionResults



Start-Sleep -Seconds 600

} 
