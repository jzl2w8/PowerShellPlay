[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

$webClient = new-object System.Net.WebClient
$webClient.Headers.Add("user-agent", "PowerShell Script")
$websiteup=0
while ($websiteup -eq 0) {
$output = ""

try {

$output = $webClient.DownloadString("https://192.168.71.129/")

}

catch {
    Write-Host "Website down"
     $websiteup=0 
     sleep 10
}


if ($output -like "*Dashboard*") {
      write-host "Success website up"
      $websiteup=1 
   } 
   
}

