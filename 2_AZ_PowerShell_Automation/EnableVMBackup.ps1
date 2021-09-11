
param (
    [Parameter(Mandatory=$true)] 
    [String] $ResourceGroupName,
    [Parameter(Mandatory=$true)] 
    [String] $VMName
)
# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process

$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

Get-AzRecoveryServicesVault -Name "EUS-CMP-VAULT" | Set-AzRecoveryServicesVaultContext
$policy = Get-AzRecoveryServicesBackupProtectionPolicy -Name "DefaultPolicy"
Enable-AzRecoveryServicesBackupProtection -ResourceGroupName "EUS-CMP-RG-VMS" -Name "EUS-Linux-VM" -Policy $policy

Write-Output "Backup For $VMName Enabled Successfully !!!" 