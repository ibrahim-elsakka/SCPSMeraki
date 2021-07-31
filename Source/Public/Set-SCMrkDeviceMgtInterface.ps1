function Set-SCMrkDeviceMgtInterface {
    <#
    .SYNOPSIS
        Cmdlet for setting the Management Interface on Meraki Devices
    .DESCRIPTION
        This cmdlet can be used for setting the Manamgenet Interface on a specified Meraki
        Device. You can chose to set the interface as DHCP or by setting a static Ip address.
    .EXAMPLE
        PS C:\> $InterfaceArgs = @{
                    Serial = $serial
                    Interface = "wan1"
                    ManagementVlan = "20"
                    StaticIpAddress = "192.168.1.2"
                    SubnetMask = "255.255.255.0"
                    DefaultGateway = "192.168.1.1"
                    DNSServers = @(
                        "8.8.8.8",
                        "8.8.4.4"
                    )
                }

        PS C:\> Set-SCMrkDeviceMgtInterface -UseStaticIP @InterfaceArgs
        
        This example will use splatting to configure the management interface on the device defined by the serial number
        $serial. The example will configure the interface to use a Static IP address defined by the switch parameter: -UseStaticIP.
        It will then use the information passed in the splat to configure the interface.
    .EXAMPLE
        PS C:\> Set-SCMrkDeviceMgtInterface -Serial $serial -Interface "wan1" -ManagementVlan 1 -UseDHCP
        
        This example will configure the management interface on the device defined by the $serial variable. It will
        configure the device to use DHCP for configuring the interface.
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-device-management-interface
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey,
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Serial,
        [Parameter(Mandatory=$true, HelpMessage="Chose either wan1 or wan2")]
        [String]$Interface,
        [Parameter(Mandatory=$true, HelpMessage="Choose a vlan between 1-1024")]
        [String]$ManagementVlan,
        [Parameter(Mandatory=$false, ParameterSetName="dhcp")]
        [switch]$UseDHCP,
        [Parameter(Mandatory=$false, ParameterSetName="static")]
        [switch]$UseStaticIP,
        [Parameter(Mandatory=$true, ParameterSetName="static", HelpMessage="Set the Ip address of the interface")]
        [String]$StaticIpAddress,
        [Parameter(Mandatory=$true, ParameterSetName="static", HelpMessage="Set the subnet mask of the interface")]
        [String]$SubnetMask,
        [Parameter(Mandatory=$true, ParameterSetName="static", HelpMessage="Set the default gateway for the interface")]
        [String]$DefaultGateway,
        [Parameter(Mandatory=$true, ParameterSetName="static", HelpMessage="Array containing DNS Ip addresses")]
        [Array]$DNSServers
    )

    Begin {
        if($UseDHCP.IsPresent){
            Write-Verbose -Message "Configuring Device Management Interface with DHCP"
        }
        elseif($UseStaticIP.IsPresent){
            Write-Verbose -Message "Configuring Device Management Interface with Static IP"
        }
        else {
            Write-Error -Message "No Switch was configured. Either set: -UseDHCP or -UseStaticIP"
            Exit
        }
    }

    Process {
        if($UseDHCP.IsPresent){
            Write-Verbose -Message "Generating object for configuring interface as DHCP"
            $object = New-Object -TypeName psobject -Property @{
                "usingStaticIp"     = $false
                "vlan"              = $ManagementVlan
            }
            Write-Verbose -Message "Compiling HTTP payload"
            $Payload = New-Object -TypeName psobject -Property @{
                $Interface = $object
            }
        }
        elseif($UseStaticIP.IsPresent){
            Write-Verbose -Message "Generating object for configuring interface as Static IP"
            $object = New-Object -TypeName psobject -Property @{
                "usingStaticIp" = $true
                "staticIp" = $StaticIpAddress
                "staticSubnetMask" = $SubnetMask
                "staticGatewayIp" = $DefaultGateway
                "staticDns" = $DNSServers
                "vlan" = $ManagementVlan
            }
            Write-Verbose -Message "Compiling HTTP payload"
            $Payload = New-Object -TypeName psobject -Property @{
                $Interface = $object
            }
        }

        If($Payload){
            Write-Verbose -Message "Payload was configured. Sending HTTP request"
            try {
                $request = Invoke-PRMerakiApiCall -Method PUT -Resource "/devices/$($Serial)/managementInterface" -ApiKey $ApiKey -Payload $Payload
            }
            catch {
                Write-Error "$($_)"
            }
        }
    }

    End {
        if($request){
            Write-Verbose -Message "Sucessfully send HTTP request"
            return $request
        }
    }
}