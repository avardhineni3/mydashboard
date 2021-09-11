
param (
    [Parameter(Mandatory=$false)] 
    [String] $ResourceGroupName,
    [Parameter(Mandatory=$false)]
    [String] $VMName,
    [Parameter(Mandatory=$false)]
    [object] $WebhookData
)
# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process
$Body = ConvertFrom-Json -InputObject $WebhookData.RequestBody
$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

Stop-AzVM -Name $Body.VMNAME -ResourceGroupName $Body.RESOURCEGROUPNAME -Force


Write-Output "VM $VMName Stopped Successfully" 