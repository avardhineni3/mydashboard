param (
    [Parameter(Mandatory=$false)] 
    [String] $ResourceGroupName,
    [Parameter(Mandatory=$false)]
    [String] $DiskName,
    [Parameter(Mandatory=$false)]
    [String] $DiskSize,
    [Parameter(Mandatory=$false)]
    [object] $WebhookData
)
# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process
$Body = ConvertFrom-Json -InputObject $WebhookData.RequestBody
$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint


$disk= Get-AzDisk -ResourceGroupName $Body.RgName -DiskName $Body.DiskName
$disk.DiskSizeGB = $Body.DiskSize
Update-AzDisk -ResourceGroupName $ResourceGroupName -Disk $disk -DiskName $Body.DiskName

    
Write-Output "Disk Resized Successfully !!!" 