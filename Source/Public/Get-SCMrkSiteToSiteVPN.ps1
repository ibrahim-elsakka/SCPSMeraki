function Get-SCMrkSiteToSiteVPN {
    <#
    .SYNOPSIS
        This cmdlet will retrieve all Site To Site VPN configurations on a network
    .DESCRIPTION
        This cmdlet will return an object containing all data regarding Site To Site configuration
        for a specific network
    .EXAMPLE
        PS C:\> Get-SCMrkSiteToSiteVPN -Id $Id

        This example will retrieve the Site To Site configurations for the Network $id
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
        [String]$ApiKey = $ApiKey
    )

    begin {
        Write-Verbose -Message "Querying Meraki API for the Site To Site configurations in Network: $($Id)"
    }
    
    process {
        try {
            Write-Verbose -Message "Retrieving Meraki Site To Site config for network: $($Id)"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/vpn/siteToSiteVpn" -ApiKey $ApiKey
            Write-Output -InputObject $result
        }
        catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
        }
    }
    
    end {
        if($statusCode){
            Write-Error -Message "Status code: $($statusCode), Error Description: $($statusDescription)"
        }
    }
}