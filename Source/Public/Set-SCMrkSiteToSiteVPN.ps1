function Set-SCMrkSiteToSiteVPN {
    <#
    .SYNOPSIS
        Cmdlet for configuring Site To Site on a network
    .DESCRIPTION
        Cmdlet which lets you configure Site To Site as either Spoke or Hub, or disable Site
        To Site completely.

        If a network is configured as a Spoke and you just want to set a subnet to be available on the VPN
        you should just run the command as configuring a spoke with that specific subnet
    .EXAMPLE
        PS C:\> Set-SCMrkSiteToSiteVPN -Id $id -HubId "L_6711231278931634675" -LocalSubnet "192.168.2.0/24" -UseVPN $true -Mode "spoke"
        
        This example will configure the Site To Site as a spoke connecting to the Hub: L_6711231278931634675 and Configuring the local subnet
        192.168.2.0/24 to be allowed on the VPN.
    .EXAMPLE
        PS C:\> Set-SCMrkSiteToSiteVPN -Id $id -Mode "hub"

        This example will configure the Site To Site as a Hub
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!update-network-appliance-vpn-site-to-site-vpn
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey,
        [Parameter(Mandatory=$true, HelpMessage="Can be none, spoke or hub")]
        [ValidateSet("none","spoke","hub")]
        [String]$Mode,
        [Parameter(Mandatory=$false)]
        [String]$HubId,
        [Parameter(Mandatory=$false)]
        [Boolean]$UseDefaultRoute = $false,
        [Parameter(Mandatory=$false)]
        [String]$LocalSubnet,
        [Parameter(Mandatory=$false)]
        [Boolean]$UseVPN = $false
    )

    Begin {
        if($Mode.ToLower() -eq "none"){
            Write-Verbose -Message "Removing Site To Site VPN Configurations"
            $SwitchParameter = "none"
        }
        elseif($Mode.ToLower() -eq "spoke"){
            if(!$HubId){
                Write-Error -Message "Parameter -HubId needs to be set to configure Site To Site VPN as Spoke"
                Exit
            }
            elseif(!$LocalSubnet){
                Write-Error -Message "Parameter -LocalSubnet needs to be set to configure Site To Site VPN as Spoke"
            }
            else {
                Write-Verbose -Message "Configuring Site To Site as Spoke"
                $SwitchParameter = "spoke"
            }
        }
        else {
            Write-Verbose -Message "Configuring Site To Site as Hub"
            $SwitchParameter = "hub"
        }
    }

    Process {
        Switch($SwitchParameter){
            "none" {
                $payload = New-Object -TypeName psobject -Property @{
                    "mode"      = $Mode
                    "hubs"      = @()
                    "subnets"   = @()
                }
            }

            "spoke" {
                # Configuring Hub Object
                $hub = New-Object -TypeName System.Collections.ArrayList
                $hubObject = New-Object -TypeName psobject -Property @{
                    "hubId" = $HubId
                    "useDefaultRoute" = $UseDefaultRoute
                }
                $null = $hub.Add($hubObject)

                # Configuring Subnet Object
                $subnet = New-Object -TypeName System.Collections.ArrayList
                $subnetObject = New-Object -TypeName psobject -Property @{
                    "localSubnet" = $LocalSubnet
                    "useVpn" = $UseVPN
                }
                $null = $subnet.Add($subnetObject)

                # Configuring payload for HTTP request
                $payload = New-Object -TypeName psobject -Property @{
                    "mode"      = $Mode
                    "hubs"      = $hub
                    "subnets"   = $subnet
                }
            }

            "hub" {
                $payload = New-Object -TypeName psobject -Property @{
                    "mode"      = $Mode
                    "hubs"      = @()
                    "subnets"   = @()
                }
            }
        }

        if($payload){
            Write-Verbose -Message "Payload was found. Initiating HTTP request"
            Write-Output -InputObject ($payload | convertTo-Json)
            try {
                Write-Verbose -Message "Sending HTTP Request"
                $result = Invoke-PRMerakiApiCall -Method PUT -Resource "/networks/$($Id)/appliance/vpn/siteToSiteVpn" -ApiKey $ApiKey -Payload $Payload
                return $result
            }
            catch {
                Write-Error -Message "$($_)"
            }
        }
    }

    End {
        if($result){
            Write-Verbose -Message "Succussfully set Site To Site VPN"
        }
    }
}