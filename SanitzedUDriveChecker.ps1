#This I setup to check space on a network drive. It does some math and sends out email reports if it's too full﻿

$DeviceID = 'U' #This defines the drive we are looking for, might be redudnant 

$VolumeName =  'Shares' #This defines the volume we're loooking for, might be redundant

New-PSDrive -Name "U" -PSProvider FileSystem -Root "\\NetDrive\SharedFolder" -Persist # I set this up to work with my network drive, for some reason it needs to be explicitly stated with Task Scheduler

#here we are defining the exact drive we want. Get-Cim cmdlet with the classname Win32_LogicalDisk just searches for disks connected. Then
# we filter it with Where-Object to search only a specific drive.
 
$Drive = Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object { 
    $_.DeviceID -eq 'U:' -and $_.VolumeName -eq 'SHARES'
}

if (-not $Drive) {
    Write-Warning "Drive $DeviceID with volume $VolumeName not found."
    exit
}


  #this lets us use this $freespace as a variable by doing the math to check freespace
 $freespace = [math]::Round($Drive.Freespace /1gb, 2 )

 #if we have more than 10 gigs available,then we update with how much we have left  

 $securePwd = ConvertTo-SecureString "insertAPIkeyhere" -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential("apikey", $securePwd)
# I set up the credentials this way because powershell / sendgrid didn't like me stating them after the send-mailmessage cmdlet, only before 


if ($freespace -gt 10) {

Send-MailMessage -From "sender@gmail.com" `
  -To "email@gmail.com"`
  -Subject "Drive Space Update" `
  -Body "Drive E:, Shared Drive on NetworkDriveServer is at $freeSpace GB. " `
  -SmtpServer "smtp.sendgrid.net" `
  -Port 587 `
  -UseSsl `
  -Credential $creds -Verbose

  }

  #if we have less than 10 gigs we send this out to a different email with a differnet message. Either way its checked weekly. 

 else   {  

Send-MailMessage -From "sender@gmail.com" `
  -To "email@gmail.com" `
  -Subject "Drive Space Alert" `
  -Body "Drive E:, Shared Drive on NetworkDriveServer is below 10 GB. Current Free Space is $freespace GB" `
  -SmtpServer "smtp.sendgrid.net" `
  -Port 587 `
  -UseSsl `
  -Credential $creds -Verbose


}

#  I set this up to run weekly on Task Scheduler after, otherwise you can background this process as needed. 



