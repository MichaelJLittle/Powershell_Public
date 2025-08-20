 

 $ClipLog = "C:\CLipLog.txt" # this makes the file, and if it's not there we make it. C drive is easiest to pick 

 If(-not(Test-Path $ClipLog) ) { 

 New-Item -ItemType File -Path ClipLog -Force
 } 



 while($true)  { 

 $Date = Get-Date -Format "yyyy-MM-dd HH:mm:ss" 
 
 $ClipBoard = Get-Clipboard  

 Add-Content -Value "The user has *$Clipboard* , as of $Date" -Path $Cliplog


 start-sleep 6


 } 
 # i imagine this one is good if you think information is being copied when it shouldn't be, its pretty simple and utlizes that get-clipboard cmdlet. we keep it all in the loop
 #to keep it updated 