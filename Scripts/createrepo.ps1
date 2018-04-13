# this is the name and location of our repository
# (adjust these details, and make sure the UNC path
# points to a file share that you have read and write
# permission)
$RepositoryName = 'Team1'
$path = '\\localhost\myrepository'

# check to see that the target exists
$exists = Test-Path "filesystem::$path"
if (!$exists) { throw "Repository $path is offline" }

# check to see whether that location is registered already
$existing = Get-PSRepository -Name $RepositoryName -ErrorAction Ignore

# if not, register it
if ($existing -eq $null)
{
  Register-PSRepository -Name $RepositoryName -SourceLocation $path -ScriptSourceLocation $path -InstallationPolicy Trusted 
}

# list all registered repositories
Get-PSRepository