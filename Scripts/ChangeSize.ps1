

write-host "Increasing Windows buffer size - to cater for the log"

$pshost = get-host
$pswindow = $pshost.ui.rawui
$newsize = $pswindow.buffersize
$newsize.height = 30000
$newsize.width = 150
$pswindow.buffersize = $newsize

#$newsize = $pswindow.windowsize
#$newsize.height = 50
#$newsize.width = 150
#$pswindow.windowsize = $newsize

. D:\Temp\PowerShell\get-bufferhtml.ps1 >out1.html
 