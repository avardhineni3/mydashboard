param (
    [Parameter(Mandatory=$false)] 
    [String] $Vnet1Name,
    [Parameter(Mandatory=$false)]
    [String] $Vnet2Name,
    [Parameter(Mandatory=$false)] 
    [String] $Vnet1ResourceGroup,
    [Parameter(Mandatory=$false)]
    [String] $Vnet2ResourceGroup,
    [Parameter(Mandatory=$false)]
    [object] $WebhookData
)
# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process
$Body = ConvertFrom-Json -InputObject $WebhookData.RequestBody
$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

$Vnet1 = Get-AzVirtualNetwork -Name $Body.Vnet1Name -ResourceGroupName $Body.Vnet1Rg
$Vnet2 = Get-AzVirtualNetwork -Name $Body.Vnet2Name -ResourceGroupName $Body.Vnet2Rg

Add-AzVirtualNetworkPeering `
  -Name "Vnet1-Vnet2" `
  -VirtualNetwork $Vnet1 `
  -RemoteVirtualNetworkId $Vnet2.Id

Add-AzVirtualNetworkPeering `
  -Name "Vnet2-Vnet1" `
  -VirtualNetwork $Vnet2 `
  -RemoteVirtualNetworkId $Vnet1.Id

Write-Output "VNETS Peered Successfully" 