#---------------------------------------------------------[Script Parameters]------------------------------------------------------

Param (
  #Script parameters go here
  [string] $SubscriptionName 
)


$ScriptPath = (Get-Variable MyInvocation -Scope Script).Value.MyCommand.Path

$ScriptPath
# get script working directory 
$ScriptWorkingDirectory = (get-item $ScriptPath).Directory.FullName
$ScriptWorkingDirectory

$usr=[System.Security.Principal.WindowsIdentity]::GetCurrent().Name
cd $ScriptWorkingDirectory
$Error.Clear()

if( !(Test-Path "$ScriptWorkingDirectory\Output"))
{
    New-Item -Name "output" -Path $ScriptWorkingDirectory -ItemType Directory
}


## create name for the file 

$CSVFile    = "$ScriptWorkingDirectory\output\$((get-item $ScriptPath).BaseName)-$(Get-Date -Format "ddMMyy-HHmm").csv"

Write-Host "Csv file: $CSVFile" 

$OUTPUT_ARRAY = @()

#-----------------------------------------------------------[Execution]------------------------------------------------------------

#Connecting to Azure Portal Account
#Connect-AzAccount -ErrorVariable cmdOutput


if($SubscriptionName)
{
 $subs = Get-AzSubscription -SubscriptionName $SubscriptionName
}
else
{
$subs = Get-AzSubscription
}

foreach ($sub in $subs)
{


Select-AzSubscription $sub.Name 

$Vnets = Get-AzVirtualNetwork 

            foreach ($Vnet in $Vnets)
            {


                $Vnet_Name = $Vnet.Name
                $Vnet_ResourceGroup = $Vnet.ResourceGroupName

                $result = Get-AzVirtualNetwork -Name "$Vnet_Name"  -ResourceGroupName "$Vnet_ResourceGroup" -ExpandResource 'subnets/ipConfigurations' 

                $VnetPrivateIps = $result.Subnets[0].IpConfigurations.PrivateIpAddress
                $VnetPublicIps  = $result.Subnets[0].IpConfigurations.PublicIpAddress
                
                if($VnetPrivateIps -eq $null -and $VnetPublicIps -eq $null)

                    {
                       $OUTPUT_ARRAY += New-Object PSObject -Property @{
                                                Subscription_Name = $sub.Name ;
                                                Resource_Group = $Vnet_ResourceGroup;
                                                Vnet_Name = $Vnet_Name;                
                                
                                             }

                    }

                else
                {
                Write-Host "$Vnet_Name - Devices are connected with the Vnet "
                }

 }
 
 }
 $OUTPUT_ARRAY | Select-Object Subscription_Name, Resource_Group, Vnet_Name | Export-Csv -Path $CSVFile -NoTypeInformation
