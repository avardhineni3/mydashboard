param (
    [Parameter(Mandatory=$false)] 
    [String] $StorageAccount,
    [Parameter(Mandatory=$false)]
    [String] $ResourceGroup,
    [Parameter(Mandatory=$false)] 
    [String] $ContainerName,
    [Parameter(Mandatory=$false)]
    [object] $WebhookData
)
# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process
$Body = ConvertFrom-Json -InputObject $WebhookData.RequestBody
$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

Set-AzCurrentStorageAccount -ResourceGroupName $Body.RgName -AccountName $Body.StorageAccount
New-AzStorageContainer -Name $Body.ContainerName

Write-Output "Container Created Successfully" 