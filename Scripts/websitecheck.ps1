[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

$webClient = new-object System.Net.WebClient
$webClient.Headers.Add("user-agent", "PowerShell Script")
$websiteup=0
while ($websiteup -eq 0) {
$output = ""
$output = $webClient.DownloadString("https://192.168.71.129/")
if ($output -like "*Dashboard*") {
      write-host "Success website up"
      $websiteup=1 
   } else {
      write-host "Failure website down"
      $websiteup=0 
      sleep 10
   }
}

