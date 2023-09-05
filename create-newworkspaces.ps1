<#
    New AWS WorkSpaces

    Changelog
        v1.0
            Initial offering. Don't beat me up.
            Forces directory: DirectoryX
            Forces bundle: BundleX

    TODO
        Temp caching adm credential
        Logic to choose which directory
        Logic to choose which bundle
        Make more pretty
        KMS management
#>

if (!([Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544')) {
    cls
    Write-Host "   *******************************   " -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "   * Please run as administrator *   " -ForegroundColor Magenta -BackgroundColor Black
    Write-Host "   *******************************   " -ForegroundColor Yellow -BackgroundColor Black
    #break
}

if (!(test-path -Path "C:\Program Files\WindowsPowerShell\Modules\AWS.Tools.Installer")) {
    Install-Module -Name AWS.Tools.Installer -Force
    Import-Module -Name AWS.Tools.Installer -Force
}

if (!(test-path -Path "C:\Program Files\WindowsPowerShell\Modules\AWSPowerShell")) {
    Install-Module -Name AWSPowerShell
    Import-Module -Name AWSPowerShell
}

if (!(test-path -Path "C:\Program Files\WindowsPowerShell\Modules\SqlServer")) {
    Install-Module -Name SqlServer
    Import-Module -Name SqlServer
}

$cred = Get-Credential -Credential $env:USERNAME
$awsuser = Read-Host "EU login ID"
$awscostcenter = Read-Host "EU cost center"
$awsbundle = "" # add bundle here
$awsdirectory = "" # add directory here

#########################################################################

$tagkms = 
$tagcounty = 
$tagemployeetype = 
$tagcompany = 
$tagdepartment = 
$tagdirectory = 
$tagemail = 
$tagcostcenter = 

#########################################################################

$SQLInstance = ""
$SQLDatabase = "master"
$SQLUsername = ""
$SQLPassword = ""

$query=@"
select * from [Database].dbo.table where [id] like '$awsuser';
"@

#$SQLQuery1Output = Invoke-Sqlcmd -query $query -ServerInstance $SQLInstance -Username $SQLUsername -Password $SQLPassword | Select-Object cost_center| foreach {$_.cost_center}
$SQLQuery1Output = Invoke-Sqlcmd -query $query -ServerInstance $SQLInstance -Username $SQLUsername -Password $SQLPassword

New-WKSWorkspace -Workspace -Credential $cred @{"BundleID" = "$awsbundle"; "DirectoryId" = "$awsdirectory"; "UserName" = "$awsuser"}