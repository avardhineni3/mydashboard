param (
    [Parameter(Mandatory=$false)] 
    [String] $ResourceGroupName,
    [Parameter(Mandatory=$false)]
    [String] $WebAppName,
    [Parameter(Mandatory=$false)]
    [object] $WebhookData
)
# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process
$Body = ConvertFrom-Json -InputObject $WebhookData.RequestBody
$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

Start-AzWebApp -ResourceGroupName $Body.RgName -Name $Body.WebAppName


Write-Output "WebApp $WebAppName Started Successfully" 