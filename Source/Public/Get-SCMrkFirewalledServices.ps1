function Get-SCMrkFirewalledServices {
    <#
    .SYNOPSIS
        Cmdlet for retrieving firewalled services from a specific network
    .DESCRIPTION
        This cmdlet will query a specified network and retrieve an object of firewalled
        service
    .EXAMPLE
        PS C:\> Get-SCMrkFirewalledServices -Id $Id
        
        This example will retrieve a PowerShell object of all the firewalled services in a network
    .NOTES
        Meraki API Docs: https://developer.cisco.com/meraki/api-v1/#!get-network-appliance-firewall-firewalled-services
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
        Write-Verbose -Message "Querying Meraki API for firewalled services in Network: $($Id)"
    }
    
    process {
        try {
            Write-Verbose -Message "Retrieving Meraki Device"
            $result = Invoke-PRMerakiApiCall -Method GET -Resource "/networks/$($Id)/appliance/firewall/firewalledServices" -ApiKey $ApiKey
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