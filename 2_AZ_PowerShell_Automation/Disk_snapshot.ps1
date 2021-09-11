param (
    [Parameter(Mandatory=$false)] 
    [String] $ResourceGroupName,
    [Parameter(Mandatory=$false)]
    [String] $DiskName,
    [Parameter(Mandatory=$false)]
    [String] $snapshotName,
    [Parameter(Mandatory=$false)]
    [object] $WebhookData
)
# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process
$Body = ConvertFrom-Json -InputObject $WebhookData.RequestBody
$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

$Disk = Get-AzDisk -ResourceGroupName $Body.RgName -DiskName $Body.DiskName

$snapshot =  New-AzSnapshotConfig `
    -SourceUri $Disk.Id `
    -Location $Disk.Location `
    -CreateOption copy

New-AzSnapshot `
    -Snapshot $snapshot `
    -SnapshotName $Body.SnapShotName `
    -ResourceGroupName $Body.RgName
    
Write-Output "Snapshot created successfully !!!" 