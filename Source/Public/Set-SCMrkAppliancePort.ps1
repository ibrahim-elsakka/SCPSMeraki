function Set-SCMrkAppliancePort {
    <#
    .SYNOPSIS
        Cmdlet for configuring a single port on a MX appliance
    .DESCRIPTION
        This cmdlet will configure a single port on a MX appliance as either an Accsess port or a Trunk port.
    .EXAMPLE
        PS C:\> Set-SCMrkAppliancePort -id $id -PortId 5 -Type "access" -vlan 30
        
        This example will configure port 5 as an access port and set it to VLAN 30
    .EXAMPLE
        PS C:\> Set-SCMrkAppliancePort -id $id -PortId 5 -Type "trunk" -vlan 1 -AllowedVlans "10,20,30,400,555"

        This example will configure port 5 as a trunk and set the native vlan to be 1 and allow the vlans:
        10,20,30,400,555 to be tagged on the trunk.
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-network-appliance-port
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey,
        [Parameter(Mandatory=$true, HelpMessage="Enter the port number of the port you want to configure")]
        [String]$PortId,
        [Parameter(Mandatory=$false)]
        [Boolean]$Enabled = $true,
        [Parameter(Mandatory=$true, HelpMessage="Enter a VLAN Id")]
        [String]$Vlan,
        [Parameter(Mandatory=$false)]
        [Boolean]$DropUntaggedTraffic = $false,
        [Parameter(Mandatory=$true, HelpMessage="Enter a Type: trunk or access")]
        [ValidateSet("trunk","access")]
        [String]$Type,
        [Parameter(Mandatory=$false)]
        [String]$AccessPolicy = "Open",
        [Parameter(Mandatory=$false, HelpMessage="A comma seperated string with the vlans or type all to allow all vlans")]
        [String]$AllowedVlans
    )

    Begin {
        if($Type -eq "trunk"){
            Write-Verbose -Message "Port will be configured as trunk"
            if(!$AllowedVlans){
                Write-Error -Message "You will need to specify the parameter -AllowedVlans when configuring a Trunk"
                Exit
            }
            else {
                $SwitchParameter = "trunk"
            }
        }
        else {
            Write-Verbose -Message "Port will be configured as an access port"
            $SwitchParameter = "access"
        }
    }

    Process {
        Switch($SwitchParameter) {
            "trunk" {
                $payload = New-Object -TypeName psobject -Property @{
                    "enabled"               = $Enabled
                    "type"                  = $Type
                    "dropUntaggedTraffic"   = $DropUntaggedTraffic
                    "vlan"                  = $Vlan
                    "allowedVlans"          = $AllowedVlans
                }
            }
            "access" {
                $payload = New-Object -TypeName psobject -Property @{
                    "enabled"               = $Enabled
                    "type"                  = $Type
                    "dropUntaggedTraffic"   = $DropUntaggedTraffic
                    "vlan"                  = $Vlan
                    "accessPolicy"          = $AccessPolicy
                }
            }
        }
        
        try {
            $result = Invoke-PRMerakiApiCall -Method PUT -Resource "/networks/$($Id)/appliance/ports/$($PortId)" -ApiKey $ApiKey -Payload $payload
        }
        catch {
            Write-Error -Message "$($_)"
        }
    }

    End {
        if($result){
            try {
                $request =  Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/ports/$($PortId)" -ApiKey $ApiKey
                return $request
            }
            catch {
                Write-Error -Message "$($_)"
            }
        }
    }
}