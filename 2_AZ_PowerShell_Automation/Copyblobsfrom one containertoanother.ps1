param (
    [Parameter(Mandatory=$false)] 
    [String] $StorageAccount,
    [Parameter(Mandatory=$false)]
    [String] $ResourceGroup,
    [Parameter(Mandatory=$false)] 
    [String] $SourceContainer,
    [Parameter(Mandatory=$false)]
    [String] $DestinationContainer,
    [Parameter(Mandatory=$false)]
    [String] $BlobName,
    [Parameter(Mandatory=$false)]
    [object] $WebhookData
)
# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process
$Body = ConvertFrom-Json -InputObject $WebhookData.RequestBody
$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

Set-AzCurrentStorageAccount -ResourceGroupName $Body.RgName -AccountName $Body.StorageAccount
Start-AzStorageBlobCopy -SrcBlob $Body.BlobName -DestContainer $Body.DestinationContainerName -SrcContainer $Body.SourceContainerName

Write-Output "Blob copied successfully" 