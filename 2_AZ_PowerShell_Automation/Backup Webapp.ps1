param (
    [Parameter(Mandatory=$false)] 
    [String] $RgName,
    [Parameter(Mandatory=$false)]
    [String] $WebAppName,
    [Parameter(Mandatory=$false)] 
    [String] $Frequency,
    [Parameter(Mandatory=$false)] 
    [String] $Retention,
    [Parameter(Mandatory=$false)]
    [object] $WebhookData
)
# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process
$Body = ConvertFrom-Json -InputObject $WebhookData.RequestBody
$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

try
{
 $storage = Get-AzStorageAccount -Body.RgName $Body.RgName -Name $Body.WebAppName
 $sasUrl = New-AzStorageContainerSASToken -Name appbackup -Permission rwdl -Context $storage.Context -ExpiryTime (Get-Date).AddYears(1) -FullUri
}
catch
{
$storage = New-AzStorageAccount -Body.RgName $Body.RgName -Name $Body.WebAppName -SkuName Standard_LRS -Location eastus
New-AzStorageContainer -Name appbackup -Context $storage.Context
 $sasUrl = New-AzStorageContainerSASToken -Name appbackup -Permission rwdl -Context $storage.Context -ExpiryTime (Get-Date).AddYears(1) -FullUri
}

Edit-AzWebAppBackupConfiguration -Body.RgName $Body.RgName -Name $Body.WebAppName -StorageAccountUrl $sasUrl -FrequencyInterval $BodyFrequency -FrequencyUnit Day -KeepAtLeastOneBackup -StartTime (Get-Date).AddHours(1) -RetentionPeriodInDays $Body.Retention


Get-AzWebAppBackupList -Body.RgName $Body.RgName -Name $Body.WebAppName


Write-Output "WebApp $Body.WebAppName Backed UP Successfully" 