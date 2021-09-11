param (
    [Parameter(Mandatory=$false)] 
    [String] $ResourceGroupName,
    [Parameter(Mandatory=$false)]
    [String] $SQLServerName,
    [Parameter(Mandatory=$false)]
    [String] $RuleName,
    [Parameter(Mandatory=$false)]
    [String] $StartIp,
    [Parameter(Mandatory=$false)]
    [String] $EndIp,
    [Parameter(Mandatory=$false)]
    [object] $WebhookData
)
# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process
$Body = ConvertFrom-Json -InputObject $WebhookData.RequestBody
$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

New-AzSqlServerFirewallRule -ResourceGroupName $Body.RgName -ServerName $Body.ServerName -FirewallRuleName $Body.RuleName -StartIpAddress $Body.StartIp -EndIpAddress $Body.EndIp


Write-Output "WebApp $WebAppName Stopped Successfully" 