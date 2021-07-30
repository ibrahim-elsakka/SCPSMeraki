function Set-SCMrkFirewalledService {
    <#
    .SYNOPSIS
        Cmdlet for setting a firewalled service on a specified network
    .DESCRIPTION
        This cmdlet will configure a firewalled service on a network. You can configure the
        services: web, SNMP and ICMP.
        You can configure the service to be either: blocked, restricted or unrestricted.
    .EXAMPLE
        PS C:\> Set-SCMrkFirewalledService -Id $Id -Service "SNMP" -Access "restricted" -AllowedIPs @("10.245.0.23", "10.232.45.90")
        
        This example will set the service SNMP on the network $Id to be restricted and only the IPs 10.245.0.23 and 10.232.45.90
        Will have access to that service.
    .EXAMPLE
        PS C:\> Set-SCMrkFirewalledService -Id $Id -Service "web" -Access "blocked"

        This example will set the service web to be blocked for the network
    .EXAMPLE
        PS C:\> Set-SCMrkFirewalledService -Id $Id -Service "ICMP" -Access "unrestricted"

        This will set the service ICMP to be allowed by any remote IP addresses over the internet
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-network-appliance-firewall-firewalled-service
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey,
        [Parameter(Mandatory=$true, HelpMessage="Can be either: ICMP, web or SNMP")]
        [String]$Service,
        [Parameter(Mandatory=$true, HelpMessage="Can be either: blocked, restricted, unrestricted")]
        [ValidateSet("blocked","restricted","unrestricted")]
        [String]$Access,
        [Parameter(Mandatory=$false, HelpMessage="Array of IP addresses")]
        [Array]$AllowedIPs
    )
    
    Begin {
        if($Access.ToLower() -eq "blocked"){
            Write-Verbose -Message "Setting firewalled Service: $($Service), Access as: $($Access)"
            $SwitchParameter = "blocked"
        }
        elseif($Access.ToLower() -eq "restricted"){
            Write-Verbose -Message "Setting firewalled Service: $($Service), Access as: $($Access)"
            if(!$AllowedIPs){
                Write-Error -Message "You need to provide an array of IPs for the parameter -AllowedIPs"
                Exit
            }
            $SwitchParameter = "restricted"
        }
        else {
            Write-Verbose -Message "Setting firewalled Service: $($Service), Access as: $($Access)"
            $SwitchParameter = "unrestricted"
        }
    }

    Process {
        Switch ($SwitchParameter){
            "blocked" {
                $payload = New-Object -TypeName psobject -Property @{
                    "service"   = $Service
                    "access"    = $Access
                }
            }

            "restricted" {
                $payload = New-Object -TypeName psobject -Property @{
                    "service"       = $Service
                    "access"        = $Access
                    "allowedIps"    = $AllowedIPs
                }
            }

            "unrestricted" {
                $payload = New-Object -TypeName psobject -Property @{
                    "service"   = $Service
                    "access"    = $Access
                }
            }
        }

        if($payload){
            Write-Verbose -Message "Payload was found. Initiating HTTP request"
            try {
                Write-Verbose -Message "Sending HTTP Request"
                $result = Invoke-PRMerakiApiCall -Method PUT -Resource "/networks/$($Id)/appliance/firewall/firewalledServices/$($Service)" -ApiKey $ApiKey -Payload $Payload
                return $result
            }
            catch {
                Write-Error -Message "$($_)"
            }
        }
    }

    End {
        if($result){
            Write-Verbose -Message "Succussfully created SNMP firewall service"
        }
    }
}