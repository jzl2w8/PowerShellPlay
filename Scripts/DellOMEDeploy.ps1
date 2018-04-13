#Dell OME Deploy - http://www.dell.com/support/home/uk/en/ukbsdt1/Drivers/DriversDetails?driverId=H2RRX
#VMWare PowerCLi Needed
#Account with vCenter/DNS/RemoteBackup
#Service Account 

#
# the below varibales are defined in the seperate variables.ps1 file in the variables folder

#$currentdirectoy = (Get-Item -Path ".\" -Verbose).FullName

#. .\Variables\Variables.ps1


##
##
## Run this script with arg of varible and password file eg DeployOneViewAppliance_v1.ps1 readingvariable readingpasswd
##
##

write-host "Increasing Windows buffer size - to cater for the log"

$pshost = get-host
$pswindow = $pshost.ui.rawui
$newsize = $pswindow.buffersize
$newsize.height = 30000
$newsize.width = 150
$pswindow.buffersize = $newsize

$currentpath = get-location

if ($args.Length -ne "2") 
{
Write-Host "You have not defined either the variables or password files please check values are correct" 
Exit

}

foreach ($arg in $args)
 {


    . .\Variables\"$arg.ps1"
    
 } 




Write-host ""
write-host "This is not fully automated, you will be prompted press continue"
Write-host ""

pause


cd "C:\Program Files\VMware\VMware OVF Tool"
C:


if (test-path $sourceovf)
 {
   Write-Host $sourceovf "found"
 }
 else {
 if (Test-Path $sourceova)
 {
 Write-Host $sourceova "found"
  .\ovftool.exe $sourceova $sourceovf
 }
 else {
 Write-Host "Error missing OVA"
 pause
 exit(1)
 
 }
 }

DO{
Write-Host "Checking for OVF files"
Write-Host "Checking...."
sleep -seconds 1
Write-Host ""
Write-Host "Not Done Yet" 
Write-Host "Will try again in 5 seconds." 
Write-Host ""
sleep -seconds 5
}

Until (Test-Path $sourceovf)

Write-Host "" 
Write-Host "OVF File now found" 
Write-Host ""

Write-Host "Deploying Appliance to" $vcenter "Please login to the vCenter and prep for next steps"
Write-Host ""
Write-Host ""

sleep -seconds 2

cd "C:\Program Files\VMware\VMware OVF Tool"
C:

./ovftool.exe --noSSLVerify -ds="$DataStore" --net:"VM Network"="$burvlan" -n="$VCGuestName" --powerOn  $sourceovf vi://$vcenter/?dns=$esxihost 


Write-host ""
write-host "Now connect to the OneViewAppliance console via vcenter for" $AppFQDNName " Open its console screen and when the server is powered up showing the EULA  - this may take 5 mins or more then  press continue"
Write-host ""

pause