

$WifiStrength = "C:\WifiLog.txt"

If(-not(Test-Path $WifiStrength ) )  { 

new-item -ItemType File -Path $WifiStrength -Force
} 

while($true)   { 

$Date = Get-Date -Format "mm-dd HH:mm:ss"
$lastssid1 = netsh wlan show interfaces | Select-String -Pattern  'SSID' | ForEach-Object { $_.Line.Trim() }

$lastssid2 = netsh wlan show interfaces | Select-String -Pattern 'Signal'  | ForEach-Object { $_.Line.Trim() }

$lastssid3 = netsh wlan show interfaces | Select-String -Pattern 'Band' | ForEach-Object { $_.Line.Trim() }


Add-Content -Value " Wifi Check at $Date " -Path $WifiStrength
Add-Content -Value " $lastssid , checked at $Date" -Path $WifiStrength
Add-Content -Value "$lastssid2" -Path $WifiStrength 
Add-Content -Value "$lastssid3" -Path $WifiStrength 


start-sleep 5

} 

