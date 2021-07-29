function Get-SCMrkL3FirewallRules {
    <#
    .SYNOPSIS
        Cmdlet for retrieving all L3 firewall rules for a network
    .DESCRIPTION
        This cmdlet will return an Array of all L3 firewall rules configured on a network
    .EXAMPLE
        PS C:\> Get-SCMrkL3FirewallRules -Id L_918231134598135
        
        This example will return all L3 firewall rules configured for the network with Id
        L_918231134598135.
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-appliance-firewall-l-3-firewall-rules
    .LINK
        Online Help: https://scriptingchris.tech
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [String]$ApiKey = $ApiKey
    )

    Begin {
        Write-Verbose -Message "Initiating retrieval of all L3 Firewall Rules associated to the network: $($Id)"
    }

    Process {
        try {
            Write-Verbose -Message "Retrieving Meraki L3 Firewall Rules"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/firewall/l3FirewallRules" -ApiKey $ApiKey
            Write-Output -InputObject $result.rules
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }

    End {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}